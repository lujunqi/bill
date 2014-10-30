<%@ page contentType="text/html;charset=utf-8" language="java"%>
<jsp:directive.page import="java.util.Date" />
<%@ include file="../../import.jsp"%>
<%
	try
	{
		String sql = "select count1.sumCount,        count1.sumAmt,        count1.sumFee,        count1.sumGain,        area.CITY as unit_addr,   (select channel.channel_name from channel_info channel where channel.channel_id= merch.ec_id)      as ec_id,        temp.term_id1,        c.unit_name,        merch.MCC,        gain.FEE_COUNT,        gain.FEE_AMOUNT,        gain.FEE,        gain.GAIN,        gain.TOTAL_DATE ";
		sql += "   from REP_MERCHANT gain,        Apppay_105 merch,        (select temp.commercial_id,temp.apppay_id,temp.term_id1 from term_app_table temp where  temp.status=1 and  temp.apptype='105'  group by temp.commercial_id,temp.apppay_id,temp.term_id1) temp,        WS_AREA area,        commercial_info c,        (select sum(FEE_COUNT) as sumCount,                MERCHANTSNO_ID,                sum(FEE_AMOUNT) as sumAmt,                sum(FEE) as sumFee,                sum(GAIN) as sumGain           from REP_MERCHANT          where to_char(trunc(sysdate), 'yy') = substr(TOTAL_DATE, 1, 2)          group by MERCHANTSNO_ID) count1";
		sql += " where  gain.customer_id=temp.commercial_id  and gain.merchantsno_id=temp.apppay_id  and merch.apppay_id=temp.apppay_id  and count1.MERCHANTSNO_ID = temp.apppay_id  and c.commercial_id=temp.commercial_id  and area.AREAID = c.UNIT_AREA  and merch.APPR_STATUS = 2";
		if (request.getParameter("endTime") != null
				&& !"".equals(request.getParameter("endTime")))
		{
			sql += " and gain.TOTAL_DATE<='"
					+ request.getParameter("endTime") + "'";
		}
		if (request.getParameter("startTime") != null
				&& !"".equals(request.getParameter("startTime")))
		{
			sql += " and gain.TOTAL_DATE>='"
					+ request.getParameter("startTime") + "'";
		}
		String tranType = request.getParameter("tranType");

		if ("0".equals(tranType))
		{
			sql += " and gain.FEE_COUNT =0";
		} else
		{
			sql += " and gain.FEE_COUNT !=0";
		}

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
		}

		CreatePage createPage = new CreatePage();

		if (request.getParameter("page_size") != null
				&& !("").equals(request.getParameter("page_size")))
		{
			int page_size = new Integer(
					request.getParameter("page_size"));
			createPage.setPageSize(page_size);
		}
		if (request.getParameter("cur_page") != null)
		{
			int cur_page = new Integer(request.getParameter("cur_page"));
			createPage.setCurPage(cur_page);
		}
		sql += " order by c.UNIT_AREA,gain.TOTAL_DATE";

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
		out.println(jo);

	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
