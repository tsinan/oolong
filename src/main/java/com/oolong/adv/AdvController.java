package com.oolong.adv;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.oolong.platform.exception.DuplicationNameException;
import com.oolong.platform.exception.InputValidateException;
import com.oolong.platform.util.TextUtil;
import com.oolong.platform.util.TimeUtil;
import com.oolong.platform.web.AjaxValidateFieldResult;

/**
 * 广告处理控制器，页面跳转、增、删、改、查、校验
 * 
 * @author liumeng
 * @since 2013-12-1
 */
@Controller
@RequestMapping(value = "/advs")
public class AdvController
{
	private static final Logger logger = LoggerFactory
			.getLogger(AdvController.class);

	private static final String FILE_UPLOAD_DIRECTRY = "D:\\tmp";

	private static final int FILE_UPLOAD_SIZE_MAX = 10240000;

	private static final String FILE_UPLOAD_TYPE_ONLY = ".zip";

	@Autowired
	private AdvRepository advRepo;
	
	@Autowired
	private ActivityRepository actiRepo;

	@Autowired
	private AdvWebsiteRelationRepository awrRepo;

	@Autowired
	private AdvAreaRelationRepository aarRepo;

	/******************************************************
	 * 页面跳转
	 ******************************************************/
	@RequestMapping(value = "/createPage", method = RequestMethod.GET)
	public String toCreateActivityPage()
	{
		return "adv/createAdv";
	}

	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public String toListActivityPage()
	{
		return "adv/listAdv";
	}

	@RequestMapping(value = "/editPage", method = RequestMethod.GET)
	public String toEditActivityPage(HttpServletRequest request)
	{
		return "adv/editAdv";
	}

	/******************************************************
	 * 功能接口
	 ******************************************************/

	/**
	 * 查询广告订单列表
	 * 
	 * @param query 查询条件
	 * @param page 当前页数
	 * @param pageSize 每页记录数
	 * @param sortColumn 排序字段
	 * @param sortOrder 正序/逆序
	 * @return 返回查询结果
	 */
	@RequestMapping(method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	@Transactional
	public @ResponseBody
	Map<String, Object> list(@RequestParam String query,
			@RequestParam Integer page, @RequestParam Integer pageSize,
			@RequestParam String sortColumn, @RequestParam String sortOrder)
	{
		// 构造分页和排序对象
		Pageable pageable = TextUtil.parsePageableObj(page, pageSize,
				sortOrder, sortColumn, "lastUpdateTime");

		String advNameLike = TextUtil.buildLikeText(query);

		List<Adv> list = null;
		long count = 0;
		if (advNameLike.length() > 0)
		{
			list = advRepo.findByAdvNameLike(advNameLike, pageable);
			count = advRepo.countByAdvNameLike(advNameLike);
		}
		else
		{
			list = advRepo.findAll(pageable).getContent();
			count = advRepo.count();
		}
		
		// 补充显示名称
		for(Adv adv:list)
		{
			Activity acti = actiRepo.findOne(adv.getActivityId());
			if(acti != null)
			{
				adv.setActivityName(acti.getActivityName());
			}
			else
			{
				adv.setActivityName("-");
			}
		}

		// 查询并返回结果
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("currentPage", list);
		result.put("totalRows", Long.valueOf(count));

		result.put("paging", page + "|" + pageSize + "|" + sortColumn + "|"
				+ sortOrder);
		result.put("query", query);
		return result;
	}

	/**
	 * 根据id查询广告
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	@Transactional
	public @ResponseBody
	Adv get(@PathVariable("id") long id)
	{
		// 查询并返回结果
		return advRepo.findOne(id);
	}

	/**
	 * 创建新广告
	 * 
	 * @param adv json格式封装的广告订单对象
	 * @return 创建成功的广告活动
	 */
	@RequestMapping(method = RequestMethod.POST, headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.CREATED)
	@Transactional
	public @ResponseBody
	Adv create(@Valid @RequestBody Adv adv, HttpServletResponse reponse)
	{
		// 校验广告订单名称不可重复
		if (advRepo.findByAdvName(adv.getAdvName()).size() > 0)
		{
			throw new DuplicationNameException("AdvName duplication.");
		}

		// 时间格式校验
		Date startDate = TextUtil.parseDateFromInput(adv.getStartDate());
		Date endDate = TextUtil.parseDateFromInput(adv.getEndDate());
		if (startDate == null || endDate == null)
		{
			throw new InputValidateException("StartDate or EndDate is null.");
		}
		else if (startDate.after(endDate))
		{
			throw new InputValidateException("StartDate is later than EndDate.");
		}

		// 存入数据库
		adv.setCreateTime(TimeUtil.getServerTimeSecond());
		adv.setLastUpdateTime(TimeUtil.getServerTimeSecond());
		advRepo.save(adv);

		// 关联网站关系保存
		if (adv.getWebsite() != null)
		{
			for (String websiteId : adv.getWebsite())
			{
				AdvWebsiteRelation awr = new AdvWebsiteRelation(adv.getId(),
						Long.valueOf(websiteId));
				awrRepo.save(awr);
			}
		}

		// 推送区域关系保存
		if (adv.getArea() != null)
		{
			for (String areaId : adv.getArea())
			{
				AdvAreaRelation aar = new AdvAreaRelation(adv.getId(),
						Long.valueOf(areaId));
				aarRepo.save(aar);
			}
		}

		// 返回201码时，需要设置新资源的URL（非强制）
		reponse.setHeader("Location", "/advs/" + adv.getId());

		// 返回创建成功的活动信息
		return adv;
	}

	/**
	 * 修改广告订单
	 * 
	 * @param id
	 * @param activity
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.OK)
	@Transactional
	public @ResponseBody
	Adv put(@PathVariable("id") long id, @Valid @RequestBody Adv adv)
	{
		adv.setId(id);
		adv.setLastUpdateTime(TimeUtil.getServerTimeSecond());
		advRepo.save(adv);

		return adv;
	}

	/**
	 * 删除活动
	 * 
	 * @param ids
	 */
	@RequestMapping(value = "/{ids}", method = RequestMethod.DELETE)
	@ResponseStatus(value = HttpStatus.NO_CONTENT)
	@Transactional
	public void delete(@PathVariable("ids") String idString)
	{
		List<Long> idArry = new ArrayList<Long>();

		String[] ids = idString.split(",");
		for (String id : ids)
		{
			idArry.add(Long.valueOf(id));
		}

		advRepo.batchDelete(idArry);
		awrRepo.batchDelete(idArry);
		aarRepo.batchDelete(idArry);
	}

	/**
	 * 响应页面ajax校验请求
	 * 
	 * @param value 请求URL中携带的待校验值
	 * @param field 请求URL中携带的待校验字段名
	 * @return 返回json对象，详细内容见AjaxValidateFieldResult
	 */
	@RequestMapping(value = "checkNameIfDup", method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	public @ResponseBody
	AjaxValidateFieldResult ajaxValidateName(
			@RequestParam("value") String value,
			@RequestParam("field") String field,
			@RequestParam(value = "exceptId", required = false) Long exceptId)
	{
		String advName = TextUtil.parseTextFromInput(value);

		AjaxValidateFieldResult result = new AjaxValidateFieldResult();
		result.setValue(advName);

		List<Adv> advs = advRepo.findByAdvName(advName);
		if (advs == null || advs.size() == 0 || advs.get(0).getId() == exceptId)
		{
			result.setValid(true);
			result.setMessage("广告订单名称尚未使用，请继续输入其他信息");
		}
		else
		{
			result.setValid(false);
			result.setMessage("已经存在同名广告订单，请输入其他广告订单名称");
		}

		return result;
	}

	/**
	 * 广告文件上传
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/advFiles", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> upload(MultipartHttpServletRequest request,
			HttpServletResponse response)
	{
		Map<String, Object> result = new HashMap<String, Object>();
		MultipartFile multipartFile = request.getFile("trueAdvFile");

		// 校验文件大小,最大10兆
		if (multipartFile.getSize() > FILE_UPLOAD_SIZE_MAX)
		{
			throw new InputValidateException("广告文件超过最大容量限制：10M。");
		}

		// 提取并校验文件名扩展
		String fileExtension = multipartFile.getOriginalFilename().substring(
				multipartFile.getOriginalFilename().lastIndexOf("."));
		if (fileExtension == null
				|| !fileExtension.equalsIgnoreCase(FILE_UPLOAD_TYPE_ONLY))
		{
			// 文件名扩展有误
			throw new InputValidateException("广告文件不是.zip格式");
		}

		// 生成UUID新文件名字
		String newFilenameBase = UUID.randomUUID().toString();
		String newFilename = newFilenameBase + fileExtension;

		// 写入指定目录
		String filePath = FILE_UPLOAD_DIRECTRY + "/" + newFilename;
		File newFile = new File(filePath);
		try
		{
			multipartFile.transferTo(newFile);
		}
		catch (IOException e)
		{
			logger.error(
					"Could not upload file "
							+ multipartFile.getOriginalFilename(), e);

			throw new RuntimeException("文件上传失败，请联系管理员解决。");
		}

		result.put("path", filePath);
		return result;
	}

	public void setAdvRepository(AdvRepository advRepo)
	{
		this.advRepo = advRepo;
	}

	public void setAwrRepo(AdvWebsiteRelationRepository awrRepo)
	{
		this.awrRepo = awrRepo;
	}

	public void setAarRepo(AdvAreaRelationRepository aarRepo)
	{
		this.aarRepo = aarRepo;
	}
}
