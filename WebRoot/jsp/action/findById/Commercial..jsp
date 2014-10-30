<%@page import="com.dodou.table.Commercial_Info"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String id = request.getParameter("id");
		System.out.println("-------------------------------"+id);
		if (null != id)
		{
			Commercial_Info info = new Commercial_InfoDao()
					.findById(Integer.parseInt(id));
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