package com.oolong.area;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.oolong.exception.DuplicationNameException;
import com.oolong.util.IpUtil;
import com.oolong.util.TextUtil;
import com.oolong.web.AjaxValidateFieldResult;

/**
 * 区域IP段处理控制器，页面跳转、增、删、查、校验
 * 
 * @author liumeng
 * @since 2013-12-22
 */
@Controller
@RequestMapping(value = "/areas/{id}/areaIps")
public class IpSegmentController
{
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory
			.getLogger(IpSegmentController.class);

	@Autowired
	private IpSegmentRepository ipSegmentRepo;

	/******************************************************
	 * 页面跳转
	 ******************************************************/

	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public String toListIpSegmentPage()
	{
		return "resource/listAreaIp";
	}

	/******************************************************
	 * 功能接口
	 ******************************************************/

	/**
	 * 查询IP地址段列表
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
	Map<String, Object> list(@PathVariable("id") long areaId,
			@RequestParam(required = false) String query,
			@RequestParam(required = false) Integer page,
			@RequestParam(required = false) Integer pageSize,
			@RequestParam(required = false) String sortColumn,
			@RequestParam(required = false) String sortOrder)
	{
		// 构造分页和排序对象
		Pageable pageable = TextUtil.parsePageableObj(page, pageSize,
				sortOrder, sortColumn, "ipStart");

		long queryIp = 0;
		if (query != null && query.length() > 0)
		{
			queryIp = IpUtil.convertIpAddressFromText(query);
		}

		// 查询
		List<IpSegment> list = null;
		long count = 0;
		if (queryIp > 0)
		{
			list = ipSegmentRepo.findByAreaIdAndIpAddr(areaId, queryIp,
					pageable);
			count = ipSegmentRepo.countByAreaIdAndIpAddr(areaId, queryIp);
		}
		else
		{
			list = ipSegmentRepo.findByAreaId(areaId, pageable);
			count = ipSegmentRepo.countByAreaId(areaId);
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
	 * 创建新IP地址段
	 * 
	 * @param ipSegment json格式封装的关联网站对象
	 * @return 创建成功的IP地址段
	 */
	@RequestMapping(method = RequestMethod.POST, headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.CREATED)
	@Transactional
	public @ResponseBody
	IpSegment create(@PathVariable("id") long areaId,
			@Valid @RequestBody IpSegment ipSegment, HttpServletResponse reponse)
	{
		// 计算起止IP地址
		long[] address = IpUtil.computeIpAddressByMask(
				ipSegment.getIpStartText(), ipSegment.getMaskLength());
		ipSegment.setIpStart(address[0]);
		ipSegment.setIpEnd(address[1]);

		// 校验IP不可重叠
		if (ipSegmentRepo.findConflictsByIpAddress(ipSegment.getIpStart(),
				ipSegment.getIpEnd()).size() > 0)
		{
			throw new DuplicationNameException("IpAddress duplication.");
		}

		// 存入数据库
		ipSegment.setAreaId(areaId);
		ipSegmentRepo.save(ipSegment);

		// 返回201码时，需要设置新资源的URL（非强制）
		reponse.setHeader("Location", "/areas/" + ipSegment.getAreaId() + "/"
				+ ipSegment.getId());

		// 返回创建成功的活动信息
		return ipSegment;
	}

	/**
	 * 删除IP地址段
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

		ipSegmentRepo.batchDelete(idArry);
	}

	/**
	 * 响应页面ajax校验请求
	 * 
	 * @param ip 请求URL中携带的待校验IP
	 * @param maskLength 请求URL中携带的待校验掩码长度
	 * @return 返回json对象，详细内容见AjaxValidateFieldResult
	 */
	@RequestMapping(value = "checkIpSegmentIfDup", method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	public @ResponseBody
	AjaxValidateFieldResult ajaxValidateName(@RequestParam("ip") String ip,
			@RequestParam("maskLength") int maskLength)
	{
		AjaxValidateFieldResult result = new AjaxValidateFieldResult();

		// 计算起止IP地址
		long[] address = IpUtil.computeIpAddressByMask(ip, maskLength);

		// 校验IP不可重叠
		if (ipSegmentRepo.findConflictsByIpAddress(address[0], address[1])
				.size() > 0)
		{
			result.setValid(false);
		}
		else
		{
			result.setValid(true);
		}

		return result;
	}

	public void setIpSegmentRepo(IpSegmentRepository ipSegmentRepo)
	{
		this.ipSegmentRepo = ipSegmentRepo;
	}
}
