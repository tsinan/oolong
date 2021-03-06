package com.oolong.website;

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

import com.oolong.adv.AdvWebsiteRelationRepository;
import com.oolong.platform.exception.DuplicationNameException;
import com.oolong.platform.util.TextUtil;
import com.oolong.platform.util.TimeUtil;
import com.oolong.platform.web.AjaxValidateFieldResult;

/**
 * 关联网站处理控制器，页面跳转、增、删、改、查、校验
 * 
 * @author liumeng
 * @since 2013-12-05
 */
@Controller
@RequestMapping(value = "/websites")
public class WebsiteController
{
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory
			.getLogger(WebsiteController.class);

	@Autowired
	private WebsiteRepository websiteRepo;

	@Autowired
	private WebsiteUrlRepository websiteUrlRepo;
	
	@Autowired
	private AdvWebsiteRelationRepository awrRepo;

	/******************************************************
	 * 页面跳转
	 ******************************************************/
	@RequestMapping(value = "/createPage", method = RequestMethod.GET)
	public String toCreateWebsitePage()
	{
		return "resource/createWebsite";
	}

	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public String toListWebsitePage()
	{
		return "resource/listWebsite";
	}

	@RequestMapping(value = "/editPage", method = RequestMethod.GET)
	public String toEditWebsitePage(HttpServletRequest request)
	{
		return "resource/editWebsite";
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

		// 解析查询条件
		String websiteNameLike = TextUtil.buildLikeText(query);

		List<Website> list = null;
		long count = 0;
		if (websiteNameLike.length() > 0)
		{
			list = websiteRepo.findByWebsiteNameLike(websiteNameLike, pageable);
			count = websiteRepo.countByWebsiteNameLike(websiteNameLike);
		}
		else
		{
			list = websiteRepo.findAll(pageable).getContent();
			count = websiteRepo.count();
		}

		for (Website website : list)
		{
			// 查找URL数量
			long urlCount = websiteUrlRepo.countByWebsiteId(website.getId());
			website.setUrlCount(urlCount);
			
			// 查找关联的广告数量
			long advRelationCount = awrRepo.countByWebsiteId(website.getId());
			website.setAdvRelationCount(advRelationCount);
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
	 * 根据id查询关联网站
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	@Transactional
	public @ResponseBody
	Website get(@PathVariable("id") long id)
	{
		// 查询并返回结果
		return websiteRepo.findOne(id);
	}

	/**
	 * 创建新关联网站
	 * 
	 * @param website json格式封装的关联网站对象
	 * @return 创建成功的关联网站
	 */
	@RequestMapping(method = RequestMethod.POST, headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.CREATED)
	@Transactional
	public @ResponseBody
	Website create(@Valid @RequestBody Website website,
			HttpServletResponse reponse)
	{
		// 校验关联网站名称不可重复
		if (websiteRepo.findByWebsiteName(website.getWebsiteName()).size() > 0)
		{
			throw new DuplicationNameException("WebsiteName duplication.");
		}

		// 存入数据库
		website.setCreateTime(TimeUtil.getServerTimeSecond());
		website.setLastUpdateTime(TimeUtil.getServerTimeSecond());
		websiteRepo.save(website);

		// 返回201码时，需要设置新资源的URL（非强制）
		reponse.setHeader("Location", "/websites/" + website.getId());

		// 返回创建成功的活动信息
		return website;
	}

	/**
	 * 修改关联网站
	 * 
	 * @param id
	 * @param website
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.OK)
	@Transactional
	public @ResponseBody
	Website put(@PathVariable("id") long id, @Valid @RequestBody Website website)
	{
		website.setId(id);
		website.setLastUpdateTime(TimeUtil.getServerTimeSecond());
		websiteRepo.save(website);

		return website;
	}

	/**
	 * 删除关联网站
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
			long advCount = awrRepo.countByWebsiteId(toDelete);
			if(advCount == 0)
			{
				websiteUrlRepo.deleteByWebsiteId(toDelete);
				websiteRepo.delete(toDelete);
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
			@RequestParam(required = false) Long exceptId)
	{
		String websiteName = TextUtil.parseTextFromInput(value);

		AjaxValidateFieldResult result = new AjaxValidateFieldResult();
		result.setValue(websiteName);

		List<Website> websites = websiteRepo.findByWebsiteName(websiteName);
		if (websites == null || websites.size() == 0
				|| websites.get(0).getId() == exceptId)
		{
			result.setValid(true);
			result.setMessage("关联网站名称尚未使用，请继续输入其他信息");
		}
		else
		{
			result.setValid(false);
			result.setMessage("已经存在同名关联网站，请输入其他关联网站名称");
		}

		return result;
	}

	public void setWebsiteRepo(WebsiteRepository websiteRepo)
	{
		this.websiteRepo = websiteRepo;
	}

	public void setWebsiteUrlRepo(WebsiteUrlRepository websiteUrlRepo)
	{
		this.websiteUrlRepo = websiteUrlRepo;
	}

	public void setAwrRepo(AdvWebsiteRelationRepository awrRepo)
	{
		this.awrRepo = awrRepo;
	}

	
}
