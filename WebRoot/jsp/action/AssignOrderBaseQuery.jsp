<%@page import="com.szzt.model.AssignOrderModel"%>
<%@page import="com.szzt.model.VisitBacklogModel"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String where = "";
		String ter = request.getParameter("terminalId");
		String com = request.getParameter("COMMERCIAL_ID");
		if (null != ter)
			where = " and ter.TEMINAL_INFO_ID=" + ter;
		if (null != com)
		{
			where += " and com.COMMERCIAL_ID=" + com;
		}

		AssignOrderDao dao = new AssignOrderDao();
		
		List<AssignOrderModel> list = dao.loadByTerminal(where);
		TableJson<AssignOrderModel> json = new TableJson<AssignOrderModel>();
		json.setRows(list.size());
		json.setTotal(list.size());
		json.setResultset(list.toArray());
		out.println(json.toJson());
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>