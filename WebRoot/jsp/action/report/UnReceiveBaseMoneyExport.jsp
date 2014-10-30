<%@page import="com.szzt.export.UnReceiveBaseMoneyExport"%>
<%@page import="com.szzt.export.CommercialMonthLogExport"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<jsp:directive.page import="java.util.Date" />
<%@ include file="../../../import.jsp"%>
<%
	try
	{
		String sql =request.getParameter("sql");
		System.out.println("sql"+sql);
		UnReceiveBaseMoneyExport export=new UnReceiveBaseMoneyExport();
		export.setFileName("代收押金" + session.getId().substring(20));
		export.initSql(sql);
		String result = export.export(application
				.getRealPath("/report"));
		export.exportLog(session);
		out.println("../../../report/"+export.getFileName());
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
