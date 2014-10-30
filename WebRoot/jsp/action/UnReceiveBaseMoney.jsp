<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	//未收回发票押金查询
	try
	{
		String sql = request.getParameter("sql");
		//Log.getLogger().info(sql);
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

		String defaultSql = "select fax.id, temp.term_id1, comm.unit_name, fax.in_time, (select cost.money from Temicost cost where cost.cost_type = 0 and cost.teminal_info_id = temp.teminal_info_id) as cost ";
		defaultSql+="from Commercial_Info comm, term_app_table temp, (select * from TEMICOST_HIS t where t.id not in (select trim(s.fld_48) from secu_depo s)) fax ";
		defaultSql+="where temp.status = 1 and comm.commercial_id = temp.commercial_id and temp.apptype = '105' and temp.teminal_info_id = fax.teminal_info_id ";

		String where = request.getParameter("where");

		if (null != where)
		{
			defaultSql += where;
		}

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