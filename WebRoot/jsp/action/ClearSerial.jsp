<%@page import="com.dodou.inferface.LogService"%>
<%@page import="com.szzt.dao.Terminal_InfoDao"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		String id = request.getParameter("id");
		
		if (null == id)
		{
			out.print(-1);
		} else
		{
			Permission per = new PositionPermessionImpl();
			if (per.hasPermission(session, Permission.SERIAL_BACK))
			{
				String sql = "update " + Terminal_InfoDao.TABLE
						+ " set serial1=''  where teminal_info_id="+id;
				DatabaseAccess acc = new DatabaseAccess();
				acc.executeUpdate(sql);
				//
				LogService ls = new LogService();
				Operman_info o = (Operman_info)session.getAttribute("man");
				String tempSql = ls.newLog(Terminal_InfoDao.TABLE,o.getOperman_name(), Integer.parseInt(id), 300, "清空主机序列号:"+request.getParameter("host_no"));
				acc.executeUpdate(tempSql);
				acc.release();
				out.print(1);
			} else
			{
				//没有权限
				out.print(-2);
			}
		}
	} catch (Exception e)
	{
		out.print(-1);
	}
%>

