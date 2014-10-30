<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="../../import.jsp"%>
<html>
<head>
<meta http-equiv="content-script-type" content="text/javascript">
<meta http-equiv="content-style-type" content="text/css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
<script language="javascript" type="text/javascript"
	src="../../js/WdatePicker.js"></script>
<script type="text/javascript">
	
</script>
</head>

<body>
	<form action="../action/report/ApmsExport.jsp" onsubmit="if(!$('#date').val()){alert('请选择日期！');return false;}else return true;">
		选择日期:<input id="date" name="date" readonly="readonly" onclick="WdatePicker()">&nbsp;<input type="submit" value="导出">
	</form>
</body>