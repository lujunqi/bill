<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.dao.DaoUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
Permission per =new PositionPermessionImpl();
if(!per.hasPermission(session, Permission.LEADER_POSITION)){
	response.sendRedirect("error.jsp");
	return;
}
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>权限配置</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
center{
	margin-left: 200px
}
.div{
	float: left;
	border-style: ridge;
	height:400px
}
span{
height: 50px;
margin-right: 15px;
text-align: left;
}
select{
border-bottom: 0px;
border-top: 0px;
border-right: 0px;
border-left: 0px;
width: 100%;
height: 90%;
}
</style>
<script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
<script type="text/javascript">
	function loadAuthority(v){
		$("#bt").removeAttr("disabled");
		$.post("../action/UserPostsQuery.jsp",{id:$(v).val()},function(data){
			data=eval("("+data+")");
			$("#authorityTable").hide();
			$("#outAuthority").hide();
			$("#authorityTable").html("");
			$("#outAuthority").html("");
			for(var i in data){
				var vv="";
				if(data[i].check){
					vv=data[i].value+'<input name="au" type="checkbox" checked="checked" value="'+data[i].key+'">';
					vv="<span>"+vv+"</span>";
					$("#authorityTable").append(vv);
				}
				else{
					vv=data[i].value+'<input name="au" type="checkbox"  value="'+data[i].key+'">';
					vv="<span>"+vv+"</span>";
					$("#outAuthority").append(vv);
					}
				if(i%4==3){
					$("#authorityTable").append("<br/>");
				}
			}
			$("#authorityTable").slideDown(1000);
			$("#outAuthority").slideDown(1000);
		});
	//	$("#authorityTable").html("");		
	}
	function showUser(v){
		$("#userList").html("");
		$.post("../action/UserQuery.jsp",{area:$(v).val()},function(data){
			data=eval("("+data+")");
			for(var i in data){
				var op="<option value='"+data[i].key+"'>"+data[i].value+"</option>";
				$("#userList").append(op);
			}
		});
	}
	function wrapTd(){
		return "";
	}
	function assignOk(){
		var ids="";
		$("input:[name='au']:[checked='checked']").each(function(){
			ids+=$(this).val()+",";
		});
		ids=ids.substring(0,ids.length-1);
		$.post("../action/UserPostsAssign.jsp",{id:ids,userId:$("#userList").val()},function(data){
			if(data==1)
				{
					alert("权限分配成功！");
					loadAuthority($("#userList"));
				}
			else alert("权限分配失败！");
		});
	}
	
</script>
</head>

<body >
	<center>
		<div  class="div" style="width:90px">
			<font color="blue">地区筛选</font>
			<select title="地区筛选" style="width:100%;" name="ACCOUNT_CITY" size="14"  id="ACCOUNT_CITY" onchange="showUser(this)">
						<option value="0000">湖南省</option>
						<option value="4301">长沙市</option>
						<option value="4302">株洲市</option>
						<option value="4303">湘潭市</option>
						<option value="4304">衡阳市</option>
						<option value="4305">邵阳市</option>
						<option value="4306">岳阳市</option>
						<option value="4307">常德市</option>
						<option value="4308">张家界市</option>
						<option value="4309">益阳市</option>
						<option value="4310">郴州市</option>
						<option value="4311">永州市</option>
						<option value="4312">怀化市</option>
						<option value="4325">娄底市</option>
						<option value="4326">湘西自治州</option>
					</select>
		</div>
		<div  class="div"  style="width: 130px;" >
		<font color="blue">地区人员</font>
			<select id="userList" size="20" style="width: 100%"  onchange="loadAuthority(this)" >
			</select>
		</div>
		<div style="width: 40%;" class="div">
			<div  style="border-style:groove;border: 2px soild red">
				<div align="left" style="text-align: left;"><font color="blue">已有权限</font> </div>
				<hr>
				<div id="authorityTable"></div>
			</div>
			<div  style="border-style:groove;border: 2px soild red">
			<div align="left" style="text-align: left;"><font color="blue">未有权限</font> </div>
				<hr>
				<div id="outAuthority"></div>
			</div>
			<button onclick="assignOk()"  id="bt" disabled="disabled" style="width: 100px">提交</button>
		</div>
	</center>
	
	<div>
	</div>
</body>
</html>
