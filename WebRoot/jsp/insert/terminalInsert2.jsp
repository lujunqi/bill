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
%>
<meta http-equiv="content-script-type" content="text/javascript">
<meta http-equiv="content-style-type" content="text/css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
  select{
  width:100px;
  height:30px;
  margin-top: 10px;
  margin-bottom: 10px;
  }
  </style>
  <script type="text/javascript">
  function toggleRadio(v){
	 var isC=$(v).is(":checked");
	 if(isC){
		 $(v).removeAttr("checked");
	 }
  }
  $(function(){
	  initComplexArea('UNIT_INSTALLED_CITY1', 'UNIT_INSTALLED_CITY', 'UNIT_INSTALLED_STREET', area_array, sub_array, '43', '0', '0');
	  find2();
		$.post("../action/findById/Commercial..jsp",{id:${param.CommercialId}},function(json){
			json=eval("("+json+")");
			var result=json;
			if(result){
				$("#UNIT_INSTALLED_MAN").val(result["CONTACT_NAME_1"]);
				$("#UNIT_INSTALLED_TEL").val(result["CONTACT_TEL_1"]);
				$("#UNIT_INSTALLED_ADD").val(result["COMM_AD"]);
			}
		});
		$("#UNIT_INSTALLED_CITY").val(${sessionScope.man.oper_address});
		$("#UNIT_INSTALLED_CITY").change();
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
function beforeSubmit(form) {
	var bindIds="";
	var checkAll=true;
	$("#BusinessManage input:radio").each(function(){
		if($(this).is(":checked")){
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
	$("#" + form + " input:text[class!='notRequired'],#"+form+" select").each(function(index, data) {
		if($(this).is(":hidden")){
			return true;
		}
		if (this.value == null || this.value == ''||$.trim(this.value).length<1) {
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
		if($("#UNIT_INSTALLED_STREET").val()==0)
		{
			alert("请选择城市！");
			$("#UNIT_INSTALLED_STREET").focus();
			return;
		}
		var form = document.getElementById(form);
		form.submit();
	}
}
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
		data:{'cur_page':cur_page2+1,'page_size':page_size,'COMMERCIAL_ID':${param.CommercialId},"append":true},
		success: function(json){
			var object = json.resultset;
	        $('#merDayGain_Templet2').nextAll().remove();
	        if (json.total==0){
	        	$('#cust_Table2').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
	        }
	        var i=0;
	        for(i=(json.rows-1);i>=0;i--){
//	        	if(object[i]["APPTYPE"]=="收付宝"||object[i]["APPTYPE"]=="自助终端"){
//	        		continue;
//	        	}
	        	if(object[i]["APPTYPE"]=="自助终端"){
	        		continue;
	        	}
	        	var row = $('#merDayGain_Templet2').clone(true);
	        	for(var pro in object[0]) {
	        		if(pro=='APPPAY_ID'){
	        			if(object[i]['APPTYPE']=='实名支付')
	        			 {
	        			 row.find('#APPPAY_ID').html("<input title='双击解绑' ondblclick='toggleRadio(this)' class='radio' id='-"+object[i][pro]+"' type='radio' name='1110000111111' />");
	        			}
	        			else if(object[i]['APPTYPE']=='便捷付'){
	        				row.find('#APPPAY_ID').html("<input title='双击解绑'  ondblclick='toggleRadio(this)' class='radio'  id='2"+object[i][pro]+"' type='radio' name='1100000000222222'/>");
			        	 }
	        			else if(object[i]['APPTYPE']=='收付宝'){
	        				row.find('#APPPAY_ID').html("<input title='双击解绑'  ondblclick='toggleRadio(this)' class='radio'  id='6"+object[i][pro]+"' type='radio' name='1100000000666666'/>");
			        	 }
	        			else {
	        				row.find('#APPPAY_ID').html("<input title='双击解绑'  ondblclick='toggleRadio(this)' class='radio'  id='5"+object[i][pro]+"' type='radio' name='11111000555'/>");
			        	 }
	        		}
	        		//else //if(pro=="APPTYPE"){
	        			//if(object[i]["APPTYPE"]=="实名支付"){
	        				//row.find('#APPTYPE').html("实名支付");
	        			//}else if(object[i]["APPTYPE"]=="便捷付"){
	        			//	row.find('#'+pro+'').html("便捷付");
	        			//}
	        		//}
	        		else if(pro=="APPR_STATUS"){
	        			if(object[i]["APPR_STATUS"]>=2)
	        				row.find('#APPR_STATUS').html("审批通过");
	        			else	row.find('#APPR_STATUS').html("录入完成");
	        		}
	        		else
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

</script>
<style type="text/css">
.radio{
width: 30px;
margin: 0 atuo;
text-align: center;
}
</style>
</head>

<body >
      
<div id="easyTabContext" class="tab-container">
<!-- 终端管理 -->
  <div id="TerminalManage" class="panel-container">
   		<div  class="left02">
			<div class="left02topDiv" >
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
					<input type="text" name="UNIT_INSTALLED_MAN" id="UNIT_INSTALLED_MAN" />
					<input type="hidden" name="TEMINAL_INFO_ID" id="TEMINAL_INFO_ID" readonly="readonly" value="${requestScope.TEMINAL_INFO_ID}"/>
					<input type="hidden" name="COMMERCIAL_ID" id="COMMERCIAL_ID" value='<c:out value="${param.CommercialId}"></c:out>' readonly="readonly"/>
					<input type="hidden" name="BIND_IDS" id="BIND_IDS" readonly="readonly"/>
					<font>*</font>
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
					<select id="UNIT_INSTALLED_CITY1" name="UNIT_INSTALLED_CITY1" onChange="changeComplexProvince(this.value, sub_array, 'UNIT_INSTALLED_CITY', 'UNIT_INSTALLED_STREET');">
	   				 </select>
				      <select id="UNIT_INSTALLED_CITY" name="UNIT_INSTALLED_CITY" onChange="changeCity(this.value,'UNIT_INSTALLED_STREET','UNIT_INSTALLED_STREET');">
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
					<select name="EQUI_TYPE" id="EQUI_TYPE">
						<option value="0">普通POS</option>
						<option value="1">移动POS</option>
						<option value="2">分体POS</option>
						<option value="3">其他类型POS</option>
					</select>
					<font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">加急标志位:</td>
				<td>
					<select name="IS_HURRY" id="IS_HURRY">
						<option value="0">不加急</option>
						<option value="1">加急</option>
					</select>
					<font>*</font>
				</td>
				<td align="right">终端通讯方式:</td>
				<td>
					<select name="COMM_TYPE" id="COMM_TYPE">
						<option value="0">电话模式</option>
						<option value="1">网络模式</option>
					</select>
					<font>*</font>
				</td>
			</tr>
			<tr>
				<td align="right">通讯方式是否绑定:</td>
				<td>
					<select name="IS_BIND" id="IS_BIND">
						<option value="0">不绑定</option>
						<option value="1"> 绑定</option>
					</select>
					<font>*</font>
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
					<font>*</font>
				</td>
					<td align="right">程序版本选择:</td>
				<td>
					<select id="term_version" name="term_version">
						<option value="0">请选择</option>
						<option value="00100014">岳阳房地局项目</option>
						<option value="00100016">吉屋网络项目</option>
						
					</select>
				</td>
			</tr>
			<tr>
			<td align="right">备注信息:</td>
				<td>
					<textarea rows="3" cols="20" id="REMARK_INFO" name="REMARK_INFO"></textarea>
				</td>
				<td></td><td></td>
			</tr>			
			 
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
				<td><input type="text" name="MONEY0" id="MONEY0" onKeyUp="onlyNumberAllow(this)"/><font>*</font>
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
					<input type="text" onKeyUp="onlyNumberAllow(this)" class="notRequired" name="MONEY1" id="MONEY1" />
					<input type="hidden" value="1" class="notRequired" name="COST_TYPE1" id="COST_TYPE1" />
				</td>
				<td>
				<select name="CYCLE1" class="notRequired" id="CYCLE1" >
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
					<input type="text" onKeyUp="onlyNumberAllow(this)"  class="notRequired" name="MONEY2" id="MONEY2" />
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
			<table id='cust_Table2' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader' style="width: 90px">绑定(双击解绑)</th>
				<th class='dataTableHeader'>业务类型</th>
				<th class='dataTableHeader'>门店名称</th>
				<th class='dataTableHeader'>商户编号</th>
				<th class='dataTableHeader'>扣率</th>
				<th class='dataTableHeader'>拓展人</th>
				<th class='dataTableHeader'>业务状态</th>
				<th class='dataTableHeader'>详情</th>
			</tr>
			<tr id='merDayGain_Templet2'>
				<td id="APPPAY_ID"></td>
				<td id="APPTYPE"></td>
				<td id="MARCHANT_NAME"></td>
				<td id="TREM1"></td>
				<td id="contract_fee"></td>
				<td id="name"></td>
				<td id="APPR_STATUS"></td>
				<td id="more"></td>
			</tr>	
		</table>
			<div id='cust_Pagination2' class='pagination'></div>
			<div id='cust_Searchresult2'></div>
					</div>
				</div>
			  </div>
			<center>
				<tr >
					<td>
						<button type="button" style="width:100px;text-align: center; table-layout: fixed;" onClick="beforeSubmit('terminal_baseInfo_form')">提交</button>
						<button type="button" id="windowBackBtn" onClick="window.location.href='commercialInsert.jsp?show=1&CommercialId=${param.CommercialId}'" style="width:100px;text-align: center; table-layout: fixed;" >返回</button>
					</td>
				</tr>
			</center>
		</form>
		</div>
  </div>
</div>
</body>
</html>		
