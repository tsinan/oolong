package com.oolong.adv;

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

import com.oolong.platform.exception.DuplicationNameException;
import com.oolong.platform.util.TextUtil;
import com.oolong.platform.util.TimeUtil;
import com.oolong.platform.web.AjaxValidateFieldResult;

/**
 * 活动处理控制器，页面跳转、增、删、改、查、校验
 * 
 * @author liumeng
 * @since 2013-11-20
 */
@Controller
@RequestMapping(value = "/activities")
public class ActivityController
{

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory
			.getLogger(ActivityController.class);

	@Autowired
	private ActivityRepository activityRepo;
	
	@Autowired
	private AdvRepository advRepo;

	/******************************************************
	 * 页面跳转
	 ******************************************************/
	@RequestMapping(value = "/createPage", method = RequestMethod.GET)
	public String toCreateActivityPage()
	{
		return "adv/createActivity";
	}

	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public String toListActivityPage()
	{
		return "adv/listActivity";
	}

	@RequestMapping(value = "/editPage", method = RequestMethod.GET)
	public String toEditActivityPage(HttpServletRequest request)
	{
		return "adv/editActivity";
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
	Map<String, Object> list(@RequestParam(required = false) String query,
			@RequestParam(required = false) Integer page,
			@RequestParam(required = false) Integer pageSize,
			@RequestParam(required = false) String sortColumn,
			@RequestParam(required = false) String sortOrder)
	{
		// 构造分页和排序对象
		Pageable pageable = TextUtil.parsePageableObj(page, pageSize,
				sortOrder, sortColumn, "lastUpdateTime");

		// 需要考虑解码
		String actiNameLike = TextUtil.buildLikeText(query);

		List<Activity> list = null;
		long count = 0;
		if (actiNameLike.length() > 0)
		{
			list = activityRepo.findByActivityNameLike(actiNameLike, pageable);
			count = activityRepo.countByActivityNameLike(actiNameLike);
		}
		else
		{
			list = activityRepo.findAll(pageable).getContent();
			count = activityRepo.count();
		}
		
		// 查询各个广告活动的广告订单数量
		for(Activity acti:list)
		{
			acti.setAdvCount(advRepo.countByActivityId(acti.getId()));
		}

		// 查询并返回结果
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("currentPage", list);
		result.put("totalRows", Long.valueOf(count));

		// 将分页和查询条件放入结果集
		result.put("paging", page + "|" + pageSize + "|" + sortColumn + "|"
				+ sortOrder);
		// 页面传递参数encode两次，因容器进行了一次decode，此处需要encode一次发到页面
		result.put("query", TextUtil.encodeURIComposite(query));	
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
		// 校验活动名称不可重复
		if (activityRepo.findByActivityName(activity.getActivityName()).size() > 0)
		{
			throw new DuplicationNameException("ActivityName duplication.");
		}

		// 存入数据库
		activity.setCreateTime(TimeUtil.getServerTimeSecond());
		activity.setLastUpdateTime(TimeUtil.getServerTimeSecond());
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
		
		// 校验活动名称不可重复
		List<Activity> activities = activityRepo
				.findByActivityName(activity.getActivityName());
		if (activities.size() >= 0
				&& activities.get(0).getId() != id)
		{
			throw new DuplicationNameException("ActivityName duplication.");
		}
				
		activity.setLastUpdateTime(TimeUtil.getServerTimeSecond());
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
		String[] ids = idString.split(",");
		for (String id : ids)
		{
			long toDelete = Long.valueOf(id);

			//检查是否有广告，有广告的活动，不能删除
			long advCount = advRepo.countByActivityId(toDelete);
			if(advCount == 0)
			{
				activityRepo.delete(toDelete);
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
		String activityName = TextUtil.parseTextFromInput(value);

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

	public void setAdvRepo(AdvRepository advRepo)
	{
		this.advRepo = advRepo;
	}
	
	
}
