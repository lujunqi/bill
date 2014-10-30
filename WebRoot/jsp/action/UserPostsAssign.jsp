<%@page import="com.google.gson.Gson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String id = request.getParameter("id");
		String userId = request.getParameter("userId");
		UserAuthorities au = new UserAuthorities();
		boolean result = au.assign(id, userId);
		if (result)
		{
			out.print(1);
		} else
		{
			out.print(-1);
		}
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>