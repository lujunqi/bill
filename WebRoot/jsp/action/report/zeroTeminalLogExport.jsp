<%@page import="com.szzt.export.ZeroTerminalLogExport"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<jsp:directive.page import="java.util.Date" />
<%@ include file="../../../import.jsp"%>
<%
	String sql = " where 1=1 ";
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");

	if (null != startTime && startTime.trim().length() > 0)
	{
		sql += " and m.total_date >= '" + startTime + "' ";
	}
	if (null != endTime && endTime.trim().length() > 0)
	{
		sql += " and m.total_date <= '" + endTime + "' ";
	}

	String where = "";
	if (request.getParameter("unit_area") != null
			&& !"".equals(request.getParameter("unit_area")))
	{
		String unit_area = request.getParameter("unit_area");
		where += " and c.UNIT_AREA='" + unit_area + "'";
	}
	String commercialName = request.getParameter("commercialName");
	String commercialNo = request.getParameter("commercialNo");
	String terminalNo = request.getParameter("terminalNo");

	if (null != commercialName && commercialName.trim().length() > 0)
	{
		where += " and c.unit_name like '%" + commercialName + "%' ";
	}

	if (null != commercialNo && commercialNo.trim().length() > 0)
	{
		where += " and trim(temp.term_id1)='" + commercialNo + "' ";
	}

	if (null != terminalNo && terminalNo.trim().length() > 0)
	{
		where += " and trim(temp.term_id2)='" + terminalNo + "' ";
	}

	where += " order by c.UNIT_AREA";
	ZeroTerminalLogExport export = new ZeroTerminalLogExport();
	export.initSql(where, sql);
	export.setFileName("zeroTeminalLogExport" + session.getId().substring(20));
	String result = export.export(application.getRealPath("/report"));
	export.exportLog(session);
	out.println("<a href='../../../report/" + export.getFileName()+".xls'>请点击右键->另存为:" + export.getFileName() + "</a>");
%>