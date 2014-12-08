<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="../../import.jsp"%>
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


<script type="text/javascript">
<!--

$(document).ready(function()
{
	$("#findForm").formly({},function(e) {});
});
function shutdown(){
	var date = $("#date").val();
	if (date == ''){
		alert('忘记选时间了吧!');
		return;
	}
	window.open('../action/report/exportShutdownToTxt.jsp?date='+$("#date").val()+'','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no');
}
function merchant(){
	var date = $("#date").val();
	if (date == ''){
		alert('忘记选时间了吧!');
		return;
	}
	window.open('../action/report/exportMerchantToTxt2.jsp?date='+$("#date").val()+'','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no');
}
function terminal(){
	var date = $("#date").val();
	if (date == ''){
		alert('忘记选时间了吧!');
		return;
	}
	window.open('../action/report/exportTerminalToTxt2.jsp?date='+$("#date").val()+'','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no');

}

function shutdown_dqd(){
	var date = $("#date").val();
	if (date == ''){
		alert('忘记选时间了吧!');
		return;
	}
	window.open('../action/report/exportShutdownToTxt_dqd.jsp?date='+$("#date").val()+'','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no');
}
function merchant_dqd(){
	var date = $("#date").val();
	if (date == ''){
		alert('忘记选时间了吧!');
		return;
	}
	window.open('../action/report/exportMerchantToTxt_dqd.jsp?date='+$("#date").val()+'','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no');
}
function terminal_dqd(){
	var date = $("#date").val();
	if (date == ''){
		alert('忘记选时间了吧!');
		return;
	}
	window.open('../action/report/exportTerminalToTxt_dqd.jsp?date='+$("#date").val()+'','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no');

}


function parameter(){
	var date = $("#date").val();
	if (date == ''){
		alert('忘记选时间了吧!');
		return;
	}
	window.open('../action/report/exportParamTable.jsp?date='+$("#date").val()+'','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no');

}

//-->
</script>
</head>

<body>

   	<div class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c">商户及终端数据导出</div>
		</div>
		<div class="left02downDiv">
			<form id="findForm" method="post">
			<table border='0px' style='font-sizd: 1.2em' >
				<tr>
					<td align='right'>审批日期:</td>
					<td><input type='text' id="date" name='date' style='width: 120px' require="true" label='请输入审批日期'  onClick="WdatePicker()"/></td>
					<td><input name="submit" type="button" onclick="merchant()" value="导出商户资料" /></td>
					<td><input name="submit" type="button" onclick="terminal()" value="导出终端资料" /></td>
					<td><input name="submit" type="button" onclick="shutdown()" value="导出注销终端资料" /></td>
					<td><input name="submit" type="button" onclick="merchant_dqd()" value="导出多渠道商户资料" /></td>
					<td><input name="submit" type="button" onclick="terminal_dqd()" value="导出多渠道终端资料" /></td>
					<td><input name="submit" type="button" onclick="shutdown_dqd()" value="导出多渠道注销终端资料" /></td>
					<td><input name="submit" type="button" onclick="parameter()" value="导出银联参数表" /></td>
				</tr>
			</table>
			</form>
		</div>
	</div>

</body>
</html>

