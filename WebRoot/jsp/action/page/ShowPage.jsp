<%@page import="com.szzt.dao.PageDao"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../../import.jsp"%>
<%
	try
	{
		PageDao dao = new PageDao();
		request.setAttribute("page",
				dao.findAll(request.getParameter("post")));
		request.getRequestDispatcher("../../page/index.jsp").forward(
				request, response);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>