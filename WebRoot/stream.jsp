<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="import.jsp"%>
<html>
<head>
<meta http-equiv="content-script-type" content="text/javascript">
<meta http-equiv="content-style-type" content="text/css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/tabs.css" media="screen" />
<style type="text/css">
	table.dataTable1 
	{
		border-collapse: collapse;
	}
	table.dataTable1 th.dataTableHeader {
	color: #fff;
	background-color: #052d92;
	padding: 2px;
	border: #fff 1px solid;
	text-align: center;
}

table.dataTable1 td {
	padding: 2px;
	border-style: solid;
	border-width: 1px 1px 0 1px;
	border-color: #ccc #fff #ccc #fff;
}

table.dataTable1 td a {
	padding-right: 2px;

}

table.dataTable1 tr.odd_row {
	background-color: #e4f2fb;
}

table.dataTable1 tr.even_row {
	background-color: #f8f8f8;
}

table.dataTable1 tr.odd_row:hover,
table.dataTable1 tr.even_row:hover,
table.dataTable1 tr.odd_row:hover a,
table.dataTable1 tr.even_row:hover a {
	background-color: #FFD900;
}

table.dataTable1 tr.odd_row:hover a:hover,
table.dataTable1 tr.even_row:hover a:hover {
}

table.dataTable1 th.dataTableHeader a,
table.dataTable1 th.dataTableHeader a:link,
table.dataTable1 th.dataTableHeader a:active,
table.dataTable1 th.dataTableHeader a:visited {
	color: #fff;
	display: block;
	text-decoration: none;
}

* html table.dataTable1 th.dataTableHeader a {
	width: 100%;
}

table.dataTable1 th.dataTableHeader a:hover {
	text-decoration: underline;
}

table.dataTable1 {
	border-bottom: 1px solid #fff;
}

table.dataTable1 thead td,
table.dataTable1 tfoot td.dataTableFooter {
	border: 0;
	padding: 0;
}
</style>
<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
<script language="javascript" type="text/javascript" src="js/WdatePicker.js" charset="gb2312"></script>  
<script type="text/javascript" src="js/check.js"></script>
  
<script type="text/javascript">
function excel() {
	if (!Validator.Validate(document.from1, 3)) {
		return;
	}
	var chan_type =	$('input:radio[name=chan_type]:checked').val();
	if(chan_type==2){
		alert("温馨提示:总部间联交易数据起始日期为2013-07-01! 另：间联商户当日交易数据需次日13点后方可查询");
	}
	var filename = $.trim($('#col1').val());
	var uri = "streamreportCreate.jsp?chan_type="+chan_type+"&col1="+$.trim($('#col1').val())+"&date1="+$.trim($('#date1').val())+"&date2="+$.trim($('#date2').val())+"&filename="+filename;
	window.open(uri, 'newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no');
};
</script>
</head>

<body>
	<div id="listDiv" class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c"><span id="titleName">商户交易流水下载</span> </div>
		</div>
		<div class="left02downDiv">
<form name='from1'  method="post"  id="from1" target="iframe1" action="#" onSubmit="return Validator.Validate(this,2)">
统计日期:
	<input type="text" name="date1" id="date1"  dataType='Require' msg='请输入统计起始日期'  onClick="WdatePicker({dateFmt:'yyMMdd'})"/>
		至
	<input type="text" name="date2" id="date2"  dataType='Require' msg='请输入统计截至日期'  onClick="WdatePicker({dateFmt:'yyMMdd'})"/>
	商户编号<input type="text" name="col1" id="col1"  dataType='Require' msg='请输入商户编号' maxsize="15"/>
	直连<input type="radio" id="chan_type" name="chan_type" value="1"  checked="true" /> 间联<input type="radio" id="chan_type"  name="chan_type" value="2" />
	<input type="button" name="total" value="开始统计" onclick="excel()"/>
</form>
		</div>
		</div>		
