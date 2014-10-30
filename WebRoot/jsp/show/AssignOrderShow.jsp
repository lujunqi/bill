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

	$(document).ready(function()
{
	$('complainForm').resetForm();
	$("#complainForm").formly();
	$("#detailForm").formly();
	$("#complainDetailDiv").hide();
	$("#detailForm").formly();

	//findComplain(0);
});


function findComplain(cur_page){
	if(!timeSelected()){
		alert("请选择日期！");
		return;
	}
	$("#queryBtn").val("正在查询。。。");
	$("#queryBtn").attr("disabled","disabled");
    $('#complain_Templet').nextAll().remove();
	cur_page = cur_page || 0;
	var row = $('#complain_Templet').clone(true);
	$("#cur_page").val(cur_page+1);
	$("#complainForm").ajaxSubmit({
		dataType:'json',
		success: function(json){
			var object = json.resultset;
	        $('#complain_Templet').nextAll().remove();
	        if (json.total==0){
	        	$('#complain_Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
	        }
	        var i=0;
	        for(i=(json.rows-1);i>=0;i--){
	        	var row = $('#complain_Templet').clone(true);
	        	row.attr('id', object[i].COMP_ID);
	        	row.find("#customerId").html(object[i]["UNIT_NAME"]);
	        	row.find("#compDate").html(object[i]["COMP_DATE"]);
	        	row.find("#compType").html(getComType(object[i]["COMP_TYPE"]));
	        	row.find("#compStatus").html(object[i]["COMP_STATUS"]==1?"待处理":"已处理");
	        	row.find("#connectMan").html(object[i]["CONTACT_NAME_1"]);
	        	row.find("#connectTel").html(object[i]["CONTACT_TEL_1"]);
	        	row.find("#oper_name").html(object[i]["SAFE_MAN"]);
		        row.show();
		        row.insertAfter('#complain_Templet');
	        };
	        $('#complain_Table').mygrid();
	    	$('#cust_Pagination').pagination(json.total, {
	    		current_page : cur_page,
	    		prev_text : '前一页',
	    		next_text : '后一页',
	    		items_per_page:20,
	    		page_size:20,
	    		callback : findComplain
	    	});
	    	$('#cust_Searchresult').text(
	    			'当前显示 ' + ((cur_page * $('#page_size').val()) + 1) + '-'
	    					+ ((cur_page * $('#page_size').val()) + json.rows) + ' 条记录,共 '
	    					+ json.total + ' 条记录');
	    	$("#queryBtn").val("查询");
	    	$("#queryBtn").removeAttr("disabled");
    	},  
	    error: function(XmlHttpRequest, textStatus, errorThrown){  
	        alert( "error");  
	    	$("#queryBtn").val("查询");
	    	$("#queryBtn").removeAttr("disabled");
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
	}
}
	function complainDetail(id)
	{
		$('#detailForm').resetForm();
		$("#complainDetail").click();
		$.ajax({
			type : 'POST',
			global : false,
			url : '../action/AssignOrderDataQuery.jsp',
			data : {
				'comp_id' : id
			},
			dataType : 'json',
			cache : false,
			async : false,
			success : function(json) {
				var object = json.resultset;
				for(var pro in object[0]) {
	        		$("#detailForm").find('[name='+pro+']').val(object[0][pro]);
	        	}
				 $("form[id=detailForm] [name!=SLOVE_CONT]:[type!=button]").attr("disabled","disabled");
			},
			error : function(json) {
				alert('操作失败!\nSQL: ' + id + '\n' + json.responseText);
			}
		});
		
	}
	
	function cancel()
	{
		$('#detailForm').resetForm();
		$('#complainDetailDiv').hide();
		tb_remove();
	}
	
	function solveComplain()
	{
		var solveCont = $("form[id=detailForm] [name=SLOVE_CONT]").val();
		if(solveCont == "")
		{
			alert('请输入解决反馈');
			$("form[id=detailForm] [name=solveCont]").focus();
			return;
		}
		$.post("../action/AssignOrderUpdate.jsp",{'COMP_ID':$("#COMP_ID").val(),'SLOVE_CONT':$("#SLOVE_CONT").val()},function(data){
			if(parseInt(data)==1){
				alert("操作成功！");
			}else{
				alert("操作失败，请重试！");
			}
			 $('#solveForm').resetForm();
			 $('#sovlComplainDiv').hide();
			 tb_remove(); 
		});
		return;
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
	/**
	 * return true时间选择，false 时间未选择
	 */
	function timeSelected(){
		   return ($('#startTime').val() != '')&&($('#endTime').val() != '');
	}
</script>
<title>回访派单查询</title>
</head>

<body >

	<div id=detailDiv class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" id="titleInfo">查询条件</div>
		</div>
		<div class="left02downDiv">
		<form id="complainForm" action="../action/AssignOrderDataQuery.jsp"  method="post">
		<table border='0px' style='font-sizd: 1.2em' >
		<tr>
			<td align='right' width="10%">查询时间段:</td>
			<td width="20%">
				<input  readonly="readonly" style='width: 90px' id="startTime" name="startTime" onclick="WdatePicker();" class="Wdate" />
				至
				<input  readonly="readonly" style='width: 90px' id="endTime" name="endTime" onclick="WdatePicker();" class="Wdate" />
			</td>
			<td align='right' width="10%">工单类型:</td>
			<td width="10%">
				<select id="compType"  style='width: 130px' name="compType">
					<option value="">所有</option>
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
			<td align='right' width="8%">解决状态:</td>
			<td width="10%">
				<select id="compStatus" name="compStatus" >
					<option value="">所有</option>
					<option value="1">未解决</option>
					<option value="2">已解决</option>
				</select>
			</td>
			<td align='right' width="8%">商户名称:</td>
			<td width="10%">
				<input type="text" name="UNIT_NAME" style="width: 120px;" maxlength="12"/>
			</td>
			<td align="right" ><input name="submit" type="button" id="queryBtn" value="查 询" onclick="findComplain(0)"  />&nbsp;
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
				<th class="dataTableHeader">客户名称</th>
					<th class="dataTableHeader">投诉时间</th>
					<th class="dataTableHeader">工单类型</th>
					<th class="dataTableHeader">投诉状态</th>
					<th class="dataTableHeader">客户联系人</th>
					<th class="dataTableHeader">联系方式</th>
					<th class="dataTableHeader">维护人员</th>
			</tr>
			<tr id='complain_Templet' onclick="complainDetail(this.id);" style="cursor:hand;">
				<td id="customerId" style="width:22%"></td>
				<td id="compDate"></td>
				<td id="compType"></td>
				<td id="compStatus"></td>
				<td id="connectMan"></td>
				<td id="connectTel"></td>
				<td id="oper_name"></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div>
		
		
		<!--//************************************ 客户回访详细*****************************************************//	-->
	
	<a id='complainDetail' href='#TB_inline?height=300&width=1100&inlineId=complainDetailDiv' class='thickbox'></a>
   	<div id="complainDetailDiv" class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c">客户回访详细</div>
		</div>
		<div class="left02downDiv">
			<form id="detailForm" action="../action/AssignOrderUpdate.jsp" >
				<input type="hidden" name="COMP_ID" id="COMP_ID">
				<table width="99%" border='0px' style='font-sizd: 1.2em' >
					<tr>
						<td align="right" width="15%">客户营业名称:</td>
						<td width="30%">
							<input name="UNIT_NAME" id="UNIT_NAME" style="width: 99%; color: rgb(187, 187, 187);" maxlength="100" type="text"></td>
						</td>	
						<td align="right">客户单位性质:</td>
						<td>
							<input name="UNIT_ATTR" id="UNIT_ATTR" style="width: 99%; color: rgb(187, 187, 187);" maxlength="100" type="text">
						</td>						
					</tr>
					<tr>
						<td align="right" width="15%">客户联系人:</td>
						<td>
							<input name="CONTACT_NAME_1" id="CONTACT_NAME_1" style="width: 99%; color: rgb(187, 187, 187);" maxlength="100" type="text">
						</td>
						<td align="right" width="15%">联系方式:</td>
						<td>
							<input name="CONTACT_TEL_1" id="CONTACT_TEL_1" style="width: 99%; color: rgb(187, 187, 187);" maxlength="100" type="text">
						</td>
					</tr>
					<tr>
						<td align="right" width="15%">工单类型:</td>
						<td>
							<input name="COMP_TYPE" id="COMP_TYPE" style="width: 99%; color: rgb(187, 187, 187);" maxlength="100" type="text">
						</td>
						<td align="right" width="15%">维护人员:</td>
						<td>
							<input name="SAFE_MAN" style="width: 99%; color: rgb(187, 187, 187);" maxlength="100" type="text">
						</td>
					</tr>
					<tr>
						<td align="right" width="15%">投诉时间：</td>
						<td>
							<input name="COMP_DATE" id="COMP_DATE" style="width: 99%; color: rgb(187, 187, 187);" maxlength="100" type="text">
						</td>
						<td align="right" width="15%">解决时间:</td>
						<td>
							<input name="CHANGE_DATE" id="CHANGE_DATE" style="width: 99%; color: rgb(187, 187, 187);" maxlength="100" type="text">
						</td>
					</tr>
					<tr>
						<td align="right" width="15%">投拆内容:</td>
						<td colspan="3">
							<input name="COMP_CONT" style="width: 99%; color: rgb(187, 187, 187);" maxlength="100" type="text">
						</td>
					</tr>
					<tr>
						<td align="right" width="15%">解决反馈:</td>
						<td colspan="3">
							<input type='text' name='SLOVE_CONT' id="SLOVE_CONT" style='width: 99%' maxlength="100"
							 />
						</td>
					</tr>
				</table>
			<br>
			<input name="submit" type="button" onclick="solveComplain()" value="确定" />
			<input type="button" value="返回" onclick="cancel()">
			<br>
			</form>
		</div>
	</div>
	</div>
</body>
</html>

