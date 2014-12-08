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
	out.println("<script type=\"text/javascript\">alert('审批成功！')</script>");}
if(null!=info&&info.equals("1")){
	out.println("<script type=\"text/javascript\">alert('操作成功')</script>");
}
if(null!=info&&info.equals("11")){
	out.println("<script type=\"text/javascript\">alert('修改成功')</script>");
}
if(null!=info&&info.equals("10")){
	out.println("<script type=\"text/javascript\">alert('自助终端编号已经存在')</script>");}

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
<script type="text/javascript">
$(init);
function init(){
	$("#TERM_ID1").bind("propertychange input",function(e) {
		var tmp = $("#TERM_ID1").val();
		if(tmp.length>=15){
			var param = {};
			param["TERM_ID1"] = tmp;
			param["ACTION_TYPE"] = "JSONLIST";
			
			$.post("../../v_check_shbh.rp",param,function(j){
				if(j.length>=1){
					alert("商户编码已存在");
				}
			},"JSON");
		}
	});
}

function showLog(id){
	window.open ('../show/log.jsp?type=106&id='+id, 'log', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行
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
var UNIT_AREA;
var appppppppStatus=0;
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
		data:{"APPPAY_ID":<%=request.getParameter("appayId")==null?-1:request.getParameter("appayId")%>,apptype:106},
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
	        		row.find('#'+pro+'').html(object[i][pro]);
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
		        		row.find("#terminal_number").html(ter1);
		        		row.find("#commercial_id").html(ter2);
	        		}else{
	        			var ter1=object[i]["TERM_ID1"];
	        			if(null!=ter1){
	        				ter1=$.trim(ter1);
	        			}else ter1="";
	        			var ter2=object[i]["TERM_ID2"];
	        			if(null!=ter2){
	        				ter2=$.trim(ter2);
	        			}else ter2="";
	        			row.find("#dosmthing").html("<button  disabled='disabeld' name='ajaxSubmitBtn' id='upBtn"+i+"' onclick='bussiness101Operate("+object[i]["TEMINAL_INFO_ID"]+","+i+")'>完成</button>");
		        		row.find("#terminal_number").html("<input maxlength=8 value='"+ter1+"' disabled='disabeld' name='terminal_number' id='terminal_number"+i+"'/>");
		        		row.find("#commercial_id").html("<input maxlength=8   value='"+ter2+"' disabled='disabeld' name='commercial_id' id='commercial_id"+i+"'/>");
	        		}
	        		
	        		//row.find("#terminal_address").html(object[i]["UNIT_INSTALLED_ADD"]);
	        	}
	        	row.find("#MORE").html("<a href='../insert/terminalInsert.jsp?show=1&terminalId="
					+ object[i]["TEMINAL_INFO_ID"] + "'>详情</a>");
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
	$(function(){
		$('#PSAM_NO').attr('disabled','disabled');
		$('#PSAM_NO').val('');
		$('#SERIAL').removeAttr('disabled');
		$('#BILL_INFO').removeAttr('disabled');
		$('#PSAM_NO').attr('class','notRequired');
		$.post("../action/findById/Commercial..jsp",{id:${param.CommercialId}},function(j){
			var jj=$.parseJSON(j);
			$("#unitName").html(jj.UNIT_NAME);
			$("#TERM_ID1").val(jj.UNIT_AREA);
			UNIT_AREA = "821"+jj.UNIT_AREA;
			if ($.trim($("#MC_NAME").val()).length<1) {
				$("#MC_NAME").val(jj.UNIT_NAME);
			}
		});
		//$.address("ACCOUNT_PROVINCE","ACCOUNT_CITY","","湖南","长沙市");
	});

	function updateData3(){
		//$("#bussiness101form input").removeAttr("disabled");
		//$("#bussiness101form select").removeAttr("disabled");
		//$("#bussiness101form textarea").removeAttr("disabled");

		if(appppppppStatus==2)
		{
			$("#ACCOUNT_NO").removeAttr("disabled");
			$("#ACCOUNT_BANK_ID").removeAttr("disabled");
			$("#APPPAY_ID").removeAttr("disabled");
			$("#CONTRACT_FEE").removeAttr("disabled");
			$("#ACCOUNT_PROVINCE").removeAttr("disabled");
			$("#ACCOUNT_CITY").removeAttr("disabled");
			$("#COMMERCIAL_ID").removeAttr("disabled");

			$("#FEE_TYPE").removeAttr("disabled");
			$("#FEE_SET_TOP").removeAttr("disabled");
			$("#FEE_SET").removeAttr("disabled");
			$("#ACCOUNT_NO_CHECK").removeAttr("disabled");
			$("#ACCOUNT_TYPE").removeAttr("disabled");
			$("#ACCOUNT_BANK").removeAttr("disabled");
			$("#ACCOUNT_BANK_NAME").removeAttr("disabled");
			$("#ACCOUNT_NAME").removeAttr("disabled");
			
			
			$("#bussiness102form button").removeAttr("disabled");
		}else if(appppppppStatus<=1){
			$("#bussiness102form input").removeAttr("disabled");
			$("#bussiness102form select").removeAttr("disabled");
			$("#bussiness102form textarea").removeAttr("disabled");
			$("#bussiness102form button").removeAttr("disabled");
		}
	}
	</script>
	 <script type="text/javascript">
		function bussiness101Operate(id,index){
			var APPPAY_ID=<%=request.getParameter("appayId")==null?1:request.getParameter("appayId")%>;
			var TEMINAL_INFO_ID=id;
			var TERM_ID1=$("#commercial_id"+index).val();
			var TERM_ID2=$("#terminal_number"+index).val();
			if(null==TERM_ID1||$.trim(TERM_ID1)==""){
				alert("请输入商户编号！");
				return;
			}
			if(null==TERM_ID2||$.trim(TERM_ID2)==""){
				alert("请输入终端编号！");
				return;
			}
			$.ajax( {
				dataType : 'json',
				//url : '../action/BussinessOperate.jsp',
				url:'../action/ForwardSigletonCommercialNo.jsp',				
				data : {'APP_TYPE':'106','APPPAY_ID':APPPAY_ID,'TEMINAL_INFO_ID':TEMINAL_INFO_ID,'TERM_ID1':TERM_ID1,'TERM_ID2':TERM_ID2},
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
<%
	if(request.getParameter("show")!=null){
		%>
			$(function(){

					$("#bussiness102form input").attr("disabled","disabled");
					$("#bussiness102form select").attr("disabled","disabled");
					$("#bussiness102form textarea").attr("disabled","disabled");
					$("#bussiness102form button[name!='updateData']").attr("disabled","disabled");
					$("#bussiness102form button[id='windowBackBtn']").removeAttr("disabled");

						$.post("../action/findById/Apppay106.jsp",{'id':${param.appayId}},function(json){

							var result=eval("("+json+")");
							//var result=json.resultset[0];
							appppppppStatus=result["APPR_STATUS"];
							if(result["APPR_STATUS"]!=null&&result["APPR_STATUS"]==2){
								$("#operateBtn").attr("disabled","disabled");
								$("#bussiness102OperationForm *").attr("disabled","disabled");
								//$("input:[name!='terminal_number']:[name!='commercial_id']").attr("disabled","disabled");
								$("select").attr("disabled","disabled");
								$("#historyOperateData").removeAttr("disabled");
							}
							else if(result["APPR_STATUS"]>2){
								$("#modifyBtn").remove();//移除修改和提交按钮
								$("#submitBtn").remove();//移除修改和提交按钮
							}
							else {
								$("input[name='terminal_number']").attr("disabled","disabled");
								$("input[name='commercial_id']").attr("disabled","disabled");
							}
							$("input,select,textarea").each(function(){
								var itemId=$(this).attr("id");
								if("APPR_REMARK"==itemId){
									$("#historyOperateData").val($.trim(result[itemId]));
								}else{
									if(result[itemId]!=null)
										$(this).val($.trim(result[itemId]));
							}
							});
							if($("#TERM_ID1").val()==""){
								$("#TERM_ID1").val(UNIT_AREA);
							}
						$("#ACCOUNT_NO_CHECK").val($("#ACCOUNT_NO").val());	
						$("#FEE_TYPE").change();
						//卡限制
						if(appppppppStatus<2)
							$("#CREDIT_FLAG").change();
							//find(0,result["APPR_STATUS"]);
						});
					});
		<%
	}
%>

utils_serializeForm = function(form) {
	var hash = {};
	var serialize = $(form).serializeArray();
	$(serialize).each(function(v, dom) {
		hash[this["name"]] = (this["value"]);
	});
	return hash;
}
function showAppendPage(id){
	window.open ('AppendRemark.jsp?type=106&id='+id, 'showAppend102', 'height=150, width=300, top=40, left=100,menubar=no, scrollbars=0, resizable=0,location=n o, status=no'); //这句要写成一行 
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
			if(id == 0){
				alert("序列号重复");
				return;
			}
			if(id == -1){
				alert("序列号未入库");
				return;
			}
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
function beforeSubmit(form,isFormSubmit) {
	var allow = "";
	$("#" + form + " input[type!='hidden'][class!='notRequired'],#"+form+" select").each(function(index, data) {
		if ($.trim($(this).val()).length<1) {
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
	}else {
		if($.trim($("#ACCOUNT_BANK_ID").val()).length!=12){
			alert("账户支行号为12位！");
			$("#ACCOUNT_BANK_ID").focus();
			return;
		}
		if($("#TERM_TYPE").val() == 1 &&$.trim($("#PSAM_NO").val()).length!=16){
			alert("PSAM号为16位！");
			$("#PSAM_NO").focus();
			return;
		}
		if(isFormSubmit){
			var f=document.getElementById(form);
			f.submit();
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
		utils_submit(form,"../action/Apppay106DataInsert.jsp");
		<%}
		else{
			%>
			utils_submit(form,"../action/Apppay106DataUpdate.jsp");
			<%
		}
		%>
		//form.submit();
	}
}
function beforeSubmit2(form,isFormSubmit) {
	var allow = "";
if($("#APPR_STATUS").val()==2)
	{

	if ($.trim($("#MC_NAME").val()).length<1) {
		alert("门店名称不能为空");
		return false;
	}
		$("#" + form + " input[type!='hidden'][class!='notRequired'],#"+form+" select").each(function(index, data) {
		if($(this).attr("title")!="c1"){
			if ($.trim($(this).val()).length<1) {
				allow = $($(this).parent()).prev().html() + " 未填写！";
				try{
					$(this).focus();
				}catch(e){
				}
				return false;
			}
		}
		return true;
	});
}
	if ("" != allow) {
		alert(allow);
	}else {
		if($.trim($("#ACCOUNT_BANK_ID").val()).length!=12){
			alert("账户支行号为12位！");
			$("#ACCOUNT_BANK_ID").focus();
			return;
		}
		if(isFormSubmit){
			var f=document.getElementById(form);
			f.submit();
			return;
		}
	}
}
function showAttachFile(id){
	window.open ('../insert/attachPhoto.jsp?type=106&id='+id, 'showAttach106', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
}
</script>
<style type="text/css">

font{
color:red;}
</style>
</head>

<body>

<!-- 终端管理 -->
  <div  class="panel-container">
   		<div  class="left02">
			<div class="left02topDiv">
				<div class="left02top_right"></div>
				<div class="left02top_left"></div>
				<div class="left02top_c"  style="width: 1000px"  ><span id="titleName">（自助终端）基本信息---<font color="black" id="unitName"></font></span> </div>
			</div>
		</div>
		<form action="#" method="post"  id="bussiness102form">
			<table>
			<tr>
				<td align="right">业务类型:</td>
				<td>
					<span>自助终端</span>
					<input type="hidden" name="APPTYPE" id="APPTYPE" value="106" readonly/>
					<input type="hidden" name="APPPAY_ID" id="APPPAY_ID" value='<c:out value="${param.appayId}"></c:out>' readonly/>
					<input type="hidden" name="COMMERCIAL_ID" id="COMMERCIAL_ID" value='<c:out value="${param.CommercialId}"></c:out>' readonly/>
				</td>
				<td align='right'>终端类型:</td>
				<td>
					<select name="TERM_TYPE" id="TERM_TYPE" onChange="
					var v=$(this).val();
					if(parseInt(v)==1){
						$('#SERIAL').attr('disabled','disabled');
						$('#BILL_INFO').attr('disabled','disabled');
						$('#PSAM_NO').removeAttr('disabled');
						$('#SERIAL').val('');
						$('#BILL_INFO').val('');
						$('#SERIAL').attr('class','notRequired');
						$('#BILL_INFO').attr('class','notRequired');
					}else{
						$('#PSAM_NO').attr('disabled','disabled');
						$('#PSAM_NO').val('');
						$('#SERIAL').removeAttr('disabled');
						$('#BILL_INFO').removeAttr('disabled');
						$('#PSAM_NO').attr('class','notRequired');
					}">
						<option value="1">政通手机</option>
						<option value="2" selected="selected">通联i付</option>
					</select>
					<font>*</font>
				</td>
			</tr>
			<tr>
				<td align='right'>账户帐号:</td>
				<td>
					<input type="text" name='ACCOUNT_NO' id="ACCOUNT_NO" maxlength="20" onKeyUp="onlyNumberAllow(this)"/>
					<font>*</font>
				</td>
				<% DaoUtils daoUtils=new DaoUtils();
					request.setAttribute("expandUsers", daoUtils.localExpandUser(session,request.getParameter("show")==null));
					request.setAttribute("allChannel", daoUtils.channelInfo());
					request.setAttribute("allBank", daoUtils.bankInfo());
					%>
				<td align='right'>确认账户账号:</td>
				<td>
					<input id="ACCOUNT_NO_CHECK" class="notRequired" onpaste="return false"/>
				</td>
			</tr>
			<tr>
				<td align='right'>账户银行:</td>
				<td>
					<select id="ACCOUNT_BANK" name="ACCOUNT_BANK" >
						<option value="">---请选择---</option>
						<c:forEach items="${allBank }" var="val" varStatus="vasta">
							<option value="<c:out value="${val.key }"></c:out>"><c:out value="${val.value }"></c:out></option>
						</c:forEach>
					</select>
					<font>*</font>
				</td>
				<td align='right'>PSAM卡号:</td>
				<td>
					<input id="PSAM_NO" name="PSAM_NO" maxlength="16"/><font>*</font>
				</td>
			</tr>
			<tr>	
				<td align="right">账户支行号:</td>
				<td>
					<input type="text" name="ACCOUNT_BANK_ID" id="ACCOUNT_BANK_ID" maxlength="12" onKeyUp="onlyNumberAllow(this)"/>
					<font>*</font>
					<a target="_bank" href="https://e.czbank.com/CORPORBANK/query_unionBank_index.jsp">检索行号</a>
				</td>
				<td align="right">账户支行名称:</td>
				<td>
					<input type="text" name="ACCOUNT_BANK_NAME" id="ACCOUNT_BANK_NAME"/>
				<font>*</font>
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
				<td align="right">扣率类型:</td>
				<td>
					<select name="FEE_TYPE" id="FEE_TYPE" style="width:200px" onchange='
						var v=parseInt(this.value);
						switch(v){
							case 1:$("#changeFeeType").html("(元/笔)");
								$("#FEE_SET_TOP").hide();
								$("#FEE_SET_label").hide();
							break;
							case 2:$("#changeFeeType").html("(%)");
								$("#FEE_SET_TOP").hide();
								$("#FEE_SET_label").hide();
								//$("#FEE_SET_TOP").show();
								//$("#FEE_SET_label").show();
							break;
							case 3:
								$("#changeFeeType").html("(%-)");
								$("#FEE_SET_TOP").show();
								$("#FEE_SET_label").show();
							break;
							default:$("#changeFeeType").val("(元/笔)");break;}' >
						<option value="2" >百分比</option>
						<option value="1">固定收费</option>
						<option value="3" selected="selected">百分比-封顶</option>
						<!-- <option value="3">按交易金额比例--->封顶</option> -->
					</select>
					<font>*</font>
				</td>
				<td align="right">费用<p id="changeFeeType">(%-)</p>:</td>
				<td>
					<input type="text" name="FEE_SET" id="FEE_SET" style="width: 100px" onKeyUp="onlyNumberAllow(this)"/>
					<font>*</font>
					<input  class="notRequired" name="FEE_SET_TOP" id="FEE_SET_TOP" style="width: 100px" onKeyUp="onlyNumberAllow(this)"/>
					<label id="FEE_SET_label">封顶</label>
				</td>
			</tr>
			<tr>
				<td align="right">机具序列号:</td>
				<td>
					<input type="text" name="SERIAL" id="SERIAL"  onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" 
					/>
					<font>*</font>
				</td>
				<td align="right">销售金额（元）:</td>
				<td>
					<input type="text" name="BILL_INFO" id="BILL_INFO" onKeyUp="onlyNumberAllow(this)"/>
					<font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">拓展人：</td>
				<td>
					<select name="E_ID" id="E_ID">
						<option value="">--请选择---</option>
						<c:forEach items="${expandUsers}" var="val" varStatus="vasta">
							<option value="<c:out value="${val.key }"></c:out>"><c:out value="${val.value }"></c:out></option>
						</c:forEach>
					</select>
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
            
            
			<tr>
				<td align="right">银行推荐人:</td>
				<td>
					<input type="text" name="EC_NAME" id="EC_NAME" class="notRequired"/>
				</td>
			 	<td align="right">备注：</td>
				<td>
					<textarea rows="5" cols="20" id="REMARK_INFO" name="REMARK_INFO"></textarea>
				</td>
			</tr>
			</table>
			<center>
				<tr >
					<td>
						<%Permission per=new PositionPermessionImpl(); %>
						<c:if test="${param.show==1 }">
							<button type="button" style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onClick="showLog(${param.appayId})">修改日志</button>
						&nbsp;&nbsp;
						<button style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onClick="showAttachFile(${param.appayId})">附件</button>
							<%if(!per.hasPermission(session, Permission.OPERAT_POSITION)){ %>
							
								<button type="button" id="modifyBtn" style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onClick="updateData3()">修改</button>
							<%} %>
						</c:if>
							<button type="button" style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onClick="showAppendPage(${param.appayId})">追加备注</button>
						<button  type="button" id="submitBtn" style="width:100px;text-align: center; table-layout: fixed;" onClick="beforeSubmit('bussiness102form')" >提交</button>
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
		<form action="../action/AppayApprove.jsp" id="bussiness102OperationForm" method="post" >
			<table>
			<tr>
				<td align='right'>清算机构号:</td>
				<td>
				<input type="hidden" name="type" value='106' readonly/>
					<input type="hidden" name="APPPAY_ID" value='<c:out value="${param.appayId}"></c:out>' readonly/>
					<input type="hidden" name="COMMERCIAL_ID" id="COMMERCIAL_ID" value='<c:out value="${param.CommercialId}"></c:out>' readonly/>
					<!-- <input type="text" name="UNIT_NO" id="UNIT_NO"/> -->
					<%DaoUtils u=new DaoUtils();
					request.setAttribute("UNIT_NO", u.qingSuanJiGou());
					%>
					<select name="UNIT_NO" id="UNIT_NO">
						<c:forEach items="${UNIT_NO }" var="vv">
							<option value="${vv.value }">${vv.key }</option>
						</c:forEach>
					</select>
					<font>*</font>
				</td>
			</tr>
			<tr>
				<td align='right'>清算商户号:</td>
				<td>
					<input type="text" name='TERM_ID1' id="TERM_ID1" maxlength="15"/>
					<font>*</font>
				</td>
				<td align='right'>清算终端号:</td>
				<td>
					<input type="text" name='TERM_ID2' id="TERM_ID2" maxlength="8"/>
					<font>*</font>
				</td>
			</tr>
			<tr>	
				<td align="right">卡限制:</td>
				<td>
					<select name="CREDIT_FLAG" id="CREDIT_FLAG" onChange="
					var v=$(this).val();
					if(parseInt(v)==0){
						$('input[mineP=1]').attr('disabled','disabled');
						$('input[mineP=1]').val('');
						$('input[mineP=1]').addClass('notRequired');
					}else{
						$('input[mineP=1]').removeAttr('disabled');
						$('input[mineP=1]').removeClass('notRequired');
					}
					">
						<option value="0"  selected="selected">关</option>
						<option value="1">开</option>
					</select>
					<font>*</font>
				</td>
				<td align="right">信用卡单笔交易限制:</td>
				<td>
					<input type="text" value="0" mineP='1' name="CREDIT_CARD_LIMIT" id="CREDIT_CARD_LIMIT"/> 
					<font>*</font>
				</td>
			</tr>
			
			<tr>
				<td align='right'>信用卡月限额(元):</td>
				<td>
					<input type="text" value="0" mineP='1' name='CREDIT_M_A_LIMIT' id="CREDIT_M_A_LIMIT" onKeyUp="onlyNumberAllow(this)"/>
					<font>*</font>
				</td>
				<td align='right'>信用卡月限次:</td>
				<td>
					<input type="text" value="0" mineP='1' name='CREDIT_M_C_LIMIT' id="CREDIT_M_C_LIMIT" width="150" />
					<font>*</font>
				</td>
			</tr>
			
			<tr>
				<td align='right'>借记卡单笔交易限制(元):</td>
				<td>
					<input type="text" value="0" mineP='1' name='DEBIT_CARD_LIMIT' id="DEBIT_CARD_LIMIT" onKeyUp="onlyNumberAllow(this)"/>
					<font>*</font>
				</td>
				<td align='right'>借记卡月限额(元):</td>
				<td>
					<input type="text" value="0" mineP='1' name='DEBIT_M_A_LIMIT' id="DEBIT_M_A_LIMIT" width="150" onKeyUp="onlyNumberAllow(this)" />
					<font>*</font>
				</td>
			</tr>
            <tr>
            	<td align="right">门店名称:</td>
				<td>
				  <input type="text" name="MC_NAME" title="c1" id="MC_NAME" class=""/><font>*</font>
				</td>
			 	<td align="right">&nbsp;</td>
			  <td>&nbsp;</td>
            </tr>
            <tr>
            	<td align="right">境内银联卡手续费标准:</td>
				<td>
					<input type="text" name="LC_FEE_PRE" title="c1" id="LC_FEE_PRE" style="width:100px;"
                    onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"/>%
				</td>
			 	<td align="right">封顶</td>
				<td>
					<input type="text" name="LC_FEE_TOP" title="c1" id="LC_FEE_TOP" style="width:100px;"
                    onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"/>(元)
				</td>
            </tr>
            <tr>
            	<td align="right">境外银联卡手续费标准:</td>
				<td>
					<input type="text" name="OUT_FEE_PRE" title="c1" id="OUT_FEE_PRE" style="width:100px;"
                    onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"/>%
				</td>
			 	<td align="right">封顶</td>
				<td>
					<input type="text" name="OUT_FEE_TOP" title="c1" id="OUT_FEE_TOP" style="width:100px;"
                    onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"/>(元)
				</td>
            </tr>
            
			<tr>
				<td align='right'>借记卡月限次:</td>
				<td>
					<input type="text" value="0" mineP='1' name='DEBIT_M_C_LIMIT' id="DEBIT_M_C_LIMIT"/>
					<font>*</font>
				</td>
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
						<option value="2" selected="selected" >通过</option>
						<option value="1">驳回</option>
					</select>
					<font>*</font>
				</td>
			</tr>
			<tr>
				<td align='right'>不通过原因:</td>
				<td>
					<select  class="notRequired" disabled="disabled" onChange="$('#APPR_REMARK').val($('#aaaaaaaaaaaaaaaaaaa').val())" id="aaaaaaaaaaaaaaaaaaa">
						<option>--请选择--</option>
						<option value="资料缺失">资料缺失</option>
						<option value="扣率不符">扣率不符</option>
						<option value="其他">其他</option>
					</select>
					<input name="APPR_REMARK"  style="width: 300px" id="APPR_REMARK" disabled="disabled" class="notRequired"/>
				</td>
				<td>
					<input type="hidden" name='STATUS' id="STATUS" width="150"  value="1" readonly/>
				</td>
			</tr>
			<tr>
			<td>历史驳回信息：</td>
				<td>
					<textarea rows="3" cols="40" readonly id="historyOperateData">
					</textarea>
				</td>
			
			</tr>
			</table>
			<center>
				<tr >
					<td>
						<% 
						//	List<Integer> posts=(List<Integer>)session.getAttribute("posts"); 
							if(per.hasPermission(session, Permission.OPERAT_POSITION)){
						%>
							<!-- 审批的权限 -->
							<button type="button" id='operateBtn' onClick="beforeSubmit2('bussiness102OperationForm',true)"  style="width:100px;text-align: center; table-layout: fixed;">完成</button>
						<%} %>
					</td>
				</tr>
			</center>
		</form>
		</div>
  </div>
	</div>
</div>
 
 </c:if>
</body>
</html>		
