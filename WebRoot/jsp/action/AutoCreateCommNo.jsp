<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		String sq = "auto_comm_no_sq";
		String sql = "select auto_comm_no_sq.nextval from dual";
		DatabaseAccess dba = new DatabaseAccess();
		ResultSet set = dba.executeQuery(sql);
		String v = "";
		if (set.next())
		{
			v = set.getString(1);
		}
		for (int i = 0; i <= 8 - v.length(); i++)
		{
			v = "0" + v;
		}

		String tmp = "tmp" + v;
		out.println(tmp);
		set.close();
		dba.release();
	} catch (Exception e)
	{
		out.println("系统错误");
	}
%>
