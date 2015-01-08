<%@page import="com.szzt.dao.DaoUtils"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="../../import.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
String info=request.getParameter("info");
if(null!=info&&info.equals("s1")){
	out.println("<script type=\"text/javascript\">alert('审批成功，请审批终端！')</script>");}
if(null!=info&&info.equals("1")){
	out.println("<script type=\"text/javascript\">alert('操作成功')</script>");
}
if(null!=info&&info.equals("11")){
	out.println("<script type=\"text/javascript\">alert('修改成功')</script>");
}
if(null!=info&&info.equals("10")){
	out.println("<script type=\"text/javascript\">alert('修改失败')</script>");}

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
 <link href="../../css/uploadify.css"
     rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../../css/allinpay.css" media="screen" />


<script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="../../js/jquery.uploadify.min.js"></script>
<script language="javascript" type="text/javascript" src="../../js/WdatePicker.js"></script>  
<script type="text/javascript" src="../../js/thickbox-compressed.js"></script>
<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
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
 <script src="../../js/province_city_area_select.js" type="text/javascript"></script>
  <script src="../../js/Area.js" type="text/javascript"></script>
    <script src="../../js/AreaData_min.js" type="text/javascript"></script>
 
<script type="text/javascript">
function showLog(id){
	window.open ('../show/log.jsp?type=103&id='+id, 'log', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行
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
function showAreaID(city,street) {
    var areaID = street;
    try{
		  var areaName = getAreaNamebyID(areaID) ;
		   return "湖南省"+areaName;
	  }catch(e){
		  return street;
	  }
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

var appppppppStatus=0;
function bussiness101Operate(id,index){
	var APPPAY_ID=<%=request.getParameter("appayId")==null?-1:request.getParameter("appayId")%>;
	var TEMINAL_INFO_ID=id;
	var TERM_ID2=$("#terminal_number"+index).val();
	var TERM_ID1=$("#commercial_id"+index).val();
	if(null==TERM_ID1||$.trim(TERM_ID1)==""||$.trim(TERM_ID1).length<15){
		alert("商户编号为15位！");
		return;
	}
	if(null==TERM_ID2||$.trim(TERM_ID2)==""||$.trim(TERM_ID2).length<8){
		alert("终端编号为8位！");
		return;
	}
	$.ajax( {
		dataType : 'json',
//		url : '../action/BussinessOperate.jsp',
		url:'../action/ForwardSigletonCommercialNo.jsp',
		data : {'APP_TYPE':'103','APPPAY_ID':APPPAY_ID,'TEMINAL_INFO_ID':TEMINAL_INFO_ID,'TERM_ID1':TERM_ID1,'TERM_ID2':TERM_ID2,"COMMERCIAL_ID":${param.CommercialId}},
		type : 'post',
		success : function(id) {
			if(id<0){
				//alert("操作失败！");
				alert("操作失败，商户编号已经存在！");
				//window.location.reload();
			}else{
				alert("操作成功！");
				$("#commercial_id"+index).attr("disabled","disabled");
				$("#terminal_number"+index).attr("disabled","disabled");
				$("#upBtn"+index).attr("disabled","disabled");	
			}
		},
		error : function(d) {
			alert("操作失败！");
			window.location.reload();
		}
	});
}
	$(function(){
		$.post("../action/findById/Commercial..jsp",{id:${param.CommercialId}},function(j){
			var jj=$.parseJSON(j);
			$("#unitName").html(jj.UNIT_NAME);
		});
		//$.address("ACCOUNT_PROVINCE","ACCOUNT_CITY","","湖南","长沙市");
		<%
		if(request.getParameter("show")!=null){
			%>
						find();
						$("#bussiness101form input").attr("disabled","disabled");
						$("#bussiness101form select").attr("disabled","disabled");
						$("#bussiness101form button[name!='updateData']").attr("disabled","disabled");
						$("#bussiness101form button[name='windowBackBtn']").removeAttr("disabled");
							$.post("../action/Appay103DataQuery.jsp",{'appayId':<%=request.getParameter("appayId")%>},function(json){
								json=eval("("+json+")");
								var result=json.resultset[0];
								appppppppStatus=result["APPR_STATUS"];
								if(result["APPR_STATUS"]!=null&&result["APPR_STATUS"]==2){
									$("#operateBtn").attr("disabled","disabled");
									//$("#cust_Table input:[name='terminal_number']").removeAttr("disabled");
									//$("#cust_Table input:[name='commercial_id']").removeAttr("disabled");
									//$("#cust_Table button:[name='ajaxSubmitOperate']").removeAttr("disabled");
									$("select").attr("disabled","disabled");
									$("#bussinessOperationForm *").attr("disabled","disabled");
									$("#historyOperateData").removeAttr("disabled");
								}else if(result["APPR_STATUS"]>2){
									$("#modifyBtn").remove();//移除修改和提交按钮
									$("#submitBtn").remove();//移除修改和提交按钮
								}else {
									$("input[name='terminal_number']").attr("disabled","disabled");
									$("input[name='commercial_id']").attr("disabled","disabled");
								}
								$("input,select,textarea").each(function(){
									var itemId=$(this).attr("id");
									if("APPR_REMARK"==itemId){
										$("#historyOperateData").val($.trim(result[itemId]));
									}else
									if(result[itemId])
										$(this).val($.trim(result[itemId]));
								});
								$("#IS_DEFAULT").val(result["IS_DEFAULT"]);
								$("#ACCOUNT_NO_CHECK").val($("#ACCOUNT_NO").val());	
								//客户基本信息查询完毕后开始查询终端信息。。。
								find(0,result["APPR_STATUS"]);
							});
			<%
		}
	%>
	});
	
	utils_serializeForm = function(form) {
		var hash = {};
		var serialize = $(form).serializeArray();
		$(serialize).each(function(v, dom) {
			hash[this["name"]] = (this["value"]);
		});
		return hash;
	}
	/**
	 * 提交信息到后台，会将form中的信息自动封装
	 * @param {Object} form
	 * @param {Object} url
	 * @param {Object} divId
	 * @param {Object} back 回调函数，成功时使用的函数
	 */
	utils_submit = function(form, url) {
		$.ajax( {
			dataType : 'json',
			url : url,
			data : utils_serializeForm(form),
			type : 'post',
			success : function(id) {
				if(id<0){
					window.location.reload();
				}else{
					$("input").attr("disabled","disabled");
					$("#submitBtn").remove();
					alert("操作成功！");
					showAttachFile(id);
	            	$("#windowBackBtn").click();
				}
			},
			error : function(d) {
				alert("操作失败！");
				window.location.reload();
			}
		});
	}
	function showAttachFile(id){
		window.open ('../insert/attachPhoto.jsp?type=103&id='+id, 'showAttach103', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
	}
	function beforeSubmit(form) {
		var allow = "";
		$("#" + form + " input[type!='hidden'][class!='notRequired'],#"+form+" select").each(function(index, data) {
			if ($.trim($(this).val()).length<1) {
				allow = false;
				allow = $($(this).parent()).prev().html() + " 未填写！";
				try{
					$(this).focus();
				}catch(e){
				}
				return false;
			}
			return true;
		});
		if ("" != allow) {
			alert(allow);
		} else {
			if($.trim($("#ACCOUNT_BANK_ID").val()).length!=12){
				alert("账户支行号为12位！");
				$("#ACCOUNT_BANK_ID").focus();
				return;
			}
			if($("#ACCOUNT_NO_CHECK").val()!=$("#ACCOUNT_NO").val()){
				alert("两次输入的账户账号不一致!");
				$("#ACCOUNT_NO_CHECK").focus();
				return;
			}
			var form = document.getElementById(form);
			<%if(request.getParameter("show")==null){
			%>
			utils_submit(form,"../action/Apppay103DataInsert.jsp");
			<%}
			else{
				%>
				utils_submit(form,"../action/Apppay103DataUpdate.jsp");
				<%
			}
			%>
			//form.submit();
		}
	}
	
	</script>
<script type="text/javascript">
function showAppendPage(id){
	window.open ('AppendRemark.jsp?type=103&id='+id, 'showAppend103', 'height=150, width=300, top=40, left=100,menubar=no, scrollbars=0, resizable=0,location=n o, status=no'); //这句要写成一行 
}
var cur_page = 0;
function find(cur_page,appStatus){
    $('#merDayGain_Templet').nextAll().remove();
	cur_page = cur_page || 0;
	var row = $('#merDayGain_Templet').clone(true);
	$("#cur_page").val(cur_page+1);
	var page_size = $("#page_size").val();
	$.ajax({
		url:'../action/TerminalAndTempQuery.jsp',
		dataType:'json',
		type:'POST',
		data:{"APPPAY_ID":<%=request.getParameter("appayId")==null?-1:request.getParameter("appayId")%>,apptype:103},
		success: function(json){
			//alert("TEMINAL_INFO_ID in(select TEMINAL_INFO_ID from TERM_APP_TABLE where APPPAY_ID=<%=request.getParameter("appayId")==null?-1:request.getParameter("appayId")%>)");
			var object = json.resultset;
	        $('#merDayGain_Templet').nextAll().remove();
	        if (json.total==0){
	        	$('#cust_Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
	        }
	        var i=0;
	        for(i=(json.rows-1);i>=0;i--){
	        	var row = $('#merDayGain_Templet').clone(true);
	        	for(var pro in object[i]) {
	        		if(pro=="UNIT_INSTALLED_STREET"){
	        			row.find('#'+pro+'').html(showAreaID(0,object[i]["UNIT_INSTALLED_STREET"]));
	        		} else if(pro=="EQUI_TYPE"){
	        			var v=object[i]["EQUI_TYPE"];
	        			if(null==v){
	        				v="--";
	        			}else{
	        				switch(v){
	        				case 0:v="普通POS";break;
	        				case 1:v="移动POS";break;
	        				case 2:v="分体POS";break;
	        				case 3:v="其他类型POS";break;
		        			}
	        			}
	        			row.find('#'+pro+'').html(v);
	        		}else  if(pro=="TEMINAL_STATUS"){
	        			var stt=object[i][pro];
	        			var vvv="";
	        			switch(stt){
	        			case 1:vvv="录入完成";break;
	        			case 2:vvv="部分完成";break;
	        			case 3:vvv="全部审批完成";break;
	        			case 4:vvv="调试完成";break;
	        			case 5:vvv="分配完成";break;
	        			case 13:vvv="归档完成";break;
	        			case 6:vvv="撤机完成";break;
	        			case 7:vvv="待定";break;
	        			}
	        			if(row.find('#'+pro+'')!=null)
	        			row.find('#'+pro+'').html(vvv);
	        		}else row.find('#'+pro+'').html(object[i][pro]);
	        		if(object[i]["TEMINAL_STATUS"]==3)//审批通过
	        		{
	        			var ter1=object[i]["TERM_ID1"];
	        			if(null!=ter1){
	        				ter1=$.trim(ter1);
	        			}else ter1="";
	        			var ter2=object[i]["TERM_ID2"];
	        			if(null!=ter2){
	        				ter2=$.trim(ter2);
	        			}else ter2="";
	        			row.find("#dosmthing").html("已审批");
		        		row.find("#terminal_number").html(ter2);
		        		row.find("#commercial_id").html(ter1);
	        		}else{
	        			var ter1=object[i]["TERM_ID1"];
	        			if(null!=ter1){
	        				ter1=$.trim(ter1);
	        			}else ter1="";
	        			var ter2=object[i]["TERM_ID2"];
	        			if(null!=ter2){
	        				ter2=$.trim(ter2);
	        			}else ter2="";
	        			row.find("#dosmthing").html("<button disabled='disabeld' name='ajaxSubmitBtn' id='upBtn"+i+"' onclick='bussiness101Operate("+object[i]["TEMINAL_INFO_ID"]+","+i+")'>完成</button>");
		        		row.find("#terminal_number").html("<input  maxlength=8  value='"+ter2+"' disabled='disabeld' name='terminal_number' id='terminal_number"+i+"'/>");
		        		row.find("#commercial_id").html("<input   maxlength=15  value='"+ter1+"' disabled='disabeld' name='commercial_id' id='commercial_id"+i+"'/>");
	        		}
	        		
	        		//row.find("#terminal_address").html(object[i]["UNIT_INSTALLED_ADD"]);
	        	}
	        	row.find("#MORE").html("<a href='../insert/terminalInsert.jsp?show=1&terminalId="
					+ object[i]["TEMINAL_INFO_ID"] + "&CommercialId=${param.CommercialId}'>详情</a>");
		        row.show();
		        row.insertAfter('#merDayGain_Templet');
	        };
	        if(appStatus==2)
    		{
    			$("button[name='ajaxSubmitBtn']").removeAttr("disabled");	
    			$("input[name='terminal_number']").removeAttr("disabled");	
    			$("input[name='commercial_id']").removeAttr("disabled");	
    		}
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
</script>
<script type="text/javascript" src="../../js/jquery.prism.2.0.js"></script>
<script type="text/javascript">
function updateData2(){
	//$("#bussiness101form input").removeAttr("disabled");
	//$("#bussiness101form select").removeAttr("disabled");
	//$("#bussiness101form textarea").removeAttr("disabled");
	if(appppppppStatus==2)
	{
		$("#ACCOUNT_NO").removeAttr("disabled");
		$("#ACCOUNT_BANK_ID").removeAttr("disabled");
		$("#APPPAY_ID").removeAttr("disabled");
		$("#COMMERCIAL_ID").removeAttr("disabled");
		$("#CONTRACT_FEE").removeAttr("disabled");
		$("#ACCOUNT_PROVINCE").removeAttr("disabled");
		$("#ACCOUNT_CITY").removeAttr("disabled");
		$("#ACCOUNT_NO_CHECK").removeAttr("disabled");
		$("#bussiness101form button").removeAttr("disabled");
		$("#ACCOUNT_BANK_NAME").removeAttr("disabled");
		$("#ACCOUNT_NAME").removeAttr("disabled");

		$("#ACCOUNT_TYPE").removeAttr("disabled");
		$("#ACCOUNT_BANK").removeAttr("disabled");
		$("#BASE").removeAttr("disabled");
		$("#TOP").removeAttr("disabled");
		$("#CHARGE_CYCLE").removeAttr("disabled");
		
	}else if(appppppppStatus<=1){
		$("#bussiness101form input").removeAttr("disabled");
		$("#bussiness101form select").removeAttr("disabled");
		$("#bussiness101form textarea").removeAttr("disabled");
		$("#bussiness101form button").removeAttr("disabled");
	}
}
$(function(){
	$("#auto").bind("propertychange input",function(e) {
        if($("#auto").val()!=""){
			$("#autoinfos").prism({
				content:"ajax:../../auto_bank_info.rp",
				param:{C2:$("#auto").val(),ACTION_TYPE:"JSONLIST"}
				});
		}
    });

});
function func_auto(c1,c2){
<%
Permission per2=new PositionPermessionImpl();
if(request.getParameter("show")==null || !per2.hasPermission(session, Permission.OPERAT_POSITION)){
%>
	if(confirm("是否选择银行["+c2+"\n"+c1+"]")){
		$("#ACCOUNT_BANK_ID").val(c1);
		$("#ACCOUNT_BANK_NAME").val(c2);
		$("#TB_closeWindowButton").trigger("click");
	}
<%}%>
}

</script>
<style type="text/css">
	font{
	color:red;
	}
</style>
</head>

<body >
<div id="div2" style=" display:none;">
<b>请输入支行名关键字：</b><input type="text" id="auto" class='notRequired'>
<ul id="autoinfos" prism="dataGrid">
<li style="height:30px; line-height:30px;"><a href='javascript:func_auto("#@C1#","#@C2#");'>#@C2#[支行号：#@C1#][接收行号：#@C5#]</a></li>
</ul>
</div>
  <div id="easyTabContext"  class="panel-container">
   		<div  class="left02">
			<div class="left02topDiv">
				<div class="left02top_right"></div>
				<div class="left02top_left"></div>
				<div class="left02top_c" style="width: 1000px"><span id="titleName">（便捷付）基本信息---客户单位名称:<font color="black" id="unitName"></font>  </div>
			</div>
		</div>
		<div class="mycss">
		<form class="panel-container"  method="post"  action="#" id="bussiness101form">
			<table class="panel-container">
			<tr>
				<td align="right">业务类型:</td>
				<td>
					<span>便捷付</span>
					<input type="hidden" name="APPTYPE" id="APPTYPE" value="103" readonly="readonly"/>
					<input type="hidden" name="APPPAY_ID" id="APPPAY_ID" value='<c:out value="${param.appayId}"></c:out>' readonly="readonly"/>
					<input type="hidden" name="COMMERCIAL_ID" id="COMMERCIAL_ID" value='<c:out value="${param.CommercialId}"></c:out>' readonly="readonly"/>
				</td>
				<td align='right'>账户类型:</td>
				<td>
					<select name="ACCOUNT_TYPE" id="ACCOUNT_TYPE" class="notRequired">
						<option value="2">存折</option>
						<option value="1" selected="selected">银行卡</option>
					</select>
					<font>*</font>
				</td>
			</tr>
			<tr>
				<td align='right'>账户帐号:</td>
				<td>
					<input type="text" name='ACCOUNT_NO' id="ACCOUNT_NO" />
					<font>*</font>
				</td>
				<td align='right'>确认账户帐号:</td>
				<td>
					<input type="text" name='ACCOUNT_NO_CHECK' id="ACCOUNT_NO_CHECK" />
					<font>*</font>
				</td>
			</tr>
			
			<tr>
		
				<% DaoUtils daoUtils=new DaoUtils();
				request.setAttribute("expandUsers", daoUtils.localExpandUser(session,request.getParameter("show")==null));
					request.setAttribute("allChannel", daoUtils.channelInfo());
					request.setAttribute("allBank", daoUtils.bankInfo());
					%>
				<td align='right'>账户银行:</td>
				<td>
					<select id="ACCOUNT_BANK" name="ACCOUNT_BANK">
					<option value="">---请选择----</option>
						<c:forEach items="${allBank }" var="val" varStatus="vasta">
							<option value="<c:out value="${val.key }"></c:out>"><c:out value="${val.value }"></c:out></option>
						</c:forEach>
					</select>
					<font>*</font>
				</td>
			</tr>
			<tr>	
				<td align="right">账户支行号:</td>
				<td>
					<input type="text" name="ACCOUNT_BANK_ID" maxlength="12" readonly="readonly" id="ACCOUNT_BANK_ID" onKeyUp="onlyNumberAllow(this)"/>
					<font>*</font>
					<a href="#TB_inline?height=250&width=600&inlineId=div2" class="thickbox">检索行号</a>
				</td>
				<td align="right">账户支行名称:</td>
				<td>
					<input type="text" name="ACCOUNT_BANK_NAME" readonly="readonly" id="ACCOUNT_BANK_NAME"/>
					<font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">拓展人：</td>
				<td>
					<select name="E_ID" id="E_ID">
						<c:forEach items="${expandUsers }" var="val" varStatus="vasta">
							<option value="<c:out value="${val.key }"></c:out>"><c:out value="${val.value }"></c:out></option>
						</c:forEach>
					</select>
					<font>*</font>
				</td>
				<td align="right">银行推荐人:</td>
				<td>
					<input type="text" name="EC_NAME" id="EC_NAME" class="notRequired"/>
				</td>
			</tr>
			<tr>
				<td align="right">账户所在省：</td>
				<td>
					<select name="ACCOUNT_PROVINCE" id="ACCOUNT_PROVINCE">
						<option value="湖南省">湖南省</option>
					</select>
					<select style="width:100px" name="ACCOUNT_CITY"  id="ACCOUNT_CITY">
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
					<font>*</font>
				</td>
				<td align="right">账户户名:</td>
				<td>
					<input type="text" name="ACCOUNT_NAME" id="ACCOUNT_NAME"/>
					<font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">签约扣率(%):</td>
				<td>
					<input type="text" name="CONTRACT_FEE" id="CONTRACT_FEE" onKeyUp="onlyNumberAllow(this)"/>
				<font>*</font>
				</td>
				<td align="right">拓展渠道:</td>
				<td>
					<select name="EC_ID" id="EC_ID">
						<c:forEach items="${allChannel }" var="val" varStatus="vasta">
							<option value="<c:out value="${val.key }"></c:out>"><c:out value="${val.value }"></c:out></option>
						</c:forEach>
					</select>
					<font>*</font>
				</td>
			</tr>
			<!-- 新增 -->
			<tr>
				<td align="right">保底(元):</td>
				<td>
					<input type="text" name="BASE" id="BASE" onKeyUp="onlyNumberAllow(this)"/>
					<font>*</font>
				</td>
				<td align="right">封顶(元):</td>
				<td>
					<input type="text" name="TOP" id="TOP" onKeyUp="onlyNumberAllow(this)"/>
					<font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">收费周期:</td>
				<td>
					<select name="CHARGE_CYCLE" id="CHARGE_CYCLE">
						<option value="1">日结</option>
						<option value="2">月结</option>
					</select>
					<font>*</font>
				</td>
				<td align="right">账户用途:</td>
				<td>
					<select name="trxdir" id="COUNT_DESIRE" class="COUNT_DESIRE" class="notRequired">
				        <option value="1">收款</option>
				        <option value="2">付款</option>
				        <option value="3">收付款</option>
			       </select>
				</td>
			</tr>
			<tr>
				<td align="right">是否默认:</td>
				<td>
					<select name="IS_DEFAULT" id="IS_DEFAULT" class="notRequired">
				         <option value="1">是</option>
				         <option value="2">否</option>
				      </select>
				</td>
				<td align="right">终端月保底(元):</td>
				<td>
					<input type="text" name="TER_MONTH_MIN" id="TER_MONTH_MIN" class="notRequired" onKeyUp="onlyNumberAllow(this)"/>
				</td>
			</tr>
			<tr>
				<td align="right">经营年限：</td>
				<td>
					<select name="OPERATE_LIMIT" id="OPERATE_LIMIT">
						<option value="">--请选择--</option>
					      <option value="20">5年以上</option>
					      <option value="10">1——5年</option>
					      <option value="5">1年以下</option>
					  </select>
					  <font>*</font>
				</td>
				<td align="right">注册资本:</td>
				<td>
					<select name="REGISTER_CAPITAL" id="REGISTER_CAPITAL" style="width:130px;" rate="0.4" >
				      		<option value="">--请选择--</option>
				          <option value="15">1000万以上</option>
				          <option value="12">50——1000万</option>
				          <option value="8">50万以下</option>
				     </select>
				    <font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">经营场所：</td>
				<td>
					<select name="OPERATE_AREA" id="OPERATE_AREA" >
				          <option value="">--请选择--</option>
				          <option value="50">自有产权500㎡以上</option>
				          <option value="45">自有产权500㎡以下</option>
				          <option value="40">租期3年以上</option>
				          <option value="30">租期1-3年</option>
				          <option value="5">租期1年以下</option>
				     </select>
				     <font>*</font>
				</td>
				<td align="right">公司人数:</td>
				<td>
					<select name="STAFFS" id="STAFFS"> 
					   	     <option value="">--请选择--</option>
					          <option value="50">500人以上</option>
					          <option value="30">50-500人</option>
					          <option value="10">50人以下</option>
					   </select>
					   <font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">上市公司：</td>
				<td>
					<select name="MARKET_COMMPANY" id="MARKET_COMMPANY">
				         <option value="">--请选择--</option>
				          <option value="100">上市公司</option>
				          <option value="60">非上市公司</option>
				     </select>
				     <font>*</font>
				</td>
				<td align="right">内部管理::</td>
				<td>
					<select name="INNER_MANAGE" id="INNER_MANAGE"  >
				      <option value="">--请选择--</option>
				          <option value="100">公司管理层本科以上学历(40%以上)</option>
				          <option value="80">公司管理层本科以上学历(25%以上)</option>
				          <option value="60">公司管理层本科以上学历(10%以上)</option>
				     </select>
				     <font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">现场考察：</td>
				<td>
					<select name="INSPACE" id="INSPACE">
					      <option value="">--请选择--</option>
					          <option value="100">好</option>
					          <option value="70">一般</option>
					          <option value="50">差</option>
					 </select>
					 <font>*</font>
				</td>
				<td align="right">业务关系:</td>
				<td>
					<select name="BUS_RELATION" id="BUS_RELATION">
				    	  <option value="">--请选择--</option>
				          <option value="100">直属机构</option>
				          <option value="90">固定业务合作</option>
				          <option value="80">短期业务合作</option>
				          <option value="50">随机客户</option>
				     </select>
				     <font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">授权协议：</td>
				<td>
					<select name="AUTH_ARGENT" id="AUTH_ARGENT">
				          <option value="">--请选择--</option>
				          <option value="100">书面合作协议</option>
				          <option value="80">电子等其他合作签约</option>
				          <option value="50">无合作协议</option>
				     </select>
				     <font>*</font>
				</td>
				<td align="right">行业：（大类）</td>
				<td>
					<select name="BUSS_TYPE_LARGE" id="BUSS_TYPE_LARGE">
					      <option value="">--请选择--</option>
					      <option value="1">保险行业</option>
					      <option value="2">小贷行业</option>
					      <option value="3">分销行业</option>
					      <option value="4">商旅行业</option>
					      <option value="5">汽车行业</option>
					      <option value="6">教育行业</option>
					      <option value="7">房产行业</option>
					      <option value="8">医疗行业</option>
					      <option value="9">物流</option>
					      <option value="10">金融</option>
					      <option value="11">银行</option>
					      <option value="99">其他</option>
					    </select> 
					    <font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">行业：（小类）：</td>
				<td>
					<input class="notRequired" id="BUSS_TYPE_SMALL" name="BUSS_TYPE_SMALL"/>
				</td>
				<td align="right">非标准行业情况说明:</td>
				<td>
					<input class="notRequired" id="NOT_NORM_DESC" name="NOT_NORM_DESC"/>
				</td>
			</tr>
			<tr>
				<td align="right">选择父客户：</td>
				<td>
					<input class="notRequired" id="UP_COMMERCIAL" name="UP_COMMERCIAL"/>
				</td>
				<td align="right">收入所属方：:</td>
				<td>
					<input class="notRequired" id="INCOME_BELONG" name="INCOME_BELONG"/>
				</td>
			</tr>
			<tr>
				 <tr>
			 	<td align="right">备注：</td>
				<td>
					<textarea rows="5" cols="20" id="REMARK_INFO" name="REMARK_INFO"></textarea>
				</td>
			</tr>
			</tr>
			</table>
			<center>
				<tr >
					<td>
					<% 
						//	List<Integer> posts=(List<Integer>)session.getAttribute("posts"); 
						Permission per=new PositionPermessionImpl();
						%>
						<c:if test="${param.show==1 }">
							<button type="button" style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onClick="showLog(${param.appayId})">修改日志</button>
						&nbsp;&nbsp;
							<button style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onClick="showAttachFile(${param.appayId})">附件</button>
							<%if(!per.hasPermission(session, Permission.OPERAT_POSITION)) {%>
								<button type="button" id="modifyBtn" style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onClick="updateData2()">修改</button>
							<%} %>
						</c:if>
						<button type="button" style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onClick="showAppendPage(${param.appayId})">追加备注</button>
						<button type="button" id="submitBtn" style="width:100px;text-align: center; table-layout: fixed;" onClick="beforeSubmit('bussiness101form')">提交</button>
						<button type="button" id="windowBackBtn" onClick="window.location.href='commercialInsert.jsp?show=1&CommercialId=${param.CommercialId}'" name="windowBackBtn" style="width:100px;text-align: center; table-layout: fixed;" >返回</button>
					</td>
				</tr>
			</center>
		</form>
		</div>
		
		<!-- 000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 -->
   	<c:if test="${param.show==1 }">
   		<div  class="left02">
			<div class="left02topDiv">
				<div class="left02top_right"></div>
				<div class="left02top_left"></div>
				<div class="left02top_c"><span id="titleName">业务审批信息</span> </div>
			</div>
		</div>
		<div class="mycss">
		<form action="../action/AppayApprove.jsp" id="bussinessOperationForm" method="post">
			<table>
			<input type="hidden" name="type" value='103' readonly="readonly"/>
			<input type="hidden" name="APPPAY_ID" value='<c:out value="${param.appayId}"></c:out>' readonly="readonly"/>
		<!-- 		
		<tr>
				<td align="right">终端信息1:</td>
				<td>
					<input type="text" name="TERM_ID1" id="TERM_ID1"  />
					
				</td>
				<td align='right'>终端信息2:</td>
				<td>
					<input type="text" name="TERM_ID2" id="TERM_ID2" />
				</td>
			</tr>
			<tr>
				<td align="right">商户号状态:</td>
				<td>
					<input value="1" readonly="readonly" name="STATUS" id="STATUS"/>
				</td>
				
			</tr>
		 -->
			<tr>
				<td align='right'>审批状态:</td>
				<td>
					<select name="APPR_STATUS" id="APPR_STATUS" onChange="
						if(this.value==1){
							$('#aaaaaaaaaaaaaaaaaaa').removeAttr('disabled');
							$('#APPR_REMARK').removeAttr('disabled');
						}else{
							$('#aaaaaaaaaaaaaaaaaaa').attr('disabled','disabled');
							$('#APPR_REMARK').attr('disabled','disabled');
							$('#APPR_REMARK').val('');
						};
					">
						<option value="2" selected="selected">通过</option>
						<option value="1">驳回</option>
					</select>
					<font color=red>*</font>
				</td>
				
				<td align="right">不通过原因:</td>
				<td>
					<select disabled="disabled" onChange="$('#APPR_REMARK').val($('#aaaaaaaaaaaaaaaaaaa').val())" id="aaaaaaaaaaaaaaaaaaa">
						<option>--请选择--</option>
						<option value="资料缺失">资料缺失</option>
						<option value="扣率不符">扣率不符</option>
						<option value="其他">其他</option>
					</select>
					<input id="APPR_REMARK" style="width: 300px" disabled="disabled" name="APPR_REMARK" class="notRequired"/>
				</td>
			</tr>
			<tr>
				<td>历史驳回信息：</td>
				<td>
					<textarea rows="3" cols="40" readonly="readonly" id="historyOperateData">
					</textarea>
				</td>
			</tr>
			</table>
			<center>
				<tr >
					<td>
					<% 
						//List<Integer> posts=(List<Integer>)session.getAttribute("posts"); 
						if(per.hasPermission(session, Permission.OPERAT_POSITION)){
					%>
						<!-- 审批的权限 -->
						<input id="operateBtn"  type="submit"  style="width:100px;text-align: center; table-layout: fixed;" value="完成"/>
					<%} %>
					</td>
				</tr>
			</center>
		</form>
		</div>
  </div>
	</div>
</div>
	<div id="listDiv" class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" style="width: 80%">
				<span>终端信息</span>
			</div>
		</div>
		<div class="left02downDiv">
		<table id='cust_Table' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>联系人</th>
				<th class='dataTableHeader'>电话</th>
				<th class='dataTableHeader'>装机街道</th>
				<th class='dataTableHeader'>客户装机地址</th>
				<th class='dataTableHeader'>状态</th>
				<th class='dataTableHeader'>商户编号</th>
				<th class='dataTableHeader'>终端编号</th>
				<th class='dataTableHeader'>录入时间</th>
				<th class='dataTableHeader'>pos类型</th>
				<th class='dataTableHeader'>操作</th>
				<th class='dataTableHeader'>详情</th>
			</tr>
			<!-- 数据显示区 -->
			<tr id='merDayGain_Templet'>
				<td id="UNIT_INSTALLED_MAN"></td>
				<td id="UNIT_INSTALLED_TEL"></td>
				<td id="UNIT_INSTALLED_STREET"></td>
				<td id="UNIT_INSTALLED_ADD"></td>
				<td id="TEMINAL_STATUS"></td>
				<td id="commercial_id"></td>
				
				<td id="terminal_number"></td>
				<td id="INPUT_DATE"></td>
				<td id="EQUI_TYPE"></td>
				<td id="dosmthing"></td>
				<td id="MORE"></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div>
		</div>
   	</c:if>
</body>
</html>		
