<%@page import="com.szzt.dao.DaoUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../import.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


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

<link rel="stylesheet" href="../../css/allinpay.css" media="screen" />

<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/thickbox-compressed.js"></script>
<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
<script src="../../js/formly.min.js"></script>
<script src="../../js/jquery.form.js"></script> 
<script src="../../js/jquery.pagination.js" type="text/javascript"></script>
<script src="../../js/WdatePicker.js" type="text/javascript"></script>
<script>

$(document).ready(function()
{
	$('complainForm').resetForm();
	$("#complainForm").formly();
	$("#detailForm").formly();
	$("#complainDetailDiv").hide();
	$("#detailForm").formly();
	//findComplain(0);
	//find(0);
});

	var object;
	var cur_page = 0;
	function find(cur_page){
	    //alert(sqlstr);
		cur_page = cur_page || 0;
		//$("#cur_page").val(cur_page+1);
		var page_size = $("#page_size").val();
		$.ajax({
			url:'../action/member/show.jsp',
			dataType:'json',
			type:'POST',
			data:{cur_page:cur_page+1,'page_size':page_size,query_depart:$("#query_depart").val(),query_stauts:$("#query_stauts").val(),query_name:$("#query_name").val(),area:$("#area").val()},
			success: function(json){
				object = json.resultset;
		        $('#complain_Templet').nextAll().remove();
		        if (json.total==0){
		        	$('#result').text('没有找到符合的记录！');
		        }else{
		        	$('#result').text("");
		        }
		        var i=0;
		        for(i=(json.rows-1);i>=0;i--){
		        	var row = $('#complain_Templet').clone(true);
		        	for(var pro in object[0]) {
		        		if(pro=="oper_status"){
		        			if(object[i][pro]==1){
		        				row.find('#'+pro+'').text("正常");
		        			}else{
		        				row.find('#'+pro+'').text("禁用");
		        			}
		        		}
		        		else if(pro=="operman_id"){
		        			var del="<button onclick='del("+object[i][pro]+")'>禁用</button>";
		        			var show="<button onclick='modify("+object[i][pro]+")'>修改</button>";
		        			row.find('#dosmthing').html(del+show);
		        		}else  row.find('#'+pro+'').text(object[i][pro]);
		        	}
			        row.show();
			        row.insertAfter('#complain_Templet');
		        };
		        $('#complain_Table').mygrid();
		    	$('#cust_Pagination').pagination(json.total, {
		    		current_page : cur_page,
		    		prev_text : '前一页',
		    		next_text : '后一页',
		    		callback : find
		    	});
		    	$('#cust_Searchresult').text(
		    			'当前显示 ' + ((cur_page * $('#page_size').val()) + 1) + '-'
		    					+ ((cur_page * $('#page_size').val()) + json.rows) + ' 条记录,共 '
		    					+ json.total + ' 条记录');
	    	},  
		    error: function(XmlHttpRequest, textStatus, errorThrown){  
		        alert( "error");  
		    }
		 }); 
	}
	function del(id){
		if(null==id){
			alert("系统错误，请刷新页面！");
		}else{
			if(confirm("确认禁用？")){
				$.post("../action/member/del.jsp",{id:id},function(d){
					if(d<0){
						alert("禁用失败！");
					}else alert("禁用成功！");
				});
			}
		}
	}
	function modify(id){
		if(null==id){
			alert("系统错误，请刷新页面！");
		}else{
			window.open ('insert.jsp?show=1&id='+id, 'sdfhkd', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
		}
	}
</script>
<title>员工信息</title>
</head>

<body >
	<div id=detailDiv class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" id="titleInfo">查询条件</div>
		</div>
		<div class="left02downDiv">
		<form id="complainForm" method="post">
		<table border='0px' style='font-sizd: 1.2em' >
		
		<tr>
			<td align='right' width="8%">部门:</td>
			<td width="15%">
			<%
				DaoUtils utils=new DaoUtils();
				request.setAttribute("market", utils.marketInfo());
			%>
				<select id="query_depart"  style="width:100px">
					<option value="">所有</option>
					<c:forEach var="v" items="${market }">
						<option value="${v.key}">${v.value }</option>
					</c:forEach>
				</select>
			</td>
			<td align='right' width="8%">状态:</td>
			<td width="15%">
				<select id="query_stauts"  style="width:100px">
					<option value="">所有</option>
					<option value="1">正常</option>
					<option value="0">禁用</option>
				</select>
			</td>
			<td align='right' width="8%">用户名:</td>
			<td width="15%">
				<input type="text" id="query_name" style="width: 120px;" maxlength="12"/>
			</td>
			<td align='right' width="8%">地区:</td>
			<td width="15%">
				<select style="width:100px" name="area"  id="area">
						<option value="">---请选择----</option>
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
						<option value="4301">长沙市</option>
						<option value="4312">怀化市</option>
						<option value="4325">娄底市</option>
						<option value="4326">湘西自治州</option>
					</select>
			</td>
			<td align="right" ><input name="submit" type="button" value="查 询" onclick="find(0)"  />&nbsp;
			</td>
		</tr>
		</table>
			<input type="hidden" id="cur_page" name="cur_page" />
			<input type="hidden" id="type" name="type" value="4"/>
			<input type="hidden"  id="page_size" name="page_size" value="20"/>
		</form>
		</div>
		
	<div id="listDiv" class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" style="width: 400px"><span id="titleName">回访列表
				<font id="result" color=red></font></span> </div>
		</div>
		<div class="left02downDiv">
		<table id='complain_Table' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>登录账号</th>
				<th class='dataTableHeader'>姓名</th>
				<th class='dataTableHeader'>状态</th>
				<th class='dataTableHeader'>部门</th>
				<th class='dataTableHeader'>联系方式</th>
				<th class='dataTableHeader'>地区</th>
				<th class='dataTableHeader'>银行账号</th>
				<th class='dataTableHeader'>操作</th>
				
			</tr>
			<tr id='complain_Templet' style="cursor:hand;">
					<td id='accout' ></td>
					<td id='operman_name' ></td>
					<td id='oper_status'></td>
					<td id='depart' ></td>
					<td id='oper_comp'></td>
					<td id='city' ></td>
					<td id='bank_account'></td>
					<td id='dosmthing'></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div>
		
</body>
</html>

