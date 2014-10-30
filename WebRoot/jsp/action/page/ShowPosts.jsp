<%@page import="com.szzt.dao.Post_infoDao"%>
<%@page import="com.szzt.dao.DaoUtils"%>
<%@page import="com.szzt.dao.PageDao"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../../import.jsp"%>
<%
	try
	{
		Post_infoDao dao=new Post_infoDao();
		request.setAttribute("posts", dao.select());
		request.getRequestDispatcher("../../page/Post.jsp").forward(
				request, response);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>