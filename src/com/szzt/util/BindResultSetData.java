package com.szzt.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.sql.ResultSet;
import java.util.Date;

import com.dodou.table.Apppay101_Info;

/**
 * 将resultset中的数据封装成对象;
 * <p>
 * 对象T中的属性必须有get和set方法
 * </p>
 * 
 * @author 陈孟琳
 * 
 */
public class BindResultSetData<T>
{
	/**
	 * 将结果集中的数据自动注入到对象中
	 * 
	 * @param data
	 * @param clazz
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public T bind(ResultSet data, @SuppressWarnings("rawtypes") Class clazz)
			throws Exception
	{
		Object instance = clazz.newInstance();
		Field[] fields = clazz.getDeclaredFields();

		for (Field field : fields)
		{
			field.setAccessible(true);
			String fieldName = field.getName();
			Type type = field.getGenericType();
			System.out.println("类型。。。。"+field.getType());
			Method method = clazz.getMethod(this.setMethod(fieldName), 	field.getType());
			if (type == String.class)
			{
				method.invoke(instance, data.getString(fieldName));
			} else if (type == int.class || type == Integer.class)
			{
				method.invoke(instance, data.getInt(fieldName));
				
			} else if (type == long.class || type == Long.class)
			{
				method.invoke(instance, data.getLong(fieldName));

			} else if (type == float.class || type == Float.class)
			{
				method.invoke(instance, data.getFloat(fieldName));

			} else if (type == double.class || type == Double.class)
			{
				method.invoke(instance, data.getDouble(fieldName));

			} else if (type == Date.class)
			{
				method.invoke(instance, data.getDate(fieldName));
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
