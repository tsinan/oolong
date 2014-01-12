package com.oolong.adv;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
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

import com.oolong.exception.DuplicationNameException;
import com.oolong.exception.InputValidateException;
import com.oolong.util.TextUtil;
import com.oolong.web.AjaxValidateFieldResult;

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
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory
			.getLogger(AdvController.class);

	@Autowired
	private AdvRepository advRepo;

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
	 * 查询广告列表
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
		Direction direction = Direction.fromStringOrNull(sortOrder) != null ? Direction
				.fromString(sortOrder) : Direction.DESC;
		Pageable pageable = new PageRequest(page, pageSize, direction,
				sortColumn, "lastUpdateTime");

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
		long now = System.currentTimeMillis();
		adv.setCreateTime(now);
		adv.setLastUpdateTime(now);
		advRepo.save(adv);

		// 关联网站关系保存
		for (String websiteId : adv.getWebsite())
		{
			AdvWebsiteRelation awr = new AdvWebsiteRelation(adv.getId(),
					Long.valueOf(websiteId));
			awrRepo.save(awr);
		}

		// 推送区域关系保存
		for (String areaId : adv.getAreas())
		{
			AdvAreaRelation aar = new AdvAreaRelation(adv.getId(),
					Long.valueOf(areaId));
			aarRepo.save(aar);
		}

		// 返回201码时，需要设置新资源的URL（非强制）
		reponse.setHeader("Location", "/advs/" + adv.getId());

		// 返回创建成功的活动信息
		return adv;
	}

	/**
	 * 修改活动
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
		adv.setLastUpdateTime(System.currentTimeMillis());
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
			System.out.println(" " + Long.valueOf(id));
			idArry.add(Long.valueOf(id));
		}

		advRepo.batchDelete(idArry);
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
