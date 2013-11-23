package com.oolong.web.exception;

/**
 * Simulated business-logic exception indicating a desired business entity or
 * record cannot be found.
 */
@SuppressWarnings("serial")
public class UnknownResourceException extends RuntimeException
{

	public UnknownResourceException(String msg)
	{
		super(msg);
	}
}
