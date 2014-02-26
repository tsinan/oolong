package com.oolong.area;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.oolong.adv.AdvAreaRelationRepository;
import com.oolong.platform.exception.DuplicationNameException;
import com.oolong.platform.util.TextUtil;
import com.oolong.platform.util.TimeUtil;
import com.oolong.platform.web.AjaxValidateFieldResult;

/**
 * 区域处理控制器，页面跳转、增、删、改、查、校验
 * 
 * @author liumeng
 * @since 2013-12-22
 */
@Controller
@RequestMapping(value = "/areas")
public class AreaController
{
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory
			.getLogger(AreaController.class);

	@Autowired
	private AreaRepository areaRepo;
	
	@Autowired
	private IpSegmentRepository ipSegmentRepo;
	
	@Autowired
	private AdvAreaRelationRepository aarRepo;



	/******************************************************
	 * 页面跳转
	 ******************************************************/
	@RequestMapping(value = "/createPage", method = RequestMethod.GET)
	public String toCreateAreaPage()
	{
		return "resource/createArea";
	}

	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public String toListAreaPage()
	{
		return "resource/listArea";
	}

	@RequestMapping(value = "/editPage", method = RequestMethod.GET)
	public String toEditAreaPage(HttpServletRequest request)
	{
		return "resource/editArea";
	}

	/******************************************************
	 * 功能接口
	 ******************************************************/

	/**
	 * 查询关联网站列表
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
	Map<String, Object> list(@RequestParam(required = false) String query,
			@RequestParam(required = false) Integer page,
			@RequestParam(required = false) Integer pageSize,
			@RequestParam(required = false) String sortColumn,
			@RequestParam(required = false) String sortOrder)
	{
		// 构造分页和排序对象
		Pageable pageable = TextUtil.parsePageableObj(page, pageSize,
				sortOrder, sortColumn, "lastUpdateTime");

		String areaNameLike = TextUtil.buildLikeText(query);

		List<Area> list = null;
		long count = 0;
		if (areaNameLike.length() > 0)
		{
			list = areaRepo.findByAreaNameLike(areaNameLike, pageable);
			count = areaRepo.countByAreaNameLike(areaNameLike);
		}
		else
		{
			list = areaRepo.findAll(pageable).getContent();
			count = areaRepo.count();
		}

		 for(Area area:list)
		 {
			 // 查找IP段数量
			 long ipCount = ipSegmentRepo.countByAreaId(area.getId());
			 area.setIpCount(ipCount);
			 
			 // 查询关联广告数量
			 long advRelationCount = aarRepo.countByAreaId(area.getId());
			 area.setAdvRelationCount(advRelationCount);
		 }

		// 查询并返回结果
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("currentPage", list);
		result.put("totalRows", Long.valueOf(count));

		result.put("paging", page + "|" + pageSize + "|" + sortColumn + "|"
				+ sortOrder);
		// 页面传递参数encode两次，因容器进行了一次decode，此处需要encode一次发到页面
		result.put("query", TextUtil.encodeURIComposite(query));	
		return result;
	}

	/**
	 * 根据id查询区域
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	@Transactional
	public @ResponseBody
	Area get(@PathVariable("id") long id)
	{
		// 查询并返回结果
		return areaRepo.findOne(id);
	}

	/**
	 * 创建新区域
	 * 
	 * @param area json格式封装的关联网站对象
	 * @return 创建成功的区域
	 */
	@RequestMapping(method = RequestMethod.POST, headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.CREATED)
	@Transactional
	public @ResponseBody
	Area create(@Valid @RequestBody Area area, HttpServletResponse reponse)
	{
		// 校验关联网站名称不可重复
		if (areaRepo.findByAreaName(area.getAreaName()).size() > 0)
		{
			throw new DuplicationNameException("AreaName duplication.");
		}

		// 存入数据库
		area.setCreateTime(TimeUtil.getServerTimeSecond());
		area.setLastUpdateTime(TimeUtil.getServerTimeSecond());
		areaRepo.save(area);

		// 返回201码时，需要设置新资源的URL（非强制）
		reponse.setHeader("Location", "/areas/" + area.getId());

		// 返回创建成功的活动信息
		return area;
	}

	/**
	 * 修改区域
	 * 
	 * @param id
	 * @param area
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.OK)
	@Transactional
	public @ResponseBody
	Area put(@PathVariable("id") long id, @Valid @RequestBody Area area)
	{
		area.setId(id);
		area.setLastUpdateTime(TimeUtil.getServerTimeSecond());
		areaRepo.save(area);

		return area;
	}

	/**
	 * 删除区域
	 * 
	 * @param ids
	 */
	@RequestMapping(value = "/{ids}", method = RequestMethod.DELETE)
	@ResponseStatus(value = HttpStatus.NO_CONTENT)
	@Transactional
	public void delete(@PathVariable("ids") String idString)
	{
		String[] ids = idString.split(",");
		for (String id : ids)
		{
			long toDelete = Long.valueOf(id);
			
			// 检查是否有广告，有广告的活动，不能删除
			long advCount = aarRepo.countByAreaId(toDelete);
			if(advCount == 0)
			{
				ipSegmentRepo.deleteByAreaId(toDelete);
				areaRepo.delete(toDelete);
			}
		}

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
		String areaName = TextUtil.parseTextFromInput(value);

		AjaxValidateFieldResult result = new AjaxValidateFieldResult();
		result.setValue(areaName);

		List<Area> areas = areaRepo.findByAreaName(areaName);
		if (areas == null || areas.size() == 0
				|| areas.get(0).getId() == exceptId)
		{
			result.setValid(true);
			result.setMessage("区域名称尚未使用，请继续输入其他信息");
		}
		else
		{
			result.setValid(false);
			result.setMessage("已经存在同名区域，请输入其他区域名称");
		}

		return result;
	}

	public void setAreaRepo(AreaRepository areaRepo)
	{
		this.areaRepo = areaRepo;
	}

	public void setIpSegmentRepo(IpSegmentRepository ipSegmentRepo)
	{
		this.ipSegmentRepo = ipSegmentRepo;
	}

	public void setAarRepo(AdvAreaRelationRepository aarRepo)
	{
		this.aarRepo = aarRepo;
	}
	
	
}
