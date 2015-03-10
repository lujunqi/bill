<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.dodou.db.DatabaseAccess"%>
<%@ include file="../../import.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<%
	try{
		String sql = "select * from COMMON_LOG where do_type="
				+ request.getParameter("type") + " and target_id="
				+ request.getParameter("id")+" order by do_time desc";
		SimpleDateFormat format = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		DatabaseAccess acc = new DatabaseAccess();
		ResultSet rs = acc.executeQuery(sql);
	%>
	<table style="width: 100%" border="1">
		<tr>
			<td>操作人</td>
			<td>日期</td>
			<td>修改事项</td>
		</tr>
		<%while(rs.next()){ %>
			<tr>
				<td><%=rs.getString("who") %> </td>
				<td><%=format.format(rs.getTimestamp("do_time")) %></td>
				<td><%=rs.getString("do_what")%></td>
			</tr>
		<%} 
			rs.close();
			acc.release();
			}catch(Exception e){
				
			}
		%>
	</table>
</body>
</html>
