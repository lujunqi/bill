<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
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
<script src="../../js/jquery.pagination2.js" type="text/javascript"></script>
<script src="../../js/WdatePicker.js" type="text/javascript"></script>
<script>

	$(document).ready(function()
{
		
	$('form').resetForm();
	$("#detail_custForm").formly();
	//
	var address=${sessionScope.man.oper_address};
	if(address!="0000"){
		$("#unit_area").val(address);
		$("#unit_area").hide();
		$("#unit_area").parent().prev("td").hide();
	}
	//find(0);
});

var cur_page = 0;
function find(cur_page){
	if(!timeSelected()){
		alert("请选择日期！");
		return;
	}
	var sqlstr = "";
    if ($('#merchant_name').val() != ''){
    	sqlstr += " and comm.unit_name like '%"+$('#merchant_name').val()+"%'";
    }
    if ($('#unit_area').val() != ''){
    	sqlstr += " and comm.unit_area = '"+$('#unit_area').val()+"'";
   }
    if ($('#sequence').val() != ''){
    	sqlstr += " and fax.id = '"+$('#sequence').val()+"'";
    }
    if ($('#startTime').val() != ''){
    	sqlstr += " and fax.in_time >= to_date('"+$('#startTime').val()+"','yyyy-MM-dd')";
    } 
    if ($('#endTime').val() != ''){
    	sqlstr += " and fax.in_time <= to_date('"+$('#endTime').val()+"','yyyy-MM-dd')";
    }       
    
    $('#merDayGain_Templet').nextAll().remove();
	cur_page = cur_page || 0;
	var row = $('#merDayGain_Templet').clone(true);
	$("#cur_page").val(cur_page+1);
	var page_size = $("#page_size").val();
	$.ajax({
		url:'../action/UnReceiveBaseMoney.jsp',
		dataType:'json',
		type:'POST',
		data:{'where':sqlstr,'cur_page':cur_page+1,'page_size':page_size},
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
	        		row.find('#'+pro+'').text(object[i][pro]);
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
	    			'当前显示 ' + ((cur_page * $('#page_size').val()) + 1) + '-'
	    					+ ((cur_page * $('#page_size').val()) + json.rows) + ' 条记录,共 '
	    					+ json.total + ' 条记录');
    	},  
	    error: function(XmlHttpRequest, textStatus, errorThrown){  
	        alert( "error");  
	    }
	 }); 
}
	/**
	 * return true时间选择，false 时间未选择
	 */
	function timeSelected(){
		   return ($('#startTime').val() != '')&&($('#endTime').val() != '');
	}
	function exportReport()
	{
		if(!timeSelected()){
			alert("请选择日期！");
			return;
		}
		var cust_Table = document.getElementById('cust_Table');
			var sqlstr = "";
		    if ($('#merchant_name').val() != ''){
		    	sqlstr += " and comm.unit_name like '%"+$('#merchant_name').val()+"%'";
		    }
		    if ($('#unit_area').val() != ''){
		    	sqlstr += " and comm.unit_area = '"+$('#unit_area').val()+"'";
		   }
		    if ($('#sequence').val() != ''){
		    	sqlstr += " and fax.id = '"+$('#sequence').val()+"'";
		    }
		    if ($('#startTime').val() != ''){
		    	sqlstr += " and fax.in_time >= to_date('"+$('#startTime').val()+"','yyyy-MM-dd')";
		    } 
		    if ($('#endTime').val() != ''){
		    	sqlstr += " and fax.in_time <= to_date('"+$('#endTime').val()+"','yyyy-MM-dd')";
		    }       
			
			if($("#unit_area").val() != null && $("#unit_area").val() != '')
			{
			}
			else
			{
				alert('只能按地区导出，请先按地区查询');
				document.getElementById('unit_area').focus();
				return;
			}
		   	location.href='../action/report/UnReceiveBaseMoneyExport.jsp?sql='+sqlstr;
	}
</script>

</head>

<body>

	<div id=detailDiv class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" id="titleInfo" style="width: 600px">押金报表->查询条件</div>
		</div>
		<div class="left02downDiv">
		<form id="detail_custForm" action="ExecuteQuery.jsp"  method="post">
		<table border='0px' style='font-sizd: 1.2em' >
		<tr>
			<td align='right' width="8%">时间段:</td>
			<td width="30%">
				<input  readonly="readonly" style='width: 100px' id="startTime" name="startTime" onclick="WdatePicker();" class="Wdate" />
				至
				<input  readonly="readonly" style='width: 100px' id="endTime" name="endTime" onclick="WdatePicker();" class="Wdate" />
			</td>
	
			<td align='right' width="8%">商户名称:</td>
			<td width="13%">
				<input   style='width: 100px' id="merchant_name" name="merchant_name" />
			</td>	
			<td align='right' width="8%">序号:</td>
			<td width="8%">
				<input  id="sequence" name="sequence" />
			</td>	
			<td align='right' width="12%">所在地区:</td>
			<td width="13%">
			<select id="unit_area" name='unit_area' style='width: 120px' />
				<option value=''>请选择</option>
				<%
						Ws_areaDao ws_areaDao = new Ws_areaDao();
						Ws_area[] ws_areas = ws_areaDao.select();
						for(int i=0;i<ws_areaDao.totalCount;i++){
							out.println("<option value='"+ws_areas[i].getAreaid()+"'  >"+ws_areas[i].getCity()+"</option>");
						}
				%>
					</select>
			</td>	
		</tr>
		<tr>
			<td colspan="8" align="right" ><input  type="button" value="查 询" onclick="find(0)"  />&nbsp;
			<%Permission per=new PositionPermessionImpl();
			if(per.hasPermission(session, Permission.REPORT_EXPORT)){%>
					<input name="goback" type="button" value="导出excel" onclick="exportReport()" /> 
			<%} %>
			</td>
		</tr>
		</table>
			<input type="hidden" id="cur_page" name="cur_page"  value=0/>
			<input type="hidden"  id="page_size" name="page_size" value="20"/>
		</form>
		</div>
	
	<div id="listDiv" class="left02">
		<div class="left02downDiv">
		<form id="queryForm">
		<table id='cust_Table' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>序号</th>
				<th class='dataTableHeader'>商户编号</th>
				<th class='dataTableHeader'>客户名称</th>
				<th class='dataTableHeader'>押金金额</th>
				<th class='dataTableHeader'>出票时间</th>
			</tr>
			<tr id='merDayGain_Templet' >
				<td id='id' ></td>
				<td id='term_id1' ></td>
				<td id='unit_name' style="width:22%;" ></td>
				<td id="cost"></td>
				<td id="in_time"></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div>
		</form>
	</div>
</body>
</html>

