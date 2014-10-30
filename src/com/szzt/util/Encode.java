package com.szzt.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

/**
 * 转换中文编码
 * 
 * @author 陈孟琳
 * 
 */
public class Encode
{
	public static final String ENCODE = "UTF-8";

	public static String decode(String value)
			throws UnsupportedEncodingException
	{
		if (null == value)
		{
			value = "";
		}
		String de = URLDecoder.decode(value, ENCODE);
		return URLDecoder.decode(de, ENCODE);
	}

	/**
	 * 转换成UTF-8编码
	 * 
	 * @param value
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String encodeUTF8(String value)
			throws UnsupportedEncodingException
	{
		if (null == value)
		{
			value = "";
		}
		String en = URLEncoder.encode(value, ENCODE);
		return URLEncoder.encode(en, ENCODE);
	}
}
