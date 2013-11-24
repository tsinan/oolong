package com.oolong.adv;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.oolong.exception.DuplicationNameException;

/**
 * 
 * @author liumeng
 * @since 2013-11-20
 */
@Controller
@RequestMapping(value = "/activities")
public class ActivityController
{
	private static final Logger logger = LoggerFactory
			.getLogger(ActivityController.class);

	@Autowired
	private ActivityRepository activityRepo;
	


	/******************************************************
	 * 页面跳转
	 ******************************************************/
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String toCreateActivityPage()
	{
		return "adv/createActivity";
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String toListActivityPage()
	{
		return "adv/listActivity";
	}

	/******************************************************
	 * 功能接口
	 ******************************************************/
	@RequestMapping(method = RequestMethod.POST, headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.CREATED)
	@Transactional
	public @ResponseBody
	Activity create(@Valid @RequestBody Activity activity)
	{
		// TODO 根据时间和随机数生成活动编码，需要编码吗？
		
		// 去除活动名称前后的空格
		activity.setActivityName(activity.getActivityName().trim());
		
		// 校验活动名称不可重复
		if(activityRepo.findByActivityName(activity.getActivityName()).size()>0)
		{
			throw new DuplicationNameException("ActivityName duplication.");
		}
		
		// TODO 活动总数不超过限制，按公司还是按管理员？
		
		// 存入数据库
		activityRepo.save(activity);
		
		// 返回创建成功的活动信息
		return activity;
	}
	
	@RequestMapping(method = RequestMethod.GET, headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.OK)
	@Transactional
	public @ResponseBody 
	List<Activity> list()
	{
		return activityRepo.findAll();
	}
	
	@RequestMapping(value = "checkNameIfDup",method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	public @ResponseBody 
	AjaxValidateFieldResult ajaxValidateName(@RequestParam("value") String value,@RequestParam("field") String field)
	{
		String activityName="";
		try
		{
			activityName = new String(value.getBytes("iso-8859-1"),"utf-8");
		}
		catch (UnsupportedEncodingException e)
		{
			// do nothing...
		}
		activityName = activityName.trim();
		
		AjaxValidateFieldResult result = new AjaxValidateFieldResult();
		result.setValue(activityName);

		if(activityRepo.findByActivityName(activityName).size()>0)
		{
			result.setValid(false);
			result.setMessage("已经存在同名活动，请输入其他活动名称");
		}
		else
		{
			result.setValid(true);
			result.setMessage("活动名称尚未使用，请继续输入其他信息");
		}
		
		return result;
	}
	
	public void setActivityRepo(ActivityRepository activityRepo)
	{
		this.activityRepo = activityRepo;
	}
}
