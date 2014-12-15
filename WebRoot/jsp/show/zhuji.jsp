<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>

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
<script src="../../js/Area.js" type="text/javascript"></script>
    <script src="../../js/AreaData_min.js" type="text/javascript"></script>
<script>
function showAreaID(city,street) {
    var areaID = street;
    var areaName = getAreaNamebyID(areaID) ;
    return "湖南省"+areaName;
}

//根据地区码查询地区名
function getAreaNamebyID(areaID) {
    var areaName = "";
    if (areaID.length == 2) {
        areaName = area_array[areaID];
    }
    else if (areaID.length == 4) {
        var index1 = areaID.substring(0, 2);
        areaName = area_array[index1] + " " + sub_array[index1][areaID];
    }
    else if (areaID.length == 6) {
        var index1 = areaID.substring(0, 2);
        var index2 = areaID.substring(0, 4);
        areaName = area_array[index1] + " " + sub_array[index1][index2] + " " + sub_arr[index2][areaID];
    }
    
    return areaName;
}
	$(document).ready(function()
{
	$('complainForm').resetForm();
	$("#complainForm").formly();
	$("#detailForm").formly();
	$("#complainDetailDiv").hide();
	$("#detailForm").formly();
	var address=${sessionScope.man.oper_address};
	if(address!="0000"){
		$("#area").val(address);
		$("#area").hide();
		$("#area").prev("label").html("只能导出本地区数据");
	}
	
});
function search(){
	find(0);
	find_zyh();
	//find_zyh(0);
	
}

	var object;
	var object_zyh;
	var cur_page = 0;
    var host_no="";

	function find(cur_page){
		var sqlstr="";
	    if ($('#host_no').val() != ''){
	    	sqlstr += " and upper(ter.serial1) = upper('"+$.trim($('#host_no').val())+"') ";
	    }    
	    host_no = $.trim($('#host_no').val());

	    //alert(sqlstr);
	    $('#complain_Templet').nextAll().remove();
		cur_page = cur_page || 0;
		var row = $('#complain_Templet').clone(true);
		$("#cur_page").val(cur_page+1);
		var page_size = $("#page_size").val();
		$.ajax({
			url:'../action/HostEngineQuery.jsp',
			dataType:'json',
			type:'POST',
			data:{'where':sqlstr,'cur_page':cur_page+1,'page_size':page_size},
			async:false,
			success: function(json){
				object = json.resultset;
		        $('#complain_Templet').nextAll().remove();
		        if (json.total==0){
		        	$('#complain_Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
					return;
		        }else{
					var i=0;
					for(i=(json.rows-1);i>=0;i--){
						var row = $('#complain_Templet').clone(true);
						row.attr('id', object[i].demo);
						for(var pro in object[i]) {
							if(pro=='UNIT_INSTALLED_STREET'){
								row.find('#'+pro+'').text(showAreaID(0,object[i]["UNIT_INSTALLED_STREET"]));
							}else
								row.find('#'+pro+'').text(object[i][pro]);
						}
						row.find('#opera').append("<input type=button onclick=gotoTimenal('"+object[i].teminal_info_id+"','"+object[i].commercial_id+"') value=查看详细 />&nbsp;&nbsp;&nbsp;<button type='button' value='清空主机序列号' onclick=clearTermid1("+object[i]["teminal_info_id"]+",'"+host_no+"')>清空主机序列号</button>");
						row.show();
						row.insertAfter('#complain_Templet');
					};
					$('#complain_Table').mygrid();
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
				}
	    	},  
		    error: function(XmlHttpRequest, textStatus, errorThrown){  
		        alert( "error");  
		    }
		 }); 
	}
	function gotoTimenal(t,c)
	{
		window.open ("../insert/terminalInsert.jsp?show=1&terminalId="+t+"&CommercialId="+c, "信息查看", 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
	}
function clearTermid1(id){
	if(null==id){
		alert("信息有误，请刷新页面！");
		return;
	}
	if(confirm("确认清空主机序列号?")){
		$.post("../action/ClearSerial.jsp",{id:id,'host_no':host_no},function(data){
			if(data==-1){
				alert("清空失败");
			}else if(data==-2){
				alert("权限不足");
			}else if(data==1){
				alert("操作成功！");
			}
		});
	}
}
function clearTermid1Zyh(id){
	if(null==id){
		alert("信息有误，请刷新页面！");
		return;
	}
	if(confirm("确认清空主机序列号?")){
		$.post("../action/ClearSerialZyh.jsp",{'id':id,'host_no':host_no},function(data){
			if(data==-1){
				alert("清空失败");
			}else if(data==-2){
				alert("权限不足");
			}else if(data==1){
				alert("操作成功！");
			}
		});
	}
}
	function find_zyh(cur_page){
		
		var sqlstr = "";
	    if ($('#host_no').val() != ''){
	    	sqlstr += " and upper(i.host_seq) = upper('"+$.trim($('#host_no').val())+"')";
	    }    
	    sqlstr += " and rownum<100";
	    //alert(sqlstr);
	    $('#complain_Templet1').nextAll().remove();
		cur_page = cur_page || 0;
		var row = $('#complain_Templet1').clone(true);
		$("#cur_page1").val(cur_page+1);
		var page_size = $("#page_size").val();
		$.ajax({
			url:'../action/HostEngineQueryZyh.jsp',
			dataType:'json',
			type:'POST',
			data:{'where':sqlstr},
			async:false,
			success: function(json_zyh){
				object_zyh = json_zyh.resultset;
		        $('#complain_Templet1').nextAll().remove();
		        if (json_zyh.total==0){
		        	$('#complain_Table1').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
					return;
		        }else{
					var i=0;
					for(i=(json_zyh.rows-1);i>=0;i--){
						var row = $('#complain_Templet1').clone(true);
						//row.attr('id', object[i].demo);
						for(var pro in object_zyh[0]) {
							if(pro=='UNIT_INSTALLED_STREET'){
								row.find('#'+pro+'').text(showAreaID(0,object_zyh[i]["UNIT_INSTALLED_STREET"]));
							}else
								row.find('#'+pro+'').text(object_zyh[i][pro]);
						}
						var id =object_zyh[i]["teminal_info_serv_id"];
						row.find('#operate_zyh').append("<input type=button onclick=clearTermid1Zyh('"+id+"') value='清空主机序列号'/>");
						row.show();
						row.insertAfter('#complain_Templet1');
					};
					$('#complain_Table1').mygrid();
					$('#cust_Pagination1').pagination(json_zyh.total, {
						current_page : cur_page,
						prev_text : '前一页',
						next_text : '后一页',
						callback : find_zyh
					});
					$('#cust_Searchresult1').text(
							'当前显示 ' + ((cur_page * $('#page_size').val()) + 1) + '-'
									+ ((cur_page * $('#page_size').val()) + json_zyh.rows) + ' 条记录,共 '
									+ json_zyh.total + ' 条记录');
				}
	    	},  
		    error: function(XmlHttpRequest, textStatus, errorThrown){  
		        alert( "error");  
		    }
		 }); 
	}
</script>
<title>主机序列号查询</title>
</head>

<body>

	<div id=detailDiv class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" id="titleInfo">报表导出</div>
		</div>
		<%Permission per=new PositionPermessionImpl(); %>
		<div class="left02downDiv">
		<form method="post" action="../action/report/HostEngineExport.jsp" >
			<%if(per.hasPermission(session, Permission.LEADER_POSITION)){ %>
		
				<label>请选择地区:</label> <select name="area" id="area">
				<option value="">全省</option>
				<option value="4302">株洲市</option>
				<option value="4303">湘潭市</option>
				<option value="4304">衡阳市</option>
				<option value="4305">邵阳市</option>
				<option value="4306">岳阳市</option>
				<option value="4307">常德市</option>
				<option value="4308">张家界市</option>
				<option value="4309">益阳市</option>
				<option value="4310">郴州市</option>
				<option value="4311">永州市</option>
				<option value="4301">长沙市</option>
				<option value="4312">怀化市</option>
				<option value="4325">娄底市</option>
				<option value="4326">湘西自治州</option>
			</select>
			
			
			<%} %>
			<input value="导出" type="submit">
		</form>
		<br>
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" id="titleInfo">查询</div>
		</div>
	<form id="complainForm" method="post">
		<table border='0px' style='font-sizd: 1.2em' >
		<tr>
			<td align='right' width="8%">主机序列号:</td>
			<td width="13%">
				<input   style='width: 100px' id="host_no" name="host_no" />
			</td>	
			<td align="right" ><input name="submit" type="button" value="查 询" onClick="search()"  />&nbsp;
			</td>
		</tr>
		</table>
			<input type="hidden" id="cur_page" name="cur_page" />
			<input type="hidden" id="type" name="type" value="4"/>
			<input type="hidden"  id="page_size" name="page_size" value="30"/>
		</form>
		</div>
	
	<div id="listDiv" class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c"><span id="titleName">自主收单主机序列号</span> </div>
		</div>
		<div class="left02downDiv">
		<table id='complain_Table' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>商户编号</th>
			<!-- 	<th class='dataTableHeader'>商户名称</th> -->
				<th class='dataTableHeader'>终端编号</th>
				<th class='dataTableHeader'>机具类型</th>
				<th class='dataTableHeader'>地市</th>
				<th class='dataTableHeader'>区镇</th>
				<th class='dataTableHeader'>终端状态</th>
				<th class='dataTableHeader'>查看详细</th>
			</tr>
			<tr id='complain_Templet' style="cursor:hand;">
					<td id='term_id1' ></td>
				<!--	<td id='merchant_name' ></td>-->
					<td id='term_id2' ></td>
					<td id='equi_type' ></td>
					<td id='UNIT_INSTALLED_STREET' ></td>
					<td id='Unit_Installed_Add' ></td>
					<td id='teminal_status' ></td>
					
					<td id='opera' ></td>
			</tr>	
		</table>

			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div>

		


	<div id="listDiv" class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c"><span id="titleName">专业化主机序列号</span> </div>
		</div>
		<div class="left02downDiv">
		<table id='complain_Table1' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>商户编号</th>
			 	<th class='dataTableHeader'>商户名称</th> 
				<th class='dataTableHeader'>终端编号</th>
				<th class='dataTableHeader'>机具类型</th>
				<th class='dataTableHeader'>地市</th>
				<th class='dataTableHeader'>区镇</th>
				<th class='dataTableHeader'>操作</th>

			</tr>
			<tr id='complain_Templet1' style="cursor:hand;">
					<td id='merchantsno' ></td>
					<td id='comm_name' style="width: 22%"></td>
					<td id='teminalno' ></td>
					<td id='teminal_product' ></td>
					<td id='s_city' ></td>
					<td id='s_county' ></td>
					<td id='operate_zyh' ></td>
			</tr>	
		</table>
			<div id='cust_Pagination1' class='pagination'></div>
			<div id='cust_Searchresult1'></div>
		</div>
</body>
</html>


