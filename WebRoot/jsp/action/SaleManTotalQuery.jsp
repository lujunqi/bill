<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		String startTime = request.getParameter("startTime");
		Operman_info man = (Operman_info) session.getAttribute("man");
		int id = man.getOperman_id();
		Log.getLogger().info("startTime=>>"+startTime);
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
		String defaultSql = "select (select o.operman_name from operman_info o where o.operman_id = '"+id+"') as tzr, sum(case when t.apptype='105' then totalCount else 0 end) as sd, sum(case when t.apptype='101' then totalCount else 0 end) as sm, sum(case when t.apptype='102' then totalCount else 0 end) as sfb, sum(case when t.apptype='103' then totalCount else 0 end) as bj from ( select '105' as apptype,count(*) as totalCount from term_app_table t,apppay_105 a where t.status=1 and to_char(t.bind_date,'yyyy-mm')='"+startTime+"' and a.e_id="+id+" and t.apppay_id=a.apppay_id and t.apptype='105' union all select '101',count(*) from term_app_table t,apppay_101 a where t.status=1 and to_char(t.bind_date,'yyyy-mm')='"+startTime+"' and a.e_id="+id+" and t.apppay_id=a.apppay_id and t.apptype='101' union all select '102',count(*) from term_app_table t,apppay_102 a where t.status=1 and to_char(t.bind_date,'yyyy-mm')='"+startTime+"' and a.e_id="+id+" and t.apppay_id=a.apppay_id and t.apptype='102' union all select '103',count(*) from term_app_table t,apppay_103 a where t.status=1 and to_char(t.bind_date,'yyyy-mm')='"+startTime+"' and a.e_id="+id+" and t.apppay_id=a.apppay_id and t.apptype='103' )t group by '"+id+"'";

		String unit_area = request.getParameter("unit_area");
		Log.getLogger().info("unit_area=>>"+unit_area);
		if (null != unit_area && !unit_area.equals(""))
		{
			defaultSql = "select (select o.operman_name from operman_info o where o.operman_id = t.e_id) as tzr, sum(case when t.apptype='105' then totalCount else 0 end) as sd, sum(case when t.apptype='101' then totalCount else 0 end) as sm, sum(case when t.apptype='102' then totalCount else 0 end) as sfb, sum(case when t.apptype='103' then totalCount else 0 end) as bj from (select '105' as apptype,count(*) as totalCount,a.e_id from term_app_table t,apppay_105 a where t.status=1 and to_char(t.bind_date,'yyyy-mm')='"+startTime+"' and a.account_city='"+unit_area+"' and t.apppay_id=a.apppay_id and t.apptype='105' group by a.e_id union all select '101',count(*),a.e_id from term_app_table t,apppay_101 a where t.status=1 and to_char(t.bind_date,'yyyy-mm')='"+startTime+"' and a.account_city='"+unit_area+"' and t.apppay_id=a.apppay_id and t.apptype='101' group by a.e_id union all select '102',count(*),a.e_id from term_app_table t,apppay_102 a where t.status=1 and to_char(t.bind_date,'yyyy-mm')='"+startTime+"' and a.account_city='"+unit_area+"' and t.apppay_id=a.apppay_id and t.apptype='102' group by a.e_id union all select '103',count(*),a.e_id from term_app_table t,apppay_103 a where t.status=1 and to_char(t.bind_date,'yyyy-mm')='"+startTime+"' and a.account_city='"+unit_area+"' and t.apppay_id=a.apppay_id and t.apptype='103' group by a.e_id) t group by e_id";
		}
		System.out.println("查询：" + defaultSql);

		defaultSql +="  ";
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
				    String str = rs.getString(j);
				    if (str == null){
						str="-";
				    }
					jo.put(rsmd.getColumnName(j).toLowerCase(),str);
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