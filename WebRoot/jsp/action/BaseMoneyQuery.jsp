<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	//押金查询
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

		String defaultSql = "select *   from (select t.*,                m.*,                substr(trim(t.fld_48), -10) as terminalsno,                (t.fld_4 / 100) as amt           from SECU_DEPO t           left join (select (select o.operman_name                               from operman_info o                              where o.operman_id = m.e_id) as sales_man,                            c.unit_area,                            temp.term_id1,                            temp.term_id2,                            m.MARCHANT_NAME,                            temp.teminal_info_id                       from Apppay_105      m,                            commercial_info c,                            Term_App_Table  temp                      where temp.commercial_id = c.commercial_id                        and temp.apppay_id = m.apppay_id                        and temp.apptype = '105') m             on m.teminal_info_id=To_number(substr(trim(t.fld_48), 0,5)) /*and length(trim(t.fld_48))=11 */                        where nvl2(translate(trim(t.fld_48),'\\1234567890', '\\'),'is characters ','is number ')='is number '             ) t where 1=1 ";

		String where = request.getParameter("where");

		if (null != where)
		{
			System.out.println("押金查询：" + where);
			defaultSql += where;
		}
		defaultSql +=" order by t.fld_13 desc  ";
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
		//Log.getLogger().info(jo.toString());
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>