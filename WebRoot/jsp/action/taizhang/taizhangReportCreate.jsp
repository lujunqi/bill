<%@page import="com.szzt.export.TaiZhangExport"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@ include file="../../../import.jsp"%>
<%
	TaiZhangExport export = new TaiZhangExport();
	String type = request.getParameter("type");
	int appType = Integer.parseInt(type);

	export.setFileName("taizhang");
	export.initSql(request.getParameter("wherestr"), appType);
	String result = export.export(application.getRealPath("/report"));
	out.println(result);
%>


