<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="java.text.Format"%>
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
		
		String permitSql = per.initCommercialWhere(
				per.loadPosts(session), per.loadCurrentId(session));

		if (null != permitSql)
		{
			where = (where == null ? "" : where);
			where += permitSql;
		}
		
		System.out.println("where:"+where);

		Commercial_InfoDao dao = new Commercial_InfoDao(where
				+ " order by COMMERCIAL_ID desc ",
				Commercial_InfoDao.TABLE);

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

		List<Commercial_Info> infos = dao.selectList(where);

		TableJson<Commercial_Info> json = new TableJson<Commercial_Info>("yyyy-MM-dd HH:mm:ss");
		int size = dao.size();
		dao.setTotalCount(size);
		json.setCur_page(dao.getCurPage());
		json.setRows(infos.size());
		json.setRowsCount(infos.size());
		json.setTotal(size);
		json.setResultset(infos.toArray());
		System.out.println("================>" + size);

		/**
		 *
		 JSONArray ja = new JSONArray();

		 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		 for (int i = dao.getStart(); i < dao.getEnd(); i++)
		 {
		 JSONObject jo = new JSONObject();
		 if (infos.length < 1)
		 break;
		 Commercial_Info info = infos[i];
		 if (null == info)
		 break;

		 jo.put("COMMERCIAL_ID", info.getCOMMERCIAL_ID());
		 jo.put("UNIT_NAME", info.getUNIT_NAME());
		 jo.put("UNIT_ATTR", info.getUNIT_ATTR());
		 jo.put("UNIT_ADD", info.getUNIT_ADD());
		 jo.put("UNIT_AREA", info.getUNIT_AREA());
		 jo.put("COMM_NO", info.getCOMM_NO());
		 jo.put("COMM_NAME", info.getCOMM_NAME());
		 jo.put("COMM_AD", info.getCOMM_AD());
		 jo.put("TRADE_NAME", info.getTRADE_NAME());
		 jo.put("CONTACT_NAME_1", info.getCONTACT_NAME_1());
		 jo.put("CONTACT_TEL_1", info.getCONTACT_TEL_1());
		 jo.put("CONTACT_NAME_2", info.getCONTACT_NAME_2());
		 jo.put("CONTACT_TEL_2", info.getCONTACT_TEL_2());
		 jo.put("UNIT_STATUS", info.getUNIT_STATUS());
		 jo.put("COMM_RATING", info.getCOMM_RATING());
		 jo.put("INPUT_DATE", format.format(info.getINPUT_DATE()));
		 jo.put("CHANGE_DATE", format.format(info.getCHANGE_DATE()));
		 jo.put("REMARK_INFO", info.getREMARK_INFO());
		 jo.put("MORE",
		 "<a href='javascript:void(0)' onclick='showWindow("
		 + info.getCOMMERCIAL_ID() + ")'>详细"
		 + "</a>");
		 ja.add(jo);
		 }
		 JSONObject jo = new JSONObject();
		 jo.put("rows", dao.getRowsCount());
		 jo.put("total", dao.size());
		 jo.put("cur_page", dao.getCurPage());
		 jo.put("total_page", dao.getPageCount());
		 jo.put("resultset", ja);
		 */
		dao.release();
		out.println(json.toJson());
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>