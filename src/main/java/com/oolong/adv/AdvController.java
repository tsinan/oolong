package com.oolong.adv;

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
	private ActivityRepository activityRepo;

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
	 * 查询活动列表
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

		// 获取查询字符串，格式为“活动公司|活动名称”
		// TODO 需要考虑解码
		String[] queryCond = query.split("|");
		String actiName = null;
		if(queryCond.length == 3)
		{
			// String company = queryCond[0]; // 暂不考虑
			actiName = "%"+queryCond[2]+"%";
		}
		else
		{
			// String company = queryCond[0]; // 暂不考虑
			actiName = "";
		}

		List<Activity> list = null;
		long count = 0;
		if (actiName.length() > 0)
		{
			list = activityRepo.findByActivityNameLike(actiName, pageable);
			count = activityRepo.countByActivityNameLike(actiName);
		}
		else
		{
			list = activityRepo.findAll(pageable).getContent();
			count = activityRepo.count();
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
	 * 根据id查询活动
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	@Transactional
	public @ResponseBody
	Activity get(@PathVariable("id") long id)
	{
		// 查询并返回结果
		return activityRepo.findOne(id);
	}

	/**
	 * 创建新活动
	 * 
	 * @param activity json格式封装的广告活动对象
	 * @return 创建成功的广告活动
	 */
	@RequestMapping(method = RequestMethod.POST, headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.CREATED)
	@Transactional
	public @ResponseBody
	Activity create(@Valid @RequestBody Activity activity,
			HttpServletResponse reponse)
	{
		// TODO 根据时间和随机数生成活动编码，需要编码吗？

		// 校验活动名称不可重复
		if (activityRepo.findByActivityName(activity.getActivityName()).size() > 0)
		{
			throw new DuplicationNameException("ActivityName duplication.");
		}

		// TODO 活动总数不超过限制，按公司还是按管理员？

		// 存入数据库
		long now = System.currentTimeMillis();
		activity.setCreateTime(now);
		activity.setLastUpdateTime(now);
		activityRepo.save(activity);

		// 返回201码时，需要设置新资源的URL（非强制）
		reponse.setHeader("Location", "/activities/" + activity.getId());

		// 返回创建成功的活动信息
		return activity;
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
	Activity put(@PathVariable("id") long id,
			@Valid @RequestBody Activity activity)
	{
		activity.setId(id);
		activity.setLastUpdateTime(System.currentTimeMillis());
		activityRepo.save(activity);

		return activity;
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

		activityRepo.batchDelete(idArry);
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
		String activityName = "";
		try
		{
			activityName = new String(value.getBytes("iso-8859-1"), "utf-8");
		}
		catch (UnsupportedEncodingException e)
		{
			// do nothing...
		}
		activityName = activityName.trim();

		AjaxValidateFieldResult result = new AjaxValidateFieldResult();
		result.setValue(activityName);

		List<Activity> activities = activityRepo
				.findByActivityName(activityName);
		if (activities == null || activities.size() == 0
				|| activities.get(0).getId() == exceptId)
		{
			result.setValid(true);
			result.setMessage("活动名称尚未使用，请继续输入其他信息");
		}
		else
		{
			result.setValid(false);
			result.setMessage("已经存在同名活动，请输入其他活动名称");
		}

		return result;
	}

	public void setActivityRepo(ActivityRepository activityRepo)
	{
		this.activityRepo = activityRepo;
	}
}
