<%@page import="com.szzt.dao.DaoUtils"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="../../import.jsp"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<%
String info = request.getParameter("info");
if(null!=info&&info.equals("back1")){
	out.println("<script type=\"text/javascript\">alert('回访成功')</script>");
}
if(null!=info&&info.equals("1")){
	out.println("<script type=\"text/javascript\">alert('添加成功')</script>");
}
if(null!=info&&info.equals("-1")){
	out.println("<script type=\"text/javascript\">alert('添加失败')</script>");
}
if(null!=info&&info.equals("3")){
	out.println("<script type=\"text/javascript\">alert('请先录入客户信息！')</script>");
}
if(null!=info&&info.equals("11")){
	out.println("<script type=\"text/javascript\">alert('修改成功')</script>");
}
if(null!=info&&info.equals("10")){
	out.println("<script type=\"text/javascript\">alert('修改失败')</script>");
}
if(null!=info&&info.equals("del0")){
	out.println("<script type=\"text/javascript\">alert('删除失败')</script>");
}
if(null!=info&&info.equals("del1")){
	out.println("<script type=\"text/javascript\">alert('删除成功')</script>");
}
if(null!=info&&info.equals("opera1")){
	out.println("<script type=\"text/javascript\">alert('审批成功')</script>");
}
if(null!=info&&info.equals("opera0")){
	out.println("<script type=\"text/javascript\">alert('审批失败')</script>");
}
if(null!=info&&info.equals("o0")){
	out.println("<script type=\"text/javascript\">alert('操作失败')</script>");
}
if(null!=info&&info.equals("o1")){
	out.println("<script type=\"text/javascript\">alert('操作成功')</script>");
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
input{
	height:30px;
	width:360px;
}
</style>
<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
<script src="../../js/jquery.pagination2.js" type="text/javascript"></script>
<script src="../../js/province_city_area_select.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
<script src="../../js/Area.js" type="text/javascript"></script>
<script src="../../js/validator.js" type="text/javascript"></script>
<script src="../../js/AreaData_min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/md5.js"></script>
<script type="text/javascript">

function isMobile(val) { 
	var teleReg = /^((0\d{2,3})-)(\d{7,8})$/;  
    var mobileReg =/^1[34587]\d{9}$/; 
    if (!teleReg.test(val) && !mobileReg.test(val)){  
        return false;  
    }else{  
        return true;  
    }
} 
function isChinaOrNumbOrLett( s ){//判断是否是汉字、字母、数字组成
	var regu = "^[0-9a-zA-Z\u4e00-\u9fa5]+$";  
	var re = new RegExp(regu);
	if (re.test(s)) {
		return true;
	}else{
		return false;
	}
}

function isTel(val){
	if(isNaN(val)){
		return false;
	}else{
		var t = val.length;
		if(11<=t<=12){
			return true;
		}else{
			return false;
		}
	}
}

$(function(){

});

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

function showAttachFileWindow(type,id){
	window.open ('../insert/quickyAdd.jsp?show=1&type='+type+'&id='+id, 'attachFileWindow', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
}
/**
 * 判断营业执照编码唯一性
 */
function checkSigletonComNo(){
	var v=$("#COMM_NO").val();
	if($.trim(v).length>0){
		$.post("../action/CheckCommercialComNun.jsp",{'COMM_NO':$("#COMM_NO").val()},function(json){
			if(json!=0){
				$("#submitBtn").attr("disabled","disabled");
				alert("营业执照编码已存在，请更换！");
			}else {
				$("#submitBtn").removeAttr("disabled");
			}		
		});
	}
}

var id=<%=request.getParameter("CommercialId")%>;
var digit="<%=request.getParameter("digit")%>";
var myDate = new Date();

if(digit!=hex_md5(myDate.getFullYear()+'*'+myDate.getMonth()+'%'+myDate.getDate()+id) && id!=null){
//	alert("非法访问");
//	location.href("../../index.jsp");
//  window.location.href="../../index.jsp"; 
}
<%
	if(request.getParameter("show")!=null){
		%>
		var cur_page2 = 0;
		function find2(cur_page){
		    $('#merDayGain_Templet').nextAll().remove();
			cur_page = cur_page || 0;
			var row = $('#merDayGain_Templet').clone(true);
			$("#cur_page").val(cur_page2+1);
			var page_size = $("#page_size").val();
			$.ajax({
				url:'../action/AppayCommonDataQuery.jsp',
				dataType:'json',
				type:'POST',
				data:{'cur_page':cur_page2+1,'page_size':page_size,'COMMERCIAL_ID':${param.CommercialId},"has102":true},
				success: function(json){
					var object = json.resultset;
			        $('#merDayGain_Templet2').nextAll().remove();
			        if (json.total==0){
			        	$('#cust_Table2').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
			        }
			        var i=0;
			        for(i=(json.rows-1);i>=0;i--){
			        	var row = $('#merDayGain_Templet2').clone(true);
			        	for(var pro in object[0]) {
			        		if(pro=="APPPAY_ID")
			        		{
			        			if(object[i]["APPTYPE"]=="收付宝")
			        				{
			        				if(object[i]["APPR_STATUS"]<2)
			        					row.find('#DELETE_APPPAY').html("<a href='javascript:void(0)' onclick='deleteTarget(this,"+object[i][pro]+",2)' >删除</a>");
			        				}	
			        			else if(object[i]["APPTYPE"]=="实名支付")
			        			{
			        				if(object[i]["APPR_STATUS"]<2)
			        				row.find('#DELETE_APPPAY').html("<a href='javascript:void(0)' onclick='deleteTarget(this,"+object[i][pro]+",1)' >删除</a>");	
			        			}else  if(object[i]["APPTYPE"]=="便捷付")
			        			{	
			        				if(object[i]["APPR_STATUS"]<2)
			        				row.find('#DELETE_APPPAY').html("<a href='javascript:void(0)' onclick='deleteTarget(this,"+object[i][pro]+",4)' >删除</a>");	
		        				}else  if(object[i]["APPTYPE"]=="收单")
			        			{	
			        				if(object[i]["APPR_STATUS"]<2)
			        				row.find('#DELETE_APPPAY').html("<a href='javascript:void(0)' onclick='deleteTarget(this,"+object[i][pro]+",5)' >删除</a>");	
		        				}else  if(object[i]["APPTYPE"]=="自助终端")
			        			{	
			        				if(object[i]["APPR_STATUS"]<2)
			        				row.find('#DELETE_APPPAY').html("<a href='javascript:void(0)' onclick='deleteTarget(this,"+object[i][pro]+",6)' >删除</a>");	
		        				}
			        		}else if(pro=="APPTYPE"){
			        			if(object[i]["APPTYPE"]=="实名支付"){
			        				row.find('#APPTYPE').html("实名支付");
			        			}
			        			else if(object[i]["APPTYPE"]=="收付宝"){
			        				row.find('#'+pro+'').html("收付宝");
			        			}
			        			else if(object[i]["APPTYPE"]=="便捷付"){
			        				row.find('#'+pro+'').html("便捷付");
			        			}else if(object[i]["APPTYPE"]=="收单"){
			        				row.find('#'+pro+'').html("收单");
			        			}else if(object[i]["APPTYPE"]=="自助终端"){
			        				row.find('#'+pro+'').html("自助终端");
			        			}
			        		}else if(pro=='APPR_STATUS'){
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
			        			if(object[i]["APPR_STATUS"]>=2 && object[i]["APPR_STATUS"] <5){
			        				$("#updataData").hide();
			        			}
			        			row.find('#'+pro+'').html(vv);
			        		} 
			        		else if(row.find('#'+pro+'')!=null)
			        		  row.find('#'+pro+'').html(object[i][pro]);
			        	}
				        row.show();
				        row.insertAfter('#merDayGain_Templet2');
			        };
			        $('#cust_Table2').mygrid();
			      
		    	},  
			    error: function(XmlHttpRequest, textStatus, errorThrown){  
			        alert( "error");  
			    }
			 }); 
		}
		var cur_page = 0;
		function find(cur_page){
		    $('#merDayGain_Templet').nextAll().remove();
			cur_page = cur_page || 0;
			var row = $('#merDayGain_Templet').clone(true);
			$("#cur_page").val(cur_page+1);
			var page_size = $("#page_size").val();
			$.ajax({
				url:'../action/TerminalDataQuery.jsp',
				dataType:'json',
				type:'POST',
				data:{'cur_page':cur_page+1,'page_size':page_size,'where':' COMMERCIAL_ID='+${param.CommercialId}},
				success: function(json){
					var object = json.resultset;
			        $('#merDayGain_Templet').nextAll().remove();
			        if (json.total==0){
			        	$('#cust_Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
			        }
			        var i=0;
			       
			        for(i=(json.rows-1);i>=0;i--){
			        	var row = $('#merDayGain_Templet').clone(true);
			        	for(var pro in object[i]) {
			        		if(pro=="TEMINAL_INFO_ID")
			        		{
			        			if(object[i]["TEMINAL_STATUS"]==1&&row.find('#TERMINAL_DELETE')!=null)
			        				row.find('#TERMINAL_DELETE').html("<a href='javascript:void(0)' onclick='deleteTarget(this,"+object[i][pro]+",3)' >删除</a>");	
			        		}else if(pro=="TEMINAL_STATUS"){
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
			        			if(stt>1&&stt!=6){
			        				$("#updataData").hide();
			        			}
			        			if(row.find('#'+pro+'')!=null)
			        				row.find('#'+pro+'').html(vvv);
			        		}else if(pro=="UNIT_INSTALLED_CITY"){
			        			//.........................................................
			        			row.find('#'+pro+'').html(showAreaID(0,object[i]["UNIT_INSTALLED_STREET"]));
			        		}else if(pro=="EQUI_TYPE"){
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
			        		} else if(row.find('#'+pro+'')!=null)
			        			row.find('#'+pro+'').html(object[i][pro]);
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
		    	},  
			    error: function(XmlHttpRequest, textStatus, errorThrown){  
			        alert( "error");  
			    }
			 }); 
		}
			$(function(){
				    find();
				    find2();
					$("input").attr("disabled","disabled");
					$("select").attr("disabled","disabled");
					$("textarea").attr("disabled","disabled");
					$("button[id!='updataData']").attr("disabled","disabled");
						$.post("../action/findById/Commercial..jsp",{'id':id,'session':true},function(json){
							var result=eval("("+json+")");
							//var result=json.resultset[0];
							$("input,select,textarea").each(function(){
								var itemId=$(this).attr("id");
								if(result[itemId])
									$(this).val(result[itemId]);
							});
							
						});
						//  $("#appendRemark").removeAttr("disabled");
					});
			function appendRemarks(){
				var v=prompt("请输入需要追加的备注信息","");
				var id=${param.CommercialId};
				if(v){
					$.post("../action/AppendRemarkInfo.jsp",{'id':id,'v':v,'type':1},function(d){
						if(d==1){
							alert("追加成功！");
						}else{
							alert("追加失败");
						}
					});
				}
			}
		<%
	}else{
		DaoUtils d=new DaoUtils();
%>
	$(function(){
		$("#UNIT_AREA").val(<%=d.currLocal(session)%>);
	});
<%}%>


</script>
<script type="text/javascript">
		//type==1 业务1删除； 2 ：业务2 删除； 3：终端删除 4 appay4删除
		function deleteTarget(obj,id,type){
			if(confirm("确认删除？")){
				if(type==1){
						obj.href="../action/Apppay101DataDelete.jsp?delId="+id;
						obj.click();
					}
				else if(type==2){
					obj.href="../action/Apppay102DataDelete.jsp?delId="+id;
					obj.click();
				}else if(type==3){
					obj.href="../action/TerminalDataDelete.jsp?delId="+id;
					obj.click();
				}else if(type==4){
					obj.href="../action/Apppay103DataDelete.jsp?delId="+id;
					obj.click();
				}else if(type==5){
					obj.href="../action/Apppay_105Delete.jsp?delId="+id;
					obj.click();
				}else if(type==6){
					obj.href="../action/Apppay106DataDelete.jsp?delId="+id;
					obj.click();
				}
			}
		}
	function beforeSubmit(){
		var allow="";
		$("input[class!='notRequired'][type!='hidden'],select").each(function(index,data){
		
			if(this.value==null||this.value=='')
			{
				allow=false;
				allow=$($(this).parent()).prev().html()+" 未填写！";
				$(this).focus();
				return false;
			}
			return true;
		});

		if(!isMobile($("#CONTACT_TEL_1").val())){
			alert("请输入正确的手机号码！");
			$("#CONTACT_TEL_1").focus();
			return false;
		}
		
		if(!isChinaOrNumbOrLett($("#COMM_AD").val())){
			alert("工商营业执照地址不能输入特殊符号！");
			$("#COMM_AD").focus();
			return false;
		}
		if(!isChinaOrNumbOrLett($("#UNIT_ADD").val())){
			alert("客户营业地址不能输入特殊符号！");
			$("#UNIT_ADD").focus();
			return false;
		}
		
		if(!isTel($("#CONTACT_TEL_2").val())){
			alert("请输入正确的固定电话！");
			$("#CONTACT_TEL_2").focus();
			return false;
		}
		
		if(""!=allow){
			alert(allow);
			 var evt = e|| window.event;
           //IE用cancelBubble=true来阻止而FF下需要用stopPropagation方法
           evt.stopPropagation ?evt.stopPropagation() : (evt.cancelBubble=true);
		}else {
			var form=document.getElementById("from1");
			form.submit();
		}
	}

	
	function updateData(){
		$("input").removeAttr("disabled");
		$("select").removeAttr("disabled");
		$("textarea").removeAttr("disabled");
		$("button").removeAttr("disabled");
	}
	function queryGSYY(){
		var v=$("#checkComIdQuery").val();
		if($.trim(v).length<1){
				alert("请输入工商营业执照编码！");
				return;
		}
		$.post("../action/CheckCommercialComNun.jsp",{'COMM_NO':v},function(json){
			if(json!=0){
				if(confirm("营业执照编码["+v+"]已存在,是否查看该客户详细信息？")){
					window.location.href="commercialInsert.jsp?show=1&CommercialId="+json;
				}
			}else{
				alert("营业执照编码["+v+"]不存在！");
			}		
		});
	}
	function autoCreateCommno(){
		$.post("../action/AutoCreateCommNo.jsp",{},function(json){
			$("#COMM_NO").val(json);
		});
		
	}
</script>
<style type="text/css">
	font{
	color: red;
	}
</style>
</head>

<body >
	<div id="listDiv" >
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" style="width:300px"><span id="titleName">客户基本信息录入
			</span> </div>
		</div>
	</div>
		<div class="mycss">
		<c:if test="${empty param.show }">
			<form  method="post"  id="from1"  action="../action/CommercialDataInsert.jsp">
		</c:if>
		<c:if test="${1==param.show }">
				<form  method="post"  id="from1"  action="../action/CommercialDataUpdate.jsp">
		</c:if>
		营业执照编码查询: <input id="checkComIdQuery" class="notRequired"><button type="button" onClick="queryGSYY()">查询</button>
		<hr>
			<table>
				<tr>
				<td align="right">客户单位名称:</td>
				<td>
					<input  type="text" name="UNIT_NAME" id="UNIT_NAME" onKeyUp="$('#COMM_NAME,#TRADE_NAME').val($(this).val())" maxlength="50"/><font>*</font>
					<input type="hidden" name="COMMERCIAL_ID" class="notRequired" value='<c:out value="${param.CommercialId }" ></c:out>'/>
				</td>
				<td align="right">工商营业执照编码:</td>
				<td>
					<input type="text" name="COMM_NO" id="COMM_NO" onBlur="checkSigletonComNo()"/>
					<font>*</font>
					<button style="width:100px" onClick="autoCreateCommno()">暂无执照编码</button>
				</td>
			</tr>
			<tr>
				<td align="right">工商营业执照名称:</td>
				<td>
					<input type="text" name="COMM_NAME" id="COMM_NAME" readonly="readonly"/><font>*</font>
				</td>
				<td align="right">工商营业执照地址:</td>
				<td>
					<input type="text" name="COMM_AD" id="COMM_AD" onKeyUp="$('#UNIT_ADD').val($(this).val())"/><font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">商户对外营业名称:</td>
				<td>
					<input type="text" name="TRADE_NAME" id="TRADE_NAME" maxlength="50"/><font>*</font>
				</td>
				<td align='right'>客户营业地址:</td>
				<td>
					<input type="text" name='UNIT_ADD' id="UNIT_ADD" width="150" /><font>*</font>
				</td>
			</tr>
			<tr>	
				<td align="right">客户所在地区:</td>
				<td>
					<select style="width:100px" name="UNIT_AREA"  id="UNIT_AREA">
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
			
				<td align='right'>单位性质:</td>
				<td>
					<select name="UNIT_ATTR"  id="UNIT_ATTR">
						<option value="5">个体商户</option>
						<option value="1">企业用户</option>
						<option value="3">个人用户</option>
						<option value="4">其他</option>
					</select><font>*</font>
				</td>
			</tr>
			
			
			<tr>
				<td align="right">客户单位联系人:</td>
				<td>
					<input type="text" name="CONTACT_NAME_1" id="CONTACT_NAME_1"/><font>*</font>
				</td>
				<td align="right">客户简称：</td>
				<td >
					<input name="COM_SIM_NAME" id="COM_SIM_NAME"/><font>*</font>
				</td>
				</tr>
			<tr>
				<!-- <td align="right">客户单位联系人_2:</td>
				<td>
					<input type="text" name="CONTACT_NAME_2" id="CONTACT_NAME_2"/>
				</td> -->
					<td align="right">移动电话</td>
				<td>
					<input type="text" name="CONTACT_TEL_1" id="CONTACT_TEL_1" 
					onKeyUp="if(isNaN(this.value)){this.value=this.value.replace(/\D/g,'')}" 
					onafterpaste="if(isNaN(this.value)){this.value=this.value.replace(/\D/g,'')}"/><font>*</font>
				</td>
				
				<td align="right">固定电话</td>
				<td>
					<input type="text" name="CONTACT_TEL_2" id="CONTACT_TEL_2" onKeyUp="if(isNaN(this.value)){this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(isNaN(this.value)){this.value=this.value.replace(/\D/g,'')}" class="notRequired"/>
				</td>
				
			</tr>
			<tr>
				<td align="right">法人姓名：</td>
				<td >
					<input name="LEGALER_NAME" id="LEGALER_NAME"/><font>*</font>
				</td>
				<td align="right">法人身份证:</td>
				<td >
					<input name="LEGAL_ID_CARD" id="LEGAL_ID_CARD"/><font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">组织机构代码证：</td>
				<td>
					<input name="UNTI_CODE_CARD" id="UNTI_CODE_CARD" class="notRequired"/>
				</td>
				<td align="right">税务登记证:</td>
				<td>
					<input name="TAX_SIGN_CARD" id="TAX_SIGN_CARD" class="notRequired"/>
				</td>
			</tr>
			
			<tr>
				<td align="right">联系邮箱： </td>
				<td>
					<input class="notRequired" id="CONTACT_EMAIL" name="CONTACT_EMAIL"/>
				</td>
				<td align="right">备注信息:</td>
				<td >
					<textarea rows="3" cols="20" id="REMARK_INFO" name="REMARK_INFO"></textarea>
				</td>
			</tr>
			</table>
			<center>
				<tr >
					<td>
						<c:if test="${1==param.show }">
							<%
							Permission per=new PositionPermessionImpl();
							if(!per.onlyPosition(session, Permission.OPERAT_POSITION)){ %>
								<button onClick="updateData()"  type="button"  id="updataData"  style="width:100px;text-align: center; table-layout: fixed;">修改</button>
							<%} %>
								<button  onclick="beforeSubmit()" type="button" style="width:100px;text-align: center; table-layout: fixed;">提交</button>
						</c:if>
						<c:if test="${1!=param.show }">
							<button id="submitBtn"  onclick="beforeSubmit()" type="button"  style="width:100px;text-align: center; table-layout: fixed;">提交</button>
						</c:if>
					</td>
				</tr>
			</center>
		</form>
		<hr/>
<script type="text/javascript">

</script>
	</div>
	<%Permission per=new PositionPermessionImpl(); %>
		<c:if test="${param.show==1 }">
		
			<!-- 客户业务信息 -->
		<div class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c"><span id="titleName">业务信息</span> </div>
			<div class="left02top_c" style="width: 500px" ><span id="titleName">
					<%
					if(per.hasPermission(session, Permission.EXPAND_POSITION)){
					%>
					<a href="bussinessInsert.jsp?CommercialId=${param.CommercialId}" style="color:red">实名支付</a>
					</span> 
					<span><a href="bussinessInsert102.jsp?CommercialId=${param.CommercialId}" style="color:red">收付宝</a></span> 
					<span><a href="bussinessInsert103.jsp?CommercialId=${param.CommercialId}" style="color:red">便捷付</a></span> 
					<span><a href="bussinessInsert105.jsp?CommercialId=${param.CommercialId}" style="color:red">收单</a></span> 
					<span><a href="bussinessInsert106.jsp?CommercialId=${param.CommercialId}" style="color:red">自助终端</a></span> 
					<%} %>
					</div>
		</div>
		<div class="left02downDiv">
		<form id="queryForm2">
		<table id='cust_Table2' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>业务类型</th>
				<th class='dataTableHeader'>门店名称</th>
				<th class='dataTableHeader'>商户编号</th>
				<th class='dataTableHeader'>扣率</th>
				<th class='dataTableHeader'>拓展人</th>
				<th class='dataTableHeader'>业务状态</th>
				<th class='dataTableHeader'>录入时间</th>
				<th class='dataTableHeader'>详情</th>
				<th class='dataTableHeader'>删除</th>
			</tr>
			<tr id='merDayGain_Templet2'>
				<td id="APPTYPE"></td>
				<td id="MARCHANT_NAME"></td>
				<td id="trem1"></td>
				<td id="contract_fee"></td>
				<td id="name"></td>
				<td id="APPR_STATUS"></td>
				<td id="input"></td>
				<td id="more"></td>
				<td id="DELETE_APPPAY"></td>
			</tr>	
		</table>
			<div id='cust_Pagination2' class='pagination'></div>
			<div id='cust_Searchresult2'></div>
		</form>
		</div>
		
	</div>
		<!-- 终端列表信息 -->
		<div class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c"><span id="titleName">终端信息记录<%if(per.hasPermission(session, Permission.EXPAND_POSITION)){ %>
			<a href="terminalInsert2.jsp?CommercialId=${param.CommercialId}" style="font: red;color: red">新增</a> 
			<%} %></span> </div>
		</div>
		<div class="left02downDiv">
		<form id="queryForm">
		<table id='cust_Table' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>联系人</th>
				<th class='dataTableHeader'>装机城市</th>
				<th class='dataTableHeader'>装机地址</th>
				<th class='dataTableHeader'>电话</th>
				<th class='dataTableHeader'>机具类型</th>
				<th class='dataTableHeader'>状态</th>
				<th class='dataTableHeader'>录入时间</th>
				<th class='dataTableHeader'>详情</th>
				<th class='dataTableHeader'>删除</th>
			</tr>
			<!-- 数据显示区 -->
			<tr id='merDayGain_Templet'>
				<td id="UNIT_INSTALLED_MAN"></td>
				<td id="UNIT_INSTALLED_CITY"></td>
				<td id="UNIT_INSTALLED_ADD"></td>
				<td id="UNIT_INSTALLED_TEL"></td>
				<td id="EQUI_TYPE"></td>
				<td id="TEMINAL_STATUS"></td>
				<td id="INPUT_DATE"></td>
				<td id="MORE"></td>
				<td id="TERMINAL_DELETE"></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</form>
		</div>
		</c:if>
</body>
</html>		
