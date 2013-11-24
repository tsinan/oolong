package com.oolong.exception;

/**
 *
 * @author liumeng
 * @since 2013-11-24
 */
@SuppressWarnings("serial")
public class DuplicationNameException extends RuntimeException
{
	public DuplicationNameException(String msg)
	{
		super(msg);
	}
}
