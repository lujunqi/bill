<%@page import="com.szzt.model.TableJson"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		HostEngineDao dao = new HostEngineDao(
				request.getParameter("where"));

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

		List<HostEngine> infos = dao.selectList();

		TableJson<HostEngine> json = new TableJson<HostEngine>();
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