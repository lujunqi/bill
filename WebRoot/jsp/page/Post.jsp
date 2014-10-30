<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../import.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>My JSP 'Post.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
ul{
list-style: none;
}
</style>
</head>

<body>
	<ul>
		<c:forEach items="${posts }" var="v" varStatus="vv">
			<c:if test="${v.post_id!=null}">
				<li>
				<c:out value="${vv.index+1 }:${v.post_name }"></c:out>
				----------------><a href="ShowPage.jsp?post=<c:out value="${v.post_id}"></c:out>">配置</a>
				</li>
			</c:if>
		</c:forEach>
	</ul>

</body>
</html>
