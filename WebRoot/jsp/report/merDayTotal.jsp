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
var address='0000';
	$(document).ready(function()
{
		
	$('form').resetForm();
	$("#detail_custForm").formly();
	//
	address=${sessionScope.man.oper_address};
	if(address!="0000"){
		$("#unit_area").val(address);
		$("#unit_area").hide();
		$("#unit_area").parent().prev("td").hide();
	}
	//find(0);
});
	/**
	 * return true时间选择，false 时间未选择
	 */
	function timeSelected(){
		   return ($('#startTime').val() != '');
	}
var cur_page = 0;
function find(cur_page){
	if(!timeSelected()){
		alert("请选择日期！");
		return;
	}
	var sqlstr = "";
	var marchant_name = $("#marchant_name").val();
	var marchant_no = $("#marchant_no").val();
	var unit_area = $("#unit_area").val();
	if (unit_area == null || unit_area == 'undefined')
	{
		unit_area = address;
	}
	var startTime = $("#startTime").val();

    $('#merDayGain_Templet').nextAll().remove();
	cur_page = cur_page || 0;
	var row = $('#merDayGain_Templet').clone(true);
	$("#cur_page").val(cur_page+1);
	var page_size = $("#page_size").val();
	$.ajax({
		url:'../action/merDayTotalQuery.jsp',
		dataType:'json',
		type:'POST',
		data:{'where':sqlstr,'cur_page':cur_page+1,'page_size':page_size,'unit_area':unit_area,'marchant_no':marchant_no,'marchant_name':marchant_name,'startTime':startTime},
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

	function exportReport()
	{
		if(!timeSelected()){
			alert("请选择日期！");
			return;
		}
		var cust_Table = document.getElementById('cust_Table');
			var sqlstr = "";
		    if ($('#merchant_name').val() != ''){
		    	sqlstr += " and t.unit_name like '%"+$('#merchant_name').val()+"%'";
		    }
		    if ($('#unit_area').val() != ''){
		    	sqlstr += " and t.unit_area = '"+$('#unit_area').val()+"'";
		   }
		    if ($('#merchantsno').val() != ''){
		    	sqlstr += " and trim(t.term_id1) = '"+$('#merchantsno').val()+"'";
		    }
		    if ($('#psam').val() != ''){
		    	sqlstr += " and trim(t.fld_57) = '"+$.trim($('#psam').val())+"'";
		    }    
		    if ($('#startTime').val() != ''){
		    	sqlstr += " and to_date(t.fld_13,'mmdd') >= to_date('"+$('#startTime').val()+"','MMdd')";
		    } 
		    if ($('#endTime').val() != ''){
		    	sqlstr += " and to_date(t.fld_13,'mmdd') <= to_date('"+$('#endTime').val()+"','MMdd')";
		    }       
		    sqlstr += "  ";
		    
			var unit_area = document.getElementById('unit_area').value;
			
			if(unit_area != null && unit_area != '')
			{
			}
			else
			{
				alert('只能按地区导出，请先按地区查询');
				document.getElementById('unit_area').focus();
				return;
			}
		   	location.href='../action/report/BaseMoneyExport.jsp?sql='+sqlstr;
	}
</script>

</head>

<body>

	<div id=detailDiv class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" id="titleInfo" style="width: 600px">商户收益统计->查询条件</div>
		</div>
		<div class="left02downDiv">
		<form id="detail_custForm" action="ExecuteQuery.jsp"  method="post">
		<table border='0px' style='font-sizd: 1.2em' >
		<tr>
			<td align='right' width="8%">查询月份:</td>
			<td>
				<input  readonly="readonly" style='width: 100px' id="startTime" name="startTime" onclick="WdatePicker({dateFmt:'yyMM'});" class="Wdate" />
			</td>
			<td align="right" >商户名称:</td>
			<td><input id="marchant_name" name="marchant_name"> </td>
			<td align="right" >商户编号:</td>
			<td><input id="marchant_no" name="marchant_no"> </td>

			<%Permission per=new PositionPermessionImpl();
				if(per.hasPermission(session, Permission.LEADER_POSITION)){
			%>
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
			<%} %>		
		</tr>
		<tr>
				<td align="right" colspan="6" >
				<input  type="button" value="查 询" onclick="find(0)"  />&nbsp;
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
				<th class='dataTableHeader'>商户名称</th>
				<th class='dataTableHeader'>01</th>
				<th class='dataTableHeader'>02</th>
				<th class='dataTableHeader'>03</th>
				<th class='dataTableHeader'>04</th>
				<th class='dataTableHeader'>05</th>
				<th class='dataTableHeader'>06</th>
				<th class='dataTableHeader'>07</th>
				<th class='dataTableHeader'>08</th>
				<th class='dataTableHeader'>09</th>
				<th class='dataTableHeader'>10</th>
				<th class='dataTableHeader'>11</th>
				<th class='dataTableHeader'>12</th>
				<th class='dataTableHeader'>13</th>
				<th class='dataTableHeader'>14</th>
				<th class='dataTableHeader'>15</th>
				<th class='dataTableHeader'>16</th>
				<th class='dataTableHeader'>17</th>
				<th class='dataTableHeader'>18</th>
				<th class='dataTableHeader'>19</th>
				<th class='dataTableHeader'>20</th>
				<th class='dataTableHeader'>21</th>
				<th class='dataTableHeader'>22</th>
				<th class='dataTableHeader'>23</th>
				<th class='dataTableHeader'>24</th>
				<th class='dataTableHeader'>25</th>
				<th class='dataTableHeader'>26</th>
				<th class='dataTableHeader'>27</th>
				<th class='dataTableHeader'>28</th>
				<th class='dataTableHeader'>29</th>
				<th class='dataTableHeader'>30</th>
				<th class='dataTableHeader'>31</th>		
				<th class='dataTableHeader'>总计</th>		
			</tr>
			<tr id='merDayGain_Templet' >
				<td id='MARCHANT_NAME' style='word-break:break-all;white-space:nowrap'></td>
				<td id='A01'></td>
				<td id='A02'></td>
				<td id='A03'></td>
				<td id='A04'></td>
				<td id='A05'></td>
				<td id='A06'></td>
				<td id='A07'></td>
				<td id='A08'></td>
				<td id='A09'></td>
				<td id='A10'></td>
				<td id='A11'></td>
				<td id='A12'></td>
				<td id='A13'></td>
				<td id='A14'></td>
				<td id='A15'></td>
				<td id='A16'></td>
				<td id='A17'></td>
				<td id='A18'></td>
				<td id='A19'></td>
				<td id='A20'></td>
				<td id='A21'></td>
				<td id='A22'></td>
				<td id='A23'></td>
				<td id='A24'></td>
				<td id='A25'></td>
				<td id='A26'></td>
				<td id='A27'></td>
				<td id='A28'></td>
				<td id='A29'></td>
				<td id='A30'></td>
				<td id='A31'></td>
				<td id='TOTAL_GAIN'></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div>
		</form>
	</div>
</body>
</html>

