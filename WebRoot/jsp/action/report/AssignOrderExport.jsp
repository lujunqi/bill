<%@page import="com.szzt.dao.AssignOrderDao"%>
<%@page import="com.szzt.export.AssignOrderExport"%>
<%@page import="com.dodou.inferface.Export"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@ include file="../../../import.jsp"%>
<%
	Export export = new AssignOrderExport();
	String where = request.getParameter("where");
	if (null != where && where.length() == 7)
	{
		where = " where to_char(a.COMP_DATE,'yyyy-MM')='" + where + "'";
	}
	export.setFileName("派单报表" + session.getId().substring(20));
	export.initSql(where);
	String result = export.export(application.getRealPath("/report"));
	export.exportLog(session);
	out.println("../../../report/"+export.getFileName());
%>


