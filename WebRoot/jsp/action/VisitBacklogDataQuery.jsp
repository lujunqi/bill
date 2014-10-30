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
		String where = request.getParameter("sql");
		/**
		
		  if ($('#man').val() != ''){
		sqlstr += " and o.OPERMAN_NAME like '%"+$('#man').val()+"%'";
		}
		 */
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
		List<VisitBacklogModel> list = dao.findAll(where);
		
		TableJson<VisitBacklogModel> json = new TableJson<VisitBacklogModel>();
		json.setRows(list.size());
		json.setTotal(dao.getTotalCount());
		json.setTotal_page(dao.getPageCount());
		json.setRowsCount(list.size());
		json.setResultset(list.toArray());
		out.println(json.toJson());

		System.out.println("查询结束。。。。。。。。。。。" + dao.getTotalCount());
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>