<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		String startTime = request.getParameter("startTime");
		Operman_info man = (Operman_info) session.getAttribute("man");
		int id = man.getOperman_id();
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
		String defaultSql = "select a.marchant_name, sum(case substr(m.total_date,5) when '01' then m.gain else 0 end) as A01, sum(case substr(m.total_date,5) when '02' then m.gain else 0 end) as A02, sum(case substr(m.total_date,5) when '03' then m.gain else 0 end) as A03, sum(case substr(m.total_date,5) when '04' then m.gain else 0 end) as A04, sum(case substr(m.total_date,5) when '05' then m.gain else 0 end) as A05, sum(case substr(m.total_date,5) when '06' then m.gain else 0 end) as A06, sum(case substr(m.total_date,5) when '07' then m.gain else 0 end) as A07, sum(case substr(m.total_date,5) when '08' then m.gain else 0 end) as A08, sum(case substr(m.total_date,5) when '09' then m.gain else 0 end) as A09, sum(case substr(m.total_date,5) when '10' then m.gain else 0 end) as A10, sum(case substr(m.total_date,5) when '11' then m.gain else 0 end) as A11, sum(case substr(m.total_date,5) when '12' then m.gain else 0 end) as A12, sum(case substr(m.total_date,5) when '13' then m.gain else 0 end) as A13, sum(case substr(m.total_date,5) when '14' then m.gain else 0 end) as A14, sum(case substr(m.total_date,5) when '15' then m.gain else 0 end) as A15, sum(case substr(m.total_date,5) when '16' then m.gain else 0 end) as A16, sum(case substr(m.total_date,5) when '17' then m.gain else 0 end) as A17, sum(case substr(m.total_date,5) when '18' then m.gain else 0 end) as A18, sum(case substr(m.total_date,5) when '19' then m.gain else 0 end) as A19, sum(case substr(m.total_date,5) when '20' then m.gain else 0 end) as A20, sum(case substr(m.total_date,5) when '21' then m.gain else 0 end) as A21, sum(case substr(m.total_date,5) when '22' then m.gain else 0 end) as A22, sum(case substr(m.total_date,5) when '23' then m.gain else 0 end) as A23, sum(case substr(m.total_date,5) when '24' then m.gain else 0 end) as A24, sum(case substr(m.total_date,5) when '25' then m.gain else 0 end) as A25, sum(case substr(m.total_date,5) when '26' then m.gain else 0 end) as A26, sum(case substr(m.total_date,5) when '27' then m.gain else 0 end) as A27, sum(case substr(m.total_date,5) when '28' then m.gain else 0 end) as A28, sum(case substr(m.total_date,5) when '29' then m.gain else 0 end) as A29, sum(case substr(m.total_date,5) when '30' then m.gain else 0 end) as A30, sum(case substr(m.total_date,5) when '31' then m.gain else 0 end) as A31, nvl(sum(m.gain),0) as total_gain   from rep_merchant m,apppay_105 a where substr(m.total_date,0,4)='"+startTime+"'   and m.merchantsno_id=a.apppay_id ";

		String marchant_name = request.getParameter("marchant_name");
		if (null != marchant_name && !marchant_name.equals(""))
		{
			defaultSql += " and a.marchant_name like '%"+marchant_name+"%'";
		}
		String marchant_no = request.getParameter("marchant_no");
		if (null != marchant_no && !marchant_no.equals(""))
		{
			defaultSql += " and m.merchantsno = '"+marchant_no+"'";
		}	
		String unit_area = request.getParameter("unit_area");
		if (null != unit_area && !unit_area.equals(""))
		{
			defaultSql += " and substr(m.merchantsno,4,4)='"+unit_area+"'";
		}			
		
		defaultSql +="  group by a.marchant_name order by total_gain desc";
		System.out.println("查询：" + defaultSql);
		ResultSet rs = dba.executeQuery(defaultSql);
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
					jo.put(rsmd.getColumnName(j),
							rs.getDouble(j));
				} else if (rsmd.getColumnTypeName(j).equalsIgnoreCase(
						"TIMESTAMP"))
				{
					jo.put(rsmd.getColumnName(j),
							UtilTime.getLocalFormat2String(rs
									.getTimestamp(j)));
				} else
				{
				    String str = rs.getString(j);
				    if (str == null){
						str="-";
				    }
					jo.put(rsmd.getColumnName(j),str);
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
		Log.getLogger().info(jo.toString());
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>