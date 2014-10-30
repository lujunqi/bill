<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
    Operman_info obj = (Operman_info) session.getAttribute("man");
	if (obj == null) {
		out.println("请重新登录!");
		return;
	}
	String teminal_info_id = request.getParameter("teminal_info_id");
	String sql = "select to_char(systimestamp, 'yymmddhh24missff') f,c.CONTACT_TEL_2, c.comm_name,c.trade_name,temp.term_id1,temp.term_id2, (select '实名支付:'||t.term_id1||' 终端编号'||t.term_id2 from term_app_table t where t.teminal_info_id=i.teminal_info_id and t.status=1 and t.apptype='101')|| (select '便捷付:'||t.term_id1||' 终端编号'||t.term_id2 from term_app_table t where t.teminal_info_id=i.teminal_info_id and t.status=1 and t.apptype='103') as demo, i.unit_installed_man,i.unit_installed_tel,c.contact_name_1,i.unit_installed_add, a.account_name, (select b.bank_name from bank_info b where b.bank_code=a.account_bank)as account_bank,a.account_no, case when i.equi_type=0 then '固定POS' when i.equi_type=1 then '移动POS' when i.equi_type=2 then '分体POS' else '其他类型' end as equi_type, i.serial1,i.serial2, (select money from temicost t where t.cost_type=0 and i.teminal_info_id=t.teminal_info_id) as yajin, (select money from temicost t where t.cost_type=2 and i.teminal_info_id=t.teminal_info_id) as txf, (select o.operman_name from operman_info o where o.operman_id=a.e_id) as e_id from teminal_info i,term_app_table temp,commercial_info c,Apppay_105 a where i.teminal_info_id="
			+ teminal_info_id
			+ " and a.apppay_id=temp.apppay_id and i.teminal_info_id=temp.teminal_info_id and c.commercial_id=temp.commercial_id and temp.apptype='105' and temp.status=1";

	DatabaseAccess dba = new DatabaseAccess();
	ResultSet rs = dba.executeQuery(sql);
	if (!rs.next()) {
		rs.close();
		dba.release();
		out.println("  <SCRIPT LANGUAGE=\'JavaScript\'> 	alert(\'没有找到此终端任何数据!\'); this.window.opener = null;window.close();     </SCRIPT>");
		return;
	}
	UtilTime.setDate(new java.util.Date());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>特约商户现场装机培训登记表</TITLE>
<meta charset="utf-8" />
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
<script>
	function print(d) {
		$("#onlyShow iframe").hide();
		PageSetup_Null();
		$("#context").show();
		$("#div0").hide();
		//跳转到打印预览 此方法阻塞
		window.focus();
		document.all.wb.ExecWB(6, 1);
		$("#div0").show();
		$("#onlyShow iframe").show();
		$("#context").hide();
		//只有关闭后才可以显示
		//重新将所有的内容全部显示
	}

	function printView() {
		PageSetup_Null();
		$("#div0").hide();
		document.all.wb.ExecWB(7, 1);
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

.baseMsg div {
	height: 20pt;
}

.baseMsg {
	width: 500pt;
}

.baseMsg .w50 {
	float: left;
	width: 50pt;
}

.baseMsg .w80 {
	float: left;
	width: 80pt;
}

.baseMsg .w100 {
	float: left;
	width: 100pt;
}

.baseMsg .w120 {
	float: left;
	width: 120pt;
}

.baseMsg .w150 {
	float: left;
	width: 150pt;
}

.baseMsg .w160 {
	float: left;
	width: 160pt;
}

.baseMsg .w180 {
	float: left;
	width: 180pt;
}

.baseMsg .w190 {
	float: left;
	width: 190pt;
}

.baseMsg .w200 {
	float: left;
	width: 200pt;
}

.baseMsg .w230 {
	float: left;
	width: 250pt;
}

.baseMsg .w250 {
	float: left;
	width: 250pt;
}

.baseMsg .w500 {
	float: left;
	width: 500pt;
}
</style>
</HEAD>

<BODY>
	<div id="onlyShow">
		<iframe width="100%" height="100%" frameborder="0"
			src="printTeminalInfoShow.jsp?teminal_info_id=<%=request.getParameter("teminal_info_id")%>"></iframe>
	</div> 
	<div style="display: none"  id="context">
		<div id="mainDiv"
			style="width: 500pt; height: 500pt; background-repeat: no-repeat;">
			<div
				style="width: 100%; height: 50%; margin-left: 8.8%; margin-top: 11%;">
				<div class="baseMsg">
					<div name="w80" class="w80"></div>
					<div name="w80" class="w180">2014&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=UtilTime.getMouth() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=UtilTime.getDay() %></div>
					<div name="w100" class="w150" style="text-align: right;"><%=rs.getString("f")%></div>
				</div>
				<div class="baseMsg">
					<div name="w100" class="w200"><%=rs.getString("comm_name")%></div>
					<div name="w160" style="float: left;width: 60pt"></div>
					<div name="w100" style="float: left;width: 240pt"><%=rs.getString("trade_name")%></div>
				</div>
				<div class="baseMsg">
					<div name="w100" class="w100"><%=rs.getString("term_id1")%></div>
					<div name="w160" class="w160"></div>
					<div name="w100" class="w100"><%=rs.getString("term_id2")%></div>
				</div>
				<div class="baseMsg">
					<div name="w500" class="w500"><%=(rs.getString("demo")==null?"":rs.getString("demo"))%></div>
				</div>
				<div class="baseMsg">
					<div name="w150" class="w150"><%=rs.getString("unit_installed_man")%></div>
					<div name="w200" class="w200"><%=rs.getString("unit_installed_tel")%></div>
					<div name="w150" class="w150"><%=(rs.getString("CONTACT_TEL_2")==null?"":rs.getString("CONTACT_TEL_2"))%></div>
				</div>
				<div class="baseMsg">
					<div name="w100" style="width: 500px" ><%=rs.getString("unit_installed_add")%></div>
				</div>
				<div class="baseMsg">
					<div name="w100" class="w100"><%=rs.getString("account_name")%></div>
					<div name="w160" class="w160"></div>
					<div name="w100" class="w100"><%=rs.getString("account_bank")%></div>
				</div>
				<div class="baseMsg">
					<div name="w500" class="w500"><%=rs.getString("account_no")%></div>
				</div>
				<div class="baseMsg">
					<div name="w190" class="w190"><%=rs.getString("equi_type")%></div>
					<div name="w160" class="w160"><%=rs.getString("serial1")%></div>
					<div name="w120" class="w120"><%=rs.getString("serial2")%></div>
				</div>
				<div style="width: 500pt; height: 60%"></div>
			</div>
			<div
				style="height: 500pt; width: 100%; margin-left: 9%; background-repeat: no-repeat;">
				<div style="width: 500pt; margin-top: 45pt">
					<div class="baseMsg">
						<div class="w100" name="w100"></div>
						<div class="w100" name="w100"></div>
					</div>
					<div class="baseMsg">
						<div style="width: 30pt;float: left" name="w30"></div>
						<div style="width: 200pt;float: left"  name="w220"><%=rs.getString("yajin")%></div>
						<div class="w150" name="w100"><%=(rs.getString("txf")==null?"":rs.getString("txf"))%></div>
					</div>
					<div class="baseMsg" style="margin-top: 120pt">
						<div style="width: 130pt;float: left" name="w30"><%=rs.getString("e_id")%></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="div0">
		<OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height=0
			id=wb name=wb width=0></OBJECT>
		<input type=button value="打印" onclick='print("1")'
			style="width: 100px">
	</div>
</BODY>
</HTML>
<%
    rs.close();
    dba.release();
%>
