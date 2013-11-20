package com.oolong.adv;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * @author liumeng
 * @since 2013-11-20
 */
@Controller
@RequestMapping(value = "/advActivity")
public class AdvActivityController
{
	private static final Logger logger = LoggerFactory
			.getLogger(AdvActivityController.class);

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String toCreateAdvActivityPage()
	{
		return "adv/createAdvActivity";
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String toListAdvActivityPage()
	{
		return "adv/listAdvActivity";
	}

	@RequestMapping(method = RequestMethod.POST, headers = "Content-Type=application/json")
	public @ResponseBody
	AdvActivity create(@RequestBody AdvActivity advAct, HttpServletResponse response)
	{
		System.out.println(advAct);
		
		return advAct;
	}
}
