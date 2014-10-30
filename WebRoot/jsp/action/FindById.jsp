<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	/**
	 根据id查询信息，所有的查询都采用统一的action
	 */
	try
	{
		String where = " 1=1 ";
		//业务id
		if (request.getParameter("appayId") != null)
		{
			int appayId = Integer.parseInt(request
					.getParameter("appayId"));
			where += " and APPPAY_ID=" + appayId;
		}

		Apppay101_InfoDao dao = new Apppay101_InfoDao(where,
				Apppay101_InfoDao.TABLE);

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

		Apppay101_Info[] infos = dao.select();

		TableJson<Apppay101_Info> json = new TableJson<Apppay101_Info>();
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