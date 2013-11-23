package com.oolong.adv;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * 
 * @author liumeng
 * @since 2013-11-20
 */
@Controller
@RequestMapping(value = "/activity")
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
		// 业务相关处理
		logger.info(activity.toString());
		
		// 存入数据库
		activityRepo.save(activity);
		
		// 返回创建成功的活动信息
		return activity;
	}
	
	public void setActivityRepo(ActivityRepository activityRepo)
	{
		this.activityRepo = activityRepo;
	}
}
