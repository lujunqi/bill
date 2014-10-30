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

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<style type="text/css">
	ul{
	list-style: none;
	}
</style>

</head>

<body>

		<c:if test="${page!=null }">
			<form action="Update.jsp">
			<input  type="hidden" name="post" value="${param.post }">
					<c:forEach items="${page }" var="v">
				<ul>
					<li><c:out value="${v.name}"></c:out> </li>
					<c:if test="${v.child!=null }">
						<table border="1">
									<tr>
										<td>菜单名称</td>
										<td>url</td>
										<td>操作</td>
									</tr>
							<c:forEach items="${v.child }" var="vv" varStatus="">
									<tr>
										<td><c:out value="${vv.name }"></c:out></td>
										<td><c:out value="${vv.url }"></c:out></td>
										<td><input name="id" value="${vv.id}" type="checkbox" <c:if test="${vv.checked }">checked="checked"</c:if> ></td>
									 </tr>
							</c:forEach>
						</table>
							
					</c:if>
				</ul>
			</c:forEach>
				<center>
					<input value="提交" type="submit">
					<input value="重置" type="reset">
				</center>
			</form>
		</c:if>
</body>
</html>
