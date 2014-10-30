<%@page import="com.szzt.dao.PageAndTempDao"%>
<%@page import="com.szzt.dao.PageDao"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../../import.jsp"%>
<%
	try
	{
		String id = request.getParameter("id");
		if (null != id)
		{
			PageDao dao = new PageDao();
			dao.delete(Integer.parseInt(id));
		}
		response.sendRedirect("../../page/ShowPages.jsp?inof=del1");
	} catch (Exception e)
	{
		response.sendRedirect("../../page/ShowPages.jsp?info=del0");
	}
%>