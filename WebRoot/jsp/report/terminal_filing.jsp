<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.ljq.MyDatabase"%>

<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="../../import.jsp"%>
<%
MyDatabase cmd = new MyDatabase();

List<String[]> list = new ArrayList<String[]>();
DatabaseAccess dba = new DatabaseAccess();
try{
	cmd.init("terminal_filing",dba.getConnection());
	list = cmd.getENum();
}catch(Exception e){
}
cmd.closeConntent();
Operman_info man = (Operman_info) session.getAttribute("man");
String address = man.getOper_address();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Untitled Document</title>
<meta http-equiv="content-script-type" content="text/javascript" />
<meta http-equiv="content-style-type" content="text/css" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
<script src="../../js/jquery.prism.2.0.js" type="text/javascript"></script>
<style type="text/css">
#search_div li {
	float: left;
	padding-right: 10px;
	margin:2px;
	height:35px;
	display:table-column;
	width:350px;
	font-size:12px;
}
#search_div li input{
	width:160px;
}
#search_div li select{
	width:180px;
}

#search_div li label{
	text-align:right; 
	width:120px;
	display:inline-block;
}
</style>
<script>
$(document).ready(function()
{
	$('form').resetForm();
	$("#detail_custForm").formly();
	//find(0);
	var leader="${sessionScope.man.oper_address}";
	if(leader!='0000'){
		$("#unit_area").hide();
		$("#unit_area").parent().prev("td").hide();
		$("#unit_area").val(leader);
	}
	$("#jsyh").prism({content:"ajax:../../bank_info.rp",param:{ACTION_TYPE:"JSONLIST"},begin:function(){
		var opt = "<option value=''>请选择</option>";
		$("#jsyh").append($(opt));
		
	},
	end:function(){
		$("#jsyh").val("");
	}
	,error: function(XmlHttpRequest, textStatus, errorThrown){  
	       if( XmlHttpRequest.status==401){//未授权访问
		   		window.top.location.href="../../login.jsp";
		   }
	    }
	});

	$("#shszdq").prism({content:"ajax:../../ws_area.rp",param:{ACTION_TYPE:"JSONLIST"},begin:function(){
		var opt = "<option value=''>请选择</option>";
		$("#shszdq").append($(opt));
	},
	end:function(){
		$("#shszdq").val("");
	}});
	
	$("#tzqd").prism({content:"ajax:../../channel_info.rp",param:{ACTION_TYPE:"JSONLIST"},begin:function(){
		var opt = "<option value=''>请选择</option>";
		$("#tzqd").append($(opt));
	},
	end:function(){
		$("#tzqd").val("");
	}});
	$("#tzry").prism({content:"ajax:../../operman_info.rp",param:{ACTION_TYPE:"JSONLIST"},begin:function(){
		var opt = "<option value=''>请选择</option>";
		$("#tzry").append($(opt));
	},
	end:function(){
		$("#tzry").val("");
	}});
	
	
	init();
});
function init(){
	var $tranType = $("#tranType");
	$("#tranType").change(function(e) {
        if($(this).val()=="105"){
			$("#mcc").parent("li").show();
			$("#mcc").removeAttr("disabled");
			
			$("input[name=shmdmc]").parent("li").show();
			$("input[name=shmdmc]").removeAttr("disabled");
			
			$("[name=qsjg]").parent("li").show();
			$("[name=qsjg]").removeAttr("disabled");
			
			$("input[name=shlb]").parent("li").show();
			$("input[name=shlb]").removeAttr("disabled");
			
		}else{
			$("#mcc").parent("li").hide();
			$("#mcc").attr("disabled","disabled");
			
			$("input[name=shmdmc]").parent("li").hide();
			$("input[name=shmdmc]").attr("disabled","disabled");
			
			$("[name=qsjg]").parent("li").hide();
			$("[name=qsjg]").attr("disabled","disabled");
			
			$("input[name=shlb]").parent("li").hide();
			$("input[name=shlb]").attr("disabled","disabled");
			
		}
    });

}
/**
 * return true时间选择，false 时间未选择
 */
function timeSelected(){
	   return ($('#startTime').val() != '')&&($('#endTime').val() != '');
}
function find(cur_page){
	var header = $("TH","#tableHead");
	var checkboxs = $(":checkbox","#setTitle");
	for(var i=0;i<checkboxs.length;i++){
		var checkbox = checkboxs.eq(i);
		var key = checkbox.val();
		if(checkbox.is(':checked')){
			header.eq(key).show();
		}else{
			header.eq(key).hide();
		}
	}
	$("#ACTION_TYPE").val("");
	$('#terminalDayGain_Templet').nextAll().remove();
	cur_page = cur_page || 0;
	var row = $('#terminalDayGain_Templet').clone(true);
	$("#cur_page").val(cur_page+1);
	
	$("#detail_custForm").ajaxSubmit({
		dataType:'json',
		error : function(XMLResponse) {
			alert("session超时请重新登录");
			 if( XMLResponse.status==401){//未授权访问
		   		window.top.location.href="../../login.jsp";
		   }
		},
		success: function(json){
			var object = json.resultset;
	        $('#terminalDayGain_Templet').nextAll().remove();
	        if (json.total==0){
	        	$('#cust_Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
	        }
	        var i=0;
			
			$("#terminalDayGain_Templet").prism({content:object,end:function(el,data){
				var tr = $("TR",el);
				for(var j=0;j<tr.length;j++){
					var td = $("TD",tr.eq(j));
					for(var i=0;i<checkboxs.length;i++){
						var checkbox = checkboxs.eq(i);
						var key = checkbox.val();
						if(checkbox.is(':checked')){
							td.eq(key).show();
						}else{
							td.eq(key).hide();
						}
					}
				}
			}});
			
	        $('#cust_Table').mygrid();
	       // document.getElementById('titleName').innerHTML = '终端交易日报表';
	 	   //	document.getElementById('startTime').value = json.startTime;
	    	//document.getElementById('endTime').value = json.endTime;
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
	    
	 }); 
}

function exportReport(){
	var checkboxs = $(":checked","#setTitle");
	var keys = [];
	for(var i=0;i<checkboxs.length;i++){
		keys[i] = checkboxs.eq(i).val();
	}
	$("#ACTION_TYPE").val("EXCEL");
	$("#keys").val(JSON.stringify(keys));
}	

</script>
</head>

<body>

<div id=detailDiv class="left02">
<div class="left02topDiv">
  <div class="left02top_right"></div>
  <div class="left02top_left"></div>
  <div class="left02top_c" id="titleInfo" style="width: 600px">台账报表-&gt;终端归档</div>
</div>
<div class="left02downDiv">
    <ul id="setTitle" style="display:none;">
      <%
for(int i=0;i<list.size();i++){
String[] t = list.get(i);
%>
      <li>
        <input type="checkbox"   checked="checked" key="<%=t[1]%>" value="<%=i%>"/>
        <%=t[0]%></li>
      <%}%>
    </ul>
  <form id="detail_custForm" onsubmit="exportReport()" target="_blank" action="../../terminal_filing.rp"  method="post">
    <div style=" clear:both"></div>
    <div id="search_div">
      <li>
        <label >归档时间:</label>
        <input type="text" name="begin_shgdsj_date"  style="width:60px;"  readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
        -
        <input type="text" name="end_shgdsj_date"  style="width:60px;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
      </li>
     
      
    </div>

    <div style="float:right;">
    
      <input name="submit" type="button" value="查 询" onclick="find(0)"  />
      &nbsp;
      <%Permission per=new PositionPermessionImpl();
				if(per.hasPermission(session, Permission.REPORT_EXPORT))
				{
				%>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="goback" type="submit" value="导出excel"  />
      <%} %>
       
    </div>
    <input type="hidden" id="cur_page" name="cur_page" />
    <input type="hidden"  id="page_size" name="page_size" value="30"/>
    <input type="hidden" id="ACTION_TYPE" name="ACTION_TYPE" value="EXCEL"/>
    <input type="hidden" id="keys" name="keys" />
  </form>
</div>
<div id="listDiv" class="left02">
<div class="left02downDiv">
  <form id="queryForm">
    <table id='cust_Table' class='dataTable1' >
      <thead id="tableHead">
        <tr>
          <%
for(int i=0;i<list.size();i++){
	String[] t = list.get(i);
	out.println("<th class='dataTableHeader'  nowrap='nowrap' style='font-size:12px;'>"+t[0]+"</th>");
}
%>
        </tr>
      </thead>
      <tbody id="terminalDayGain_Templet" prism="dataGrid">
        <tr >
          <%
for(int i=0;i<list.size();i++){
	String[] t = list.get(i);
	out.println("<td class='dataTableHeader' nowrap='nowrap' style='font-size:12px;'>#@"+t[1]+"#</td>");
}
%>
        </tr>
      </tbody>
    </table>
    <div id='cust_Pagination' class='pagination'></div>
    <div id='cust_Searchresult'></div>
  </form>
</div>


</body>
</html>
