package com.szzt.model;

/**
 * 通用键值对信息
 * 
 * @author 陈孟琳
 * 
 */
public class KeyValueModel
{
	private String key;
	private String value;
	private boolean check;

	public boolean isCheck()
	{
		return check;
	}

	public void setCheck(boolean check)
	{
		this.check = check;
	}

	public String getKey()
	{
		return key;
	}

	public void setKey(String key)
	{
		this.key = key;
	}

	public String getValue()
	{
		return value;
	}

	public void setValue(String value)
	{
		this.value = value;
	}

}
