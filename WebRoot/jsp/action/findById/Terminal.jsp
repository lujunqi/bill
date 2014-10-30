<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.dodou.table.Apppay101_Info"%>
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
			Terminal_Info info = new Terminal_InfoDao()
					.findById(Integer.parseInt(id));
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd")
					.create();
			out.println(gson.toJson(info));
		}

	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>