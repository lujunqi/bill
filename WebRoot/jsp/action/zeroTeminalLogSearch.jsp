<%@page import="com.szzt.util.DateConventer"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<jsp:directive.page import="java.util.Date" />
<%@ include file="../../import.jsp"%>
<%
	try
	{

		String sql = "select (select a.city from ws_area a where a.areaid = c.unit_area) as unit_area, temp.term_id1, temp.term_id2, c.trade_name, i.archive_date, i.unit_installed_man, i.unit_installed_tel, i.unit_installed_add, i.serial1, i.serial2, (select cost.money from temicost cost where cost.cost_type=0 and cost.teminal_info_id=i.teminal_info_id) as cost";
		sql += " from (select m.merchantsno_id, m.teminal_info_id, sum(fee_count) as fee_count from rep_teminal m ";

		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");

		sql += " where m.total_date <= '" + endTime
				+ "' and m.total_date >= '" + startTime + "' ";

		sql += "group by m.teminal_info_id, m.merchantsno_id) gain, teminal_info i, apppay_105 m, term_app_table temp, commercial_info c ";
		sql += "where gain.merchantsno_id = temp.apppay_id and gain.teminal_info_id = temp.teminal_info_id and i.teminal_info_id = temp.teminal_info_id and m.apppay_id = temp.apppay_id and c.commercial_id = temp.commercial_id and gain.fee_count = 0 and i.teminal_status = 13 and i.installed_status = 4 and temp.apptype = '105' and temp.status = 1";

		if (request.getParameter("unit_area") != null
				&& !"".equals(request.getParameter("unit_area")))
		{
			String unit_area = request.getParameter("unit_area");
			sql += " and c.UNIT_AREA='" + unit_area + "'";
		}

		String commercialName = request.getParameter("commercialName");
		String commercialNo = request.getParameter("commercialNo");
		String terminalNo = request.getParameter("terminalNo");

		if (null != commercialName
				&& commercialName.trim().length() > 0)
		{
			sql += " and c.unit_name like '%" + commercialName + "%' ";
		}

		if (null != commercialNo && commercialNo.trim().length() > 0)
		{
			sql += " and temp.term_id1='" + commercialNo + "' ";
		}

		if (null != terminalNo && terminalNo.trim().length() > 0)
		{
			sql += " and temp.term_id2='" + terminalNo + "' ";
		}

		sql += " order by c.UNIT_AREA";
		Log.getLogger().info("零交易报表查询:"+sql);
		CreatePage createPage = new CreatePage();
		if (request.getParameter("cur_page") != null
				&& !"".equals(request.getParameter("cur_page")))
		{
			int cur_page = Integer.valueOf(request
					.getParameter("cur_page"));
			createPage.setCurPage(cur_page);
		}
		if (request.getParameter("page_size") != null
				&& !"".equals(request.getParameter("page_size")))
		{
			int page_size = Integer.valueOf(request
					.getParameter("page_size"));
			createPage.setPageSize(page_size);
		}
		DatabaseAccess dba = new DatabaseAccess();
		ResultSet rs = dba.executeQuery(sql);
		rs.last();
		createPage.setTotalCount(rs.getRow());
		rs.first();
		ResultSetMetaData rsmd = rs.getMetaData();
		JSONArray ja = new JSONArray();
		for (int i = createPage.getStart(); i < createPage.getEnd(); i++)
		{
			if (createPage.getTotalCount() == 0)
				break;
			rs.absolute(i + 1);
			JSONObject jo = new JSONObject();
			for (int j = 1; j <= rsmd.getColumnCount(); j++)
			{
				if (rsmd.getColumnTypeName(j)
						.equalsIgnoreCase("NUMBER"))
				{
					jo.put(rsmd.getColumnName(j).toLowerCase(),
							rs.getDouble(j));
				} else if (rsmd.getColumnTypeName(j).equalsIgnoreCase(
						"TIMESTAMP"))
				{
					jo.put(rsmd.getColumnName(j).toLowerCase(),
							UtilTime.getLocalFormat2String(rs
									.getTimestamp(j)));
				} else
				{
					jo.put(rsmd.getColumnName(j).toLowerCase(),
							rs.getString(j));
				}
			}
			ja.add(jo);
		}
		rs.close();
		dba.release();
		JSONObject jo = new JSONObject();
		jo.put("rows", createPage.getRowsCount());
		jo.put("total", createPage.getTotalCount());
		jo.put("cur_page", createPage.getCurPage());
		jo.put("total_page", createPage.getPageCount());
		jo.put("resultset", ja);
		jo.put("startTime", startTime);
		jo.put("endTime", endTime);
		out.println(jo);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
