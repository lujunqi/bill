<%@page import="java.net.URLEncoder"%>
<%@ include file="../../import.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="java.io.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>机具变更</title>
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript">
	function update() {
		if (confirm("确认变更？")) {
			$.post("../action/EquipUpdate.jsp", {'terminalId':${param.terminalId},'EQUI_TYPE':$("#EQUI_TYPE").val()}, function(d) {
				if(d==1){
					alert("变更成功，刷新页面后显示！");
					window.close();
				}else{
					alert("变更失败，请重试！");
				}
			});
		}
	}
</script>
</head>
<body >
	<script type="text/javascript">
		
	</script>
	<center>
		<table>
			<tr>
				<td align="right">机具变更:</td>
				<td><select name="EQUI_TYPE" id="EQUI_TYPE" style="height:30px">
						<option value="0">普通POS</option>
						<option value="1">移动POS</option>
						<option value="2">分体POS</option>
						<option value="3">其他类型POS</option>
				</select></td>
				<td><input value="提交" type="button" onclick="update()" /></td>
			</tr>
		</table>
	</center>
</body>
</html>
