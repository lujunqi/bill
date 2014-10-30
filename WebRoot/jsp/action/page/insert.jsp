<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.dao.PageAndTempDao"%>
<%@page import="com.szzt.dao.PageDao"%>
<%@page import="com.dodou.table.Page"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../../import.jsp"%>
<%
	try
	{
		Page p = new BindRequest().toModel(request, Page.class);
		if (0 == p.getUp_id())
		{
			p.setType(0);
		} else
		{
			p.setType(1);
		}
		PageDao dao = new PageDao();
		dao.insert(p);
		response.sendRedirect("../../page/ShowPages.jsp");
	} catch (Exception e)
	{
		e.printStackTrace();
	}
%>