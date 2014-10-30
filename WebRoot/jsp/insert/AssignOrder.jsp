<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.dao.DaoUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
String info = request.getParameter("info");
if(null!=info&&info.equals("1")){
	out.println("<script type=\"text/javascript\">alert('派单成功！')</script>");
}
if(null!=info&&info.equals("-1")){
	out.println("<script type=\"text/javascript\">alert('派单失败！')</script>");
}
%>

<html>
<head>
<meta http-equiv="content-script-type" content="text/javascript">
<meta http-equiv="content-style-type" content="text/css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../../css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../../css/dataTable.css" media="screen" />
<link rel="stylesheet" href="../../css/formly.min.css" media="screen" />
<link rel="stylesheet" href="../../css/tabs.css" media="screen" />
<link rel="stylesheet" href="../../css/pagination.css" media="screen" />
<link rel="stylesheet" href="../../css/thickbox.css" />



<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/thickbox-compressed.js"></script>
<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
<script src="../../js/formly.min.js"></script>
<script src="../../js/jquery.form.js"></script> 
<script src="../../js/jquery.pagination.js" type="text/javascript"></script>
<script src="../../js/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function(){
		$.post("../action/AssignOrderBaseQuery.jsp",{'terminalId':${param.terminalId}},function(json){
			json=eval("("+json+")");
			var result=json.resultset[0];
			$("input,select").each(function(){
				var itemId=$(this).attr("id");
				if(result[itemId])
					$(this).val(result[itemId]);
			});
			$("#UNIT_ATTR").val(result["UNIT_ATTR"]);
		});
		find(0);
	});
	var cur_page = 0;
	function find(cur_page){
	    $('#merDayGain_Templet').nextAll().remove();
		cur_page = cur_page || 0;
		var row = $('#merDayGain_Templet').clone(true);
		$("#cur_page").val(cur_page+1);
		var page_size = $("#page_size").val();
		$.ajax({
			url:'../action/AssignOrderDataQuery.jsp',
			dataType:'json',
			type:'POST',
			data:{"COMMERCIAL_ID":${param.commercialId},'cur_page':cur_page+1,'page_size':page_size},
			success: function(json){
				var object = json.resultset;
		        $('#merDayGain_Templet').nextAll().remove();
		        if (json.total==0){
		        	$('#cust_Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
		        }
		        var i=0;
		        for(i=(json.rows-1);i>=0;i--){
		        	var row = $('#merDayGain_Templet').clone(true);
		        	row.find("#customerId").html(object[i]["UNIT_NAME"]);
		        	row.find("#compDate").html(object[i]["COMP_DATE"]);
		        	row.find("#compType").html(getComType(object[i]["COMP_TYPE"]));
		        	row.find("#compStatus").html(object[i]["COMP_STATUS"]==1?"待处理":"已处理");
		        	row.find("#connectMan").html(object[i]["CONTACT_NAME_1"]);
		        	row.find("#connectTel").html(object[i]["CONTACT_TEL_1"]);
		        	row.find("#oper_name").html(object[i]["SAFE_MAN"]);
			        row.show();
			        row.insertAfter('#merDayGain_Templet');
		        };
		        $('#cust_Table').mygrid();
		    	$('#cust_Pagination').pagination(json.total, {
		    		current_page : cur_page,
		    		prev_text : '前一页',
		    		next_text : '后一页',
		    		callback : find
		    	});
		    	$('#cust_Searchresult').text(
		    			'当前显示 ' + ((cur_page * 20) + 1) + '-'
		    					+ ((cur_page * 20) + json.rows) + ' 条记录,共 '
		    					+ json.total + ' 条记录');
	    	},  
		    error: function(XmlHttpRequest, textStatus, errorThrown){  
		        alert( "error");  
		    }
		 }); 
	}
function getComType(id){
	if(null==id){
		return "所有";
	}
	switch(id){
	case '01':return "问咨";break;
	case '02':return "故障";break;
	case '03':return "服务质量";break;
	case '04':return "其它";break;
	case '05':return "交易查询";break;
	case '06':return "撤机";break;
	case '07':return "账务调整";break;
	case '08':return "耗材配送";break;
	case '00':return "所有";break;
	}
}
function complainSubmit(){
	var allow=true;
	$("#complainForm input").each(function(){
		if($(this).val()==null||$(this).val().length<1){
			alert("信息输入不完整！");
			allow=false;
			return false;
		}
	});
	return allow;
}
</script>
</head>

<body >
	
	<div id="TB_ajaxContent"><div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c">回访派单</div>
		</div><div class="left02downDiv">
			<form onsubmit="return complainSubmit()" class="formlyWrapper-Base" id="complainForm" action="../action/AssignOrderInsert.jsp" method="post">
				<table style="font-sizd: 1.2em" border="0px" width="99%">
					<tbody>
					<tr>
						<td align="right" width="15%">客户营业名称:</td>
						<td width="30%">
							<input id="COMMERCIAL_ID" name="COMMERCIAL_ID" type="hidden" value="${param.commercialId }">
							<input id="TEMINAL_INFO_ID" name="TEMINAL_INFO_ID" value="${param.terminalId }" type="hidden">
							<input  name="opertype" value="1" type="hidden">
							<input name="UNIT_NAME" id="UNIT_NAME" style="width: 180px" type="text"></td>
						</td>							
					</tr>
					<tr>
						<td align="right">客户单位性质:</td>
						<td>
							<select name="UNIT_ATTR"  id="UNIT_ATTR">
								<option value="0">个体商户</option>
								<option value="1">企业用户</option>
								<option value="3">个人用户</option>
								<option value="4">其他</option>
							</select>
						</td>
						<td align="right">装机地址:</td>
						<td><input name="UNIT_INSTALLED_ADD" id="UNIT_INSTALLED_ADD" style="width: 98%" type="text"></td>
					</tr>
					<tr>
						<td align="right">客户联系人:</td>
						<td>
							<input name="CONTACT_NAME_1" id="CONTACT_NAME_1" style="width: 120px" maxlength="20" type="text">
						</td>
						<td align="right">联系方式:</td>
						<td>
							<input name="CONTACT_TEL_1" id="CONTACT_TEL_1" style="width: 120px" maxlength="20" type="text">
						</td>
					</tr>
					<tr>
						<td align="right">工单类型:</td>
						<td>
							<select name="COMP_TYPE" onchange="checkRevokeStatus(this.value)" style="width: 120px">
								<option value="01">问咨</option>
								<option value="02">故障</option>
								<option value="03">服务质量</option>
								<option value="04">其它</option>
								<option value="05">交易查询</option>
								<option value="06">撤机</option>
								<option value="07">账务调整</option>
								<option value="08">耗材配送</option>
							</select>
						</td>
						<td align="right">维护人员:</td>
						<td>
							<%
							DaoUtils daoUtils=new DaoUtils();
							request.setAttribute("safeUsers", daoUtils.operateUser(Permission.SAFE_POSITION)); %>
					<select id="SAFE_MAN" name="SAFE_MAN">
						<c:forEach items="${safeUsers }" var="val" varStatus="vasta">
							<option value="<c:out value="${val.key }"></c:out>"><c:out value="${val.value }"></c:out></option>
						</c:forEach> 
					</select>
						</td>
					</tr>
					<tr>
						<td align="right">投拆内容:</td>
						<td colspan="3">
							<input name="COMP_CONT" style="width: 99%; color: rgb(187, 187, 187);" maxlength="100" type="text">
						</td>
					</tr>
				</tbody>
			</table>
			<br>
			
	<div style="clear:both;">
	</div><div class="formlyAlerts"></div>
	<div style="margin: 0 auto">
			<input name="submit"  value="确定" type="submit">
			<input name="submit" onclick="window.close()" value="取消" type="button">
	</div>
	</form>
		</div><div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c">客户回访记录</div>
		</div><div class="left02downDiv">
			<table id="cust_Table" class="dataTable">
				<tbody><tr>
					<th class="dataTableHeader">客户名称</th>
					<th class="dataTableHeader">投诉时间</th>
					<th class="dataTableHeader">工单类型</th>
					<th class="dataTableHeader">投诉状态</th>
					<th class="dataTableHeader">客户联系人</th>
					<th class="dataTableHeader">联系方式</th>
					<th class="dataTableHeader">维护人员</th>
					<th class="dataTableHeader">操作</th>
				</tr>
				<tr id="merDayGain_Templet">
					<td id="customerId"></td>
					<td id="compDate"></td>
					<td id="compType"></td>
					<td id="compStatus"></td>
					<td id="connectMan"></td>
					<td id="connectTel"></td>
					<td id="oper_name"></td>
					<td id="oper"></td>
				</tr>	
			<tr>
			<td colspan="10" align="center">对不起,没有找到符合条件的记录!</td></tr></tbody></table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div></div>

</body>
</html>

