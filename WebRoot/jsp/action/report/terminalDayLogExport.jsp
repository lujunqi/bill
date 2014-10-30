<%@page import="com.szzt.export.TerminalDayLogExport"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<jsp:directive.page import="java.util.Date" />
<%@ include file="../../../import.jsp"%>
<%
	try
	{
		String where = "";
		if (request.getParameter("endTime") != null
				&& !"".equals(request.getParameter("endTime")))
		{
			where += " and tergain.TOTAL_DATE<='"
					+ request.getParameter("endTime") + "'";
		}
		if (request.getParameter("startTime") != null
				&& !"".equals(request.getParameter("startTime")))
		{
			where += " and tergain.TOTAL_DATE>='"
					+ request.getParameter("startTime") + "'";
		}

		String tranType = request.getParameter("tranType");

		if ("0".equals(tranType))
		{
			where += " and tergain.FEE_COUNT =0";
		} else
		{
			where += " and tergain.FEE_COUNT !=0";
		}

		String commercialName = request.getParameter("commercialName");
		String commercialNo = request.getParameter("commercialNo");
		String terminalNo = request.getParameter("terminalNo");

		if (null != commercialName
				&& commercialName.trim().length() > 0)
		{
			where += " and comm.unit_name like '%" + commercialName
					+ "%' ";
		}

		if (null != commercialNo && commercialNo.trim().length() > 0)
		{
			where += " and temp.term_id1='" + commercialNo + "' ";
		}

		if (null != terminalNo && terminalNo.trim().length() > 0)
		{
			where += " and temp.term_id2='" + terminalNo + "' ";
		}

		if (request.getParameter("unit_area") != null
				&& !"".equals(request.getParameter("unit_area")))
		{
			String unit_area = request.getParameter("unit_area");
			where += " and comm.UNIT_AREA='" + unit_area + "'";
		}
		TerminalDayLogExport export = new TerminalDayLogExport();
		export.initSql(where);
		export.setFileName("终端日报表"+session.getId().substring(20));
		String result = export.export(application
				.getRealPath("/report"));
		export.exportLog(session);
		out.println(result);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
