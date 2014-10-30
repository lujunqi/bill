<%@page import="com.szzt.dao.PageDao"%>
<%@ include file="../../import.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<style type="text/css">
ul {
	list-style: none;
}
</style>
<%
	PageDao dao = new PageDao();
	request.setAttribute("menus", dao.findRootMenus());
%>
<script type="text/javascript">
	function check(){
		var name=document.getElementById("name");
		var url=document.getElementById("url");
		if(name.value==null){
			alert("请输入菜单名称");
			return false;
		}
		if(url.value==null){
			alert("请输入url地址");
			return false;
		}
		return true;
	}

</script>
</head>

<body>
	<center>
		<form action="../action/page/insert.jsp" onsubmit="return check()" method="post">
			<label>菜单名称</label><input name="name" id="name"><br/>
			<label>菜单URL</label><input name="url" id="url"><br/>		
			<label>上级菜单</label>
			<select name="up_id">
				<option value="0">--无--</option>
				<c:forEach var="v" items="${menus }">
					<option value="${v.id }">${v.name }</option>
				</c:forEach>
			</select>
			<br/>		
			<input type="submit" value="提交">
			<input type="reset" value="重置">	
		</form>
	</center>
</body>
</html>
