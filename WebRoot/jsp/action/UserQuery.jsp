<%@page import="com.google.gson.Gson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String area = request.getParameter("area");
		if (null == area)
		{
			return;
		}
		DaoUtils utils = new DaoUtils();
		Gson gson = new Gson();
		out.print(gson.toJson(utils.operateUserQuery(area)));
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>