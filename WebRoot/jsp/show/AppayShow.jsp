<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../import.jsp"%>
<html>
<head>
<%
Permission per=new PositionPermessionImpl();
//if (!per.hasPermission(session,Permission.LEADER_POSITION)&&!per.hasPermission(session,Permission.OPERAT_POSITION))
//{
//	response.sendRedirect("../insert/error.jsp");
//	return;
//}
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
input,select{
width: 150px;
}

</style>
<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
<script src="../../js/jquery.pagination2.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
<script src="../../js/province_city_area_select.js" type="text/javascript"></script>
<script type="text/javascript">
/**
 * if(pro=="APPPAY_ID")
	{
		if(object[i]["APPTYPE"]=="收付宝")
		{
			row.find('#attach_Files').html("<a href='javascript:void(0)' onclick='showAttachFileWindow(102,"+object[i][pro]+")' >查看</a>");
		}	
		else if(object[i]["APPTYPE"]=="实名支付"){
			row.find('#attach_Files').html("<a href='javascript:void(0)' onclick='showAttachFileWindow(101,"+object[i][pro]+")' >查看</a>");	
		}else if(object[i]["APPTYPE"]=="便捷付"){
			row.find('#attach_Files').html("<a href='javascript:void(0)' onclick='showAttachFileWindow(103,"+object[i][pro]+")' >查看</a>");	
		}
	}
	else
 */
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
	function showAttachFileWindow(type,id){
		window.open ('../insert/quickyAdd.jsp?show=1&type='+type+'&id='+id, 'attachFileWindow', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
	}
	function find2(cur_page){
		$("#queryBtn").attr("disabled","disabled");
		var where=" 1=1 ";
		var typeQueryVal=$("#appayTypeQuery").val();
		if(typeQueryVal==0){
			alert("请选择业务类型！");
	    	$("#queryBtn").removeAttr("disabled");
			return;
		}
		//where=" and APPTYPE="+typeQueryVal;
		
	 	var APPR_STATUS=$("#APPR_STATUS").val();
	 	var INPUT_DATE=$("#INPUT_DATE").val();
	 	var INPUT_DATE2=$("#INPUT_DATE2").val();
	 	var UNIT_NAME=$("#UNIT_NAME").val();
	 	var UNIT_AREA=$("#UNIT_AREA").val();
	 	var fee_chan=$("#fee_chan").val();
	 	
	 	if(fee_chan>0&&typeQueryVal==105){
	 		where+=" and fee_chan="+fee_chan;
	 	}
	 	if(null!=APPR_STATUS&&APPR_STATUS>=0){
	 		where+=" and APPR_STATUS="+APPR_STATUS;
	 	}
	 	
	 	if(null!=INPUT_DATE&&INPUT_DATE.length>0){
	 		where+=" and to_char(INPUT_DATE,'yyyy-MM-dd HH24')>='"+INPUT_DATE+"' ";
	 	}
	 	if(null!=INPUT_DATE2&&INPUT_DATE2.length>0){
	 		where+=" and to_char(INPUT_DATE,'yyyy-MM-dd HH24')<'"+INPUT_DATE2+"' ";
	 	}
	 	if(null!=UNIT_NAME&&UNIT_NAME.length>0){
	 		where+=" and COMMERCIAL_ID in(select COMMERCIAL_ID from COMMERCIAL_INFO c where  UNIT_NAME like '%"+UNIT_NAME+"%')";
	 	}
	 	if(null!=UNIT_AREA&&UNIT_AREA.length>0){
	 		where+=" and COMMERCIAL_ID in(select COMMERCIAL_ID from COMMERCIAL_INFO c where  UNIT_AREA ='"+UNIT_AREA+"')";
	 	}
		
	    $('#merDayGain_Templet').nextAll().remove();
		cur_page = cur_page || 0;
		var row = $('#merDayGain_Templet').clone(true);
		$("#cur_page").val(cur_page+1);
		var page_size = $("#page_size").val();
		$.ajax({
			url:'../action/AppayCommonDataQuery.jsp',
			dataType:'json',
			type:'POST',
			data:{'cur_page':cur_page+1,'page_size':page_size,'allData':1,'where':where,'type':typeQueryVal},
			success: function(json){
				var object = json.resultset;
		        $('#merDayGain_Templet2').nextAll().remove();
		        if (json.total==0){
		        	$('#cust_Table2').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
		        }
		        var i=0;
		        for(i=(json.rows-1);i>=0;i--){
		        	var row = $('#merDayGain_Templet2').clone(true);
		        	for(var pro in object[i]) {
		        		 if(pro=='APPR_STATUS'){
		        			var vv="";
		        			switch(object[i]["APPR_STATUS"]){
		        			case 3:vv="新增终端待审批";break;
		        			case 0:vv="新商户入网待审批";break;
		        			case 1:vv="新商户入网未通过";break;
		        			case 2:vv="审批通过";break;
		        			case 4:vv="信息变更待审批";break;
		        			case 5:vv="新增终端未通过";break;
		        			case 6:vv="信息变更未通过";break;		        			
		        			}
		        			row.find('#'+pro+'').html(vv);
		        		} else if(pro=="more"){
		        			if(object[i]["APPTYPE"]=="收付宝"){
		        				row.find('#more_detial').html("<a href='javascript:void(0);' onclick=showAppay("+object[i]["APPPAY_ID"]+",102,"+object[i]["COMMERCIAL_ID"]+")>详细</a>");
		        			}else if(object[i]["APPTYPE"]=="实名支付")
		        				row.find('#more_detial').html("<a href='javascript:void(0);' onclick=showAppay("+object[i]["APPPAY_ID"]+",101,"+object[i]["COMMERCIAL_ID"]+")>详细</a>");
		        			else if(object[i]["APPTYPE"]=="便捷付")
	        				row.find('#more_detial').html("<a href='javascript:void(0);' onclick=showAppay("+object[i]["APPPAY_ID"]+",103,"+object[i]["COMMERCIAL_ID"]+")>详细</a>");
		        			else if(object[i]["APPTYPE"]=="收单")
	        				row.find('#more_detial').html("<a href='javascript:void(0);' onclick=showAppay("+object[i]["APPPAY_ID"]+",105,"+object[i]["COMMERCIAL_ID"]+")>详细</a>");
		        			else if(object[i]["APPTYPE"]=="自助终端")
	        				row.find('#more_detial').html("<a href='javascript:void(0);' onclick=showAppay("+object[i]["APPPAY_ID"]+",106,"+object[i]["COMMERCIAL_ID"]+")>详细</a>");
		        		}else if(pro=="UNIT_AREA")
		        			row.find('#UNIT_AREA2').html(getAreaNameByCode(object[i][pro]));
		        		else if(pro=="fee_chan")
		        			row.find('#fee_chan2').html(getFeeChan(object[i]["fee_chan"]));
		        		else row.find('#'+pro+'').html(object[i][pro]);
		        		 
		        	}
			        row.show();
			        row.insertAfter('#merDayGain_Templet2');
		        };
		        $('#cust_Table2').mygrid();
		    	$('#cust_Pagination2').pagination(json.total, {
		    		current_page : cur_page,
		    		prev_text : '前一页',
		    		next_text : '后一页',
		    		callback : find2
		    	});
		    	$('#cust_Searchresult2').text(
		    			'当前显示 ' + ((cur_page * 20) + 1) + '-'
		    					+ ((cur_page * 20) + json.rows) + ' 条记录,共 '
		    					+ json.total + ' 条记录');
		    	$("#queryBtn").removeAttr("disabled");
	    	},  
		    error: function(XmlHttpRequest, textStatus, errorThrown){  
		    	$("#showMsg").html("查询异常！");
		    	$("#queryBtn").removeAttr("disabled");
		    }
		 }); 
	}
	function getFeeChan(chan){
		if(null==chan){
			return "--";
		}
		switch(chan){
		case 1:return "自主直联";break;
		case 2:return "自主间联" ;break;
		case 3:return "百日竞赛(自主间联)"; break;
		case 4:return "电子渠道"; break;
		case 5: return "策略营销(自主间联)";break;
		default:return "--";
		}
	}
	//查看终端
	function showAppay(id,type,comId){
		if(type==101)
	    	window.open ("../insert/bussinessInsert.jsp?show=1&appayId="+id+"&CommercialId="+comId, "业务信息查看", 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
		else if(type==102)
		  window.open ("../insert/bussinessInsert102.jsp?show=1&appayId="+id+"&CommercialId="+comId, "业务信息查看", 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
		else if(type==103)
		  window.open ("../insert/bussinessInsert103.jsp?show=1&appayId="+id+"&CommercialId="+comId, "业务信息查看", 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
		else if(type==105)
		  window.open ("../insert/bussinessInsert105.jsp?show=1&appayId="+id+"&CommercialId="+comId, "业务信息查看", 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
		else if(type==106)
		  window.open ("../insert/bussinessInsert106.jsp?show=1&appayId="+id+"&CommercialId="+comId, "业务信息查看", 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
	}
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
		</div>
	</div>
	<div class="left02downDiv">
			<form  method="post" target="iframe1" action="#" onSubmit="return Validator.Validate(this,2)">
				<td align='right'>商户名称:</td>
				<td>
					<input id="UNIT_NAME"/>
				</td>
			
				<td align='right'>录入时间:</td>
				<td>
					从<input readonly="readonly" id="INPUT_DATE" onclick="new WdatePicker({dateFmt:'yyyy-MM-dd HH'})"/>
					至<input readonly="readonly" id="INPUT_DATE2" onclick="new WdatePicker({dateFmt:'yyyy-MM-dd HH'})"/>
				</td>
				<br>
				<td align='right'>	
					<font color="red">业务类型*</font>
				</td>
				<td>
				<select id="appayTypeQuery">
						<option value="101">实名支付</option>
						<option value="102">收付宝</option>
						<option value="103">便捷付</option>
						<option value="106">自助终端</option>
						<option value="105" selected="selected">收单</option>
				</select>
				</td>
				<td align='right'>业务状态：</td>
				<td>
					<select id="APPR_STATUS">
						<option value="-1">---请选择---</option>
						<option value="3">新增终端待审批</option>
						<option value="0">新商户入网待审批</option>
						<option value="4">信息变更待审批</option>
						<option value="1">新商户入网未通过</option>
						<option value="2">审批通过</option>
						<option value="5">新增终端未通过</option>
						<option value="6">信息变更未通过</option>
					</select>
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
				<td align='right'>交易渠道:</td>
				<td>
					<select name='fee_chan' id="fee_chan" style='width: 120px'  label='请输入交易渠道' />
						<option value="0" >--请选择--</option>
						<option value="1" >自主直联</option>
						<option value="2">自主间联</option>
						<option value="3">百日竞赛(自主间联)</option>
						<option value="4">电子渠道</option>
						<option value="5">策略营销(自主间联)</option>
						<option value="6">本地渠道</option>
					</select>
				</td>
				<input  type="button" name="total" id="queryBtn" value="开始查询" onclick="find2()"/>
				<font color=red id="showMsg"></font>
			</form>
		</div>
	<input id="cur_page" value="0" type="hidden">
	<div class="left02downDiv">
	<form id="queryForm">
		<table id='cust_Table2' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>客户名称</th>
				<th class='dataTableHeader'>客户所在地区</th>
				<th class='dataTableHeader'>业务类型</th>
				<th class='dataTableHeader'>业务状态</th>
				<th class='dataTableHeader'>交易渠道</th>
				<th class='dataTableHeader'>录入时间</th>
				<th class='dataTableHeader'>更新时间</th>
				<th class='dataTableHeader'>详情</th>
			</tr>
			<tr id='merDayGain_Templet2'>
				<td id="commercialName" style="width:22%"></td>
				<td id="UNIT_AREA2"></td>
				<td id="APPTYPE"></td>
				<td id="APPR_STATUS"></td>
				<td id="fee_chan2"></td>
				<td id="INPUT_DATE"></td>
				<td id="CHANGE_DATE"></td>
				<td id="more_detial"></td>
			</tr>	
		</table>
			<div id='cust_Pagination2' class='pagination'></div>
			<div id='cust_Searchresult2'></div>
	</form>
	</div>
</body>
</html>		
