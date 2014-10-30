<%@page import="com.szzt.model.AssignOrderModel"%>
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
		String where = "";
		String com = request.getParameter("COMMERCIAL_ID");
		String comp_id = request.getParameter("comp_id");

		AssignOrderDao dao = new AssignOrderDao();

		if (null != com)
		{
			where += " and allData.COMMERCIAL_ID=" + com;
		}
		if (null != comp_id)
		{
			TableJson<AssignOrderModel> json = new TableJson<AssignOrderModel>();
			json.setResultset(new Object[] { dao.findById(Integer
					.parseInt(comp_id)) });
			out.println(json.toJson());
			return;
		}

		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String compType = request.getParameter("compType");
		String compStatus = request.getParameter("compStatus");
		String UNIT_NAME = request.getParameter("UNIT_NAME");

		if (null != startTime && startTime.trim().length() > 0)
		{
			where += " and to_char(allData.comp_date,'yyyy-MM-dd')>='"
					+ startTime + "'";
		}

		if (null != endTime && endTime.trim().length() > 0)
		{
			where += " and to_char(allData.comp_date,'yyyy-MM-dd')<='"
					+ endTime + "'";
		}
		if (null != compType && compType.trim().length() > 0)
		{
			where += " and allData.comp_type='" + compType + "'";
		}
		if (null != compStatus && compStatus.trim().length() > 0)
		{
			where += " and allData.comp_status=" + compStatus;
		}
		if (null != UNIT_NAME && UNIT_NAME.trim().length() > 0)
		{
			where += " and allData.UNIT_NAME like '%" + UNIT_NAME
					+ "%'";
		}

		where += " order by allData.comp_date asc ";

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

		List<AssignOrderModel> list = dao.selectByList(where);
		dao.release();
		TableJson<AssignOrderModel> json = new TableJson<AssignOrderModel>();
		json.setRows(list.size());
		json.setTotal(dao.getTotalCount());
		json.setRowsCount(list.size());
		json.setTotal_page(dao.getPageCount());
		json.setResultset(list.toArray());
		out.println(json.toJson());
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>