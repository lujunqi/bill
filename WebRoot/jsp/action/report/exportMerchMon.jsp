<%@page import="com.dodou.inferface.Export"%>
<%@page import="com.szzt.export.CommercialMonthLogExport"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<jsp:directive.page import="java.util.Date" />
<%@ include file="../../../import.jsp"%>
<%
	try
	{
		String sql = "";
		if (request.getParameter("total_date") != null
				&& !"".equals(request.getParameter("total_date")))
		{
			sql += " and gain.TOTAL_DATE = '"
					+ request.getParameter("total_date") + "'";
		}

		if (request.getParameter("serv_lev") != null
				&& !"".equals(request.getParameter("serv_lev")))
		{
			String serv_lev = request.getParameter("serv_lev");
			sql += " and gain.serv_lev='" + serv_lev + "'";
		}
		if (request.getParameter("unit_area") != null
				&& !"".equals(request.getParameter("unit_area")))
		{
			String unit_area = request.getParameter("unit_area");
			sql += " and c.UNIT_AREA='" + unit_area + "'";
		}
		if (request.getParameter("account_bank") != null
				&& !"".equals(request.getParameter("account_bank")))
		{
			String account_bank = request.getParameter("account_bank");
			sql += " and m.account_bank='" + account_bank + "'";
		}
		if (request.getParameter("sales_man") != null
				&& !"".equals(request.getParameter("sales_man")))
		{
			String sales_man = request.getParameter("sales_man");
			sql += " and m.e_id=" + sales_man + "";
		}
		if (request.getParameter("date1") != null
				&& !"".equals(request.getParameter("date1")))
		{
			String date1 = request.getParameter("date1");
			sql += " and m.input_date >=to_date('" + date1
					+ "','yyyy-mm-dd')";
		}
		if (request.getParameter("date2") != null
				&& !"".equals(request.getParameter("date2")))
		{
			String date2 = request.getParameter("date2");
			sql += " and m.input_date <=to_date('" + date2
					+ "','yyyy-mm-dd')";
		}

		if (request.getParameter("merchantsno") != null
				&& !"".equals(request.getParameter("merchantsno")))
		{
			String merchantsno = request.getParameter("merchantsno");
			sql += " and temp.term_id1 = '" + merchantsno + "'";

		}
		if (request.getParameter("merchant_name") != null
				&& !"".equals(request.getParameter("merchant_name")))
		{
			String merchant_name = request
					.getParameter("merchant_name");
			sql += " and c.unit_name like '%" + merchant_name + "%'";
		}
		System.out.println(" 商户月报表  " + sql);

		CommercialMonthLogExport export = new CommercialMonthLogExport();
		export.setFileName("商户月报表" + session.getId().substring(20));
		export.initSql(sql);
		String result = export.export(application
				.getRealPath("/report"));
		JSONObject json = new JSONObject();
		json.put("result", result);

		Export ex = new Export()
		{
			public void initSql(String where)
			{
			}
		};
		ex.release();
		ex.setFileName("导出商户");
		ex.exportLog(session);
		out.println(json);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
