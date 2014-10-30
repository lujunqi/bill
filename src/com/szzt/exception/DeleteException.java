package com.szzt.exception;

/**
 * 删除失败异常
 * 
 * @author 陈孟琳
 * 
 */
public class DeleteException extends RuntimeException
{
	private static final long serialVersionUID = 1303774453787186146L;

	public DeleteException()
	{
	}

	public DeleteException(String name)
	{
		super(name);
	}

}
