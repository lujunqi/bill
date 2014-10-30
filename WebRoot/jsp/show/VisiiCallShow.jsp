<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="../../css/allinpay.css" />


<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/thickbox-compressed.js"></script>
<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
<script src="../../js/formly.min.js"></script>
<script src="../../js/jquery.form.js"></script> 
<script src="../../js/jquery.pagination.js" type="text/javascript"></script>
<script src="../../js/WdatePicker.js" type="text/javascript"></script>
<script>
/**
 * return true时间选择，false 时间未选择
 */
function timeSelected(){
	   return ($('#startTime').val() != '')&&($('#endTime').val() != '');
}
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
		if(!timeSelected()){
			alert("请选择日期！");
			return;
		}
		var sqlstr="";
	    if ($('#UNIT_NAME').val() != ''){
	    	sqlstr += " and com.UNIT_NAME like '%"+$('#UNIT_NAME').val()+"%'";
	    }
	    if ($('#man').val() != ''){
			sqlstr += " and o.OPERMAN_NAME like '%"+$('#man').val()+"%'";
			}
	    if ($('#has_col10').val() != ''){
	    	if($('#has_col10').val()==1){
	    		sqlstr += " and has_col10 = 1 ";
	    	}else{
	    		sqlstr += " and( has_col10 =2 or has_col10 is null) ";
	    	}
	    	
	    }    
	    if ($('#startTime').val() != ''){
	    	sqlstr += " and visit.visit_date >= to_date('"+$('#startTime').val()+"','yyyy-MM-dd')";
	    } 
	    if ($('#endTime').val() != ''){
	    	sqlstr += " and visit.visit_date <= to_date('"+$('#endTime').val()+"','yyyy-MM-dd')";
	    }       
	    //alert(sqlstr);
		cur_page = cur_page || 0;
		//$("#cur_page").val(cur_page+1);
		var page_size = $("#page_size").val();
		$.ajax({
			url:'../action/VisitBacklogDataQuery.jsp',
			dataType:'json',
			type:'POST',
			data:{'sql':sqlstr,'cur_page':cur_page+1,'page_size':page_size},
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
		        	row.attr('id', object[i].DEMO);
		        	row.attr('title', "备注："+object[i].DEMO);
		        	for(var pro in object[0]) {
		        		row.find('#'+pro+'').text(object[i][pro]);
			        	if (pro.indexOf("has",0) > -1){
			        		if (object[i][pro]=='1'){
				        		row.find('#'+pro+'').text('是');
				        	}else {
				        		row.find('#'+pro+'').text('否');
				        	}
			        	}
		        	}
		        	row.find('#index').text(i+1);
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

	function complainDetail(id)
	{
		alert("备注:\n"+id);
	}
	
	function cancel()
	{
		$('#detailForm').resetForm();
		$('#complainDetailDiv').hide();
		tb_remove();
	}
	
	function solveComplain()
	{
		var solveCont = $("form[id=detailForm] [name=solveCont]").val();
		if(solveCont == "")
		{
			alert('请输入解决反馈');
			$("form[id=detailForm] [name=solveCont]").focus();
			return;
		}
		$("#detailForm").ajaxSubmit({
			dataType:'json',
			success: function(data){
				alert('操作成功!');
				$('#detailForm').resetForm();
				$('#complainDetailDiv').hide();
				tb_remove();
	    	},  
		    error: function(XmlHttpRequest, textStatus, errorThrown){  
		         alert('操作成功!!!!!');
				 $('#solveForm').resetForm();
				 $('#sovlComplainDiv').hide();
				 tb_remove(); 
		    }
	    });
	}

	function sms(mobile_no,content){
		window.open('http://pi.noc.cn/SendSMSGB2312.aspx?Msisdn='+mobile_no+'&SMSContent='+content+'&MSGType=5&ECECCID=301011055&Password=hntonglian','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
	
	function sendsms(){
		if(!confirm("确定要发送短信吗？")){
			return ;
		}
		var content = '您有一条工单请立即处理!商户名:'+$('#detailForm').find('[name=compCont]').val()+' 装机联系人:'+$('#detailForm').find('[name=connectMan]').val()+' 电话:'+$('#detailForm').find('[name=connectTel]').val()+" 工单内容:"+$('#detailForm').find('[name=compCont]').val()+" [通联支付]";
		var inst_man = $('#detailForm').find('[name=service_man]').val();
		alert('短信发送至:'+inst_man);
		sms(inst_man,content);
	}
</script>
<title>回访查询</title>
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
			<td align='right' width="8%">查询时间段:</td>
			<td width="30%">
				<input  readonly="readonly" style='width: 100px' id="startTime" name="startTime" onclick="WdatePicker();" class="Wdate" />
				至
				<input  readonly="readonly" style='width: 100px' id="endTime" name="endTime" onclick="WdatePicker();" class="Wdate" />
			</td>
			<td align='right' width="8%">解决状态:</td>
			<td width="15%">
				<select id="has_col10" name="has_col10" >
					<option value="">所有</option>
					<option value="1">已接通</option>
					<option value="2">未接通</option>
				</select>
			</td>
			<td align='right' width="8%">商户名称:</td>
			<td width="15%">
				<input type="text" id="UNIT_NAME" style="width: 120px;" maxlength="12"/>
			</td>
			<td align='right' width="8%">维护人员:</td>
			<td width="15%">
				<input type="text" id="man" style="width: 120px;" maxlength="12"/>
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
		<div class="left02downDiv">
		<table id='complain_Table' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>序号</th>
				<th class='dataTableHeader'>维护人</th>
				<th class='dataTableHeader'>商户名称</th>
				<th class='dataTableHeader'>回访时间</th>
				<th class='dataTableHeader'>是否接通</th>
				<th class='dataTableHeader'>装机时间</th>
				<th class='dataTableHeader'>受理培训</th>
				<th class='dataTableHeader'>核对签名</th>
				<th class='dataTableHeader'>保管单据</th>
				<th class='dataTableHeader'>押金金额</th>
				<th class='dataTableHeader'>押金收据</th>
				<th class='dataTableHeader'>是否满意</th>
			</tr>
			<tr id='complain_Templet' onclick="complainDetail(this.id);" style="cursor:hand;">
					<td id='index' ></td>
					<td id='SAFE_MAN' ></td>
					<td id='UNIT_NAME' style="width:22%"></td>
					<td id='visit_date' ></td>
					<td id='has_col10' ></td>
					<td id='has_col1' ></td>
					<td id='has_col2' ></td>
					<td id='has_col3' ></td>
					<td id='has_col4' ></td>
					<td id='has_col5' ></td>
					<td id='has_col6' ></td>
					<td id='has_col7' ></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div>
		
</body>
</html>

