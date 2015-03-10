<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="com.szzt.util.Encode"%>
<%@ page import="java.sql.*"%><%@ page import="java.util.*"%><%@ page import="java.io.*"%><%@ page import="com.dodou.log.*"%><%@ page import="com.dodou.util.*"%><%@ page import="com.dodou.db.*"%><%@ page import="com.dodou.table.*"%><%@ page import="com.dodou.dao.*"%><%@ page import="net.sf.json.*"%><%@ page import="java.security.*"%>
<%@page import="com.ljq.*"%>


<%

MyDatabase cmd = new MyDatabase();
List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
DatabaseAccess dba = new DatabaseAccess();
try{
	Map<String, Object> map = new HashMap<String,Object>();
	map.put("USERID",request.getParameter("userId"));
	cmd.init("v_mobileCode",dba.getConnection());
	list = cmd.getResultSet(map,0,100);
	
	if(!list.isEmpty()){
		Map<String, Object> m = list.get(0);
		String mobile = m.get("OPER_COMP")+"";
		
		System.out.println(mobile+"="+new java.util.Date()+SendSMS.sendSMS(mobile,"1234"));	
	}
}catch(Exception e){
	e.printStackTrace();
}
cmd.closeConntent();
%>