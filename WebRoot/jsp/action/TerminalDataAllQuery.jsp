<%@page import="java.util.Date"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String where = request.getParameter("where");

		Permission per = new PositionPermessionImpl();
		String authSql = per.initTerminalWhere(per.loadPosts(session),
				per.loadCurrentId(session));

		if (null != authSql)
		{
			where = (where == null ? "" : where);
			where += authSql;
		}

		Terminal_InfoDao dao = new Terminal_InfoDao(where,
				Terminal_InfoDao.TABLE);

		if (request.getParameter("cur_page") != null
				&& !"".equals(request.getParameter("cur_page")))
		{
			int cur_page = Integer.valueOf(request
					.getParameter("cur_page"));
			dao.setCurPage(cur_page);
		}

		if (request.getParameter("page_size") != null
				&& !"".equals(request.getParameter("page_size")))
		{
			int page_size = Integer.valueOf(request
					.getParameter("page_size"));
			dao.setPageSize(page_size);
		}
		//Terminal_Info[] infos = dao.select();
		String newSql = "SELECT d.*,UNIT_NAME,(select o.operman_name from operman_info o where d.input_user_id=o.operman_id) as input_user_id1 FROM (SELECT A.*,c.UNIT_NAME,c.input_user_id,ROWNUM RN FROM (SELECT * FROM TEMINAL_INFO "
				+ " where 1=1 and "
				+ where
				+ " order by TEMINAL_INFO_ID desc ) A,COMMERCIAL_INFO c WHERE ROWNUM<="
				+ (dao.getCurPage() * dao.pageSize)
				+ " and c.COMMERCIAL_ID=A.COMMERCIAL_ID   ) d "
				+ " WHERE RN>="
				+ ((dao.getCurPage() - 1) * dao.getPageSize()) + " ";

		ResultSet result = dao.execQuery(newSql);

		JSONArray ja = new JSONArray();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		int i = 0;
		while (result.next())
		{
			i++;
			JSONObject jo = new JSONObject();
			jo.put("TEMINAL_INFO_ID", result.getInt("TEMINAL_INFO_ID"));
			jo.put("TEMINAL_STATUS", result.getInt("TEMINAL_STATUS"));

			jo.put("UNIT_NAME", result.getString("UNIT_NAME"));
			jo.put("UNIT_INSTALLED_ADD",
					result.getString("UNIT_INSTALLED_ADD"));

			jo.put("UNIT_INSTALLED_CITY",
					result.getString("UNIT_INSTALLED_CITY"));
			jo.put("UNIT_INSTALLED_STREET",
					result.getString("UNIT_INSTALLED_STREET"));
			jo.put("UNIT_INSTALLED_MAN",
					result.getString("UNIT_INSTALLED_MAN"));
			jo.put("UNIT_INSTALLED_CITY",
					result.getString("UNIT_INSTALLED_CITY"));
			
			jo.put("INPUT_USER", result.getString("input_user_id1"));

			if (result.getString("INPUT_DATE") != null)
				jo.put("INPUT_DATE",
						format.format(result.getDate("INPUT_DATE")));

			if (result.getString("APPROVAL_DATE") != null)
				jo.put("APPROVAL_DATE",
						format.format(result.getDate("APPROVAL_DATE")));

			jo.put("MORE",
					"<a href='javascript:void(0)' onclick=showWindow('"
							+ result.getInt("TEMINAL_INFO_ID")
							+ "&CommercialId="
							+ result.getInt("COMMERCIAL_ID")
							+ "') >详情</a>");
			ja.add(jo);
		}
		result.close();
		JSONObject jo = new JSONObject();
		int size = dao.size();
		jo.put("rows", ja.size());
		jo.put("total", size);
		jo.put("cur_page", dao.getCurPage());
		jo.put("total_page", dao.getPageCount());
		jo.put("resultset", ja);
		dao.release();
		out.println(jo);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>