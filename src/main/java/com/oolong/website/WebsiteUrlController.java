package com.oolong.website;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
 * 关联网站地址处理控制器，页面跳转、增、删、改、查、校验
 * 
 * @author liumeng
 * @since 2013-12-07
 */
@Controller
@RequestMapping(value = "/websites/{id}/websiteUrls")
public class WebsiteUrlController
{
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory
			.getLogger(WebsiteUrlController.class);

	@Autowired
	private WebsiteUrlRepository websiteUrlRepo;

	/******************************************************
	 * 页面跳转
	 ******************************************************/

	@RequestMapping(value = "/listUrl", method = RequestMethod.GET)
	public String toListWebsiteUrlPage()
	{
		return "resource/listWebsiteUrl";
	}

	/******************************************************
	 * 功能接口
	 ******************************************************/

	/**
	 * 查询关联网站地址列表
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
	Map<String, Object> list(@PathVariable("id") long websiteId,
			@RequestParam String query, @RequestParam Integer page,
			@RequestParam Integer pageSize, @RequestParam String sortColumn,
			@RequestParam String sortOrder)
	{
		// 构造分页和排序对象
		Direction direction = Direction.fromStringOrNull(sortOrder) != null ? Direction
				.fromString(sortOrder) : Direction.DESC;
		Pageable pageable = new PageRequest(page, pageSize, direction,
				sortColumn, "url");

		// TODO 需要考虑解码
		String queryUrl = null;
		if (query != null && query.length() > 0)
		{
			queryUrl = "%" + query + "%";
		}
		else
		{
			queryUrl = "";
		}

		// 查询
		List<WebsiteUrl> list = null;
		long count = 0;
		if (queryUrl.length() > 0)
		{
			list = websiteUrlRepo.findByWebsiteIdAndUrlLike(websiteId, queryUrl, pageable);
			count = websiteUrlRepo.countByWebsiteIdAndUrlLike(websiteId, queryUrl);
		}
		else
		{
			list = websiteUrlRepo.findByWebsiteId(websiteId, pageable);
			count = websiteUrlRepo.countByWebsiteId(websiteId);
		}

		// 添加显示类型名称
		for (WebsiteUrl websiteUrl : list)
		{
			switch (websiteUrl.getUrlType())
			{
			case 1:
				websiteUrl.setUrlTypeName("精确匹配");
				break;
			case 2:
				websiteUrl.setUrlTypeName("前缀匹配");
				break;
			case 3:
				websiteUrl.setUrlTypeName("包含匹配");
				break;
			default:
				websiteUrl.setUrlTypeName("精确匹配");
				break;
			}
		}

		// 查询并返回结果
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("currentPage", list);
		result.put("totalRows", Long.valueOf(count));

		// 将分页和查询条件放入结果集
		result.put("paging", page + "|" + pageSize + "|" + sortColumn + "|"
				+ sortOrder);
		result.put("query", query);
		
		return result;
	}

	/**
	 * 创建新活动
	 * 
	 * @param websiteUrl json格式封装的关联网站对象
	 * @return 创建成功的关联网站
	 */
	@RequestMapping(method = RequestMethod.POST, headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.CREATED)
	@Transactional
	public @ResponseBody
	WebsiteUrl create(@PathVariable("id") long websiteId,
			@Valid @RequestBody WebsiteUrl websiteUrl,
			HttpServletResponse reponse)
	{
		// 校验URL不可重复
		if (websiteUrlRepo.findByUrl(websiteUrl.getUrl()).size() > 0)
		{
			throw new DuplicationNameException("WebsiteUrl duplication.");
		}

		// 存入数据库
		websiteUrl.setWebsiteId(websiteId);
		websiteUrlRepo.save(websiteUrl);

		// 返回201码时，需要设置新资源的URL（非强制）
		reponse.setHeader("Location", "/websites/" + websiteUrl.getWebsiteId()
				+ "/" + websiteUrl.getId());

		// 返回创建成功的活动信息
		return websiteUrl;
	}

	/**
	 * 删除网站地址
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

		websiteUrlRepo.batchDelete(idArry);
	}

	/**
	 * 响应页面ajax校验请求
	 * 
	 * @param value 请求URL中携带的待校验值
	 * @param field 请求URL中携带的待校验字段名
	 * @return 返回json对象，详细内容见AjaxValidateFieldResult
	 */
	@RequestMapping(value = "checkUrlIfDup", method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	public @ResponseBody
	AjaxValidateFieldResult ajaxValidateName(
			@RequestParam("value") String value,
			@RequestParam("field") String field)
	{
		String url = "";
		try
		{
			url = new String(value.getBytes("iso-8859-1"), "utf-8");
		}
		catch (UnsupportedEncodingException e)
		{
			// do nothing...
		}
		url = url.trim();

		AjaxValidateFieldResult result = new AjaxValidateFieldResult();
		result.setValue(url);

		List<WebsiteUrl> websiteUrls = websiteUrlRepo.findByUrl(url);
		if (websiteUrls == null || websiteUrls.size() == 0)
		{
			result.setValid(true);
			result.setMessage("站点地址未重复，请继续输入其他信息");
		}
		else
		{
			result.setValid(false);
			result.setMessage("已经存在相同站点地址，请输入其他站点地址");
		}

		return result;
	}

	public void setWebsiteUrlRepo(WebsiteUrlRepository websiteUrlRepo)
	{
		this.websiteUrlRepo = websiteUrlRepo;
	}
}
