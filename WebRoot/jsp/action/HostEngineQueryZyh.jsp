<%@page import="com.szzt.model.TableJson"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String sql = "select * from teminal_info_serv i where 1=1 ";

		String where = request.getParameter("where");
		
		
		if (null != where)
		{
			sql += where;
		}
		System.out.println("============="+sql);

		CreatePage createPage = new CreatePage();
		DatabaseAccess dba = new DatabaseAccess();

		ResultSet rs = dba.executeQuery(sql);
		ResultSetMetaData rsmd = rs.getMetaData();
		JSONArray ja = new JSONArray();
		int i = 0;
		if (rs.next())
		{
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
				    String val = "0";
				    if (rs.getString(j) != null){
						val = rs.getString(j);
				    }
					jo.put(rsmd.getColumnName(j).toLowerCase(),val);
				}
			}
			ja.add(jo);
			i++;
		}
	
		rs.close();
		dba.release();
		JSONObject jo = new JSONObject();
		jo.put("rows", i);
		jo.put("total", i);
		jo.put("cur_page", 1);
		jo.put("total_page", 1);
		jo.put("resultset", ja);
		out.println(jo);
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>