<%@page import="com.szzt.model.VisitBacklogModel"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String undoType = request.getParameter("undoType");
		String where = null;
		int type = 2;
		if ("2".equals(undoType))
		{
			where = " and (visit.has_col10=2 or visit.has_col10 is null)";
		} else
		{
			type = 1;
			where = " and tem.TEMINAL_INFO_ID not in (select TEMINAL_INFO_ID from TEMINAL_INFO_VISIT_CALL) ";
		}
		String date = request.getParameter("APPROVAL_DATE");
		if (null != date && date.length() > 2)
		{
			where += " and to_char(tem.APPROVAL_DATE,'yyyy-MM')='"
					+ date + "'";
		}
		Teminal_info_visit_callDao dao = new Teminal_info_visit_callDao();

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

		List<VisitBacklogModel> list = dao.search(where, type);
		TableJson<VisitBacklogModel> json = new TableJson<VisitBacklogModel>();
		json.setRows(list.size());
		json.setTotal(dao.getTotalCount());
		json.setResultset(list.toArray());
		out.println(json.toJson());
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>