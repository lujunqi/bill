<%@page import="com.szzt.dao.PageAndTempDao"%>
<%@page import="com.szzt.dao.PageDao"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../../import.jsp"%>
<%
	PageAndTempDao dao = new PageAndTempDao();
	try
	{
		String[] id = request.getParameterValues("id");

		dao.bind(request.getParameter("post"), id);
		response.sendRedirect("ShowPosts.jsp");
		dao.release();
	} catch (Exception e)
	{
		try
		{
			dao.roll();
			dao.release();
		} catch (Exception e1)
		{
			e1.printStackTrace();
		}
		e.printStackTrace();
	}
%>