<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
    try {
		CreatePage createPage = new CreatePage();

		DatabaseAccess dba = new DatabaseAccess();
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		String defaultSql = "select  t.teminal_count,(select ar.city from ws_area ar where ar.areaid=t.unit_installed_city) as city,t1.gain,round(t1.gain / t.teminal_count,2) as per_gain,round(t2.zero_count /t.teminal_count,2) as rate from (select count(*) as teminal_count,ii.unit_installed_city from teminal_info ii, apppay_105 a,term_app_table temp where  ii.teminal_info_id=temp.teminal_info_id and a.apppay_id=temp.apppay_id and a.fee_chan=1 and ii.teminal_status=13 and ii.installed_status=4 group by ii.unit_installed_city) t left join (  select sum(gain) as gain,i.unit_installed_city from rep_teminal r,teminal_info i, apppay_105 a where r.total_date>='"
			+ date1
			+ "' and r.total_date<='"
			+ date2
			+ "'   and a.fee_chan=1 and r.merchantsno_id=a.apppay_id   and i.teminal_info_id=r.teminal_info_id group by i.unit_installed_city) t1   on t1.unit_installed_city=t.unit_installed_city left join ( select count(*)as zero_count,i.unit_installed_city   from (select m.merchantsno_id,                m.teminal_info_id,                sum(fee_count) as fee_count           from rep_teminal m          where m.total_date <= '"
			+ date2
			+ "'            and m.total_date >= '"
			+ date1
			+ "'          group by m.teminal_info_id, m.merchantsno_id) gain,        teminal_info i,        term_app_table temp,        apppay_105 a  where   gain.merchantsno_id=temp.apppay_id   and gain.teminal_info_id = temp.teminal_info_id   and i.teminal_info_id=temp.teminal_info_id   and a.apppay_id=temp.apppay_id   and gain.fee_count > 0   and i.teminal_status = 13   and i.installed_status=4   and a.fee_chan=1   group by i.unit_installed_city) t2   on t2.unit_installed_city=t.unit_installed_city";

		String where = request.getParameter("where");

		if (null != where) {
		    defaultSql += " where t.unit_installed_city is not null "+where;
		}
		Log.getLogger().info(" cityWeekQuery => "+defaultSql.toString());
		ResultSet rs = dba.executeQuery(defaultSql);
		rs.last();
		createPage.setTotalCount(rs.getRow());
		rs.first();
		ResultSetMetaData rsmd = rs.getMetaData();
		JSONArray ja = new JSONArray();
		for (int i = createPage.getStart(); i < createPage.getEnd(); i++) {
		    if (createPage.getTotalCount() == 0)
			break;
		    rs.absolute(i + 1);
		    JSONObject jo = new JSONObject();
		    for (int j = 1; j <= rsmd.getColumnCount(); j++) {
			if (rsmd.getColumnTypeName(j)
				.equalsIgnoreCase("NUMBER")) {
			    jo.put(rsmd.getColumnName(j).toLowerCase(),
				    rs.getDouble(j));
			} else if (rsmd.getColumnTypeName(j).equalsIgnoreCase(
				"TIMESTAMP")) {
			    jo.put(rsmd.getColumnName(j).toLowerCase(),
				    UtilTime.getLocalFormat2String(rs
					    .getTimestamp(j)));
			} else {
			    String str = rs.getString(j);
			    if (str == null) {
				str = "-";
			    }
			    jo.put(rsmd.getColumnName(j).toLowerCase(), str);
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
    } catch (Exception e) {
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
    }
%>