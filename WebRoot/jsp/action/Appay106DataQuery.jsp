<%@page import="com.dodou.table.Terminal_Info"%>
<%@page import="com.szzt.model.TableJson"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String where = " 1=1 ";
		//终端
		if (request.getParameter("appayId") != null)
		{
			int appayId = Integer.parseInt(request
					.getParameter("appayId"));
			where += " and APPPAY_ID=" + appayId;
		}

		Apppay106_InfoDao dao = new Apppay106_InfoDao(where,
				Apppay102_InfoDao.TABLE);

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

		Apppay106_Info[] infos = dao.select();

		TableJson<Apppay106_Info> json = new TableJson<Apppay106_Info>();
		json.setCur_page(dao.getCurPage());
		json.setRows(dao.getRowsCount());
		json.setTotal(dao.size());
		json.setTotal_page(dao.getPageCount());
		json.setResultset(infos);
		dao.release();
		out.println(json.toJson());

	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>