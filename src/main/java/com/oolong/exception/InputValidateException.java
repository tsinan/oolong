package com.oolong.exception;

/**
 * 
 * @author liumeng
 * @since 2014-01-12
 */
@SuppressWarnings("serial")
public class InputValidateException extends RuntimeException
{
	public InputValidateException(String msg)
	{
		super(msg);
	}
}
