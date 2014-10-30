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
<script src="../../js/jquery.pagination1.js" type="text/javascript"></script>
<script src="../../js/WdatePicker.js" type="text/javascript"></script>
<script>
$(document).ready(function()
{
	$('form').resetForm();
	$("#detail_custForm").formly();
	//find(0);
	var leader=${sessionScope.man.oper_address};
	if(leader!='0000'){
		$("#unit_area").hide();
		$("#unit_area").parent().prev("td").hide();
		$("#unit_area").val(leader);
	}
});

/**
 * return true时间选择，false 时间未选择
 */
function timeSelected(){
	   return ($('#startTime').val() != '')&&($('#endTime').val() != '');
}
function find(cur_page){
	if(!timeSelected()){
		alert("请选择日期！");
		return;
	}
    $('#terminalDayGain_Templet').nextAll().remove();
	cur_page = cur_page || 0;
	var row = $('#terminalDayGain_Templet').clone(true);
	$("#cur_page").val(cur_page+1);
	$("#detail_custForm").ajaxSubmit({
		dataType:'json',
		success: function(json){
			var object = json.resultset;
	        $('#terminalDayGain_Templet').nextAll().remove();
	        if (json.total==0){
	        	$('#cust_Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
	        }
	        var i=0;
	        for(i=(json.rows-1);i>=0;i--){
	        	var row = $('#terminalDayGain_Templet').clone(true);
	        	//row.attr('id', object[i].merchantsNo);
	        	for(var pro in object[0]) {
	        		if(pro=='teminal_product'){
	        			var v=object[i][pro];
	        			if(v==0){
	        				v="通联产权";
	        			}else if(v==1){
	        				v="银行产权";
	        			}else if(v==0){
	        				v="代理商产权";
	        			}
	        			row.find('#'+pro+'').text(v);
	        		}
	        		else
	        			row.find('#'+pro+'').text(object[i][pro]);
	        	}
		        row.show();
		        row.insertAfter('#terminalDayGain_Templet');
	        };
	        $('#cust_Table').mygrid();
	       // document.getElementById('titleName').innerHTML = '终端交易日报表';
	 	   //	document.getElementById('startTime').value = json.startTime;
	    	//document.getElementById('endTime').value = json.endTime;
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
			var startTime = document.getElementById('startTime').value;
			var endTime = document.getElementById('endTime').value;
			var tranType = document.getElementById('tranType').value;
			var unit_area = document.getElementById('unit_area').value;
			var commercialName = document.getElementById('commercialName').value;
			var commercialNo = document.getElementById('commercialNo').value;
			var terminalNo = document.getElementById('terminalNo').value;
			var other="&commercialName="+commercialName+"&commercialNo="+commercialNo+"&terminalNo="+terminalNo;
			
			if(unit_area != null && unit_area != '')
			{
				//sql += " and merch.UNIT_AREA='"+unit_area+"'";
			}
			else
			{
				alert('只能按地区导出，请先按地区查询');
				document.getElementById('unit_area').focus();
				return;
			}
		   	location.href='../action/report/terminalDayLogExport.jsp?startTime='+startTime+"&endTime="+endTime+'&tranType='+tranType+"&unit_area="+unit_area+other;
	}	
</script>

</head>

<body>

	<div id=detailDiv class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" id="titleInfo" style="width: 600px">终端日报表->查询条件</div>
		</div>
		<div class="left02downDiv">
		<form id="detail_custForm" action="../action/terminalDayLogSearch.jsp"  method="post">
		<table border='0px' style='font-sizd: 1.2em' >
		<tr>
			<td align="right" >商户名称:</td>
			<td><input id="commercialName" name="commercialName"> </td>
			<td align="right" >商户编号:</td>
			<td><input id="commercialNo" name="commercialNo"> </td>
			<td align="right" >终端编号:</td>
			<td><input id="terminalNo" name="terminalNo"> </td>
		</tr>
		<tr>
			<td align='right' width="8%">查询时间段:</td>
			<td width="30%">
				<input  readonly="readonly" style='width: 100px' id="startTime" name="startTime" onclick="WdatePicker({dateFmt:'yyMMdd'});" class="Wdate" />
				至
				<input  readonly="readonly" style='width: 100px' id="endTime" name="endTime" onclick="WdatePicker({dateFmt:'yyMMdd'});" class="Wdate" />
			</td>
	
			<td align='right' width="8%">交易类型:</td>
			<td width="13%">
				<select id="tranType" style='width: 100px' name="tranType">
					<option value="0" selected="selected">无交易</option>
					<option value="1">有交易</option>
				</select>
			</td>	
			<td align='right' width="10%" >客户所在地区:</td>
			<td width="13%"><select name='unit_area' style='width: 100px' id="unit_area"/>
				<option value="" >请选择</option>
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
			<td align="right" colspan="8" ><input name="submit" type="button" value="查 询" onclick="find(0)"  />&nbsp;
				<%Permission per=new PositionPermessionImpl();
				if(per.hasPermission(session, Permission.REPORT_EXPORT))
				{
				%>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="goback" type="button" value="导出excel" onclick="exportReport()" />
				<%} %>
			</td>
		</tr>
		</table>
			<input type="hidden" id="cur_page" name="cur_page" />
			<input type="hidden"  id="page_size" name="page_size" value="30"/>
		</form>
		</div>
	
	<div id="listDiv" class="left02">
		<div class="left02downDiv">
		<form id="queryForm">
		<table id='cust_Table' class='dataTable1' width="3600px">
			<tr>
				 <th class='dataTableHeader'>交易日期</th>
				 <th class='dataTableHeader'>所属地市</th>
				 <th class='dataTableHeader'>客户名称</th>
				 <th class='dataTableHeader'>工商注册名称</th>
				 <th class='dataTableHeader'>商户编号</th>
				 <th class='dataTableHeader'>终端编码</th>
				 <th class='dataTableHeader'>机具产权</th>
				<th class='dataTableHeader'>装机地址</th>
				<th class='dataTableHeader'>联系人</th>
				<th class='dataTableHeader'>联系人电话</th>
				<th class='dataTableHeader'>归档时间</th>
				
				<th class='dataTableHeader'>调试人员</th>
				<th class='dataTableHeader'>装机人员</th>
				
				<th class='dataTableHeader'>本月总交易笔数</th>
				<th class='dataTableHeader'>本月总交易金额</th>
				<th class='dataTableHeader'>本月总刷卡手续费</th>
				<th class='dataTableHeader'>本月总收单收益</th>
				
				<th class='dataTableHeader'>本年累计交易笔数</th>
				<th class='dataTableHeader'>本年累计交易金额</th>
				<th class='dataTableHeader'>本年累计刷卡手续费</th>
				<th class='dataTableHeader'>本年累计总收单收益</th>
			</tr>
			<tr id='terminalDayGain_Templet' >
				<td id='total_date'></td>
				<td id='unit_area' ></td>
				<td id='trade_name' style="width:9%" ></td>
				<td id='comm_name' ></td>
				<td id='term_id1' ></td>
				
				<td id='term_id2' ></td>
				<td id="teminal_product"></td>
				<td id="unit_installed_add"></td>
				<td id="unit_installed_man"></td>
				<td id="unit_installed_tel"></td>
				
				<td id='archive_date' ></td>
				<td id="debug_man"></td>
				<td id="inst_man"></td>
				
				<td id="fee_count"></td>
				<td id="fee_amount"></td>
				<td id="fee"></td>
				<td id="gain"></td>
				
				<td id="sumcount"></td>
				<td id="sumamt"></td>
				<td id="sumfee"></td>
				<td id="sumgain"></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div>
		</form>
	</div>
</body>
</html>

