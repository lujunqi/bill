<%@page import="com.szzt.dao.Terminal_InfoDao"%>
<%@page import="com.szzt.dao.Apppay101_InfoDao"%>
<%@page import="com.szzt.dao.Commercial_InfoDao"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		String type = request.getParameter("type");
		String value = request.getParameter("v");
		String id = request.getParameter("id");
		if (null != type)
		{
			if (null == value || value.trim().length() < 1)
			{
				out.print("请输入要追加的信息！");
				return;
			}
			DatabaseAccess acc = new DatabaseAccess();
			String sql = null;
			int c = Integer.parseInt(type);
			switch (c)
			{
			case 101://101
			case 102:
			case 103:
			case 105:
			case 106:
				sql = "update APPPAY_" + c
						+ " set REMARK_INFO=concat(REMARK_INFO,'"
						+ value.trim() + "') where apppay_id=" + id;
				break;//客户信息
			case 201:
				sql = "update " + Terminal_InfoDao.TABLE
						+ " set REMARK_INFO=concat(REMARK_INFO,'"
						+ value.trim() + "') where TEMINAL_INFO_ID=" + id;
				break;//客户信息
			}
			if (null != sql)
				acc.executeUpdate(sql);
			out.print("追加成功");
			acc.release();
		}
	} catch (Exception e)
	{
		out.print("追加失败！");
	}
%>

