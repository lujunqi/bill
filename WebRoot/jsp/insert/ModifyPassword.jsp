<%@page import="java.net.URLEncoder"%>
<%@ include file="../../import.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="java.io.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head runat="server">
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript">
	function check(){
		var oldPass=$("#oldPass").val();
		var newPass=$("#newPass").val();
		var newPassCheck=$("#newPassCheck").val();
		var error="密码长度至少为6位！";
		if(assertLength(oldPass,6,error)&&assertLength(newPass,6,error)){
			if(newPass==newPassCheck){
				if(allowReg(newPass)){
					return true;
				}else{
					alert("密码由数字和字母组成,并且以字母开头！");
					return false;
				}
			}
			alert("两次输入的密码不一致！");
			return false;
		}
		return false;
	}
	function allowReg(v){
		return /^[a-zA-Z]+[0-9]+$/.test(v);
	}
	function assertLength(v,len,error){
		if(null==v||v.length<len){
			alert(error);
			return false;
		}
		if(v.length>=len){
			return true;
		}
	}
</script>
</head>
<body>
	<center>
		<div>
			<c:if test="${error!=null }">
				错误信息:<br>
			</c:if>
		</div>
		<form id="f" action="../action/ModifyPassword.jsp" onsubmit="return check()" method="post">
			<input name="def" value="${param.def}" type="hidden">
			<fieldset>
				<label for="oldPass">原始密码:</label><input name="oldPass"  type="password" id="oldPass" maxlength="20"/><br/>
				<label for="oldPass">新密码:</label><input name="newPass" type="password" id="newPass"  maxlength="20"/><br/>
				<label for="oldPass">确认新密码:</label><input name="newPassCheck" type="password" id="newPassCheck"  maxlength="20"/><br/>
				<input type="submit" value="提交">
				<input type="reset" value="重置">
			</fieldset>
		</form>
	</center>
</body>
</html>
