<%@page import="com.szzt.dao.DaoUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../import.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="../../css/allinpay.css" media="screen" />

<script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
<script type="text/javascript">
function onlyNumberAllow(obj){
	var val=$(obj).val();
	if(null!=val&&val.length>0){
		//先把非数字的都替换掉，除了数字和.
		obj.value = obj.value.replace(/[^\d.]/g,"");
		//必须保证第一个为数字而不是.
		obj.value = obj.value.replace(/^\./g,"");
		//保证只有出现一个.而没有多个.
		obj.value = obj.value.replace(/\.{2,}/g,".");
		//保证.只出现一次，而不能出现两次以上
		obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
	}
}
function beforeSubmit(form) {
	var allow = "";
	$("#f input:[type!='hidden']:[class!='notRequired'],#f select").each(function(index, data) {
		if (this.value == null || this.value == ''&&this.required!='false') {
			allow = false;
			allow = $($(this).parent()).prev().html() + " 未填写！";
			try{
				$(this).focus();
			}catch(e){
			}
			return false;
		}
		return true;
	});
	if ("" != allow) {
		alert(allow);
		return false;
	}
	return true;
}
</script>
<c:if test="${param.show==1}">
	<script type="text/javascript">
		$(function(){
			$.post("../action/member/query.jsp",{id:${param.id}},function(r){
				var r=eval("("+r+")");
				if(r){
					for(var v in r){
						$("[name='"+v+"']").val(r[v]);
					}
				}
			});
		});	
	</script>
</c:if>
</head>

<body>
	<center>
		<c:if test="${param.show==null }">
			<form onsubmit="return beforeSubmit()" id="f" method="post" action="../action/member/insert.jsp">
		</c:if>
		<c:if test="${param.show==1 }">
			<form onsubmit="return beforeSubmit()" id="f" method="post" action="../action/member/update.jsp">
		</c:if>
			<table border="1">
				<tr>
					<td>用户编号</td>
					<td>
						<c:if test="${param.show==null }">自动生成...</c:if>
						<c:if test="${param.show==1 }">${param.show }
							<input type="hidden" name="operman_id" value="${param.id}"/>
						</c:if>
					</td>
					<td>所属部门</td>
					<td>
						<%
							DaoUtils utils=new DaoUtils();
							request.setAttribute("market", utils.marketInfo());
						%>
							<select id="departid" name="departid" style="width:100px">
								<option value="">---请选择----</option>
								<c:forEach var="v" items="${market }">
									<option value="${v.key}">${v.value }</option>
								</c:forEach>
							</select>
					</td>
				</tr>
				<tr>
					<td>登录账号</td>
					<td><input maxlength="30" name="accout"></td>
					<td>用户名</td>
					<td><input maxlength="30" name="operman_name"></td>
				</tr>
				<tr>
					<td>银行卡号</td>
					<td><input maxlength="30" name="bank_account"></td>
					<td>手机号码</td>
					<td><input maxlength="30" name="oper_comp"></td>
				</tr>
				<tr>
					<td>地址</td>
					<td>
						<select style="width:100px" name="oper_address"  id="oper_address">
						<option value="">---请选择----</option>
						<option value="0000">超级地区用户</option>
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
						<option value="4301">长沙市</option>
						<option value="4312">怀化市</option>
						<option value="4325">娄底市</option>
						<option value="4326">湘西自治州</option>
					</select>
					</td>
					<td>用户状态</td>
					<td>
						<select name="oper_status">
							<option value="1">正常</option>
							<option value="0">禁止</option>
						</select>
					</td>
				</tr>
				<tr>
				<c:if test="${param.show==1 }">
						<td>重置密码</td>
						<td><input type="checkbox" value="1111" name="oper_pass1"></td>
					</c:if>
				</tr>
			</table>
			<center>
				<input type="submit" value="提交">
				<input type="reset" value="重置">
			</center>
		</form>
	</center>
</body>
</html>
