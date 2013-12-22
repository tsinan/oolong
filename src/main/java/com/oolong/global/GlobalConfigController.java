package com.oolong.global;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * 全局配置处理控制器，页面跳转、修改
 * 
 * @author liumeng
 * @since 2013-12-21
 */
@Controller
@RequestMapping(value = "/globalConfig")
public class GlobalConfigController
{
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory
			.getLogger(GlobalConfigController.class);

	@Autowired
	private GlobalConfigRepository globalConfigRepo;

	/******************************************************
	 * 页面跳转
	 ******************************************************/
	@RequestMapping(value = "/editPage", method = RequestMethod.GET)
	public String toEditGlobalConfigPage(HttpServletRequest request)
	{
		return "resource/editGlobalConfig";
	}

	/******************************************************
	 * 功能接口
	 ******************************************************/

	/**
	 * 根据id查询全局配置
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	@Transactional
	public @ResponseBody
	GlobalConfig get(@PathVariable("id") long id)
	{
		// 若ID为0，则为查询默认配置
		if (id == 0)
		{
			return GlobalConfig.buildDefaultGlobalConfig();
		}
		else
		{
			// 查询默认配置，若没有则创建
			List<GlobalConfig> list = globalConfigRepo.findAll();
			if (list.size() == 0)
			{
				GlobalConfig globalConfig = GlobalConfig
						.buildDefaultGlobalConfig();

				globalConfigRepo.save(globalConfig);
				return globalConfig;
			}
			else
			{
				return list.get(0);
			}
		}

	}

	/**
	 * 修改全局配置
	 * 
	 * @param id
	 * @param globalConfig
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, 
					headers = "Content-Type=application/json")
	@ResponseStatus(value = HttpStatus.OK)
	@Transactional
	public @ResponseBody
	GlobalConfig put(@PathVariable("id") long id,
			@Valid @RequestBody GlobalConfig globalConfig)
	{
		globalConfig.setId(id);
		globalConfigRepo.save(globalConfig);

		return globalConfig;
	}

	public void setGlobalConfigRepo(GlobalConfigRepository globalConfigRepo)
	{
		this.globalConfigRepo = globalConfigRepo;
	}

}
