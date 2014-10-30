<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.dao.DaoUtils"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="java.io.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>机具变更</title>
<link href="../../css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../../css/tabs.css" media="screen" />
<link rel="stylesheet" href="../../css/dataTable.css" media="screen" />
<link rel="stylesheet" href="../../css/formly.min.css" media="screen" />
<link rel="stylesheet" href="../../css/pagination.css" media="screen" />
<link rel="stylesheet" href="../../css/thickbox.css" media="screen" />
<link rel="stylesheet" href="../../css/tab.css" media="screen" />
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
  table.dataTable1 
{
	border-collapse: collapse;
}
table.dataTable1 th.dataTableHeader {
color: #fff;
background-color: #052d92;
padding: 2px;
border: #fff 1px solid;
text-align: center;
}

table.dataTable1 td {
	padding: 2px;
	border-style: solid;
	border-width: 1px 1px 0 1px;
	border-color: #ccc #fff #ccc #fff;
}

table.dataTable1 td a {
	padding-right: 2px;

}

table.dataTable1 tr.odd_row {
	background-color: #e4f2fb;
}

table.dataTable1 tr.even_row {
	background-color: #f8f8f8;
}

table.dataTable1 tr.odd_row:hover,
table.dataTable1 tr.even_row:hover,
table.dataTable1 tr.odd_row:hover a,
table.dataTable1 tr.even_row:hover a {
	background-color: #FFD900;
}

table.dataTable1 tr.odd_row:hover a:hover,
table.dataTable1 tr.even_row:hover a:hover {
}

table.dataTable1 th.dataTableHeader a,
table.dataTable1 th.dataTableHeader a:link,
table.dataTable1 th.dataTableHeader a:active,
table.dataTable1 th.dataTableHeader a:visited {
	color: #fff;
	display: block;
	text-decoration: none;
}

* html table.dataTable1 th.dataTableHeader a {
	width: 100%;
}

table.dataTable1 th.dataTableHeader a:hover {
	text-decoration: underline;
}

table.dataTable1 {
	border-bottom: 1px solid #fff;
}

table.dataTable1 thead td,
table.dataTable1 tfoot td.dataTableFooter {
	border: 0;
	padding: 0;
}
  </style>
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script src="../../js/Area.js" type="text/javascript"></script>
<script src="../../js/AreaData_min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function(){
		initComplexArea('UNIT_INSTALLED_CITY1', 'UNIT_INSTALLED_CITY', 'UNIT_INSTALLED_STREET', area_array, sub_array, '43', '0', '0');
		$.post("../action/TerminalDataQuery.jsp",{'where':' TEMINAL_INFO_ID='+<%=request.getParameter("terminalId")%>,'singleton':true},function(json){
			json=eval("("+json+")");
			var result=json.resultset[0];
			$("input,select").each(function(){
				var itemId=$(this).attr("id");
				if(itemId=="IS_OVERLAY"){
					$("#IS_OVERLAY").val(result[itemId]);
				}
				else if("INSTALLED_STATUS"==itemId){
					$(this).val(result[itemId]);
				}else if("UNIT_INSTALLED_STREET"==itemId){
					$("#UNIT_INSTALLED_CITY").val(result["UNIT_INSTALLED_CITY"]);
					try{
						$("#UNIT_INSTALLED_CITY").change();
					}catch(e){}
					$("#UNIT_INSTALLED_STREET").val(result["UNIT_INSTALLED_STREET"]);
				}else {
					$("#"+itemId).val(result[itemId]);
				}
			});
			$("#SER").val(result["SERIAL1"]);
		});
	
	});
	utils_serializeForm = function() {
		var hash = {};
		var serialize = $("#updateForm").serializeArray();
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
	utils_submit = function(url) {
		$.ajax( {
			dataType : 'json',
			url : url,
			data : utils_serializeForm(),
			type : 'post',
			success : function(id) {
				if(id<0){
					if(id==-1)
						alert("主机序列号重复");	
					else if(id==-2)
						alert("主机序列号不在仓库中！");
					else alert("更改失败！");
				}else{
					alert("更新成功，刷新页面后显示！");
					window.close();
				}
			},
			error : function(d) {
				alert("操作失败！");
				window.location.reload();
			}
		});
	}
	function beforeSubmit() {
		var allow = "";
		$("#updateForm input:[class!='notRequired'],#updateForm select:[class!='notRequired']").each(function(index, data) {
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
			if($("#UNIT_INSTALLED_CITY").val()==0){
				alert("请选择地址");
				$("#UNIT_INSTALLED_CITY").focus();
				return;
			}else if($("#UNIT_INSTALLED_STREET").val()==0){
				alert("请选择地址");
				$("#UNIT_INSTALLED_STREET").focus();
				return;
			}
			utils_submit("../action/TerminalUpdate.jsp");
			//utils_submit();
		}
	}
	function sigletonSerial1(s){
		var value=$(s).val();
		
		if(value==$("#SER").val()){
			$("#debug_OK").removeAttr("disabled");
			return;
		}
		
		if(null!=value&&$.trim(value).length>0){
			$.post("../action/SigletonSerial1.jsp",{ser:value},function(j){
				if(j>0){
					$("#debug_OK").removeAttr("disabled");
				} else if(j==-1){
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
</head>
<body >
	<center style="margin-top:100px">
	<div class="panel-container">
			<form id="updateForm">
			<input type="hidden" name="TEMINAL_INFO_ID" id="TEMINAL_INFO_ID" readonly="readonly" value="${param.terminalId}"/>
			<table>
				<tr>
				<td align="right">客户装机联系人:</td>
				<td>
					<input type="text" name="UNIT_INSTALLED_MAN" id="UNIT_INSTALLED_MAN"/>
				</td>
				<td align='right'>客户装机联系电话:</td>
				<td>
					<input type="text" name="UNIT_INSTALLED_TEL" id="UNIT_INSTALLED_TEL"/>
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
				</td>
				<td align="right">客户装机地址:</td>
				<td>
					<input type="text" name="UNIT_INSTALLED_ADD" id="UNIT_INSTALLED_ADD"/>
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
				</td>
				<td align="right">加急标志位:</td>
				<td>
					<select name="IS_HURRY" id="IS_HURRY">
						<option value="0">不加急</option>
						<option value="1">加急</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">终端通讯方式:</td>
				<td>
					<select name="COMM_TYPE" id="COMM_TYPE">
						<option value="0">电话模式</option>
						<option value="1">网络模式</option>
					</select>
				</td>
				<td align="right">通讯方式是否绑定:</td>
				<td>
					<select name="IS_BIND" id="IS_BIND">
						<option value="0">不绑定</option>
						<option value="1"> 绑定</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">通讯方式描述:</td>
				<td>
					<input type="text" name="COMM" id="COMM" class="notRequired"/>
				</td>
					<td align="right">主机序列号:</td>
					<td>
						<input type="hidden" name="SER" id="SER"/>
						<input type="text" name="SERIAL1" id="SERIAL1" onblur="sigletonSerial1(this)"/>
						<input type="hidden" name="node" value='4'/>
						<input type="hidden" name="TEMINAL_INFO_ID" value='<c:out value="${param.terminalId }"></c:out>'/>
					</td>
				</tr>
			<tr>
					<td align='right'>键盘序列号:</td>
					<td>
						<input type="text" name="SERIAL2" id="SERIAL2" class="notRequired"/>
					</td>
				</tr>
				
				<tr>
					<td align='right'>机具安装人:</td>
					<td>
						<select id="INST_MAN" name="INST_MAN">
						<option value="">---请选择---</option>
						<%
						DaoUtils daoUtils=new DaoUtils();
						request.setAttribute("installUsers", daoUtils.localTerminalUser(session,Permission.SAFE_POSITION, request.getParameter("terminalId"))); %>
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
			</form>
		
		</div>
		<button style="width: 100px" id="debug_OK" onclick="beforeSubmit()">提交</button>
	</center>
</body>
</html>
