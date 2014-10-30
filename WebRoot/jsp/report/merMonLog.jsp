<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.dao.Operman_infoDao"%>
<%@page import="com.szzt.model.KeyValueModel"%>
<%@page import="com.szzt.dao.DaoUtils"%>
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
<style type="text/css">
	
</style>


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
	var leader=${sessionScope.man.oper_address};
	if(leader!='0000'){
		$("#unit_area").hide();
		$("#unit_area").parent().prev("td").hide();
		$("#unit_area").val(leader);
	}
});


function find(cur_page){
	if(!timeSelected()){
		alert("请选择日期！");
		return;
	}
    $('#merMonGain_Templet').nextAll().remove();
	cur_page = cur_page || 0;
	var row = $('#merMonGain_Templet').clone(true);
	$("#cur_page").val(cur_page+1);
	$("#detail_custForm").ajaxSubmit({
		dataType:'json',
		success: function(json){
			var object = json.resultset;
	        $('#merMonGain_Templet').nextAll().remove();
	        if (json.total==0){
	        	$('#cust_Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
	        }
	        var i=0;
	        for(i=(json.rows-1);i>=0;i--){
	        	var row = $('#merMonGain_Templet').clone(true);
	        	for(var pro in object[0]) {
	        		row.find('#'+pro+'').text(object[i][pro]);
	        	}
		        row.show();
		        row.insertAfter('#merMonGain_Templet');
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
	   return ($('#merMonLog').val() != '');
}
function exportReport()
{
	if(!timeSelected()){
		alert("请选择日期！");
		return;
	}
	var cust_Table = document.getElementById('cust_Table');
	if(cust_Table.rows.length <= 0)
	{
	    alert('没有要导出的数据！');
	}
	else
	{
		$("#detail_custForm").ajaxSubmit({
			dataType:'json',
			url:"../action/report/exportMerchMon.jsp",
			success:function(json){
				$("body").html("");
				$("body").append("<div class='export'>"+json.result+"</div>");
			},error:function(json){
				alert(json.responseText);
			}
		});
		return;
	}
}
</script>

</head>

<body>

	<div id=detailDiv class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" style="width: 600px" id="titleInfo">商户月报表->查询条件</div>
		</div>
		<div class="left02downDiv">
		
	<form id="detail_custForm" action="../action/merMonLogSearch.jsp"  method="post" style="font: 15px" >
		<table border='0px' style='font:15px;font-size: 15px' >
		<tr>
			<td align='right' width="12%">查询年月:</td>
			<td width="13%">
				<input  readonly="readonly" style='width: 120px' id="total_date" name="total_date" onclick="WdatePicker({dateFmt:'yyMM'});" class="Wdate" />
			</td>
			<td align='right' width="12%">录入时间:</td>
			<td width="25%">
			<input type="text" name="date1" style='width: 120px' class="Wdate" id="date1"  dataType='Require' msg='请输入统计起始日期'  onClick="WdatePicker()"/>
			至
			<input type="text" name="date2" style='width: 120px' class="Wdate" id="date2"  dataType='Require' msg='请输入统计截至日期'  onClick="WdatePicker()"/>
			</td>
			</tr>
		<tr>
			<td align='right' width="12%">商户编号:</td>
			<td width="13%">
			<input type="text" name="merchantsno"  id="merchantsno"  dataType='Require' msg='请输入商户编号' maxsize="15"/>
			</td>
			<td align='right' width="12%">商户名称:</td>
			<td width="13%">
			<input type="text" name="merchant_name"  id="merchant_name"  dataType='Require' msg='请输入商户名称' />
			</td>
			<td align='right' width="12%">客户所在地区:</td>
			<td width="13%"><select id="unit_area" name='unit_area' style='width: 120px' label='请输入客户所在地区'/>
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
			<td align='right' width="12%">服务等级:</td>
			<td width="13%">
				<select id="serv_lev" style='width: 120px' name="serv_lev">
					<option value="">所有</option>
					<option value="1">F</option>
					<option value="2">E</option>
					<option value="3">D</option>
					<option value="4">C</option>
					<option value="5">B</option>
					<option value="6">A</option>
				</select>
			</td>	
			<td align='right' width="12%">开户银行:</td>
			<td width="13%"><select id="account_bank" name='account_bank' style='width: 120px' label='请输入开户银行'/>
				<option value="" >请选择</option>
				<%
				DaoUtils utils=new DaoUtils();
				List<KeyValueModel> banks=utils.bankInfo();
				for(KeyValueModel model:banks){
					out.println("<option value='"+model.getKey()+"' >"+model.getValue()+"</option>");
				}
				%>
					</select>
			</td>			
				<td align='right'>拓展人员:</td>
			<td>
				<select name='sales_man' style='width: 120px'  label='请输入拓展人员' />
				<option value="" >请选择</option>
					<%
					List<KeyValueModel> expands=utils.operateUser(Permission.EXPAND_POSITION);
					for(KeyValueModel model:expands){
						out.println("<option value='"+model.getKey()+"'>"+model.getValue()+"</option>");
					}
					%>
				</select>
			</td>		
			
			
			</tr>
		<tr>
		<td align="right" colspan="6" ><input name="submit" type="button" value="查 询" onclick="find(0)"  />&nbsp;
				<%Permission per=new PositionPermessionImpl();
				if(per.hasPermission(session, Permission.REPORT_EXPORT)){%>
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
		<table id='cust_Table' class='dataTable1' width="2800px">
			<tr>
				 <th class='dataTableHeader'>所属地市</th>
				 <th class='dataTableHeader'>合作渠道</th>
				 <th class='dataTableHeader'>商户编号</th>
				 <th class='dataTableHeader'>工商注册名称</th>
				 <th class='dataTableHeader'>商户MCC</th>
				  <th class='dataTableHeader'>服务等级</th>
				 <th class='dataTableHeader'>POS总数</th>
				<th class='dataTableHeader'>本月总交易笔数	</th>
				<th class='dataTableHeader'>本月总交易金额	</th>
				<th class='dataTableHeader'>本月总刷卡手续费	</th>
				<th class='dataTableHeader'>本月总收单收益	</th>
				<th class='dataTableHeader'>本月通联总收益	</th>
				
				<th class='dataTableHeader'>本年累计总交易笔数	</th>
				<th class='dataTableHeader'>本年累计总交易金额</th>
				<th class='dataTableHeader'>本年累计总刷卡手续费</th>
				<th class='dataTableHeader'>本年累计总收单收益</th>
				<th class='dataTableHeader'>本年累计通联总收益</th>
			</tr>
			<tr id='merMonGain_Templet' >
				<td id='unit_addr' ></td>
				<td id='channel_name' ></td>
				<td id='term_id1' ></td>
				<td id='trade_name' ></td>
				<td id='mcc' ></td>
				<td id='serv_lev' ></td>
				
				<td id="pos_count"></td>
				<td id="fee_count"></td>
				<td id="fee_amount"></td>
				<td id="fee"></td>
				<td id="gain"></td>
				<td id="total_gain"></td>
				
				<td id="sumcount"></td>
				<td id="sumamt"></td>
				<td id="sumfee"></td>
				<td id="sumgain"></td>
				<td id="sumtotalgain"></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div>
		</form>
	</div>
</body>
</html>

