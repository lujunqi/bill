<%@page import="com.dodou.table.Operman_info"%>
<%@page import="com.szzt.util.Md5Util"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		Operman_infoDao dao = new Operman_infoDao();
		String where = "";

		if (null != request.getParameter("query_depart")
				&& request.getParameter("query_depart").length() > 0)
		{
			where += " and market.DEPA_ID="
					+ request.getParameter("query_depart");
		}
		if (null != request.getParameter("query_stauts")
				&& request.getParameter("query_stauts").length() > 0)
		{
			where += " and oper_status="
					+ request.getParameter("query_stauts");
		}
		if (null != request.getParameter("query_name")
				&& request.getParameter("query_name").length() > 0)
		{
			where += " and OPERMAN_NAME like '%"
					+ request.getParameter("query_name") + "%' ";
		}
		if (null != request.getParameter("area")
				&& request.getParameter("area").length() > 0)
		{
			where += " and OPER_ADDRESS ="
					+ request.getParameter("area")+" ";
		}

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
		Operman_info[] info = dao.select(where);
		TableJson<Operman_info> json = new TableJson<Operman_info>();
		json.setCur_page(dao.getCurPage());
		json.setPageCount(dao.getPageCount());
		json.setRowsCount(dao.getEnd() - dao.getEnd());
		json.setResultset(info);
		json.setRows(dao.getRowsCount());
		json.setTotal_page(dao.getTotalCount() / 20 + 1);
		json.setTotal(dao.getTotalCount());
		out.println(json.toJson());
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>