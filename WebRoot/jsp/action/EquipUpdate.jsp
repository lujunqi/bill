<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String terId = request.getParameter("terminalId");
		String EQUI_TYPE = request.getParameter("EQUI_TYPE");
		if (null == terId || null == EQUI_TYPE)
		{
			out.print(-1);
		} else
		{
			String update = "update " + Terminal_InfoDao.TABLE
					+ " set EQUI_TYPE=" + EQUI_TYPE
					+ " where TEMINAL_INFO_ID=" + terId;
			DatabaseAccess dba = new DatabaseAccess();
			dba.executeUpdate(update);
			dba.release();
			out.print(1);
		}
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>