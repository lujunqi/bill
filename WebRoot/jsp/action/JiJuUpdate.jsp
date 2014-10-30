<%@page import="com.szzt.model.TableJson"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String hostId = request.getParameter("host");
		String area = request.getParameter("area");
		if (null == hostId || null == area)
		{
			out.print(-1);
			return;
		}
		String sqlstr = "update TEMINAL_INFO_KEY set area=" + area
				+ " where host_no='" + hostId + "'";
		DatabaseAccess acc = new DatabaseAccess();
		acc.executeUpdate(sqlstr);
		acc.release();
		out.print(1);
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>