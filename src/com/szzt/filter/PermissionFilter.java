package com.szzt.filter;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dodou.inferface.Permission;
import com.szzt.authority.PositionPermessionImpl;

public class PermissionFilter implements Filter
{

	private Object mirror = new Object();

	public void destroy()
	{

	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain chain) throws IOException, ServletException
	{
		Permission per = new PositionPermessionImpl();
		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpServletResponse response = (HttpServletResponse) arg1;
		String url = request.getRequestURI().toString();
		System.out.println(url);
		synchronized (this.mirror)
		{

			if (this.pattern(url, "\\w*jsp/show/\\w*.jsp\\w*"))
			{
				
			}
			// System.out.println("ajax请求？" + this.isAjax(request));
		}

		chain.doFilter(request, response);
	}

	private boolean pattern(String url, String regex)
	{
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(url);
		return matcher.find();
	}

	/**
	 * 判断是否为ajax请求
	 * 
	 * @param request
	 * @return true是ajax，否则普通请求
	 */
	private boolean isAjax(HttpServletRequest request)
	{
		return request.getHeader("X-Requested-With") != null;
	}

	public void init(FilterConfig arg0) throws ServletException
	{
		System.out.println("进入filter======================》");
	}

}
