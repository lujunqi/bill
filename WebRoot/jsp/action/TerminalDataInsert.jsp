<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.util.TermiCostUtils"%>
<%@page import="com.szzt.dao.TermiCostDao"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.szzt.dao.ApppayTerminalDao"%>
<%@page import="com.szzt.dao.Terminal_InfoDao"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	Permission per = new PositionPermessionImpl();
	if (!per.hasPermission(session, Permission.EXPAND_POSITION))
	{
		response.sendRedirect("../insert/error.jsp");
		return;
	}
	Terminal_InfoDao dao = new Terminal_InfoDao();
	ApppayTerminalDao atd = new ApppayTerminalDao();
	TermiCostDao termiDao = new TermiCostDao();
	int comId = -1;
	try
	{
		String binds = request.getParameter("BIND_IDS");
		if (null != binds && binds.trim().length() > 0)
		{
			Terminal_Info info = new Terminal_Info();
			info.requestGetParameter(request);
/*
			if (request.getParameter("IS_OVERLAY").equals("1")){
			    String UNIT_INSTALLED_CITY = request.getParameter("UNIT_INSTALLED_CITY");
			    int result = 0;
				Random rand = new Random();
				result = rand.nextInt(999999);
				Log.getLogger().info("便民商户编号:"+("000000".substring((result+"").length())+result));
				String no = "01"+(UNIT_INSTALLED_CITY.substring(2))+"0000"+("000000".substring((result+"").length())+result);
				info.setUNIT_INSTALLED_NAME(no);
			}
*/
			comId = info.getCOMMERCIAL_ID();
			int id = dao.insert(info);
			//绑定业务
			if (request.getParameter("BIND_IDS") != null
					&& request.getParameter("BIND_IDS").trim().length() > 0)
			{
				String[] ids = request.getParameter("BIND_IDS").split(
						",");
				atd.bind(Integer.parseInt(request
						.getParameter("COMMERCIAL_ID")), id, ids);
			}
			termiDao.debug("<<<<<<<<<<<<信息绑定成功！>>>>>>>>>>>>>>>>>>>>");
			//绑定一组费用信息
			TermiCostUtils utils = new TermiCostUtils();
			TemiCost[] costs = utils.getTermiCosts(request, id);
			for (TemiCost t : costs)
			{
				termiDao.insert(t);
				termiDao.debug("<<<<<<<<<<<<费用信息添加成功>>>>>>>>>>>>>>>>>>>>");
			}
			//	comId = dao.loadCommercialIdByTerId(id);
			dao.release();
			atd.release();
			termiDao.release();

			termiDao.debug("--------------------添加机具费用成功----------------------------");
			response.sendRedirect("../insert/commercialInsert.jsp?info=1&show=1&CommercialId="
					+ comId);
		} else
		{
			response.sendRedirect("../insert/commercialInsert.jsp?info=-1&show=1&CommercialId="
					+ comId);
		}
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		response.sendRedirect("../insert/commercialInsert.jsp?info=-1&show=1&CommercialId="
				+ comId);
	}
%>