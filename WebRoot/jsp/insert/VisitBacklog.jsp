<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../import.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
<link rel="stylesheet" href="../../css/allinpay.css" />


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
	$('undoForm').resetForm();
	$("#undoForm").formly();
	//find(0);
});


function find(cur_page){
	$("#resultShow").text("正在查询。。。");
	$("#searchBtn").attr("disabeld","disabled");
    $('#undo_Templet').nextAll().remove();
	cur_page = cur_page || 0;
	var row = $('#undo_Templet').clone(true);
	$("#cur_page").val(cur_page+1);
	$("#undoForm").ajaxSubmit({
		dataType:'json',
		success: function(json){
			var object = json.resultset;
	        $('#undo_Templet').nextAll().remove();
	        if (json.total==0){
	        	$('#undo_Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
	        }
	        var i=0;
	        for(i=(json.rows-1);i>=0;i--){
	        	var row = $('#undo_Templet').clone(true);
	        	//row.attr('id', object[i].merchantsNo);
	        	for(var pro in object[0]) {
	        		if(pro=="is_hurry"){
	        			if(object[i]["is_hurry"]==0){
	        				row.find('#'+pro+'').text("不加急");
	        			}else 
	        				row.find('#'+pro+'').text("加急");
	        		}
	        		else row.find('#'+pro+'').text(object[i][pro]);
	        	}
		       	row.find('#oper').html("<input type=button onclick=gotoTimenal("+object[i].COMMERCIAL_ID+","+object[i].TEMINAL_INFO_VISIT_CALL_ID+","+object[i].TEMINAL_INFO_ID+") value=开始回访 />");
		       	row.show();
		        row.insertAfter('#undo_Templet');
	        };  
	        $("#resultShow").text("查询完毕！");
	    	$("#searchBtn").removeAttr("disabeld");
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
	        alert( textStatus);  
	        $("#resultShow").text("查询完毕！");
	    	$("#searchBtn").removeAttr("disabeld");
	    }
	 }); 
}

	function gotoTimenal(customerId,id,timenalId)
	{
		window.open ("../insert/terminalInsert.jsp?show=1&terminalId="+timenalId+"&CommercialId="+customerId+"&TEMINAL_INFO_VISIT_CALL_ID="+id, "回访", 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
	}
	
</script>
<title>待办事宜</title>
</head>

<body >

	<div id=detailDiv class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" id="titleInfo">待办查询</div>
		</div>
		<div class="left02downDiv">
		<form id="undoForm" action="../action/VisitBacklogSearch.jsp"  method="post">
		<table border='0px' style='font-sizd: 1.2em' >
		<tr>
			<td align='right' width="10%">待办类型:</td>
			<td width="20%">
				<select id="undoType"  style='width: 130px' name="undoType">
					<option value="1">待回访</option>
					<option value="2">暂未接通</option>
				</select>
			</td>
			<td align='right' width="10%">归档时间：</td>
			<td width="20%">
				<input name="APPROVAL_DATE" readonly="readonly" onclick="new WdatePicker({dateFmt:'yyyy-MM'})"/>
			</td>
			<td align="right" ><input name="submit" type="button" id="searchBtn" value="查 询" onclick="find(0)"  />&nbsp;
			</td>
			<td>
				<font color=red id="resultShow"></font>
			</td>
		</tr>
		</table>
			<input type="hidden" id="cur_page" name="cur_page" />
			<input type="hidden"  id="page_size" name="page_size" value="10"/>
		</form>
		</div>
	
	<div id="listDiv" class="left02">
		<div class="left02downDiv">
		<form id="queryForm">
		<table id='undo_Table' class='dataTable1' width="100%">
			<tr>
				 <th class='dataTableHeader'>待办类型</th>
				 <th class='dataTableHeader'>商户名称</th>
				 <th class='dataTableHeader'>商户地区</th>
				 <th class='dataTableHeader'>维护人</th>
				 <th class='dataTableHeader'>加急标志</th>
				 <th class='dataTableHeader'>时间</th>
				 <th class='dataTableHeader'>备注</th>
				 <th class='dataTableHeader'>待办操作</th>
			</tr>
			<tr id='undo_Templet' >
				<td id='typeUndo'></td>
				<td id='UNIT_NAME' style="width:22%"></td>
				<td id='UNIT_AREA'></td>
				<td id='SAFE_MAN'></td>
				<td id='is_hurry'></td>
				<td id='APPROVAL_DATE'></td>
				<td id='DEMO'></td>
				<td id='oper' align="center"></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div>
		</form>
	</div>
</body>
</html>