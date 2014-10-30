<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="../../import.jsp"%>
<html>
<head>
<%
	if (session.getAttribute("COMMERCIAL_ID") == null)
	{
		response.sendRedirect("commercialInsert.jsp?info=3");
		return;
	}
	String info = request.getParameter("info");
	if (null != info && info.equals("1"))
	{
		out.println("<script type=\"text/javascript\">alert('添加成功')</script>");
	}
	if (null != info && info.equals("-1"))
	{
		out.println("<script type=\"text/javascript\">alert('添加失败')</script>");
	}
	if (null != info && info.equals("101"))
	{
		out.println("<script type=\"text/javascript\">alert('请先录入终端信息！')</script>");
	}
%>
<meta http-equiv="content-script-type" content="text/javascript">
<meta http-equiv="content-style-type" content="text/css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../../css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../../css/tabs.css" media="screen" />
<link rel="stylesheet" href="../../css/dataTable.css" media="screen" />
<link rel="stylesheet" href="../../css/formly.min.css" media="screen" />
<link rel="stylesheet" href="../../css/pagination.css" media="screen" />
<link rel="stylesheet" href="../../css/thickbox.css" media="screen" />
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
<link rel="stylesheet" type="text/css" href="../../css/easy_tab.css" />
<script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
<script language="javascript" type="text/javascript" src="../../js/WdatePicker.js"></script>  
<script type="text/javascript" src="../../js/thickbox-compressed.js"></script>
<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
<script type="text/javascript" src="../../js/jquery.easytabs.min.js"></script>
<script src="../../js/jquery.pagination2.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/check.js"></script>
  <style type="text/css">
  	input{
  		width:300px;
  		height:30px;
  	}
  select{
  width:100px;
  height:30px;
  margin-top: 10px;
  margin-bottom: 10px;
  }
  </style>
  <script type="text/javascript">
var id=<%=request.getParameter("terminalId")%>;
<%
	if(request.getParameter("terminalId")!=null){
		session.setAttribute("TEMINAL_INFO_ID",Integer.parseInt( request.getParameter("terminalId")));
		%>
			$(function(){
						$("input").attr("disabled","disabled");
						$("select").attr("disabled","disabled");
						$("textarea").attr("disabled","disabled");
						$("button").attr("disabled","disabled");
						
						$.post("../action/TerminalDataQuery.jsp",{'where':' TEMINAL_INFO_ID='+id},function(json){
							json=eval("("+json+")");
							var result=json.resultset[0];
							$("input").each(function(){
								var itemId=$(this).attr("id");
								if(result[itemId])
									$(this).val(result[itemId]);
							});
							
						});
					});
		<%
	}
%>
</script>
<script type="text/javascript">

function beforeSubmit(form) {
	var allow = "";
	$("#" + form + " input").each(function(index, data) {
		if (this.value == null || this.value == '') {
			allow = false;
			allow = $($(this).parent()).prev().html() + " 未填写！";
			$(this).focus();
			return false;
		}
		return true;
	});
	if ("" != allow) {
		alert(allow);
	} else {
		var form = document.getElementById(form);
		form.submit();
	}
}
var cur_page = 0;
function find(cur_page){
    $('#merDayGain_Templet').nextAll().remove();
	cur_page = cur_page || 0;
	var row = $('#merDayGain_Templet').clone(true);
	$("#cur_page").val(cur_page+1);
	var page_size = $("#page_size").val();
	$.ajax({
		url:'../action/AppayDataQuery.jsp',
		dataType:'json',
		type:'POST',
		data:{'cur_page':cur_page+1,'page_size':page_size},
		success: function(json){
			var object = json.resultset;
	        $('#merDayGain_Templet').nextAll().remove();
	        if (json.total==0){
	        	$('#cust_Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
	        }
	        var i=0;
	        for(i=(json.rows-1);i>=0;i--){
	        	var row = $('#merDayGain_Templet').clone(true);
	        	for(var pro in object[0]) {
	        		row.find('#'+pro+'').html(object[i][pro]);
	        	}
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

	$(document).ready(function() {
		find();
	});
</script>
</head>

<body >

 <!-- 业务信息 -->
  <div id="BusinessManage" class="panel-container">
	<div id="listDiv" class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" style="width: 80%">
			<%if(request.getParameter("terminalId")==null){ %>
					<span id="titleName">
						<a href="bussinessInsert.jsp" style="color:red">实名支付</a>
					</span> 
					<span><a href="bussinessInsert102.jsp" style="color:red">收付宝</a></span>
			<%} %>
			</div>
		</div>
		<div class="left02downDiv">
		<form id="queryForm">
		<table id='cust_Table' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>业务名称</th>
				<th class='dataTableHeader'>业务状态</th>
				<th class='dataTableHeader'>详情</th>
			</tr>
			<tr id='merDayGain_Templet'>
				<td id="APP_NAME"></td>
				<td id="STATUS"></td>
				<td id="MORE"></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div>
		</form>
	</div>
</div>
<!-- 终端列表信息 -->
		<div class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c"><span id="titleName">终端信息记录</span> </div>
			<div class="left02top_c" style="float: right"><a href="terminalInsert.jsp">新增</a> </div>
		</div>
		<div class="left02downDiv">
		<form id="queryForm">
		<table id='cust_Table' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>联系人</th>
				<th class='dataTableHeader'>电话</th>
				<th class='dataTableHeader'>状态</th>
				<th class='dataTableHeader'>详情</th>
			</tr>
			<!-- 数据显示区 -->
			<tr id='merDayGain_Templet'>
				<td id="UNIT_INSTALLED_MAN"></td>
				<td id="UNIT_INSTALLED_TEL"></td>
				<td id="TEMINAL_STATUS"></td>
				<td id="MORE"></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</form>
		</div>
		</div>
</body>
</html>		
