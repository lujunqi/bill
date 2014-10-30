<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="../../import.jsp"%>
<html>
<head>
<title>用户信息录入</title>
<meta http-equiv="content-script-type" content="text/javascript">
<meta http-equiv="content-style-type" content="text/css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../../css/style.css" rel="stylesheet" type="text/css" />


<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript"
	src="../../js/WdatePicker.js"></script>
<style type="text/css">
ul {
	list-style: none
}
</style>
</head>

<body>
	<center>
		<h1>报表导出</h1>
		<ul>
			<li>
			<div  class="left02">
			<div class="left02topDiv">
				<div class="left02top_right"></div>
				<div class="left02top_left"></div>
				<div class="left02top_c"><span id="titleName">回访报表</span> </div>
			</div>
		</div>
				<form action="../action/report/VisitBacklogExport.jsp">
						 月份筛选：<input readonly="readonly"
							onclick="new WdatePicker({dateFmt:'yyyy-MM'})" id="b" name="where">
					<input value="导出回访报表" type="submit">
				</form>
			</li>
			<li>
			<div  class="left02">
			<div class="left02topDiv">
				<div class="left02top_right"></div>
				<div class="left02top_left"></div>
				<div class="left02top_c"><span id="titleName">派单报表</span> </div>
			</div>
		</div>
				<form action="../action/report/AssignOrderExport.jsp">
					月份筛选：<input readonly="readonly"
						onclick="new WdatePicker({dateFmt:'yyyy-MM'})" id="b" name="where">
					<input value="导出派单报表" type="submit">
				</form>
			</li>
		</ul>
	</center>
</body>
</html>
