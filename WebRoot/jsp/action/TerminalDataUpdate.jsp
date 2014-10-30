<%@page import="com.szzt.exception.ForbidUpdateException"%>
<%@page import="com.szzt.util.TermiCostUtils"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.dao.*"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	String terminalId = request.getParameter("TEMINAL_INFO_ID");

	int comId = -1;
	try
	{
		if (null != terminalId)
		{
			BindRequest bind = new BindRequest();
			Terminal_Info info = bind.toModel(request,
					Terminal_Info.class);
			//info.requestGetParameter(request);

			Terminal_InfoDao dao = new Terminal_InfoDao();

			Operman_info man = (Operman_info) session
					.getAttribute("man");
			dao.setWho(man.getOperman_name());

			dao.update(info);
			comId = dao.loadCommercialIdByTerId(info
					.getTEMINAL_INFO_ID());
			String[] ids = request.getParameter("BIND_IDS").split(",");

			ApppayTerminalDao atd = new ApppayTerminalDao();
			atd.bind(dao.loadCommercialIdByTerId(Integer
					.parseInt(terminalId)), Integer
					.parseInt(terminalId), ids);

			//------更新收费表信息-----
			TermiCostUtils utils = new TermiCostUtils();
			TemiCost[] costs = utils.getTermiCosts(request,
					Integer.parseInt(terminalId));
			TermiCostDao termiDao = new TermiCostDao();
			for (TemiCost t : costs)
			{
				termiDao.update(t);
			}
			dao.release();
			atd.release();
			termiDao.release();
			response.sendRedirect("../insert/commercialInsert.jsp?info=11&show=1&CommercialId="
					+ comId);
		} else
		{
			response.sendRedirect("../insert/commercialInsert.jsp?info=10&show=1&CommercialId="
					+ comId);
		}
	} catch (ForbidUpdateException f)
	{
		response.sendRedirect("../insert/terminalInsert.jsp?info=update0&show=1&terminalId="
				+ terminalId);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		response.sendRedirect("../insert/commercialInsert.jsp?info=10&show=1&CommercialId="
				+ comId);
	}
%>