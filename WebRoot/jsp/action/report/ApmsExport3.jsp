<%@page import="com.szzt.export.APMSImportExcel"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../../import.jsp"%>
<%
	String date = request.getParameter("date");
	if (date == null)
	{
		out.println("请选择日期！");
		return;
	}
	
	String filename = "apms" + date + "_I_FU.xls";
	
	APMSImportExcel export = new APMSImportExcel();
	String filePath = export.createAPMSData2Excel3(date,application,filename);
	out.println("<a href='../../../report/" + filename+ "'>生成文件:" + filePath + "</a>");
%>


