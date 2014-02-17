package com.oolong.platform.web;

/**
 * jqBootstrapValidate页面Ajax校验结果回应信息
 * @author liumeng
 * @since 2013-11-24
 */
public class AjaxValidateFieldResult
{

	private String value;
	
	private boolean valid;
	
	private String message;

	public String getValue()
	{
		return value;
	}

	public void setValue(String value)
	{
		this.value = value;
	}

	public boolean getValid()
	{
		return valid;
	}

	public void setValid(boolean valid)
	{
		this.valid = valid;
	}

	public String getMessage()
	{
		return message;
	}

	public void setMessage(String message)
	{
		this.message = message;
	}
	
	
	
}
