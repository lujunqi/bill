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

<title>追加备注</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body >
	<center>
		<form action="../action/AppendRemarkInfo.jsp" method="post">
			<input type="hidden" name="type" value="${param.type }">
			<input type="hidden" name="id" value="${param.id }">
		追加信息:<textarea rows="5" cols="20" name="v" style="text-align: left">
			</textarea>
			<br>
			<input type="submit" value="提交" style="width: 50px">
		</form>
	</center>
</body>
</html>
