<%@ page contentType="text/html;charset=utf-8" language="java"%>
<jsp:directive.page import="java.util.Date" />
<%@ include file="../../import.jsp"%>
<%
	try
	{
		String sql = "select count1.sumCount, count1.sumAmt, count1.sumFee, count1.sumGain, count1.sumTotalGain, gain.serv_lev, area.CITY as unit_addr, i.channel_name, temp.term_id1, c.trade_name, m.MCC, gain.POS_COUNT, gain.FEE_COUNT, gain.FEE_AMOUNT, gain.FEE, gain.GAIN, gain.TOTAL_GAIN, gain.TOTAL_DATE ";
		sql += "from REP_TOTAL_GAIN_MON gain, Apppay_105 m, WS_AREA area, commercial_info c, (select i.channel_name from channel_info i where i.channel_id= m.ec_id), (select sum(FEE_COUNT) as sumCount, MERCHANTSNO_ID, sum(FEE_AMOUNT) as sumAmt, sum(FEE) as sumFee, sum(GAIN) as sumGain, sum(TOTAL_GAIN) as sumTotalGain from REP_TOTAL_GAIN_MON where substr('1401', 0, 2) = substr(TOTAL_DATE, 1, 2) group by MERCHANTSNO_ID) count1, (select temp.apppay_id, temp.commercial_id, temp.term_id1 from term_app_table temp where temp.apptype = '105' and temp.status = 1 group by temp.apppay_id, temp.commercial_id, temp.term_id1) temp";
		sql += " where gain.merchantsno_id = temp.apppay_id and gain.commercial_id = temp.commercial_id and m.apppay_id = temp.apppay_id and c.commercial_id = temp.commercial_id and area.AREAID = c.UNIT_AREA and count1.MERCHANTSNO_ID = temp.apppay_id ";
		System.out.println("ss:" + sql);
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
			sql += " and c.unit_name like '%" + merchant_name
					+ "%'";
		}

		sql += " order by c.UNIT_AREA,gain.serv_lev desc";

		Log.getLogger().info(sql);
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
		Log.getLogger().info(createPage.getTotalCount());
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
		out.println(jo);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
