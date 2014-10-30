<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../import.jsp"%>
<html>
<head>
<%
String info=request.getParameter("info");
	if(null!=info&&"del0".equals(info)){
		out.println("<script type=\"text/javascript\">alert('删除失败')</script>");
	}
	if(null!=info&&"del1".equals(info)){
		out.println("<script type=\"text/javascript\">alert('删除成功')</script>");
	}
%>
<title>用户信息录入</title>
<meta http-equiv="content-script-type" content="text/javascript">
<meta http-equiv="content-style-type" content="text/css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../../css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../../css/pagination.css" media="screen" />
<link rel="stylesheet" href="../../css/dataTable.css" media="screen" />
<link rel="stylesheet" href="../../css/allinpay.css" />

<style type="text/css">
.mycss {
	width: 100%;
	height: auto;
	border: 1px solid #b4b4b4;
	border-top: 0;
	background: #fff;
}
</style>
<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
<script src="../../js/jquery.pagination2.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
<script src="../../js/province_city_area_select.js" type="text/javascript"></script>
<script src="../../js/Area.js" type="text/javascript"></script>
    <script src="../../js/AreaData_min.js" type="text/javascript"></script>
<script type="text/javascript">

function showAreaID(city,street) {
    var areaID = street;
   try{
	   var areaName = getAreaNamebyID(areaID) ;
	   return "湖南省"+areaName;
   
   }catch(e){}
    return "湖南省";
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

/**
 * 根据地区编码获取地区中文名称
 */
function getAreaNameByCode(code) {
	switch (code) {
	case '4301':return "长沙市";
	case '4302':return "株洲市";
	case '4303':return "湘潭市";
	case '4304':return "衡阳市";
	case '4305':return "邵阳市";
	case '4306':return "岳阳市";
	case '4307':return "常德市";
	case '4308':return "张家界市";
	case '4309':return "益阳市";
	case '4310':return "郴州市";
	case '4311':return "永州市";
	case '4312':return "怀化市";
	case '4325':return "娄底市";
	case '4326':return "湘西自治州";
	default:return "---";
	}
}
	function testDelete(obj,id){
		if(confirm("确认删除？")){
			obj.href="../action/CommercialDataDelete.jsp?delId="+id;
			obj.click();
		}
	}
	var cur_page = 0;
	function find(cur_page){
		$("#queryBtn").attr("disabled","disabled");
		$("#showMsg").html("正在查询。。。");
		var where=" 1=1 ";
		if($("#terminalStatusQuery").val()!=""){
			if($("#terminalStatusQuery").val()==103){
				where+=" and INSTALLED_STATUS=5 and TEMINAL_STATUS=13 "
			}else if($("#terminalStatusQuery").val()==101){//装机中
				where+=" and TEMINAL_STATUS=5 ";
			}else if($("#terminalStatusQuery").val()==102){//已装机
				where+=" and INSTALLED_STATUS=4 and TEMINAL_STATUS=13 ";
			}else if($("#terminalStatusQuery").val()==104){//取消装机
				where+=" and TEMINAL_STATUS=13 and INSTALLED_STATUS=0  ";
			}else if($("#terminalStatusQuery").val()==105){//延迟装机
				where+=" and INSTALLED_STATUS=2 and TEMINAL_STATUS=5 ";
			}else
			 where+=" and TEMINAL_STATUS="+$("#terminalStatusQuery").val();
		}
		where+=" and TEMINAL_STATUS!=15 ";
		var APPROVAL_DATE=$("#APPROVAL_DATE").val();
		var UNIT_NAME=$("#UNIT_NAME").val();
		var TERM_ID1=$("#TERM_ID1").val();
		var TERM_ID2=$("#TERM_ID2").val();
		var UNIT_AREA=$("#UNIT_AREA").val();
		
		if(APPROVAL_DATE!=null&&APPROVAL_DATE.length>0){
			where+=" and APPROVAL_DATE=to_date('"+APPROVAL_DATE+"','yyyy-MM-dd')";
		}
		
		if(UNIT_NAME!=null&&UNIT_NAME.length>0){
			where+=" and COMMERCIAL_ID in(select c.COMMERCIAL_ID from COMMERCIAL_INFO c where c.COMMERCIAL_ID=COMMERCIAL_ID and UNIT_NAME like '%"+UNIT_NAME+"%')";
		}
		
		if(TERM_ID1!=null&&TERM_ID1.length>0){
			where+=" and TEMINAL_INFO_ID in(select TEMINAL_INFO_ID from TERM_APP_TABLE t where t.TEMINAL_INFO_ID=TEMINAL_INFO_ID and t.TERM_ID1 like '%"+TERM_ID1+"%')";
		}
		if(TERM_ID2!=null&&TERM_ID2.length>0){
			where+=" and TEMINAL_INFO_ID in(select TEMINAL_INFO_ID from TERM_APP_TABLE t where t.TEMINAL_INFO_ID=TEMINAL_INFO_ID and t.TERM_ID2 like '%"+TERM_ID2+"%')";
		}
		if(UNIT_AREA!=null&&UNIT_AREA.length>0){
			where+=" and UNIT_INSTALLED_CITY='"+UNIT_AREA+"'";
		}	    
		$('#merDayGain_Templet').nextAll().remove();
		cur_page = cur_page || 0;
		var row = $('#merDayGain_Templet').clone(true);
		$("#cur_page").val(cur_page+1);
		var page_size = $("#page_size").val();
		$.ajax({
			url:'../action/TerminalDataAllQuery.jsp',
			dataType:'json',
			type:'POST',
			data:{'where':where,'cur_page':cur_page+1,'page_size':page_size},
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
		        		if(pro=="UNIT_INSTALLED_STREET"){
		        			row.find('#'+pro+'').html(showAreaID(0,object[i]["UNIT_INSTALLED_STREET"]));
		        		}else if(pro=="TEMINAL_STATUS"){
		        			var st="";
		        			switch(object[i][pro]){
		        			case 0:
		        			case 1:st="待审批";break;
		        			case 2:st="待审批";break;
		        			case 3:st="待调试";break;
		        			case 4:st="待分配";break;
		        			case 5:st="待归档";break;
		        			case 13:st="已归档";break;
		        			case 6:st="已撤机";break;
		        			}
		        			row.find('#'+pro+'').html(st);
		        		}else if(pro=='ACCOUNT_CITY'){
		        			 row.find('#ACCOUNT_CITY').html(getAreaNameByCode(object[i]["ACCOUNT_CITY"]));
		        		}else{
		        				row.find('#'+pro+'').html(object[i][pro]);
		        			}
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
		    	$("#queryBtn").removeAttr("disabled");
				$("#showMsg").html("查询完毕！");
	    	},  
		    error: function(XmlHttpRequest, textStatus, errorThrown){  
		    	$("#queryBtn").removeAttr("disabled");
				$("#showMsg").html("查询异常！");  
		    }
		 }); 
	}
	$(function(){
		//find();
	});
	function showWindow(url){
		window.open ("../insert/terminalInsert.jsp?show=1&terminalId="+url, "信息查看", 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 

	}
</script>
<script language="javascript" type="text/javascript" src="../../js/WdatePicker.js"></script>  
</head>

<body >
		<!-- 终端列表信息 -->
	<div class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c"><span id="titleName">终端信息 </span> </div>
		</div>
	</div>
	<div class="left02downDiv">
			<form  method="post" target="iframe1" action="#" onSubmit="return Validator.Validate(this,2)">
				<td align='right'>	
					终端状态：
				</td>
				<td>
				<%Permission per=new PositionPermessionImpl(); %>
					<select id="terminalStatusQuery" style="width: 100px">
						<% if(per.hasPermission(session, Permission.FILE_POSITION)){%>
							<option value="">全部</option>
							<option value="3">待调试</option>
							<option value="103">取消调试</option>
							<option value="102">已装机</option>
							<option value="5">装机中</option>
							<option value="102">已装机</option>
							<option value="13">已归档</option>
							<option value="6">已撤机</option>
							<option value="104">取消装机</option>
							<option value="105">延迟装机</option>
							<option value="4">待分配</option>
						<%} else {
							if(per.hasPermission(session, Permission.DEBUG_POSITION)){ %>
							<option value="3">待调试</option>
							<option value="103">取消调试</option>
						<%} %>
						
						<%if(per.hasPermission(session, Permission.SAFE_POSITION)) {%>
							<option value="102">已装机</option>
							<option value="6">已撤机</option>
						<%} %>
						<%if(per.hasPermission(session, Permission.INSTALL_POSITION)) {%>
							<option value="102">已装机</option>
							<option value="5">装机中</option>
						<%} %>
						<%if(per.hasPermission(session, Permission.FILE_POSITION)) {%>
							<option value="5">装机中</option>
							<option value="102">已装机</option>
							<option value="13">已归档</option>
							<option value="6">已撤机</option>
							<option value="104">取消装机</option>
							<option value="105">延迟装机</option>
						<%} %>
						<% }%>
					</select>
				</td>
				<td align='right'>	
					审批日期：
				</td>
				<td>
					<input id="APPROVAL_DATE" readonly="readonly" onclick="new WdatePicker()"/>
				</td>
				<td align='right'>	
					商户名称：
				</td>
				<td>
					<input id="UNIT_NAME"/>
				</td>
				<td align='right'>	
					商户编号：
				</td>
				<td>
					<input id="TERM_ID1"/>
				</td>
				<td align='right'>	
					终端编号:
				</td>
				<td>
					<input id="TERM_ID2"/>
				</td>
				
				
			<c:if test="${sessionScope.man.oper_address=='0000'}">
					<br>
				</td>
					<td align='right'>客户所在地区：</td>
				<td>
					<select style="width:100px" name="UNIT_AREA"  id="UNIT_AREA">
						<option value="">---请选择----</option>
						<option value="4301">长沙市</option>
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
				</td>
			</c:if>
				
				
				
				
				<div style="float: right">
					<input type="button" name="total" value="开始查询" id="queryBtn" onclick="find()"/>
				<font color="red" id="showMsg"></font>
				</div>
			</form>
		</div>
	
	<div class="left02downDiv">
	<form id="queryForm">
	<table id='cust_Table' class='dataTable1' width="100%">
		<tr>
			<th class='dataTableHeader'>终端状态</th>
			<th class='dataTableHeader'>客户名称</th>
			<th class='dataTableHeader'>装机街道</th>
			<th class='dataTableHeader'>客户装机地址</th>
			<th class='dataTableHeader'>录入时间</th>
			<th class='dataTableHeader'>归档时间</th>
			<th class='dataTableHeader'>客户录入人员</th>
			<th class='dataTableHeader'>详细</th>
		</tr>
		<!-- 数据显示区 -->
		<tr id='merDayGain_Templet'>
			<td id="TEMINAL_STATUS"></td>
			<td id="UNIT_NAME" style="width:22%"></td>
			<td id="UNIT_INSTALLED_STREET" style="width:22%"></td>
			<td id="UNIT_INSTALLED_ADD" style="width:22%"></td>
			<td id="INPUT_DATE"></td>
			<td id="ARCHIVE_DATE"></td>
			<td id="INPUT_USER"></td>
			<td id="MORE"></td>
		</tr>	
	</table>
		<div id='cust_Pagination' class='pagination'></div>
		<div id='cust_Searchresult'></div>
	</form>
	</div>
</body>
</html>		
