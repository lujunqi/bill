<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
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
<link rel="stylesheet" href="../../css/tabs.css" media="screen" />

<script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
<script language="javascript" type="text/javascript" src="../../js/WdatePicker.js"></script>  
<script type="text/javascript" src="../../js/check.js"></script>
  
<script type="text/javascript">
<%
	Operman_info man=(Operman_info)session.getAttribute("man");
%>
var operman={
		operman_id:<%
						if(session.getAttribute("OPERMAN_ID") != null){
							out.println(String.valueOf(session.getAttribute("OPERMAN_ID")));
						}else{
							out.print("10000");
						}%>,
		post_id:<%
						if(session.getAttribute("POST_ID") != null){
							out.println((Integer)session.getAttribute("POST_ID"));
						}else{
							out.print("2");
						}%>,
		oper_address:${sessionScope.man.oper_address}
};
$(document).ready(function()
{
		if(operman.oper_address!='0000')
		{
			var target=$("#from1").find('[name=unit_area]');
			target.val(operman.oper_address);
			target.hide();
			target.parent().prev("td").hide();
		}
		
});
function excel() {
	if (!Validator.Validate(document.from1, 3)) {
		return;
	}
	var wherestr="";
    if ($('#unit_area').val() != ''){
    	wherestr += " and c.unit_area = "+$('#unit_area').val()+"";
    }
    if ($('#account_bank').val() != ''){
    	wherestr += " and m.account_bank = '"+$('#account_bank').val()+"'";
    } 
    if ($('#sales_man').val() != ''){
    	wherestr += " and m.e_id = "+$('#sales_man').val()+"";
    } 

    if ($('input[name="teminal_status"]:checked').val() == '1'){
    	wherestr += " and i.teminal_status = 6";
    }else if ($('input[name="teminal_status"]:checked').val() == '13'){
        wherestr += " and i.teminal_status=13 and i.installed_status=4 ";
    	wherestr += " and i.archive_date between to_date('"+$('#date1').val()+"','yyyy-mm-dd') and to_date('"+$('#date2').val()+"','yyyy-mm-dd')";
    }else{
    	wherestr += " and i.teminal_status != 6";
    }      
    if ($('#date1').val() != '' && $('input[name="teminal_status"]:checked').val() != '13'){
    	wherestr += " and i.input_date between to_date('"+$('#date1').val()+"','yyyy-mm-dd') and to_date('"+$('#date2').val()+"','yyyy-mm-dd')";
    }   
	var filename = $.trim($('#sales_man').val());
	var uri = "../action/taizhang/taizhangReportCreate.jsp?wherestr="+wherestr+"&filename="+filename+"&type="+$("#appType").val();
	window.open (uri, 'newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, location=no, status=no');
};
</script>
</head>

<body>
	<div id="listDiv" class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c"><span id="titleName">商户台帐下载</span> </div>
		</div>
		<div class="left02downDiv">
<form name='from1'  method="post"  id="from1" target="iframe1" action="#" onSubmit="return Validator.Validate(this,2)">
统计日期:
	<input type="text" name="date1" id="date1"  dataType='Require' msg='请输入统计起始日期'  onClick="WdatePicker()"/>
		至
	<input type="text" name="date2" id="date2"  dataType='Require' msg='请输入统计截至日期'  onClick="WdatePicker()"/>
	<td align='right' width="10%">地区:</td>
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
	<td align='right'>账户银行:</td>
	<td><select name='account_bank' id="account_bank" style='width: 120px' label='请选择账户银行' >
			<option value="" >请选择</option>
	
			<%
				DaoUtils utils=new DaoUtils();
				List<KeyValueModel> list=utils.bankInfo();
				for(KeyValueModel model:list){
					out.println("<option value='"+model.getKey()+"'>"+model.getValue()+"</option>");
				}
			 %>
		</select>
	</td>
	<td align='right'>拓展人员:</td>
	<td>
		<select name='sales_man' id="sales_man" style='width: 120px'  label='请输入拓展人员' />
				<option value="" >请选择</option>
			<%
			List<KeyValueModel> operators=	utils.operateUser();
			for(KeyValueModel model:operators){
				out.println("<option value='"+model.getKey()+"'>"+model.getValue()+"</option>");
			}
			%>
		</select>
	</td>
	<td align='right'>业务类型</td>
	<td>
		<select id="appType">
			<option value="101">实名支付</option>
			<option value="103">便捷付</option>
			<option value="105">收单</option>
		</select>
	 </td>	
 
	<td align='right'>
	<INPUT TYPE="radio" name="teminal_status" id="teminal_status" value="2" checked="checked"/>新增台帐</td>
	<td> <INPUT TYPE="radio"  name="teminal_status" id="teminal_status" value="1"/>撤机台帐</td>		
	<td> <INPUT TYPE="radio"  name="teminal_status" id="teminal_status" value="13"/>已归档台帐</td>		
	
	<%Permission per=new PositionPermessionImpl();
	if(per.hasPermission(session, Permission.REPORT_EXPORT)){%>
	<input type="button" name="total" value="开始统计" onclick="excel()"/>
	<%} %>
</form>
		</div>
		</div>		
