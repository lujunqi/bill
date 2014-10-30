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
<%
String info=request.getParameter("info");
if(null!=info&&info.equals("del1")){
	out.println("<script type=\"text/javascript\">alert('删除成功')</script>");
}
if(null!=info&&info.equals("del0")){
	out.println("<script type=\"text/javascript\">alert('删除失败')</script>");
}
%>

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
<%
	PageDao dao=new PageDao();
	request.setAttribute("page", dao.findMenus());
%>
<script type="text/javascript">
	function checkDel(id,root){
		var v="确认删除？";
		if(root){
			v+="删除该菜单后，所有子菜单都将被删除！";
		}
		if(confirm(v)){
			window.location.href="../action/page/delete.jsp?id="+id;
		}
	}
	function update(id){
		window.location.href="update.jsp?id="+id;
	}
</script>

</head>

<body>

		<c:if test="${page!=null }">
			<form action="Update.jsp">
				<c:forEach items="${page }" var="v">
				<ul>
					<li><c:out value="${v.name}"></c:out><td><a href="javascript:void(0)" onclick="update(${v.id})">查看/修改</a></td><a href="javascript:void(0)" onclick="checkDel(${v.id},true)">删除</a> </li>
					<c:if test="${v.child!=null }">
						<table border="1">
									<tr>
										<td>菜单名称</td>
										<td>url</td>
										<td>查看/修改</td>
										<td>删除</td>
									</tr>
							<c:forEach items="${v.child }" var="vv" varStatus="">
								<c:if test="${vv.checked }">
									<tr>
										<td><c:out value="${vv.name }"></c:out></td>
										<td><c:out value="${vv.url }"></c:out></td>
										<td><a href="javascript:void(0)" onclick="update(${vv.id})">查看/修改</a></td>
										<td><a href="javascript:void(0)" onclick="checkDel(${vv.id},false)">删除</a></td>
									 </tr>
								</c:if>
							</c:forEach>
						</table>
							
					</c:if>
				</ul>
			</c:forEach>
			</form>
		</c:if>
</body>
</html>
