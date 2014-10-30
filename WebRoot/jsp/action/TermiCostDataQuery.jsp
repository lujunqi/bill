<%@page import="com.szzt.model.TableJson"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.dodou.table.*"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String id = request.getParameter("terminalId");
		if (null != id)
		{
			TermiCostDao dao = new TermiCostDao();
			TemiCost[] cost = dao.findById(id);
			TableJson<TemiCost> json = new TableJson<TemiCost>();
			json.setResultset(cost);
			dao.release();
			out.print(json.toJson());
			System.out.println("查询完毕---------");
		}
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>