<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.prism.dbutil.VMPreparedStatement"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ include file="../../import.jsp"%>
<%
DatabaseAccess dba = new DatabaseAccess();
Connection conn = dba.getConnection();
try{
	String sql = "INSERT INTO BACK_TYPE(C1,C2,C5)VALUES(${c1<STRING>},${c2<STRING>},${c5<STRING>})";
	VMPreparedStatement cmd = new VMPreparedStatement(conn);
	Map<String,Object> param  = new HashMap<String,Object>();
	param.put("c1",request.getParameter("c1"));
	param.put("c2",request.getParameter("c2"));
	param.put("c5",request.getParameter("c5"));
	cmd.putAll(param);
	Object i = cmd.executeUpdate(sql)+"";

	out.print("{\"code\":"+1+"}");
}catch (Exception e) {
	e.printStackTrace();
		out.print("{\"code\":"+0+"}");
}
conn.close();
%>