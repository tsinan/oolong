package com.oolong.global;

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
 * 免推送地址处理控制器，页面跳转、增、删、改、查、校验
 * 
 * @author liumeng
 * @since 2013-12-22
 */
@Controller
@RequestMapping(value = "/freePushUrls")
public class FreePushUrlController
{
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory
			.getLogger(FreePushUrlController.class);

	@Autowired
	private FreePushUrlRepository freePushUrlRepo;

	/******************************************************
	 * 页面跳转
	 ******************************************************/

	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public String toListFreePushUrlPage()
	{
		return "resource/listFreePushUrl";
	}

	/******************************************************
	 * 功能接口
	 ******************************************************/

	/**
	 * 查询免推送地址列表
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
			@RequestParam Integer page,	@RequestParam Integer pageSize, 
			@RequestParam String sortColumn,@RequestParam String sortOrder)
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
		List<FreePushUrl> list = null;
		long count = 0;
		if (queryUrl.length() > 0)
		{
			list = freePushUrlRepo.findByUrlLike( queryUrl, pageable);
			count = freePushUrlRepo.countByUrlLike( queryUrl);
		}
		else
		{
			list = freePushUrlRepo.findAll(pageable).getContent();
			count = freePushUrlRepo.count();
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
	 * @param freePushUrl json格式封装的关联网站对象
	 * @return 创建成功的关联网站
	 */
	@RequestMapping(method = RequestMethod.POST, headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.CREATED)
	@Transactional
	public @ResponseBody
	FreePushUrl create(@Valid @RequestBody FreePushUrl freePushUrl,
			HttpServletResponse reponse)
	{
		// 校验URL不可重复
		if (freePushUrlRepo.findByUrl(freePushUrl.getUrl()).size() > 0)
		{
			throw new DuplicationNameException("WebsiteUrl duplication.");
		}

		// 存入数据库
		freePushUrlRepo.save(freePushUrl);

		// 返回201码时，需要设置新资源的URL（非强制）
		reponse.setHeader("Location", "/freePushUrls/"+ freePushUrl.getId());

		// 返回创建成功的活动信息
		return freePushUrl;
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

		freePushUrlRepo.batchDelete(idArry);
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

		List<FreePushUrl> freePushUrls = freePushUrlRepo.findByUrl(url);
		if (freePushUrls == null || freePushUrls.size() == 0)
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

	public void setFreePushUrlRepo(FreePushUrlRepository freePushUrlRepo)
	{
		this.freePushUrlRepo = freePushUrlRepo;
	}

}
