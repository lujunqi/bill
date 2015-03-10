<%@page import="java.net.URLEncoder"%>
<%@ include file="../../import.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="java.io.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head runat="server">
    <script type="text/javascript"
     src="../../js/jquery.min.js"></script>
<style type="text/css">
img{
	border: 2px solid #356745;
	margin-left: 30px;
}
</style>
</head>
<body >
	<center>
		<img  src="<%=basePath%>photo/${param.type}/${param.id}/${param.name}"/>
	</center>
</body>
</html>
