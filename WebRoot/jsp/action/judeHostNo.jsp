<%@page import="com.szzt.exception.SerialExistsException"%>
<%@page import="com.szzt.exception.OutOfStoreException"%>
<%@page import="com.szzt.dao.Terminal_InfoDao"%>
<%@page import="com.szzt.dao.TerminalAndTempDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.dodou.db.DatabaseAccess"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%><%@ include
	file="../../import.jsp"%>
<%

	DatabaseAccess dba = new DatabaseAccess();
	String sql = "select t.*,(select i.COMMERCIAL_ID from teminal_info i where i.SERIAL1=t.host_no and i.teminal_status!=6 and i.teminal_status!=8 and i.teminal_status!=4 ) as hasno,(select ii.merchantsno from teminal_info_serv ii where ii.host_seq = t.host_no and (ii.teminal_status != 6 or ii.teminal_status is null)) as hasno_s from TEMINAL_INFO_KEY t where host_no='"
		+ request.getParameter("host_no").trim()
			+ "' and area="
		+ request.getParameter("area");
	System.out.println("查询sql:" + sql);
	ResultSet rs = dba.executeQuery(sql);
	if (rs.next())
	{
		if (rs.getString("hasno") != null)
		{
			out.print("自主收单->" + rs.getString("hasno"));
		} else if (rs.getString("hasno_s") != null)
		{
			out.print("专业化服务->" + rs.getString("hasno_s"));
		} else
		{
			out.print("OK");
		}
	} else
	{
		//主机序列号不对，不在库中
		out.print("1");
	}
	rs.close();
	dba.release();
%>