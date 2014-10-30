<%@page import="com.szzt.export.CommercialDayLogExport"%>
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
			where += " and gain.TOTAL_DATE<='"
					+ request.getParameter("endTime") + "'";
		}
		if (request.getParameter("startTime") != null
				&& !"".equals(request.getParameter("startTime")))
		{
			where += " and gain.TOTAL_DATE>='"
					+ request.getParameter("startTime") + "'";
		}

		String commercialName = request.getParameter("commercialName");

		if (null != commercialName
				&& commercialName.trim().length() > 0)
		{
			where += " and c.unit_name like '%" + commercialName
					+ "%' ";
		}

		String tranType = request.getParameter("tranType");

		if ("0".equals(tranType))
		{
			where += " and gain.FEE_COUNT =0";
		} else
		{
			where += " and gain.FEE_COUNT !=0";
		}

		String commercialNo = request.getParameter("commercialNo");


		if (null != commercialNo && commercialNo.trim().length() > 0)
		{
			where += " and temp.term_id1='" + commercialNo + "' ";
		}

		if (request.getParameter("unit_area") != null
				&& !"".equals(request.getParameter("unit_area")))
		{
			String unit_area = request.getParameter("unit_area");
			where += " and c.UNIT_AREA='" + unit_area + "'";
		}
		CommercialDayLogExport export = new CommercialDayLogExport();
		export.initSql(where);
		export.setFileName("商户日报表" + session.getId().substring(22));
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
