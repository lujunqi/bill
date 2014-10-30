<%@page import="com.dodou.table.Teminal_info_serv"%>
<%@page import="com.dodou.dao.Teminal_info_servDao"%>
<%@page import="com.szzt.dao.Terminal_InfoDao"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		Log.getLogger().debug("00000000000000");
		Teminal_info_servDao teminal_info_servDao = new Teminal_info_servDao();
		Teminal_info_serv teminal_info_serv = new Teminal_info_serv();
		teminal_info_serv.requestGetParameter(request);
		teminal_info_servDao.insert(teminal_info_serv);
		out.println("fee_chan");
		return;
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
