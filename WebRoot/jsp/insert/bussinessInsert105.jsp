<%@page import="com.szzt.util.CommercialNoUtils"%>
<%@page import="com.szzt.dao.DaoUtils"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="../../import.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<%

String info=request.getParameter("info");
if(null!=info&&info.equals("1")){
	out.println("<script type=\"text/javascript\">alert('操作成功')</script>");
}
if(null!=info&&info.equals("11")){
	out.println("<script type=\"text/javascript\">alert('修改成功')</script>");
}
if(null!=info&&info.equals("10")){
	out.println("<script type=\"text/javascript\">alert('修改失败')</script>");}
if(null!=info&&info.equals("c0")){
	out.println("<script type=\"text/javascript\">alert('商户号重复！')</script>");}
if(null!=info&&info.equals("s1")){
	out.println("<script type=\"text/javascript\">alert('审批成功，请审批终端！')</script>");}

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
<script type="text/javascript" src="../../js/WdatePicker.js"></script>  
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

var appStatus,UNIT_NO;

var commercialNoLength=-1;//商户长度
var terminalNoLength=-1;//终端长度
var forceStep=false;
var appppppppStatus=0;
function showAppendPage(id){
	window.open ('AppendRemark.jsp?type=105&id='+id, 'showAppend102', 'height=150, width=300, top=40, left=100,menubar=no, scrollbars=0, resizable=0,location=n o, status=no'); //这句要写成一行 
}
function updateData3(){
	if(appppppppStatus==2)
	{
		$("#account_type").removeAttr("disabled");
		$("#account_bank").removeAttr("disabled");
		$("#account_no").removeAttr("disabled");
		$("#account_bank_id").removeAttr("disabled");
		$("#apppay_id").removeAttr("disabled");
		$("#contract_fee").removeAttr("disabled");
		$("#FEE_SET_TOP").removeAttr("disabled");
		$("#account_province").removeAttr("disabled");
		$("#account_city").removeAttr("disabled");
		$("#commercial_id").removeAttr("disabled");
		$("#ACCOUNT_NO_CHECK").removeAttr("disabled");
		$("#contract_type").removeAttr("disabled");
		$("#account_bank_brach").removeAttr("disabled");
		$("#account_name").removeAttr("disabled");
		
		$("#bussiness105form button").removeAttr("disabled");
		
	}else if(appppppppStatus<=1 || appppppppStatus>=5){
		$("#bussiness105form input").removeAttr("disabled");
		$("#bussiness105form select").removeAttr("disabled");
		$("#bussiness105form textarea").removeAttr("disabled");
		$("#bussiness105form button").removeAttr("disabled");
	}
}

function showAreaID(city,street) {
    var areaID = street;
    try{
    	var areaName = getAreaNamebyID(areaID) ;
    	 return areaName;
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


<%
if(request.getParameter("show")!=null){
%>
$(function(){
		//var biglistDiv = document.getElementById("biglistDiv");
		//biglistDiv.style.display = "none";
		$("#biglistDiv").hide();
		$("#bussiness105form input").attr("disabled","disabled");
		$("#bussiness105form select").attr("disabled","disabled");
		$("#bussiness105form textarea").attr("disabled","disabled");
		$("#bussiness105form button[name!='updateData']").attr("disabled","disabled");
		$("#bussiness105form button[id='windowBackBtn']").removeAttr("disabled");
		$.ajax( {
			dataType : 'json',
			url : "../action/findById/Apppay105.jsp",
			data : {'id':${param.appayId}},
			type : 'post',
			success : function(json, textStatus) {
				//var result=json.Apppay_105[0];
				var result=json;
				//alert(result["UNIT_NO"]);
				appppppppStatus=result.appr_status;
				//对于已经审批的信息，还可以再次审批
				if(result.appr_status!=null&&result.appr_status==2){
					//$("#operateBtn").attr("disabled","disabled");
					//$("#bussiness105OperationForm input").attr("disabled","disabled");
					//$("select").attr("disabled","disabled");
					//$("#historyOperateData").removeAttr("disabled");
					//$("#zhenggai").show();
					//$("#zhenggai").removeAttr("disabled");
				}
				else if(result.appr_status>2 && result.appr_status<5){
					$("#modifyBtn").remove();//移除修改和提交按钮
					$("#submitBtn").remove();//移除修改和提交按钮
				}
				else {
					$("input[name='terminal_number']").attr("disabled","disabled");
					$("input[name='commercial_id']").attr("disabled","disabled");
				}
		       	for(var pro in result) {
					if("appr_remark"==pro){
						$("#historyOperateData").val($.trim(result[pro]));
					}else 
						$("#"+pro).val($.trim(result[pro]));
	        	}
		       	setApproveRegular(result["UNIT_NO"]);
		       	$("#ACCOUNT_NO_CHECK").val($("#account_no").val());	
		       	$("#contract_type").change();
		      
		       	$("#appr_status").change();
		     	$("#credit_flag").val(result.credit_flag);
		     	//卡限制
		       	if(appppppppStatus<2 || appppppppStatus >=5)
		       		$("#credit_flag").change();
				//客户基本信息查询完毕后开始查询终端信息。。。
				appStatus=result["appr_status"];
				UNIT_NO=result["UNIT_NO"];
				find(0);
			},
			error : function(d) {
				alert("操作失败！"+d);
				window.location.reload();
			}
			
		});

		});
<%}%>
var com_area="";
$(function(){
	$.post("../action/findById/Commercial..jsp",{id:${param.CommercialId}},function(j){
		var jj=$.parseJSON(j);
		$("#unitName").html(jj.UNIT_NAME);
		com_area=jj["UNIT_AREA"];
		<%
		if(request.getParameter("show")==null){
		%>
		//alert(jj.UNIT_NAME);
			$("#MARCHANT_NAME").val(jj.UNIT_NAME);
		<%
		}
		%>
	});
});

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
		success : function(id, textStatus) {
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
			alert("操作失败！"+d);
			window.location.reload();
		}
	});
}
function beforeSubmit(form,isFormSubmit) {
	var allow = "";
	$("#" + form + " input[type!='hidden'][class!='notRequired'],#"+form+" select").each(function(index, data) {
		if ($.trim($(this).val()).length<1) {
			allow = false;
			allow = $($(this).parent()).prev().html() + " 未填写！";
			//$(this).focus();
			return false;
		}
		return true;
	});
	if ("" != allow) {
		alert(allow);
	} else {
		if($.trim($("#account_bank_id").val()).length!=12){
			alert("账户支行号为12位！");
			$("#account_bank_id").focus();
			return;
		}
		<%if(request.getParameter("show")==null){%>
			if($("#fee_chan").val()==3){
				alert("百日竞赛暂时无法提交,请选择其他交易渠道!");
				return;
			}
		<%}%>
		if(isFormSubmit){
			if($.trim($("#commercialNoTemp").val()).length!=15){
				alert("商户编号为15位！");
				//$("#commercialNoTemp").focus();
				return;
				}
			var f=document.getElementById(form);
			f.submit();
			return;
		}
		if($("#ACCOUNT_NO_CHECK").val()!=$("#account_no").val()){
			alert("两次输入的账户账号不一致!");
			$("#ACCOUNT_NO_CHECK").focus();
			return;
		}
		var form = document.getElementById(form);
		<%if(request.getParameter("show")==null){
		%>
		utils_submit(form,"../action/Apppay_105Insert.jsp");
		<%}
		else{
			%>
			utils_submit(form,"../action/Apppay_105Update.jsp");
			<%
		}
		%>
		//form.submit();
	}
}
function beforeSubmit2(form,isFormSubmit) {
	var allow = "";
	if($("#appr_status").val()==2)
	$("#" + form + " input[type!='hidden'][class!='notRequired'],#"+form+" select").each(function(index, data) {
		if($(this).attr("title")!="c1"){
			if ($.trim($(this).val()).length<1) {
				
				allow = false;
				allow = $($(this).parent()).prev().html() + " 未填写！";
				$(this).focus();
				return false;
				
			}
		}
		return true;
	});
	if ("" != allow) {
		alert(allow);
	} else {

		if(isFormSubmit){
			if($("#appr_status").val()==2&&$.trim($("#commercialNoTemp").val()).length!=15){
				$("#commercialNoTemp").focus();
				return;
				}
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
		utils_submit(form,"../action/Apppay_105Insert.jsp");
		<%}
		else{
			%>
			utils_submit(form,"../action/Apppay_105Update.jsp");
			<%
		}
		%>
		//form.submit();
	}
}
function showAttachFile(id){
	window.open ('../insert/attachPhoto.jsp?type=105&id='+id, 'showAttach105', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
}

function showLog(id){
	window.open ('../show/log.jsp?type=105&id='+id, 'log', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行
}
//审批终端
function bussiness105Operate(id,index){
	var APPPAY_ID=<%=request.getParameter("appayId")==null?1:request.getParameter("appayId")%>;
	var TEMINAL_INFO_ID=id;
	var TERM_ID1=$("#commercial_id"+index).val();
	var TERM_ID2=$("#terminal_number"+index).val();
	var TERM_ID3=$("#TERM_ID3"+index).val();
	var TERM_ID4=$("#TERM_ID4"+index).val();
	
	// commercialNoLength=-1;//商户长度
	 //terminalNoLength=-1;//终端长度
	 if(-1!=commercialNoLength){
		if(null==TERM_ID1||$.trim(TERM_ID1).length!=commercialNoLength){
			alert("商户号长度为："+commercialNoLength+",当前长度:"+TERM_ID1.length);
			$("#commercial_id"+index).focus();
			return;
		}
	 }
	 if(-1!=terminalNoLength){
		 if(null==TERM_ID2||$.trim(TERM_ID2).length!=terminalNoLength){
				alert("终端号长度为："+terminalNoLength+",当前长度:"+TERM_ID2.length);
				$("#terminal_number"+index).focus();
				return;
			}
	 }
	
	$.ajax( {
		dataType : 'json',
		//url : '../action/BussinessOperate.jsp',
		url:'../action/ForwardSigletonCommercialNo.jsp',
		data : {'APP_TYPE':'105','is105':true,'APPPAY_ID':APPPAY_ID,'TEMINAL_INFO_ID':TEMINAL_INFO_ID,'TERM_ID1':TERM_ID1,'TERM_ID2':TERM_ID2,"TERM_ID3":TERM_ID3,"TERM_ID4":TERM_ID4,"COMMERCIAL_ID":${param.CommercialId}},
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
				$("#TERM_ID3"+index).attr("disabled","disabled");
				$("#TERM_ID4"+index).attr("disabled","disabled");
				$("#upBtn"+index).attr("disabled","disabled");	
			}
		},
		error : function(d) {
			alert("操作失败！");
			window.location.reload();
		}
	});
}
function autoAssociate(v){
	var v=$.trim($(v).val());
	if(v.length>7){
		$("#mcc").val(v.substring(7,11));
		$("#mcc18").val(v.substring(7,11));
	}
	if(v.length==15){
		$.post("../action/SigletonCommercialNo.jsp",{no:v},function(json){
			if(json==-1){
				alert("商户编号已经存在！");
				$("#operateBtn").attr("disabled","disabled");
			}else{
				$("#operateBtn").removeAttr("disabled");
			}
		});
	}
}

function find(cur_page){
	cur_page = cur_page || 0;
	//var row = $('#merDayGain_Templet').clone(true);
	$("#cur_page").val(cur_page+1);
	var page_size = $("#page_size").val();
	$.ajax({
		url:'../action/TerminalAndTempQuery.jsp',
		dataType:'json',
		type:'POST',
		data:{"APPPAY_ID":<%=request.getParameter("appayId")==null?-1:request.getParameter("appayId")%>,'cur_page':cur_page+1,apptype:105},
		success: function(json){
			var object = json.resultset;
	        $('#merDayGain_Templet2').nextAll().remove();
	        if (json.total==0){
	        	$('#cust_Table2').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
	        }
	        var i=0;
	        for(i=(json.rows-1);i>=0;i--){
	        	var row = $('#merDayGain_Templet2').clone(true);
	        	if(object[i]["TERM_ID1"]!=null&&$.trim(object[i]["TERM_ID1"]).length>0){
	        			$("#commercialNoTemp").val($.trim(object[i]["TERM_ID1"]));
	        			$("[name='commercial_id']").val($.trim(object[i]["TERM_ID1"]));
        	 		}
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
	        		}
	        		else if(pro=="TEMINAL_STATUS"){
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
	        			case 15:vvv="整改";break;
	        			}
	        			if(row.find('#'+pro+'')!=null)
	        			row.find('#'+pro+'').html(vvv);

					}else 
	        		row.find('#'+pro+'').html(object[i][pro]);

	        		if(object[i]["TEMINAL_STATUS"]==15)//整改
	        		{
	        			var ter1=object[i]["TERM_ID1"];
	        			if(null!=ter1){
	        				ter1=$.trim(ter1);
	        			}else ter1="";
	        			var ter2=object[i]["TERM_ID2"];
	        			if(null!=ter2){
	        				ter2=$.trim(ter2);
	        			}else ter2="";
	        			row.find("#dosmthing").html("整改");
		        		row.find("#terminal_number").html(ter2);
		        		row.find("#commercial_id").html(ter1);
	        		}else if(object[i]["TEMINAL_STATUS"]>=3)//审批通过
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
	        			var ter3=object[i]["TERM_ID3"];
	        			if(null!=ter3){
	        				ter3=$.trim(ter3);
	        			}else ter3="";
	        			var ter4=object[i]["TERM_ID4"];
	        			if(null!=ter4){
	        				ter4=$.trim(ter4);
	        			}else ter4="";
	        			row.find("#dosmthing").html("<button disabled='disabeld' name='ajaxSubmitBtn' id='upBtn"+i+"' onclick='bussiness105Operate("+object[i]["TEMINAL_INFO_ID"]+","+i+")'>完成</button>");
		        		row.find("#terminal_number").html("<input onkeyup=forceStepFuction('TERM_ID4"+i+"',this) style='width:130px;' value='"+ter2+"' disabled='disabeld' name='terminal_number' id='terminal_number"+i+"'/>");
		        		row.find("#commercial_id").html("<input onkeyup=forceStepFuction('TERM_ID3"+i+"',this) style='width:130px;' value='"+ter1+"' disabled='disabeld' name='commercial_id' id='commercial_id"+i+"'/>");
		        		row.find("#TERM_ID3").html("<input style='width:130px;' value='"+ter3+"' disabled='disabled' name='TERM_ID3' id='TERM_ID3"+i+"'/>");
		        		row.find("#TERM_ID4").html("<input style='width:130px;' value='"+ter4+"' disabled='disabled' name='TERM_ID4' id='TERM_ID4"+i+"'/>");
	        		}
					
	        		$("#TERM_ID3"+i).val($("#commercial_id"+i).val());
	        		//row.find("#terminal_address").html(object[i]["UNIT_INSTALLED_ADD"]);
	        	}
	        	row.find("#MORE").html("<a href='../insert/terminalInsert.jsp?show=1&terminalId="
					+ object[i]["TEMINAL_INFO_ID"] + "&CommercialId=${param.CommercialId}'>详情</a>");
		        row.show();
		        row.insertAfter('#merDayGain_Templet2');
		        if(object[i]["TEMINAL_STATUS"]!=15){
	        		 if($("#commercialNoTemp").val()!=null)
	    				$("[name='commercial_id']").val($("#commercialNoTemp").val());
			        if(forceStep){
			        	//$("[name='commercial_id']").removeAttr("disabled");
			        	$("[name='TERM_ID3']").val($("#commercialNoTemp").val());
			        	
			        	//-------新。。。。。。
			        	var v=$("[name='commercial_id']").val();
			        	if(v){
			        		var len=v.length;
			        		$("[name='terminal_number']").attr("maxlength","8");
			        		$("[name='terminal_number']").val(v.substr(len-4));
			        	}
			        	
			        }else{
			        	$("[name='commercial_id']").val("");
			        }
		        }
		     
	        };
	        if($("#fee_chan").val()=="2" || $("#fee_chan").val()=="3"||$("#fee_chan").val()=="5"){
	        	$(".c100").hide();
				$(".c101").show();
				
	        }else{
				$(".c100").show();
				$(".c101").hide();
				
			}
	        if(appStatus==2)
    		{
    			$("button[name='ajaxSubmitBtn']").removeAttr("disabled");	
    			$("input[name='terminal_number']").removeAttr("disabled");	
    			//	$("input:[name='commercial_id']").removeAttr("disabled");	
    			if(UNIT_NO>2)
    			{
    				$("input[name='TERM_ID3']").removeAttr("disabled");	
    				$("input[name='TERM_ID4']").removeAttr("disabled");
    				$("input[name='commercial_id']").attr("disabled","disabled");
    				$("input[name='terminal_number']").attr("maxlength","16");
    				terminalNoLength=16;//终端号为16位
    			}
    		}
	        $('#cust_Table2').mygrid();
	    	$('#cust_Pagination2').pagination(json.total, {
	    		current_page : cur_page,
	    		prev_text : '前一页',
	    		next_text : '后一页',
	    		callback : find
	    	});
	    	$('#cust_Searchresult2').text(
	    			'当前显示 ' + ((cur_page * 20) + 1) + '-'
	    					+ ((cur_page * 20) + json.rows) + ' 条记录,共 '
	    					+ json.total + ' 条记录');
    	},  
	    error: function(XmlHttpRequest, textStatus, errorThrown){  
	        alert( "error");  
	    }
	 }); 
}
function forceStepFuction(v,t){
	if(forceStep)
		$("#"+v).val($(t).val());
}
/**
 * 设置商户与清号规则
 */
function setApproveRegular(key){
	var k=parseInt(key);
	switch(k){
	case 1:
	case 2:
		commercialNoLength=15;
		terminalNoLength=8;
		forceStep=true;
		break;
	case 3:
	case 4:
		forceStep=false;
		//商户编号不填，终端编号（填16位）,同时可填清算商户编号和清算终端编号
		terminalNoLength=16;
		break;
	}
}
function zhengGai(){
	if(confirm("确认整改？")){
		window.location.href="../action/ZhengGai.jsp?id=${param.appayId}&commercial=${param.CommercialId}";
	}
}
</script>
<style type="text/css">
font{
color:red;
}
</style>
</head>

<body>

<!-- 终端管理 -->
  <div  class="panel-container">
   		<div  class="left02">
			<div class="left02topDiv">
				<div class="left02top_right" ></div>
				<div class="left02top_left"></div>
				<div class="left02top_c" style="width: 1000px"><span id="titleName">（收单）基本信息---客户单位名称:<font color="black" id="unitName"></font> </span> </div>
			</div>
		</div>
		<div class="mycss">
		<form action="#" method="post"  id="bussiness105form">
			<table>
			<tr>
				<td align="right">业务类型:</td>
				<td>
					<span>收单</span>
					<input type="hidden" name="apptype" id="apptype" value="105" readonly/>
					<input type="hidden" name="apppay_id" id="apppay_id" value='<c:out value="${param.appayId}"></c:out>' readonly/>
					<input type="hidden" name="cId" id="cId" value='${param.CommercialId }' readonly/>
				</td>
				<td align='right'>账户类型:</td>
				<td>
					<select name="account_type" id="account_type">
						<option value="2" >存折</option>
						<option value="1" selected="selected">银行卡</option>
					</select>
					<font>*</font>
				</td>
			</tr>
			<tr>
				<td align='right'>账户帐号:</td>
				<td>
					<input type="text" name='account_no' id="account_no" onkeyup="onlyNumberAllow(this)"/>
					<font>*</font>
				</td>
				<% DaoUtils daoUtils=new DaoUtils();
					request.setAttribute("expandUsers", daoUtils.localExpandUser(session,request.getParameter("show")==null));
					request.setAttribute("allChannel", daoUtils.channelInfo());
					request.setAttribute("allBank", daoUtils.bankInfo());
					%>
					
				<td align='right'>确认账户账号:</td>
				<td>
					<input id="ACCOUNT_NO_CHECK" onpaste="return false">
					<font>*</font>
				</td>
				
			</tr>
			<tr>
				<td align='right'>账户银行:</td>
				<td>
					<select id="account_bank" name="account_bank">
					<option value=''>请选择</option>
						<c:forEach items="${allBank }" var="val" varStatus="vasta">
							<option value="<c:out value="${val.key }"></c:out>"><c:out value="${val.value }"></c:out></option>
						</c:forEach>
					</select>
					<font>*</font>
				</td>
				<td align='right'>门店名称:</td>
				<td>
					<input type="text" name="MARCHANT_NAME" id="MARCHANT_NAME"/>
					<font>*</font>
				</td>
			</tr>
			<tr>	
				<td align="right">账户支行名:</td>
				<td>
					<input type="text" name="account_bank_brach" id="account_bank_brach"/>
					<font>*</font>
				</td>
				<td align="right">账户支行号:</td>
				<td>
					<input type="text" name="account_bank_id" id="account_bank_id" maxlength="12" onkeyup="onlyNumberAllow(this)"/>
					<font>*</font>
					<a target="_bank" href="https://e.czbank.com/CORPORBANK/query_unionBank_index.jsp">检索行号</a>
				</td>

			</tr>
			<tr>
				<td align="right">账户所在省：</td>
				<td>
					<select name="account_province" id="account_province">
						<option value="湖南省">湖南省</option>
					</select>
					<select style="width:100px" name="account_city"  id="account_city">
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
					<input type="text" name="account_name" id="account_name"/>
					<font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">扣率类型:</td>
				<td>
					<select name="contract_type" id="contract_type" style="width:200px" onchange='
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
							case 3:$("#changeFeeType").html("(%-)");
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
					<input type="text" name="contract_fee" id="contract_fee" style="width: 100px" onkeyup="onlyNumberAllow(this)"/>
					<font>*</font>
					<input  class="notRequired" name="FEE_SET_TOP" id="FEE_SET_TOP" style="width: 100px" onkeyup="onlyNumberAllow(this)"/>
					<label id="FEE_SET_label">封顶</label>
				</td>
			</tr>
			<tr>
				<td align="right">推荐支行:</td>
				<td>
					<input type="text" name="ec_branch" id="ec_branch" class="notRequired"/>
				</td>
				
				<td align="right">推荐人员:</td>
				<td>
					<input type="text" name="ec_branch_name" id="ec_branch_name" class="notRequired"/>
				</td>
			</tr>
			<tr>
			 	<td align="right">拓展渠道:</td>
				<td>
					<select name="ec_id" id="ec_id">
						<c:forEach items="${allChannel }" var="val" varStatus="vasta">
							<option value="<c:out value="${val.key }"></c:out>"><c:out value="${val.value }"></c:out></option>
						</c:forEach>
					</select>
					<font>*</font>
				</td>
				<td align="right">拓展人：</td>
				<td>
					<select name="e_id" id="e_id">
						<option value="">---请选择----</option>
						<c:forEach items="${expandUsers}" var="val" varStatus="vasta">
							<option value="<c:out value="${val.key }"></c:out>"><c:out value="${val.value }"></c:out></option>
						</c:forEach>
					</select>
					<font>*</font>
				</td>
			 <tr>
				 <td align='right'>交易渠道:</td>
				<td>
					<select name='fee_chan' id="fee_chan" style='width: 120px'  label='请输入交易渠道' >
						<option value="" selected="selected">--请选择---</option>
						<option value="1" >自主直联</option>
						<option value="2">自主间联</option> 
						<option value="3">百日竞赛(自主间联)</option>
						<option value="4">电子渠道</option>
						<option value="5">策略营销(自主间联)</option>
						<option value="6">本地渠道</option>
					</select>
					<font>*</font>
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
					<%		Permission per=new PositionPermessionImpl(); %>
						<c:if test="${param.show==1 }">
						<button type="button" style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onclick="showLog(${param.appayId})">修改日志</button>
						&nbsp;&nbsp;
						<button type="button" style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onclick="showAttachFile(${param.appayId})">附件</button>
							<%if(!per.hasPermission(session, Permission.OPERAT_POSITION)){ %>
							<button type="button" id="modifyBtn" style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onclick="updateData3()">修改</button>
							<%} %>
						</c:if>
						<button type="button" style="width:100px;text-align: center; table-layout: fixed;" name="updateData" onclick="showAppendPage(${param.appayId})">追加备注</button>
						<button type="button" id="submitBtn" style="width:100px;text-align: center; table-layout: fixed;" onclick="beforeSubmit('bussiness105form')">提交</button>
						<button type="button" id="windowBackBtn" onclick="window.location.href='commercialInsert.jsp?show=1&CommercialId=${param.CommercialId}'" name="windowBackBtn" style="width:100px;text-align: center; table-layout: fixed;" >返回</button>
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
		<form action="../action/AppayApprove.jsp" id="bussiness105OperationForm" method="post" >
			<table>
				<input type="hidden" name="type" value='105' readonly/>
				<%
				Operman_info man = (Operman_info) session.getAttribute("man");
				%>
				<input type="hidden" name="appr_man" value='<%=man.getOperman_id() %>' readonly/>
				<input type="hidden" name="appr_date" value='<%=UtilTime.getOtherFormat2String("yyyy-MM-dd",new java.util.Date()) %>' readonly/>
				<input type="hidden" name="apppay_id" value='<c:out value="${param.appayId}"></c:out>' readonly/>
			<input type="hidden" name="type" value='105' readonly/>
			<tr>
				<td align='right'>清算机构:</td>
				<td>
					<!-- <input type="text" name="UNIT_NO" id="UNIT_NO"/> -->
					<%DaoUtils u=new DaoUtils();
					request.setAttribute("UNIT_NO", u.qingSuanJiGou());
					%>
					<select name="UNIT_NO" id="UNIT_NO" onchange="
						switch($(this).find('[selected=selected]').text()){
							case '银联清算':
							case '总部清算':
								commercialNoLength=15;
								terminalNoLength=8;
								forceStep=true;
								$('#commercialNoTemp').val('821'+com_area);
								$('[name=commercial_id],[name=terminal_number]').attr('disabled','disabled');
								break;
							case '本地清算':
							case '多渠道清算':
								forceStep=false;
								//商户编号不填，终端编号（填16位）,同时可填清算商户编号和清算终端编号
								terminalNoLength=16;
								break;
						}
					">
						<option value="">---请选择---</option>
						<c:forEach items="${UNIT_NO }" var="vv">
							<option value="${vv.value }">${vv.key }</option>
						</c:forEach>
					</select>
					<font>*</font>
				</td>
				<td align='right'>商户编号:</td>
				<td>
					<%CommercialNoUtils cu=new CommercialNoUtils();
					%>
					<input type="text" onkeyup="autoAssociate(this)" onpaste="return false"  name='commercialNoTemp' maxlength="15" id="commercialNoTemp" value="<%=cu.load(Integer.parseInt(request.getParameter("appayId")), session)%>"/>
					<font>*</font>
				</td>
			</tr>
			<!-- 
			<tr>
				<td align='right'>清算商户号:</td>
				<td>
					<input type="text" name='TERM_ID1' id="TERM_ID1"/>
				</td>
				<td align='right'>清算终端号:</td>
				<td>
					<input type="text" name='TERM_ID2' id="TERM_ID2"/>
				</td>
			</tr>
			<tr>				
				<td align='right'>商户号:</td>
				<td>
					<input type="text" name='TERM_ID1' id="TERM_ID1"/>
				</td>
				<td align='right'>终端号:</td>
				<td>
					<input type="text" name='TERM_ID2' id="TERM_ID2"/>
				</td>
			</tr>
			 -->
			<tr>				
				<td align='right'>MCC:</td>
				<td>
					<input type='text' name='mcc' id="mcc" style='width: 120px'	require="true"  label='请输入mcc' />
				<font>*</font>
				</td>
				<td align='right'>MCC18域:</td>
				<td>
					<input type='text' name='mcc18' id="mcc18" style='width: 120px' require="true"  label='请输入mcc18' />
				<font>*</font>
				</td>	
			</tr>
			<tr>	
				<td align="right">卡限制:</td>
				<td>
					<select name="credit_flag" id="credit_flag" onchange="
					var v=$(this).val();
					if(parseInt(v)==0){
						$('input[mineP=1]').attr('disabled','disabled');
						$('input[mineP=1]').val('0');
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
					<input  mineP='1' value="0" type="text" name="credit_card_limit" id="credit_card_limit"/> 
				<font>*</font>
				</td>
			</tr>
			
			<tr>
				<td align='right'>信用卡月限额(元):</td>
				<td>
					<input  mineP='1' value="0"  type="text" name='credit_m_a_limit' id="credit_m_a_limit" onkeyup="onlyNumberAllow(this)"/>
				<font>*</font>
				</td>
				<td align='right'>信用卡月限次:</td>
				<td>
					<input  mineP='1' value="0"   type="text" name='credit_m_c_limit' id="credit_m_c_limit" width="150" />
				<font>*</font>
				</td>
			</tr>
			
			<tr>
				<td align='right'>借记卡单笔交易限制(元):</td>
				<td>
					<input type="text" value="0"  mineP='1'   name='debit_card_limit' id="debit_card_limit" onkeyup="onlyNumberAllow(this)"/>
				<font>*</font>
				</td>
				<td align='right'>借记卡月限额(元):</td>
				<td>
					<input type="text" mineP='1'  value="0" name='debit_m_a_limit' id="debit_m_a_limit" width="150" onkeyup="onlyNumberAllow(this)" />
				<font>*</font>
				</td>
			</tr>
			<tr>
				<td align='right'>借记卡月限次:</td>
				<td>
					<input type="text" mineP='1' value="0"   name='debit_m_c_limit' id="debit_m_c_limit"/>
				<font>*</font>
				</td>
				
			</tr>
			<tr id='shenpimerchantDiv2'>
				<td align='right'>特殊计费类型内容：</td>
				<td ><select id="fee_content" name="fee_content" style='width: 120px'  label='请选择特殊计费类型内容'>
						<option value="00" selected="selected">无特殊计费类型</option>
						<option value="03" >固定比列</option>
						<option value="04" >县乡优惠</option>
					</select>	 
					<font>*</font>
				</td>
				<td align='right'>特殊计费类型档次：</td>
				<td ><select name="fee_lev" id="fee_lev" style='width: 120px'  label='请选择特殊计费类型档次'>
						<option value="0" selected="selected">普通商户</option>
						<option value="1" >三农商户</option>
					</select>	
					<font>*</font> 
				</td>
		</tr>		
		<tr id='shenpimerchantDiv' class="c100">
			<td align='right'>商户组别:</td>
			<td ><select id="marchanttype" title="c1" name="marchanttype" style='width: 120px'  label='请选择商户组别'>
					<option value="00" selected="selected">综合零售</option>
					<option value="01" >专门零售</option>
					<option value="02" >批发类</option>
					<option value="03" >住宅餐饮</option>
					<option value="04" >房地产业</option>
					<option value="05" >房地产业</option>
					<option value="06" >金融业</option>
					<option value="07" >政府服务</option>
					<option value="08" >教育</option>
					<option value="09" >卫生</option>
					<option value="10" >公共事业</option>
					<option value="11" >居民服务</option>
					<option value="12" >商业服务</option>
					<option value="13" >交通物流</option>
					<option value="14" >直销类商户</option>
					<option value="15" >租赁服务</option>
					<option value="16" >维修服务</option>
					<option value="17" >其他</option>
				</select>	 
				<font>*</font>
			</td>
			<td align='right'>分润算法:</td>
			<td ><select name="lq_rule" title="c1" id="lq_rule" style='width: 90%' require="true"  label='请选择分润算法'>
				<option value=""  selected="selected">请选择</option>
					<%
					Commercial_LqRuleDao commercial_LqRuleDao = new Commercial_LqRuleDao();
					commercial_LqRuleDao.setPageSize(100);
					Commercial_LqRule[] commercial_LqRules = commercial_LqRuleDao.select();
					for(int i=0;i<commercial_LqRuleDao.totalCount;i++){
						out.println("<option value='"+commercial_LqRules[i].getLqRuleId()+"' >"+commercial_LqRules[i].getLqRuleName()+"</option>");
					}
					%>
				</select>
				<font>*</font>
			</td>
		</tr> 
		<tr class="c100"> 
			<td align='right'>NK001-全国南卡北用决定索引:</td>
			<td ><select name="fee_rule1" title="c1" id="fee_rule1" style='width: 90%' require="true"  label='请选择全国南卡北用决定索引'>
				<option value=""  selected="selected">请选择</option>
					<%
					Commercial_FeeRuleDao commercial_FeeRuleDao = new Commercial_FeeRuleDao();
					commercial_FeeRuleDao.setPageSize(256);
					Commercial_FeeRule[] commercial_FeeRules = commercial_FeeRuleDao.select("select distinct(t.feeruleid),t.feerulename from COMMERCIAL_FEERULE t order by t.feeruleid ");
					
					for(int i=(commercial_FeeRuleDao.totalCount-1);i>=0;i--){
						out.println("<option value='"+commercial_FeeRules[i].getFeeRuleId()+"' >"+commercial_FeeRules[i].getFeeRuleId()+"-"+commercial_FeeRules[i].getFeeRuleName()+"</option>");
					}
					%>
				</select>
				<font>*</font>
			</td>
			<td align='right'>TP001-全国通配决定索引:</td>
			<td ><select name="fee_rule2" title="c1" id="fee_rule2" style='width: 99%' require="true"  label='请选择全国通配决定索引'>
				<option value=""  selected="selected">请选择</option>
					<%
					for(int i=(commercial_FeeRuleDao.totalCount-1);i>=0;i--){
						out.println("<option value='"+commercial_FeeRules[i].getFeeRuleId()+"' >"+commercial_FeeRules[i].getFeeRuleId()+"-"+commercial_FeeRules[i].getFeeRuleName()+"</option>");
					}
					%>
				</select>
				<font>*</font>
			</td>
		</tr>
        <tr class="c101"> 
			<td align="right">境内银联卡手续费标准:</td>
            <td>
                <input type="text" name="LC_FEE_PRE" title="c1" id="LC_FEE_PRE" style="width:100px;"
                onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"
                />%
            </td>
            <td align="right">封顶</td>
            <td>
                <input type="text" name="LC_FEE_TOP" title="c1" id="LC_FEE_TOP" style="width:100px;"
                onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"
                />(元)
            </td>
        </tr>
        <tr class="c101"> 
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
				<td align='right'>审批状态:</td>
				<td>
					<select name="appr_status" id="appr_status"  onchange="
						if(this.value==1 || this.value==5 || this.value==6){
							$('#APPR_REMARK_TYPE').removeAttr('disabled');
							$('#appr_remark').removeAttr('disabled');
							$('#commercialNoTemp').addClass('notRequired');
						}else{
							$('#APPR_REMARK_TYPE').attr('disabled','disabled');
							$('#appr_remark').attr('disabled','disabled');
							$('#appr_remark').val('');
							$('#commercialNoTemp').removeClass('notRequired');
						};
					">
						<option value="2" selected="selected" >通过</option>
						<option value="1">新入网驳回</option>
						<option value="5">新增终端驳回</option>
						<option value="6">信息变更驳回</option>
					</select>
					<font>*</font>
				</td>
				<td align='right'>不通过原因:</td>
				<td>
					<select disabled="disabled" onchange="$('#appr_remark').val($('#APPR_REMARK_TYPE').val())" id="APPR_REMARK_TYPE">
						<option>--请选择--</option>
						<option value="资料缺失">资料缺失</option>
						<option value="扣率不符">扣率不符</option>
						<option value="其他">其他</option>
					</select>
					<input name="appr_remark"  style="width: 300px" disabled="disabled"  id="appr_remark" class='notRequired'/>
				</td>
				<td>
					<input type="hidden" name='status' id="status" width="150"  value="1" readonly/>
				</td>
			</tr>
			<tr>
			<td>历史驳回信息：</td>
				<td>
					<textarea rows="3" cols="40" readonly id="historyOperateData">
					</textarea>
				</td>
			<td align='right'>门店名称:</td>
				<td>
					<input type="text" name="MARCHANT_NAME2" id="MARCHANT_NAME2"/>
					<font>*</font>
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
							<button type="button" id='operateBtn' onclick="beforeSubmit2('bussiness105OperationForm',true)" style="width:100px;text-align: center; table-layout: fixed;">完成</button>
							<button type="button" id='zhenggai' disabled="disabled"  onclick="zhengGai()" style="width:100px;text-align: center; table-layout: fixed;">整改</button>
						<%} %>
					</td>
				</tr>
			</center>
		</form>
		</div>
  </div>
	</div>
</div>
<div id="biglistDiv" class="left02" >
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" style="width: 80%">
				<span>大商户帐号</span>
			</div>
		</div>
		<div class="left02downDiv">
		<table id='cust_Table' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>账户银行</th>
				<th class='dataTableHeader'>账户户名</th>
				<th class='dataTableHeader'>扣率类型</th>
				<th class='dataTableHeader'>签约扣率</th>
				<th class='dataTableHeader'>状态</th>
				<th class='dataTableHeader'>商户编号</th>
				<th class='dataTableHeader'>终端编号</th>
			</tr>
			<!-- 数据显示区 -->
			<tr id='dazhanghu'>
				<td id="ACCOUNT_BANK">长沙银行</td>
				<td id="ACCOUNT_NAME">通联支付</td>
				<td id="CONTRACT_TYPE">封顶</td>
				<td id="CONTRACT_FEE">0</td>
				<td id="STATUS">启用</td>
				<td id="TERM_ID3">1234567890</td>
				<td id="TERM_ID4">1111111111</td>
			</tr>	
			<tr id='dazhanghu'>
				<td id="ACCOUNT_BANK">长沙银行</td>
				<td id="ACCOUNT_NAME">通联支付</td>
				<td id="CONTRACT_TYPE">封顶</td>
				<td id="CONTRACT_FEE">0</td>
				<td id="STATUS">启用</td>
				<td id="TERM_ID3">1234567890</td>
				<td id="TERM_ID4">2222222222</td>
			</tr>	
			<tr id='dazhanghu'>
				<td id="ACCOUNT_BANK">长沙银行</td>
				<td id="ACCOUNT_NAME">通联支付</td>
				<td id="CONTRACT_TYPE">封顶</td>
				<td id="CONTRACT_FEE">0</td>
				<td id="STATUS">启用</td>
				<td id="TERM_ID3">1234567890</td>
				<td id="TERM_ID4">3333333333</td>
			</tr>							
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
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
		<table id='cust_Table2' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>联系人</th>
				<th class='dataTableHeader'>电话</th>
				<th class='dataTableHeader'>装机城市</th>
				<th class='dataTableHeader'>装机街道</th>
				<th class='dataTableHeader'>状态</th>
				<th class='dataTableHeader'>商户编号</th>
				<th class='dataTableHeader'>终端编号</th>
				<th class='dataTableHeader'>清算商户编号</th>
				<th class='dataTableHeader'>清算终端编号</th>
				<th class='dataTableHeader'>录入时间</th>
				<th class='dataTableHeader'>pos类型</th>
				<th class='dataTableHeader'>操作</th>
				<th class='dataTableHeader'>详情</th>
			</tr>
			<!-- 数据显示区 -->
			<tr id='merDayGain_Templet2'>
				<td id="UNIT_INSTALLED_MAN"></td>
				<td id="UNIT_INSTALLED_TEL"></td>
				<td id="UNIT_INSTALLED_ADD"></td>
				<td id="UNIT_INSTALLED_STREET"></td>
				<td id="TEMINAL_STATUS"></td>
				<td id="commercial_id"></td>
				<td id="terminal_number"></td>
				<td id="TERM_ID3"></td>
				<td id="TERM_ID4"></td>
				<td id="INPUT_DATE"></td>
				<td id="EQUI_TYPE"></td>
				<td id="dosmthing"></td>
				<td id="MORE"></td>
			</tr>	
		</table>
			<div id='cust_Pagination2' class='pagination'></div>
			<div id='cust_Searchresult2'></div>
		</div>
		</div>
 
 </c:if>
</body>
</html>		
