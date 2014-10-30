package com.szzt.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 将request请求信息封装成model对象
 * <p>
 * 注意：日期只支持java.util.Date类型,默认格式为"yyyy-MM-dd"
 * </p>
 * 
 * @author 陈孟琳
 * 
 */

public class BindRequest
{
	private SimpleDateFormat format = null;
	private String format_type = "yyyy-MM-dd";

	public BindRequest()
	{
	}

	/**
	 * 
	 * @param format_type
	 *            日期格式 默认为yyyy-MM-dd
	 */
	public BindRequest(String format_type)
	{
		this.format_type = format_type;
	}

	private Date format(String value) throws ParseException
	{
		if (null == format)
			format = new SimpleDateFormat(format_type);
		return format.parse(value);
	}

	@SuppressWarnings("unchecked")
	public <T> T toModel(HttpServletRequest request, Class<? extends Object> c)
			throws Exception
	{
		Object instance = c.newInstance();
		Map<String, String[]> attributes = request.getParameterMap();
		Iterator<String> it = attributes.keySet().iterator();
		while (it.hasNext())
		{
			String name = it.next();

			String value = request.getParameter(name);

			if (value == null || "".equals(value))
				continue;

			value = value.trim();

			String methodName = this.setMethod(name);
			Method method = null;
			Class<?> type = null;
			try
			{
				Field field = c.getDeclaredField(name);
				field.setAccessible(true);
				type = field.getType();
				method = c.getMethod(methodName, type);
			} catch (Exception e)
			{
				continue;
			}

			if (type == String.class)
			{
				method.invoke(instance, "'" + value.replace("'", "") + "'");
			} else if (type == int.class || type == Integer.class)
			{
				method.invoke(instance, Integer.parseInt(value));
				
			} else if (type == long.class || type == Long.class)
			{
				method.invoke(instance, Long.parseLong(value));
				
			} else if (type == float.class || type == Float.class)
			{
				method.invoke(instance, Float.parseFloat(value));

			} else if (type == double.class || type == Double.class)
			{
				method.invoke(instance, Double.parseDouble(value));

			} else if (type == Date.class)
			{
				method.invoke(instance, this.format(value));
			}
		}
		return (T) instance;
	}

	/**
	 * 获取name对象的set方法
	 * 
	 * @param name
	 * @return
	 */
	private String setMethod(String name)
	{
		return "set" + name.substring(0, 1).toUpperCase() + name.substring(1);
	}
}
