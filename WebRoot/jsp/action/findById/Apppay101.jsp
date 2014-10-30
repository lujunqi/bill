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
			Apppay101_InfoDao dao = new Apppay101_InfoDao();
			Apppay101_Info info = dao.findById(Integer.parseInt(id));
			dao.release();
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