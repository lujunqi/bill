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
	margin-left:50px;
}
li{
height:35px;
line-height:35px;
}
</style>

<script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>

<script type="text/javascript">
function check(){
	var c1=$("#c1").val();
	var c2=$("#c2").val();
	var c5=$("#c5").val();
	var param = {};
	param["c1"] = c1;
	param["c2"] = c2;
	param["c5"] = c5;
	if(!IsNum(c1)){
		alert("商户开户行行号 必须为数字");
		return false;
	}
	if(!IsNum(c5)){
		alert("商户接收行行号 必须为数字");
		return false;
	}
	if(c2=="" || c2==null){
		alert("商户开户行名称 不能为空");
		return false;
	}
	$.post("insertAction.jsp",param,function(data){
		if(data["code"]==1){
			alert("添加成功");
		}else{
			alert("添加失败");
		}
	},"json");
	return false;
}
function IsNum(s){
    if (s!=null && s!=""){
        return !isNaN(s);
    }
    return false;
}

</script>
</head>

<body>
	<ul>
		<form  onSubmit="return check()" method="post">
		<li>	<label>商户开户行行号</label><input name="c1" id="c1"></li>
		<li>	<label>商户开户行名称</label><input name="c2" style="width:500px;" id="c2"></li>		
		<li>	<label>商户接收行行号</label><input name="c5" id="c5"><br/>		
		<li>	<input type="submit" value="提交">
			<input type="reset" value="重置">	
			</li>
		</form>
	</ul>
</body>
</html>
