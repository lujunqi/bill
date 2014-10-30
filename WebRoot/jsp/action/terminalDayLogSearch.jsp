<%@page import="com.dodou.db.DatabaseAccess"%>
<%@page import="com.szzt.util.DateConventer"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<jsp:directive.page import="java.util.Date" />
<%@ include file="../../import.jsp"%>
<%
	try
	{
		CreatePage createPage = new CreatePage();
		String countSql = "(select sum(FEE_COUNT) as sumCount,TEMINAL_INFO_ID,sum(FEE_AMOUNT) as sumAmt, sum(FEE) as sumFee,sum(GAIN) as sumGain from REP_TEMINAL "
				+ " where to_char(trunc(sysdate), 'yy') = substr(TOTAL_DATE, 1, 2) group by TEMINAL_INFO_ID) count1 ";
		String sql = "select count1.sumCount,        count1.sumAmt,        count1.sumFee,        count1.sumGain,        tergain.FEE_COUNT,        tergain.FEE_AMOUNT  ,        tergain.FEE,        tergain.GAIN ,        tergain.TOTAL_DATE,        ter.teminal_product,        ter.UNIT_INSTALLED_ADD,        ter.UNIT_INSTALLED_MAN ,        ter.UNIT_INSTALLED_TEL ,        to_char(ter.ARCHIVE_DATE, 'yyyy-mm-dd') as ARCHIVE_DATE,        (select o.OPERMAN_NAME           from operman_info o          where o.OPERMAN_ID = ter.debug_man) as debug_man ,        (select o.OPERMAN_NAME           from operman_info o          where o.OPERMAN_ID = ter.inst_man) as inst_man ,        temp.term_id2 ,   (select ar.city from Ws_Area ar where ar.areaid=comm.unit_area) as unit_area,        temp.term_id1 ,        comm.TRADE_NAME ,        comm.COMM_NAME ";
		sql += " from REP_TEMINAL tergain,        TEMINAL_INFO ter,        COMMERCIAL_INFO comm,        Apppay_105 merch,        ws_area area,        term_app_table temp,";
		sql += countSql;
		sql += "  where  merch.apppay_id=temp.apppay_id        and ter.teminal_info_id=temp.teminal_info_id        and comm.commercial_id=temp.commercial_id    and tergain.TEMINAL_INFO_ID = temp.teminal_info_id    and count1.TEMINAL_INFO_ID = temp.teminal_info_id    and tergain.COMMERCIAL_ID=temp.commercial_id    and  temp.status=1 and temp.apptype='105' and merch.APPR_STATUS = 2 and comm.UNIT_AREA = area.AREAID  and ter.teminal_status=13 and ter.installed_status=4";

		if (request.getParameter("endTime") != null
				&& !"".equals(request.getParameter("endTime")))
		{
			sql += " and tergain.TOTAL_DATE<='"
					+ request.getParameter("endTime") + "'";
		}
		if (request.getParameter("startTime") != null
				&& !"".equals(request.getParameter("startTime")))
		{
			sql += " and tergain.TOTAL_DATE>='"
					+ request.getParameter("startTime") + "'";
		}
		String tranType = request.getParameter("tranType");

		if ("0".equals(tranType))
		{
			sql += " and tergain.FEE_COUNT =0";
		} else
		{
			sql += " and tergain.FEE_COUNT !=0";
		}
		
		System.out.println(request.getParameter("unit_area"));

		if (request.getParameter("unit_area") != null
				&& !"".equals(request.getParameter("unit_area")))
		{
			String unit_area = request.getParameter("unit_area");
			sql += " and comm.UNIT_AREA='" + unit_area + "'";
		}

		String commercialName = request.getParameter("commercialName");
		String commercialNo = request.getParameter("commercialNo");
		String terminalNo = request.getParameter("terminalNo");

		if (null != commercialName
				&& commercialName.trim().length() > 0)
		{
			sql += " and comm.unit_name like '%" + commercialName + "%' ";
		}

		if (null != commercialNo && commercialNo.trim().length() > 0)
		{
			sql += " and temp.term_id1='" + commercialNo + "' ";
		}

		if (null != terminalNo && terminalNo.trim().length() > 0)
		{
			sql += " and temp.term_id2='" + terminalNo + "' ";
		}

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

		System.out.println("终端日报表：" + sql);

	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
