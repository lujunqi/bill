<%@page import="com.google.gson.Gson"%>
<%@page import="com.dodou.table.Apppay103_Info"%>
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
			Apppay103_Info info = new Apppay103_InfoDao()
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