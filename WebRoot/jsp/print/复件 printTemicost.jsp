<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@page import="com.szzt.util.ConvertMoneyToUppercase"%>
<%@ include file="../../import.jsp"%>
<%
	Operman_info obj = (Operman_info)session.getAttribute("man");
	if (obj == null){
	    out.println("请重新登录!");
	    return;
	}
	String teminal_info_id = request.getParameter("teminal_info_id");
    String sql = " select (select count(*) from temicost_his h where h.teminal_info_id=i.teminal_info_id)as total,"
	+"temp.commercial_id||temp.apppay_id||temp.teminal_info_id as seq, temp.term_id1,  i.serial1,  c.comm_name,  "
    +"t.money,(select o.operman_name from operman_info o where o.operman_id=i.inst_man) as skr   from teminal_info i,"
    +"term_app_table temp,commercial_info c,temicost t    where i.teminal_info_id="+teminal_info_id+"    "
    +"and i.teminal_info_id=t.teminal_info_id    and i.teminal_info_id=temp.teminal_info_id   "
    +"and c.commercial_id=temp.commercial_id    and temp.apptype='105'    and temp.status=1    and t.cost_type=0";
	
	DatabaseAccess dba = new DatabaseAccess();
	ResultSet rs = dba.executeQuery(sql);
	if (!rs.next()) {
		rs.close();
		dba.release();
		out.println("  <SCRIPT LANGUAGE=\'JavaScript\'> 	alert(\'没有找到此终端任何数据!\'); this.window.opener = null;window.close();     </SCRIPT>");
		return;
	}
	UtilTime.setDate(new java.util.Date());
	double value = Double.parseDouble(rs.getString("money"));   
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>机具收据打印</TITLE>
<meta charset="utf-8" />
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
<script>
	function print(d) {

		$.ajax({
			url:'./temicostHis.jsp',
			dataType:'json',
			type:'POST',
			data:{'teminal_info_id':<%=teminal_info_id%>,'seq':'<%=rs.getString("seq")%>'},
			success: function(json){
				PageSetup_Null();
				$("#div1").show();
				$("table").css({});
				$("#div0").hide();
				$("#mainDiv").css({
					'background-image' : ''
				});
				//跳转到打印预览 此方法阻塞
				window.focus();
				document.all.wb.ExecWB(6, 1);
				$("#mainDiv").css({
					'background-image' : "url('p3.png')"
				});
				$("#div0").show();
				window.close();
				//只有关闭后才可以显示
				//重新将所有的内容全部显示
	    	},  
		    error: function(XmlHttpRequest, textStatus, errorThrown){  
		    	alert("此票据序号已重复！");
		    }
		 }); 
	}

	function printView() {
		PageSetup_Null();
		eval("div0").style.visibility = "hidden";
		eval("div1").style.visibility = "visible";
		document.all.wb.ExecWB(7, 1);
		//重新将所有的内容全部显示
		for (i = 0; i < 1; i++) {
			eval("div" + i).style.visibility = "visible";
		}
	}
</script>

<SCRIPT language=javascript>
	var HKEY_Root, HKEY_Path, HKEY_Key;
	HKEY_Root = "HKEY_CURRENT_USER";
	HKEY_Path = "\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
	var head, foot, top, bottom, left, right;

	//取得页面打印设置的原参数数据
	function PageSetup_temp() {
		try {
			var Wsh = new ActiveXObject("WScript.Shell");
			HKEY_Key = "header";
			//取得页眉默认值
			head = Wsh.RegRead(HKEY_Root + HKEY_Path + HKEY_Key);
			HKEY_Key = "footer";
			//取得页脚默认值
			foot = Wsh.RegRead(HKEY_Root + HKEY_Path + HKEY_Key);
			HKEY_Key = "margin_bottom";
			//取得下页边距
			bottom = Wsh.RegRead(HKEY_Root + HKEY_Path + HKEY_Key);
			HKEY_Key = "margin_left";
			//取得左页边距
			left = Wsh.RegRead(HKEY_Root + HKEY_Path + HKEY_Key);
			HKEY_Key = "margin_right";
			//取得右页边距
			right = Wsh.RegRead(HKEY_Root + HKEY_Path + HKEY_Key);
			HKEY_Key = "margin_top";
			//取得上页边距
			top = Wsh.RegRead(HKEY_Root + HKEY_Path + HKEY_Key);
		} catch (e) {
			alert("不允许ActiveX控件" + e);
		}
		alert(left + ":" + bottom + ":" + top + ":" + right);
	}

	//设置网页打印的页眉页脚和页边距
	function PageSetup_Null() {
		try {
			var Wsh = new ActiveXObject("WScript.Shell");
			HKEY_Key = "header";
			//设置页眉（为空）
			Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "");
			HKEY_Key = "footer";
			//设置页脚（为空）
			Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "");
			HKEY_Key = "margin_bottom";
			//设置下页边距（0）
			Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "0");
			HKEY_Key = "margin_left";
			//设置左页边距（0）
			Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "0.2");
			HKEY_Key = "margin_right";
			//设置右页边距（0）
			Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "0");
			HKEY_Key = "margin_top";
			//设置上页边距（8）
			Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "0.7");
		} catch (e) {
			//	alert("不允许ActiveX控件22"+e.message);
		}
	}

	//设置网页打印的页眉页脚和页边距为默认值
	function PageSetup_Default() {
		try {
			var Wsh = new ActiveXObject("WScript.Shell");
			HKEY_Key = "header";
			HKEY_Key = "header";
			//还原页眉
			Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, head);
			HKEY_Key = "footer";
			//还原页脚
			Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, foot);
			HKEY_Key = "margin_bottom";
			//还原下页边距
			Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, bottom);
			HKEY_Key = "margin_left";
			//还原左页边距
			Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, left);
			HKEY_Key = "margin_right";
			//还原右页边距
			Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, right);
			HKEY_Key = "margin_top";
			//还原上页边距
			Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, top);
		} catch (e) {
			alert("不允许ActiveX控件11");
		}
	}
</script>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
}
</style>
</HEAD>

<BODY>
	<div>
		<div id="mainDiv"
			style="background-image: url('p3.png'); background-repeat: no-repeat; width: 60%; height: 500px;">
			<table
				style="width: 100%; height: 50%; margin-left: 9%; margin-top: 6.5%;"
				border="0">
				<tr>
					<td colspan="2"><font id="commercialNo"><%=rs.getString("seq") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					第<%=(rs.getInt("total")+1) %>次打印</font></td>
					<td  style="text-align: right">2014&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;<%=UtilTime.getMouth() %>&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;<%=UtilTime.getDay() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td ><%=rs.getString("term_id1") %></td>
					<td >&nbsp;</td>
					<td ><%=rs.getString("serial1") %></td>
				</tr>
				<tr>
					<td colspan="3"><%=rs.getString("comm_name") %></td>
				</tr>
				<tr>
					<td><%=rs.getString("money") %></td>
					<td></td>
					<td>POS机具押金</td>
				</tr>
				<tr>
					<td colspan="3"><%=ConvertMoneyToUppercase.convertMoney(value) %></td>
				</tr>
				<tr>
					<td ><%=obj.getOperman_name() %></td>
					<td ><%=rs.getString("skr") %></td>
					<td style="text-align: right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
	<div id=div0>
		<OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height=0
			id=wb name=wb width=0></OBJECT>
		<input type=button value="打印" onclick='print("1")'
			style="width: 100px">
	</div>
</BODY>
</HTML>
<%
try{
	rs.close();
	dba.release();
}catch(Exception e){}
%>