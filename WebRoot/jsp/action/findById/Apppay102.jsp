<%@page import="com.google.gson.Gson"%>
<%@page import="com.dodou.table.Apppay102_Info"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String id = request.getParameter("id");
		if (null != id)
		{
			Apppay102_InfoDao dao = new Apppay102_InfoDao();
			Apppay102_Info info = dao.findById(Integer.parseInt(id));
			Gson gson = new Gson();
			out.println(gson.toJson(info));
		}
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>