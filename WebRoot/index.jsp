<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.dao.LoginOut"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ page import="java.sql.*"%><%@ page import="java.util.*"%><%@ page import="java.security.*"%><%@ page import="java.io.*"%><%@ page import="com.dodou.log.*"%><%@ page import="com.dodou.util.*"%><%@ page import="com.dodou.db.*"%><%@ page import="com.dodou.table.*"%><%@ page import="com.dodou.dao.*"%><%@ page import="net.sf.json.*"%><%request.setCharacterEncoding("UTF-8");%>
<%
	String passwd = request.getParameter("password");
	try{
		String c = (String)session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);  
		String parm = (String) request.getParameter("checkCode");
		System.out.println(parm+":"+c);
		if (null != c && null != parm&&parm.equalsIgnoreCase(c))
		{
			LoginOut loginOut = new LoginOut();
			String name = request.getParameter("username");
			if (!loginOut.login(name, passwd, session))
			{
				response.sendRedirect("login.jsp?login=-1");
				return;
			}
			
		} else
		{
			response.sendRedirect("login.jsp?code=-1");
			return;
		}
	}catch(Exception e){}

	session.setMaxInactiveInterval(3600);
%>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<title>通联支付湖南分公司银行卡业务管理系统 </title>
	<script type="text/javascript">
		<%
		if("123456".equals(passwd)){
		%>
		alert("由于您使用的是默认密码，请修改！");
		window.location.href="jsp/insert/ModifyPassword.jsp?def=1";
		<%}%>
	</script>
	</head>
	<frameset id="frameset1" rows="102,*,8" frameborder="no" border="0" framespacing="0">
		<frame src="./index2_files/top.jsp" name="topFrame" scrolling="No" noresize="noresize" id="topFrame">
	    <frame src="./index2_files/middle.htm" name="mainFrame" id="mainFrame" logintype="1">
	    <frame src="./index2_files/bottom.htm" name="bottomFrame" scrolling="No" noresize="noresize" id="bottomFrame">
	</frameset>
	<noframes>
		&lt;body&gt;
		&lt;/body&gt;
	</noframes>


</html>