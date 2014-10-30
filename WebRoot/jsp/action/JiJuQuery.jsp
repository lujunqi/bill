<%@page import="com.szzt.model.TableJson"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String where = "";
		String zyh = "";
		String unit_area = request.getParameter("unit_area");
		if (null != unit_area && unit_area.trim().length() > 0)
		{
			where += " and t.area = '" + unit_area + "'";
		}

		String host_no = request.getParameter("host_no");
		if (null != host_no && host_no.trim().length() > 0)
		{
			where += " and t.host_no = '" + host_no + "'";
		}
		/**String status = request.getParameter("status");
		if (null != status)
		{
			if ("1".equals(status))
			{
				where += " and not exists (select i.serial1 from teminal_info i where i.serial1=t.host_no  and (i.teminal_status in (4,5) or  (i.teminal_status=13 and i.installed_status=4))) ";

			} else if ("2".equals(status))
			{
				where += " and exists (select i.serial1 from teminal_info i where i.serial1=t.host_no  and (i.teminal_status in (4,5) or  (i.teminal_status=13 and i.installed_status=4))) ";
			}
		}*/
		String startTime = request.getParameter("startTime");
		if (null != startTime && startTime.trim().length() > 0)
		{
			where += " and t.in_time >= to_date('" + startTime
					+ "','yyyy-MM-dd')";
		}
		String endTime = request.getParameter("endTime");
		if (null != endTime && endTime.trim().length() > 0)
		{
			where += " and t.in_time <= to_date('" + endTime
					+ "','yyyy-MM-dd')";
		}
		where += " order by in_time ";

		TerminalInfoKeyDao dao = new TerminalInfoKeyDao(where);

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

		List<TEMINAL_INFO_KEY> infos = dao.selectList(zyh);

		TableJson<TEMINAL_INFO_KEY> json = new TableJson<TEMINAL_INFO_KEY>();
		json.setCur_page(dao.getCurPage());
		json.setRows(infos.size());
		json.setTotal(dao.size());
		json.setTotal_page(dao.getPageCount());
		json.setResultset(infos.toArray());
		out.println(json.toJson());
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>