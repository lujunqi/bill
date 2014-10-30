package com.dodou.inferface;

import javax.servlet.http.HttpServletRequest;

/**
 * 规范com.dodou.table中的所有类对象
 * <p>
 * 注意：每个table类必填字段必须给定默认值，非必填字段不允许赋予默认值 否则数据插入，更新将可能出现问题
 * </P>
 * 
 * @author Administrator
 * 
 */
public interface TableBeanInterface
{
	/**
	 * 将request中的信息转换成bean对象的数据
	 * 
	 * @param request
	 * @throws Exception
	 */
	public void requestGetParameter(HttpServletRequest request)
			throws Exception;
}
