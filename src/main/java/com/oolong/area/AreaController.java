package com.oolong.area;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
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
import com.oolong.web.AjaxValidateFieldResult;

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
	Map<String, Object> list(@RequestParam String query,
			@RequestParam Integer page, @RequestParam Integer pageSize,
			@RequestParam String sortColumn, @RequestParam String sortOrder)
	{
		// 构造分页和排序对象
		Direction direction = Direction.fromStringOrNull(sortOrder) != null ? Direction
				.fromString(sortOrder) : Direction.DESC;
		Pageable pageable = new PageRequest(page, pageSize, direction,
				sortColumn, "lastUpdateTime");

		// TODO 需要考虑解码
		String areaName = null;
		if (query != null && query.length() > 0)
		{
			areaName = "%"+ query +"%";
		}
		else
		{
			areaName = "";
		}

		List<Area> list = null;
		long count = 0;
		if (areaName.length() > 0)
		{
			list = areaRepo.findByAreaNameLike(areaName, pageable);
			count = areaRepo.countByAreaNameLike(areaName);
		}
		else
		{
			list = areaRepo.findAll(pageable).getContent();
			count = areaRepo.count();
		}
		
		// 查找URL数量
//		for(Area area:list)
//		{
//			long urlCount = websiteUrlRepo.countByWebsiteId(area.getId());
//			area.setUrlCount(urlCount);
//		}

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
	Area create(@Valid @RequestBody Area area,
			HttpServletResponse reponse)
	{
		// 校验关联网站名称不可重复
		if (areaRepo.findByAreaName(area.getAreaName()).size() > 0)
		{
			throw new DuplicationNameException("AreaName duplication.");
		}

		// 存入数据库
		long now = System.currentTimeMillis();
		area.setCreateTime(now);
		area.setLastUpdateTime(now);
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
	Area put(@PathVariable("id") long id,
			@Valid @RequestBody Area area)
	{
		area.setId(id);
		area.setLastUpdateTime(System.currentTimeMillis());
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
		List<Long> idArry = new ArrayList<Long>();

		String[] ids = idString.split(",");
		for (String id : ids)
		{
			idArry.add(Long.valueOf(id));
		}
		
//		websiteUrlRepo.deleteUrlsByWebsiteId(idArry);
		areaRepo.batchDelete(idArry);
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
		String areaName = "";
		try
		{
			areaName = new String(value.getBytes("iso-8859-1"), "utf-8");
		}
		catch (UnsupportedEncodingException e)
		{
			// do nothing...
		}
		areaName = areaName.trim();

		AjaxValidateFieldResult result = new AjaxValidateFieldResult();
		result.setValue(areaName);

		List<Area> areas = areaRepo
				.findByAreaName(areaName);
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
	
}
