<%@page import="com.szzt.dao.DaoUtils"%>
<%@page import="com.szzt.dao.Terminal_InfoDao"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="../../import.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<%
	String info = request.getParameter("info");
	if (null != info && info.equals("update0"))
	{
		out.println("<script type=\"text/javascript\">alert('操作失败')</script>");
	}
	if (null != info && info.equals("o0"))
	{
		out.println("<script type=\"text/javascript\">alert('操作失败')</script>");
	}
	if (null != info && info.equals("o1"))
	{
		out.println("<script type=\"text/javascript\">alert('操作成功')</script>");
	}
	if (null != info && info.equals("1"))
	{
		out.println("<script type=\"text/javascript\">alert('添加成功')</script>");
	}
	if (null != info && info.equals("11"))
	{
		out.println("<script type=\"text/javascript\">alert('修改成功')</script>");
	}
	if (null != info && info.equals("10"))
	{
		out.println("<script type=\"text/javascript\">alert('修改失败')</script>");
	}
	if (null != info && info.equals("20"))
	{
		out.println("<script type=\"text/javascript\">alert('请选择业务！')</script>");
	}
	if (null != info && info.equals("-1"))
	{
		out.println("<script type=\"text/javascript\">alert('添加失败')</script>");
	}
	if (null != info && info.equals("101"))
	{
		out.println("<script type=\"text/javascript\">alert('请先录入终端信息！')</script>");
	}
	if (null != info && info.equals("e1"))
	{
		out.println("<script type=\"text/javascript\">alert('调试失败，主机序列号重复！')</script>");
	}
	if (null != info && info.equals("e2"))
	{
		out.println("<script type=\"text/javascript\">alert('调试失败，主机序列号不在仓库中！')</script>");
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
<link rel="stylesheet" href="../../css/tab.css" media="screen" />
<link rel="stylesheet" href="../../css/allinpay.css" media="screen" />



<link rel="stylesheet" type="text/css" href="../../css/easy_tab.css" />
<script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
<script src="../../js/Area.js" type="text/javascript"></script>
<script src="../../js/AreaData_min.js" type="text/javascript"></script>
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
  	font{
  	color:red;
  	}
  select{
  width:100px;
  height:30px;
  margin-top: 10px;
  margin-bottom: 10px;
  }
  </style>
  <script type="text/javascript">
var leader=${sessionScope.man.oper_address};
  function toggleRadio(v){
		 var isC=$(v).is(":checked");
		 if(isC){
			 $(v).removeAttr("checked");
		 }
	  }
  function showLog(id){
		window.open ('../show/log.jsp?type=100&id='+id, 'log', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行
	}
  function onlyNumberAllow(obj){
		var val=$(obj).val();
		if(null!=val&&val.length>0){
			//先把非数字的都替换掉，除了数字和.
			obj.value = obj.value.replace(/[^\d.]/g,"");
			//必须保证第一个为数字而不是.
			obj.value = obj.value.replace(/^\./g,"");
			//保证只有出现一个.而没有多个.
			obj.value = obj.value.replace(/\.{2,}/g,".");
			//保证.只出现一次，而不能出现两次以上
			obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		}
	}
  $(function(){
	  initComplexArea('UNIT_INSTALLED_CITY1', 'UNIT_INSTALLED_CITY', 'UNIT_INSTALLED_STREET', area_array, sub_array, '43', '0', '0');
	  find();
  });
  
  function showAppendPage(id){
		window.open ('AppendRemark.jsp?type=201&id='+id, 'showAppend107', 'height=150, width=300, top=40, left=100,menubar=no, scrollbars=0, resizable=0,location=n o, status=no'); //这句要写成一行 
	}
  function showFunctionWindow(type,name){
	  if(type==1)
	   window.open ('updateEquType.jsp?terminalId=${param.terminalId}', name, 'height=200, width=500, top=140,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
	  if(type==2)
	   window.open ('updateTerminal.jsp?terminalId=${param.terminalId}', name, 'height=500, width=1000, top=140,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
  }
  
	function queryCost(){
		//查询机具费用信息
		$.post("../action/TermiCostDataQuery.jsp",{'terminalId':<%=request.getParameter("terminalId")%>},function(json){
			json=eval("("+json+")");
			var jsonResult=json.resultset;
			for(var i=0;i<jsonResult.length;i++){
				var result=json.resultset[i];
				if(!result){
					continue;
				}
				for(var v in result){
					var type=result["COST_TYPE"];
					var id=v+type;
					//$("input:[name="+id+"]").val(result[v]);
					if($.trim(result[v])!=null&&$("#"+id))
						$("#"+id).val($.trim(result[v]));
				}
				//费用大于0
				if($.trim(result["MONEY"])){
					$("#COSTNUMBER"+i).removeClass("notRequired");
					$("#COSTNUMBER"+i).after("<font>*</font>");
					$("#REFUNDDATE"+i).removeClass("notRequired");
					$("#REFUNDDATE"+i).after("<font>*</font>");
				}
			}
		});
	}
	
  function disableForm(result){
	var index=parseInt(result["TEMINAL_STATUS"]);//终端状态
	var installState=(result["INSTALLED_STATUS"]==2);//延迟装机
	if(result["INSTALLED_STATUS"]==5){//未调试
		$("#showNotDebugMsg").html("<font size=5 color=red>(调试未通过)</font>");
		$("#terminal_status_form_2 table").remove();
		$("#waitingDebug").removeAttr("disabled");
		$("#terminal_Cancel").remove();
	}else if(result["INSTALLED_STATUS"]==2){//延迟
		$("#terminal_Cancel").remove();
	}else if(result["INSTALLED_STATUS"]==0&&result["TEMINAL_STATUS"]==13){
		$("#terminal_Cancel").remove();
		$("#waitingDebug").removeAttr("disabled");
	}
	if(index>1)
		$("#modifyBtn").remove();
	 switch(index){
	 case 15:
		 $("input,button,select").attr("disabled","disabled");
		 $("#windowBackBtn").removeAttr("disabled");
		 break;
	  case 5:
		  $("#terminal_status_form_5").find("button,input,select").attr("disabled","disabled");
		  $("#terminal_status_form_2").find("button,input,select").attr("disabled","disabled");
		 break;
	  case 6:
		  $("#terminal_status_form_10 *").attr("disabled","disabled");
		  $("#terminal_status_form_2 *").attr("disabled","disabled");
		  $("#terminal_status_form_5 *").attr("disabled","disabled");
		  $("#waitingDebug").removeAttr("disabled");
		  
		  $("#cancelTerminalDiv").show();
		  $("#cancelTime").html(result["CANCEL_TIME"]);
		  break;
	  case 13:
		  if(!installState){
			  $("#terminal_status_form_10 input").attr("disabled","disabled");
			  $("#terminal_status_form_10 select").attr("disabled","disabled");
			  $("#terminal_status_form_10 button").attr("disabled","disabled");
			  $("#terminal_Cancel").removeAttr("disabled");
		  };
		  $("#terminal_status_form_2").find("button,input,select").attr("disabled","disabled");
		  $("#terminal_status_form_5").find("button,input,select").attr("disabled","disabled");
		  $("#TerminalMessageChange").removeAttr("disabled");
		  
		  $("#archTerminalDiv").show();
		  $("#archTime").html(result["ARCHIVE_DATE"]);
		  
		  break;
	  case 3:
		  $("#terminal_status_form_10 *").attr("disabled","disabled");
		  $("#terminal_status_form_5 *").attr("disabled","disabled");
		  break;
	  case 4:
		  $("#terminal_status_form_2").find("button,input,select").attr("disabled","disabled");
		  $("#terminal_status_form_10").find("button,input,select").attr("disabled","disabled");
	  break;
	  case 2://部分审批完成
	  case 1://录入
		  $("#terminal_status_form_10 *").attr("disabled","disabled");
		  $("#terminal_status_form_2 *").attr("disabled","disabled");
		  $("#terminal_status_form_5 *").attr("disabled","disabled");
		  break;
	  }
	 //调试完成
	 /**
	 if(index<4){
		 $("#EQUI_TYPE_MODIFY").remove();
	 }else if(index!=15){
		 $("#EQUI_TYPE_MODIFY").removeAttr("disabled");
	 }*/
	 if(index<4){
		 $("a[name='print']").remove();
	 }else if(index<5){
		 $("a[name='print']:eq(1)").remove();
	 }else if(index==6){
		 $("a[name='print']").remove();
	 }else if(index==13&&result["INSTALLED_STATUS"]==5){
		 $("a[name='print']").remove();
	 }
	 //分配完成
	 if(index>5){
		 $.post("../action/loadUserName.jsp",{INST_MAN:result["INST_MAN"],SAFE_MAN:result["SAFE_MAN"]},function(data){
			 data=$.parseJSON(data);
			 $("#INST_MAN").append("<option selected=selected>"+data["INST_MAN"]+"</option>");
			 $("#SAFE_MAN").append("<option selected=selected>"+data["SAFE_MAN"]+"</option>");
		 });
	 }
  }
<%
	if(request.getParameter("show")!=null){
		//session.setAttribute("TEMINAL_INFO_ID",Integer.parseInt( request.getParameter("terminalId")));
		%>
			$(function(){
						$("#terminal_baseInfo_form input").attr("disabled","disabled");
						$("#terminal_baseInfo_form select").attr("disabled","disabled");
						$("#terminal_baseInfo_form textarea").attr("disabled","disabled");
						$("button[name!='updateData']").attr("disabled","disabled");
						$("button[id='windowBackBtn']").removeAttr("disabled");
						$("button[id='attachBtn']").removeAttr("disabled");
						$.post("../action/findById/Terminal.jsp",{'id':${param.terminalId},'singleton':true},function(json){
							var result=eval("("+json+")");
							//var result=json.resultset[0];
							disableForm(result);
							$("input,select,textarea").each(function(){
								//alert(result["TEMINAL_STATUS"]);
								var itemId=$(this).attr("id");
								if(itemId=="IS_OVERLAY"){
									$("#IS_OVERLAY").val(result[itemId]);
								}
								else if("UNIT_INSTALLED_STREET"==itemId){
									$("#UNIT_INSTALLED_CITY").val(result["UNIT_INSTALLED_CITY"]);
									
									try{
										$("#UNIT_INSTALLED_CITY").change();
									}catch(e){}
									$("#UNIT_INSTALLED_STREET").val(result["UNIT_INSTALLED_STREET"]);
								}else {
										$("#"+itemId).val(result[itemId]);
								}
							});
							$("#TEMINAL_PRODUCT_DEBUG").val(result["TEMINAL_PRODUCT"]);
							$("#INSTALLED_STATUS").change();
							queryCost();
							if(leader!=result["UNIT_INSTALLED_CITY"]&&leader!='0000'){
								$("button,select,a,input").attr("disabled","disabled");
							}
						});
					});
		<%
	}
%>
</script>
<script type="text/javascript">

function beforeSubmit(form) {
	var bindIds="";
	var checkAll=true;
	$("#BusinessManage input:radio").each(function(){
		if($(this).is(":checked"))
			{
				bindIds+=$(this).attr("id")+",";
			}
		else checkAll=false;
	});
	$("#BIND_IDS").val(bindIds);
	if(bindIds==""){
		alert("请选择业务！");
		return false;
	}
	if(!checkAll){
		if(!confirm("您还有业务未选择，确认提交？")){
			return;
		}
	}
	var allow = "";
	$("#" + form + " input[type='text'][class!='notRequired'],#"+form+" select[class!='notRequired']").each(function(index, data) {
		if($(this).is(":hidden")){
			return true;
		}
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
var terminalId=<%=request.getParameter("terminalId")%>||"";
function find(cur_page){
    $('#merDayGain_Templet').nextAll().remove();
	cur_page = cur_page || 0;
	var row = $('#merDayGain_Templet').clone(true);
	$("#cur_page").val(cur_page+1);
	var page_size = $("#page_size").val();
	$.ajax({
		url:'../action/AppayCommonDataQuery.jsp',
		dataType:'json',
		type:'POST',
		data:{'cur_page':cur_page+1,'page_size':page_size,"TEMINAL_INFO_ID":terminalId,"COMMERCIAL_ID":${param.CommercialId}},
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
	        		if(pro=='APPPAY_ID'){
	        			if(object[i]['APP_TYPE']=='101')
	        			 {
	        				if(object[i]['isBind']==1)
	        				 row.find('#APPPAY_ID').html("<input  ondblclick='toggleRadio(this)' id='-"+object[i][pro]+"' checked='checked' type='radio' name='a1245' class='radio'/>");
	        				else
	        				 row.find('#APPPAY_ID').html("<input  ondblclick='toggleRadio(this)'  id='-"+object[i][pro]+"' type='radio'  name='a1245'  class='radio'/>");
	        			}
	        			else if(object[i]['APP_TYPE']=='103'){
	        				  //便捷付
		        				if(object[i]['isBind']==1)
			        				 row.find('#APPPAY_ID').html("<input  ondblclick='toggleRadio(this)' checked='checked' id='2"+object[i][pro]+"' type='radio' name='b3123' class='radio'/>");
			        				else 
			        				row.find('#APPPAY_ID').html("<input  ondblclick='toggleRadio(this)'  id='2"+object[i][pro]+"' type='radio' name='b3123' class='radio'/>");
			        	 }else if(object[i]['APP_TYPE']=='105'){
	        				  //便捷付
		        				if(object[i]['isBind']==1)
			        				 row.find('#APPPAY_ID').html("<input  ondblclick='toggleRadio(this)' checked='checked' id='5"+object[i][pro]+"' type='radio'  name='c3354' class='radio'/>");
			        				else 
			        				row.find('#APPPAY_ID').html("<input  ondblclick='toggleRadio(this)'  id='5"+object[i][pro]+"' type='radio' name='c3354' class='radio'/>");
			        	 }
	        			if(object[i]['APP_TYPE']=='102')
	        			 {
	        				if(object[i]['isBind']==1)
	        				 row.find('#APPPAY_ID').html("<input  ondblclick='toggleRadio(this)' id='6"+object[i][pro]+"' checked='checked' type='radio' name='d1245' class='radio'/>");
	        				else
	        				 row.find('#APPPAY_ID').html("<input  ondblclick='toggleRadio(this)'  id='6"+object[i][pro]+"' type='radio'  name='d1245'  class='radio'/>");
	        			}	        			
	        		}else if(pro=='APP_TYPE'){
	        			if(object[i]['APP_TYPE']==101){
	        				row.find('#'+pro+'').html("实名支付");
	        			}
	        			if(object[i]['APP_TYPE']==102){
	        				row.find('#'+pro+'').html("收付宝");
	        			}
	        			if(object[i]['APP_TYPE']==103){
	        				row.find('#'+pro+'').html("便捷付");
	        			}
	        			if(object[i]['APP_TYPE']==105){
	        				row.find('#'+pro+'').html("收单");
	        			}
	        		}else if(pro=='APPR_STATUS'){
	        			var vv="";
	        			switch(object[i]["APPR_STATUS"]){
	        			case 3:vv="新增终端待审批";break;
	        			case 0:vv="新商户入网待审批";break;
	        			case 1:vv="审批未通过";break;
	        			case 2:vv="审批通过";break;
	        			case 4:vv="信息变更待审批";break;
	        			}
	        			row.find('#'+pro+'').html(vv);
	        		}else {
	        			row.find('#'+pro+'').html(object[i][pro]);
	        		}
	        			
	        	}
		        row.show();
		        row.insertAfter('#merDayGain_Templet');
	        };
	        $('#cust_Table').mygrid();
    	},  
	    error: function(XmlHttpRequest, textStatus, errorThrown){  
	        alert( "error");  
	    }
	 }); 
}

	function updateData4(){
		$("#terminal_baseInfo_form input").removeAttr("disabled");
		$("#terminal_baseInfo_form select").removeAttr("disabled");
		$("#terminal_baseInfo_form textarea").removeAttr("disabled");
		$("#terminal_baseInfo_form button").removeAttr("disabled");
	}
	 function showAttachFile(){
			window.open ('../insert/attachTPhoto.jsp?id=${param.terminalId}', 'showTerminal', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
		}
</script>
<style type="text/css">
.radio{
	width: 30px;
}
</style>
</head>

<body >
      
<div id="easyTabContext" class="tab-container">
<!-- 终端管理 -->
  <div id="TerminalManage" class="panel-container">
   		<div  class="left02">
			<div class="left02topDiv">
				<div class="left02top_right"></div>
				<div class="left02top_left"></div>
				<div class="left02top_c"><span id="titleName">（终端）基本信息</span> </div>
			</div>
		</div>
		<div class="mycss">
		<c:if test="${param.show==1 }">
			<form id="terminal_baseInfo_form" action="../action/TerminalDataUpdate.jsp" method="post">
		</c:if>
		<c:if test="${param.show!=1 }">
			<form id="terminal_baseInfo_form"  action="../action/TerminalDataInsert.jsp" method="post">
		</c:if>
			<table>
				<tr>
				<td align="right">客户装机联系人:</td>
				<td>
					<input type="text" name="UNIT_INSTALLED_MAN" id="UNIT_INSTALLED_MAN" maxlength="5"/>
					<font>*</font>
					<input type="hidden" name="TEMINAL_INFO_ID" id="TEMINAL_INFO_ID" readonly="readonly" value="${requestScope.TEMINAL_INFO_ID}"/>
					<input type="hidden" name="COMMERCIAL_ID" id="COMMERCIAL_ID" value='<c:out value="${param.CommercialId}"></c:out>' readonly="readonly"/>
					<input type="hidden" name="BIND_IDS" id="BIND_IDS" readonly="readonly"/>
				</td>
				<td align='right'>客户装机联系电话:</td>
				<td>
					<input type="text" name="UNIT_INSTALLED_TEL" id="UNIT_INSTALLED_TEL"/>
						<font>*</font>
				</td>
			</tr>
			<tr>
				<td align='right'>装机城市:</td>
				<td>
					<!-- <input type="text" name='UNIT_INSTALLED_CITY' id="UNIT_INSTALLED_CITY"/> -->
					<select id="UNIT_INSTALLED_CITY1" name="UNIT_INSTALLED_CITY1" onchange="changeComplexProvince(this.value, sub_array, 'UNIT_INSTALLED_CITY', 'UNIT_INSTALLED_STREET');">
	   				 </select>
				      <select id="UNIT_INSTALLED_CITY" name="UNIT_INSTALLED_CITY" onchange="changeCity(this.value,'UNIT_INSTALLED_STREET','UNIT_INSTALLED_STREET');">
				    </select>
				      <select id="UNIT_INSTALLED_STREET" name="UNIT_INSTALLED_STREET">
        </select>
        	<font>*</font>
				</td>
				<td align="right">客户装机地址:</td>
				<td>
					<input type="text" name="UNIT_INSTALLED_ADD" id="UNIT_INSTALLED_ADD"/>
						<font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">机具产权:</td>
				<td>
					<select name="TEMINAL_PRODUCT" id="TEMINAL_PRODUCT">
						<option value="0">通联产权</option>
						<option value="1">银行产权</option>
						<option value="2">代理商产权</option>
					</select>
						<font>*</font>
				</td>
				<td align="right">机具类型:</td>
				<td>
					<select name="EQUI_TYPE" id="EQUI_TYPE" style="height:30px">
						<option value="0">普通POS</option>
						<option value="1">移动POS</option>
						<option value="2">分体POS</option>
						<option value="3">其他类型POS</option>
					</select>
						<font>*</font>
					<%	Permission per=new PositionPermessionImpl(); %>
					<!--  	<%//if(per.hasPermission(session,Permission.OPERAT_POSITION)){ %>
						<button type="button" onclick="showFunctionWindow(1,'机具更改')" id="EQUI_TYPE_MODIFY" style="height:30px">机具修改</button>
					<%//} %>
					-->
				</td>
			</tr>
			<tr>
				<td align="right">加急标志位:</td>
				<td>
					<select name="IS_HURRY" id="IS_HURRY">
						<option value="0">不加急</option>
						<option value="1">加急</option>
					</select>
				</td>
				<td align="right">终端通讯方式:</td>
				<td>
					<select name="COMM_TYPE" id="COMM_TYPE">
						<option value="0">电话模式</option>
						<option value="1">网络模式</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">通讯方式是否绑定:</td>
				<td>
					<select name="IS_BIND" id="IS_BIND">
						<option value="0">不绑定</option>
						<option value="1"> 绑定</option>
					</select>
				</td>
				<td align="right">通讯方式描述:</td>
				<td>
					<input type="text" name="COMM" id="COMM" class="notRequired"/>
				</td>
			</tr>
			<tr>
			<td align="right">叠加便民:</td>
				<td>
					<select id="IS_OVERLAY" name="IS_OVERLAY">
						<option value="1">叠加</option>
						<option value="0" selected="selected">不叠加</option>
					</select>
						<font>* 体彩项目自动叠加便民，无需选择“叠加”！</font>
				</td>
			<td align="right">备注信息:</td>
				<td>
					<textarea rows="3" cols="20" id="REMARK_INFO" name="REMARK_INFO"></textarea>
				</td>
			</tr>
			<% DaoUtils daoUtils=new DaoUtils();
			%>
			 
			</table>
		<div  class="left02">
			<div class="left02topDiv">
				<div class="left02top_right"></div>
				<div class="left02top_left"></div>
				<div class="left02top_c"><span id="titleName">费用信息</span> </div>
			</div>
		</div>
		<table style="width: 60%"  class="panel-container">
			<tr>
				<td>费用类别</td>
				<td>费用金额</td>
				<td>收费周期</td>
			</tr>
			<tr>
				<td>押金(元):</td>
				<td><input type="text" name="MONEY0" id="MONEY0" onkeyup="onlyNumberAllow(this)"/>
					<font>*</font>
				<input type="hidden" name="COSTTYPEID0" id="COSTTYPEID0" class="notRequired"/>
				<input type="hidden" value="0" class="notRequired" name="COST_TYPE0" id="COST_TYPE0" />
				</td>
				<td>
					<select name="CYCLE0" id="CYCLE0" class="notRequired">
						<option value="0">一次性收费</option>
					</select>
						<font>*</font>
				</td>
			</tr>
			<tr>
				<td>服务费(元):</td>
				<td>
				<input type="hidden" name="COSTTYPEID1" id="COSTTYPEID1" />
					<input type="text" class="notRequired" name="MONEY1" id="MONEY1" onkeyup="onlyNumberAllow(this)"/>
					<input type="hidden" value="1" class="notRequired" name="COST_TYPE1" id="COST_TYPE1" />
				</td>
				<td>
				<select name="CYCLE1"  id="CYCLE1"  class="notRequired">
						<option value="0">一次性收费</option>
						<option value="1">按月收取</option>
						<option value="2">按季收取</option>
						<option value="3">按年收取</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>通讯费(元):</td>
				<td>
					<input type="text" class="notRequired" name="MONEY2" id="MONEY2" onkeyup="onlyNumberAllow(this)" />
					<input type="hidden" name="COSTTYPEID2" id="COSTTYPEID2" class="notRequired"/>
					<input type="hidden" value="2" class="notRequired" name="COST_TYPE2" id="COST_TYPE2" />
				</td>
				<td>
					<select name="CYCLE2" class="notRequired" id="CYCLE2">
						<option value="0">一次性收费</option>
						<option value="1">按月收取</option>
						<option value="2">按季收取</option>
						<option value="3" selected="selected">按年收取</option>
					</select>
				</td>
			</tr>
		</table>
			<div  class="left02">
			<div class="left02topDiv">
				<div class="left02top_right"></div>
				<div class="left02top_left"></div>
				<div class="left02top_c"><span id="titleName">业务信息</span> </div>
			</div>
		</div>
			<!-- 业务信息 -->
		  <div id="BusinessManage" class="panel-container">
			<div id="listDiv" class="left02">
				<div class="left02downDiv">
					<table id='cust_Table' class='dataTable1' width="100%">
						<tr>
							<th class='dataTableHeader' style="width: 90px">绑定(双击解绑)</th>
							<th class='dataTableHeader'>业务名称</th>
							<th class='dataTableHeader'>门店名称</th>
							<th class='dataTableHeader'>商户编号</th>
							<th class='dataTableHeader'>终端编号</th>
							<th class='dataTableHeader'>拓展人</th>
							<th class='dataTableHeader'>审批日期</th>
							<th class='dataTableHeader'>业务状态</th>
							<th class='dataTableHeader'>详情</th>
						</tr>
						<tr id='merDayGain_Templet'>
							<td id="APPPAY_ID"  style='width:20px'></td>
							<td id="APP_TYPE"></td>
							<td id="MARCHANT_NAME"></td>
							<td id="TERM_ID1"></td>
							<td id="TERM_ID2"></td>
							<td id="E_ID"></td>
							<td id="APPR_DATE"></td>
							<td id="APPR_STATUS"></td>
							<td id="more"></td>
						</tr>	
					</table>
						<div id='cust_Pagination' class='pagination'></div>
						<div id='cust_Searchresult'></div>
					</div>
				</div>
			  </div>
			<center>
				<tr >
					<td>
						<c:if test="${param.show==1 }">
								<button type="button" style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onclick="showLog(${param.terminalId})">修改日志</button>
							&nbsp;&nbsp;
							<%if(!per.hasPermission(session, Permission.OPERAT_POSITION)){ %>
							<button type="button" style="width:100px;text-align: center; table-layout: fixed;margin-right: 20px" name="updateData" id="modifyBtn" onclick="updateData4()">修改</button>
							&nbsp;&nbsp;
							<%} %>
						</c:if>
						<button type="button" id="attachBtn" style="width:100px;text-align: center; table-layout: fixed;" onclick="showAttachFile()">附件</button>
					<button type="button" style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onclick="showAppendPage(${param.terminalId})">追加备注</button>
						&nbsp;&nbsp;<button type="button" style="width:100px;text-align: center; table-layout: fixed;" onclick="beforeSubmit('terminal_baseInfo_form')">提交</button>
						
						&nbsp;&nbsp;<button type="button" id="windowBackBtn" onclick="window.location.href='commercialInsert.jsp?show=1&CommercialId=${param.CommercialId}'" style="width:100px;text-align: center; table-layout: fixed;" >返回</button>
							<!-- <a href="commercialInsert.jsp">录入客户信息</a> -->
					</td>
				</tr>
			</center>
		</form>
		</div>
		<!-- 000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 -->
		<!-- 只有查看信息才显示终端操作信息 -->
		
			<c:if test="${not empty param.show }">
			<script type="text/javascript">
				function commonFormValidate(f){
					var allow="";
					$("#"+f+" input[type!='hidden'],#"+f+" select").each(function(index, data) {
						if($(this).is(":hidden")||$(this).attr("class")=='notRequired'){
							return true;
						}
						if (this.value == null || $.trim($(this).val()).length == 0) {
							allow = $($(this).parent()).prev().html() + " 未填写！";
							$(this).focus();
							return false;
						}
						return true;
					});
					if ("" != allow) {
						alert(allow);
					} else {
						if(f == 'terminal_status_form_10' && $("#INSTALLED_STATUS").val() == '0'){
							if (!confirm("确定要取消装机吗？")) return ;
							var form=document.getElementById(f);
							form.submit();
							return;
						}else{
							var form=document.getElementById(f);
							form.submit();
						}
					}
				}
				function sigletonSerial1(s){
					var value=$(s).val();
					if(null!=value&&$.trim(value).length>0){
						$.post("../action/SigletonSerial1.jsp",{ser:value},function(j){
							j=eval("("+j+")");
							if(j>0){
								$("#debug_OK").removeAttr("disabled");;
							}else if(j==-1){
								alert("主机序列号重复！");
								$("#debug_OK").attr("disabled","disabled");;
							}else if(j==-2){
								alert("主机序列号不在仓库中！");
								$("#debug_OK").attr("disabled","disabled");;
							}
						});
					}
				}
			</script>
				<div class="mycss">
				<div  class="left02">
					<div class="left02topDiv">
						<div class="left02top_right"></div>
						<div class="left02top_left"></div>
						<div class="left02top_c"><span id="titleName">操作处理信息</span>
						</div>
					</div>
				</div>
				<!-- 调试 -->
			<form class="panel-container" action="../action/TerminalOperator.jsp" id="terminal_status_form_2">
				<span id="showNotDebugMsg"></span>
				<table>
				<tr>
				<td colspan="6">
				<%
					//调试时，显示便民的商户编号，密钥1，密钥2，（tposkey表）只显示
					String terminalId = request.getParameter("terminalId");
					DatabaseAccess dba = new DatabaseAccess();
					ResultSet rs = dba.executeQuery("select t.psam, t.tm_key1, t.tm_key2   from TPOS_KEY@DB12.LOCALDOMAIN t, term_app_table temp,teminal_info i  where t.psam = temp.term_id2  and i.teminal_info_id=temp.teminal_info_id  and temp.apptype=104    and i.IS_OVERLAY = 1    and i.teminal_info_id ="+terminalId);
					if (rs.next()){
					    out.println("本地平台PSAM号："+rs.getString("psam")+"<br>");
					    out.println("本地平台密钥1："+rs.getString("tm_key1")+"<br>");
					    out.println("本地平台密钥2："+rs.getString("tm_key2")+"<br>");
					}
					rs.close();
					dba.release();
					//交易渠道为本地，显示 商户编号，密钥1，密钥2（tposkey表）
					DatabaseAccess dba2 = new DatabaseAccess();
					ResultSet rs2 = dba2.executeQuery("select t.psam, t.tm_key1, t.tm_key2   from TPOS_KEY@DB12.LOCALDOMAIN t,term_app_table temp, teminal_info i  where i.teminal_info_id= temp.teminal_info_id  and t.psam=temp.term_id2    and i.teminal_info_id ="+terminalId);
					while (rs2.next()){
					    out.println("本地渠道PSAM号："+rs2.getString("psam")+"<br>");
					    out.println("本地渠道密钥1："+rs2.getString("tm_key1")+"<br>");
					    out.println("本地渠道密钥2："+rs2.getString("tm_key2")+"<br>");
					}
					rs2.close();
					dba2.release();
				%>
				</td>
				</tr>
				<tr>
					<td align="right"></td>
					<td>
							<!-- <input type="checkbox" checked="checked" name="notAppay"/> -->
					</td>
					<td align="right">主机序列号:</td>
					<td>
						<input type="text" maxlength="20" name="SERIAL1" id="SERIAL1" />
						<font>*</font>
						<input type="hidden" name="node" value='4'/>
						<input type="hidden" name="TEMINAL_INFO_ID" value='<c:out value="${param.terminalId }"></c:out>'/>
						<input type="hidden" name="TEMINAL_PRODUCT" id="TEMINAL_PRODUCT_DEBUG"/>
					</td>
					<td align='right'>键盘序列号:</td>
					<td>
						<input type="text" maxlength="20" name="SERIAL2" id="SERIAL2" class="notRequired"/>
					</td>
				</tr>
				</table>
				<center>
						<%
							if(per.hasPermission(session,Permission.DEBUG_POSITION)){
						%>
						<script type="text/javascript">
							function unDebug(){
								if(confirm("确认未调试？")){
									window.location.href='../action/TerminalOperator.jsp?node=10&TEMINAL_INFO_ID=${param.terminalId}';
								}
							}
						</script>
					<button type="button" name="updateData" id="debug_OK" style="width:100px;text-align: center; table-layout: fixed;" onclick="commonFormValidate('terminal_status_form_2')">调试完成</button>
					&nbsp;&nbsp;<button type="button" name="updateData"  style="width:100px;text-align: center; table-layout: fixed;" onclick="unDebug()">未调试</button>
					<a target="_blank" name="print" href="../print/printTeminalInfo.jsp?teminal_info_id=${param.terminalId}">打印装机单</a>
					<%} %>
				</center>
			</form>
			<!-- 分配 -->
		
			<form class="panel-container" action="../action/TerminalOperator.jsp" id="terminal_status_form_5">
				<table>
					<input type="hidden" name="node" value='5'/>
					<input type="hidden" name="TEMINAL_INFO_ID" value='<c:out value="${param.terminalId }"></c:out>'/>
				<tr>
					<td align='right'>机具安装人:</td>
					<td>
						<select id="INST_MAN" name="INST_MAN">
						<option value="">---请选择---</option>
						<%request.setAttribute("installUsers", daoUtils.localTerminalUser(session,Permission.INSTALL_POSITION, request.getParameter("terminalId"))); %>
						<c:forEach items="${installUsers }" var="val" varStatus="vasta">
							<option value="<c:out value="${val.key }"></c:out>"><c:out value="${val.value }"></c:out></option>
						</c:forEach> 
					</select>
					<font>*</font>
					</td>
					<td align="right">机具维护人:</td>
					<td>
						<%request.setAttribute("safeUsers",daoUtils.localTerminalUser(session,Permission.SAFE_POSITION, request.getParameter("terminalId"))); %>
					<select id="SAFE_MAN" name="SAFE_MAN">
					<option value="">---请选择---</option>
						<c:forEach items="${safeUsers }" var="val" varStatus="vasta">
							<option value="<c:out value="${val.key }"></c:out>"><c:out value="${val.value }"></c:out></option>
						</c:forEach> 
					</select>
					<font>*</font>
					</td>
				</tr>
				</table>
			<%if(per.hasPermission(session, Permission.FILE_POSITION)){ %>
				<center>
					<button type="button" name="updateData" id="assignBtn"  style="width:100px;text-align: center; table-layout: fixed;" onclick="commonFormValidate('terminal_status_form_5')">完成</button>
					<a name="print" style="font: red" target="_blank" href="../print/printTemicost.jsp?teminal_info_id=${param.terminalId}">打印收据</a>
				</center>
			<%} %>
			</form>
			
			<!-- 归档 -->
			<!-- 押金的。。。。。。。 
			        <input id="COST_TYPE3" class="notRequired" name="COST_TYPE3" value="3" type="hidden" />
				COSTNUMBER	<input type="hidden" name="COSTTYPEID3" id="COSTTYPEID3" class="notRequired"/>
					<input type="text" class="notRequired" name="COSTNUMBER3" id="COSTNUMBER3" />
				-->
			<!-- dsfs -->
			<form class="panel-container" action="../action/TerminalOperator.jsp" id="terminal_status_form_10">
				<table>
					<input type="hidden" name="node" value='13'/>
					<input type="hidden" name="TEMINAL_INFO_ID" value='<c:out value="${param.terminalId }"></c:out>'/>
				<tr>
					<td align="right">装机是否成功（装机状态）:</td>
					<td>
						<select name="INSTALLED_STATUS" id="INSTALLED_STATUS" onchange="if($(this).val()!=4){
								$('#INSTALL_END_DATE').attr('class','notRequired');
								$('#INSTALL_DATE').attr('class','notRequired');
								$('#INSTALL_END_DATE').attr('class','notRequired');
								$('#COSTNUMBER0').attr('class','notRequired');
								$('#COSTNUMBER1').attr('class','notRequired');
								$('#COSTNUMBER2').attr('class','notRequired');
								$('#terminal_status_form_10 *').attr('class','notRequired');
						}
						else {
								$('#INSTALL_END_DATE').removeAttr('class');
								$('#INSTALL_DATE').removeAttr('class');
						};
						">
							<option value="">----请选择----</option>
							<option value="0">取消装机</option>
							<option value="2">延迟装机</option>
							<option value="4">装机成功</option>
						</select>
						<font>*</font>
					</td>
				</tr>
				<tr>
					<td align="right">押金编号:</td>
					<td>
					 	<input type="text" name="COSTNUMBER0" id="COSTNUMBER0" /> 
					 	<font>*</font>
					</td>
					<td align="right">押金收取日期:</td>
					<td>
					 	<input type="text" name="REFUNDDATE0" id="REFUNDDATE0" class="notRequired" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" /> 
					</td>
				</tr>
				<tr>
					<td align="right">通讯费编号:</td>
					<td>
					 <input type="text" name="COSTNUMBER2" id="COSTNUMBER2" class="notRequired" /> 
					</td>
					<td align="right">通讯费收取日期:</td>
					<td>
					 	<input type="text" name="REFUNDDATE2" id="REFUNDDATE2" class="notRequired"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/> 
					</td>
				<tr>
					<td align="right">服务费编号:</td>
					<td>
					 	<input type="text" name="COSTNUMBER1" id="COSTNUMBER1" class="notRequired" /> 
					</td>
					<td align="right">服务费收取日期:</td>
					<td>
					 	<input type="text" name="REFUNDDATE1" id="REFUNDDATE1" class="notRequired"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/> 
					</td>
				</tr>
				<tr>
					<td align="right">装机日期:</td>
					<td>
					 <input type="text" name="INSTALL_DATE" id="INSTALL_DATE" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" required="required" readonly="readonly"/> 
					<font>*</font>
					</td>
					<td align="right">装机终止日期:</td>
					<td>
						 <input type="text" name="INSTALL_END_DATE" id="INSTALL_END_DATE" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" required="required" readonly="readonly"/> 
					<font>*</font>
					</td>
				</tr>
				</table>
			<div  class="left02" id="cancelTerminalDiv" style="display: none">
					<div class="left02topDiv">
						<div class="left02top_right"></div>
						<div class="left02top_left"></div>
						<div class="left02top_c"><span id="titleName" style="width: 800px">该终端已撤机，撤机时间:<font id="cancelTime"></font></span>
						</div>
					</div>
				</div>		
			<div  class="left02" id="archTerminalDiv" style="display: none">
					<div class="left02topDiv">
						<div class="left02top_right"></div>
						<div class="left02top_left"></div>
						<div class="left02top_c"><span id="titleName" style="width: 800px">该终端已归档，归档时间:<font id="archTime"></font></span>
						</div>
					</div>
				</div>						
				<center>
						<%
							if(per.hasPermission(session,Permission.FILE_POSITION)||per.hasPermission(session,Permission.LEADER_POSITION)){
						%>
					<button type="button" name="updateData" id="TerminalMessageChange" style="width:100px;text-align: center; table-layout: fixed;" onclick="showFunctionWindow(2,'终端信息变更')">终端信息变更</button>
					&nbsp;&nbsp;<button type="button" name="updateData"  style="width:100px;text-align: center; table-layout: fixed;" onclick="commonFormValidate('terminal_status_form_10')">归档</button>
				<td>&nbsp;&nbsp;<button type="button" id="terminal_Cancel" disabled="disabled" name="updateData"   style="width:100px;text-align: center; table-layout: fixed;" onclick="beforeCancelCheck(1)">撤机</button><td>
					<%} %>
				</center>
			</form>
				<%if(per.hasPermission(session, Permission.LEADER_POSITION)||per.hasPermission(session,Permission.FILE_POSITION)){%>
							<script type="text/javascript">
								function beforeCancelCheck(v){
									switch(v){
									case 1:
										if(confirm("确认撤机")){
											window.location.href="../action/TerminalOperator.jsp?node=6&TEMINAL_INFO_ID=<c:out value="${param.terminalId }"></c:out>";
										};
										break;
									}
								}
						function waitingOperate(type){
							if(type==1){
								if(confirm("确认将状态改为待归档？")){
									window.location.href='../action/TerminalOperator.jsp?node=11&TEMINAL_INFO_ID=${param.terminalId}'
								}
							}else if(type==2){
								if(confirm("确认将状态改为待调试？")){
									window.location.href='../action/TerminalOperator.jsp?node=12&TEMINAL_INFO_ID=${param.terminalId}'
								}
							}
						}
					</script>
							<%} %>
							
							<%if(per.hasPermission(session,Permission.LEADER_POSITION)) {%>
							<center  class="panel-container">
								<table>
								<tr>
									<td><button type="button" name="updateData" onclick="waitingOperate(2)" disabled="disabled" id="waitingDebug">待调试</button> <td>
								</tr>
							</table>
							</center>
							<% }%>
		
							
							
			</div>

		<%if(per.hasPermission(session, Permission.CUS_SERVICE_POSITION)){ %>
				<!-- 回访信息 -->			
				<div  class="left02">
					<div class="left02topDiv">
						<div class="left02top_right"></div>
						<div class="left02top_left"></div>
						<div class="left02top_c"><span id="titleName">回访</span>
						</div>
					</div>
				</div>
				<script type="text/javascript">
				function assignOrder(){
					  window.open ('AssignOrder.jsp?terminalId=${param.terminalId}&commercialId=${param.CommercialId}', "服务派单", 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
				}
					function visitInsert(){
					if($("#has_col10").attr("checked")!="checked")
						for(var i=1;i<8;i++){
							var name="has_col"+i;
							var v=$("#visitForm input[name='"+name+"'][checked='checked']:radio");
							if(0==v.length){
								var text=$($($("#visitForm input[name='"+name+"']")[0]).parent()).prev().html();
								alert(text+" 未选择！");
								return false;
							}
						}
						//$("#visitForm").submit();
						return true;
					}
				
				</script>
			<form class="formlyWrapper-Base" onsubmit="return visitInsert()" id="visitForm" action="../action/TerminalCallVisitInsert.jsp" method="post">
				<table style="font-sizd: 1.2em" border="0px">
				<input type="hidden" name="teminal_info_id" value="${param.terminalId}">
				<input type="hidden" name="comId" value="${param.CommercialId}">
				<input type="hidden" name="TEMINAL_INFO_VISIT_CALL_ID" value="${param.TEMINAL_INFO_VISIT_CALL_ID}">
				<tbody><tr>
					<td align="right">电话是否接通：</td>
					<td>是<input name="has_col10" value="1" checked="" type="radio" style="width: 30px">否<input name="has_col10" value="2" type="radio"  style="width: 30px" id="has_col10"></td>
					<td align="right">装机时间是否与登记一致：</td>
					<td>是<input name="has_col1" value="1" type="radio"  style="width: 30px">否<input  style="width: 30px" name="has_col1" value="2" type="radio"></td>
				</tr>		
				<tr>
					<td align="right">是否对收银员和财务人员给予银行卡受理知识培训：</td>
					<td>是<input name="has_col2" value="1" type="radio"  style="width: 30px">否<input name="has_col2" value="2" type="radio"  style="width: 30px"></td>
					<td align="right">是否知道信用卡必须核对签名：</td>
					<td>是<input name="has_col3" value="1" type="radio"  style="width: 30px">否<input name="has_col3" value="2" type="radio"  style="width: 30px"></td>
				</tr>		
				<tr>
					<td align="right">是否知道POS签购单自交易日期开始需保留一年：</td>
					<td>是<input name="has_col4" value="1" type="radio"  style="width: 30px">否<input name="has_col4" value="2" type="radio"  style="width: 30px"></td>
				
					<td align="right">核对押金收取金额是否一致：</td>
					<td>是<input name="has_col5" value="1" type="radio"  style="width: 30px">否<input name="has_col5" value="2" type="radio"  style="width: 30px"></td>
				</tr>		
				<tr>
					<td align="right">是否向商户出具正规的押金收据：</td>
					<td>是<input name="has_col6" value="1" type="radio"  style="width: 30px">否<input name="has_col6" value="2" type="radio"  style="width: 30px"></td>
					<td align="right">是否对我们公司目前的服务满意？</td>
					<td>是<input name="has_col7" value="1" type="radio"  style="width: 30px">否<input name="has_col7" value="2" type="radio"  style="width: 30px"></td>
				</tr>	
						<tr><td align="right">备注:</td>
						<td colspan="9"><textarea name="demo" cols="80" rows="5"></textarea></td>
					</tr>	
				</tbody>
			</table>
			<br>
			<center>
				<input style="width:100px;text-align: center; table-layout: fixed;"  value="提交" type="submit">
				<input value="重置" type="reset" style="width:100px;text-align: center; table-layout: fixed;" >
				<input value="派单" type="button" onclick="assignOrder()" style="width:100px;text-align: center; table-layout: fixed;" >
			</center>
			</form>
		<%} %>	
		
			</c:if>
  </div>
</div>
</body>
</html>		
