<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
    Operman_info obj = (Operman_info) session.getAttribute("man");
	if (obj == null) {
		out.println("请重新登录!");
		return;
	}
	String teminal_info_id = request.getParameter("teminal_info_id");
	String sql = "select to_char(systimestamp, 'yymmddhh24missff') f,        contact_tel_2,        c.comm_name,        c.trade_name,        '-' as term_id1,        '-' as term_id2,       (select '收单:' || t.term_id1 || ' 终端编号' || t.term_id2           from term_app_table t          where t.teminal_info_id = i.teminal_info_id            and t.status = 1            and t.apptype = '105') ||        (select '实名支付:' || t.term_id1 || ' 终端编号' || t.term_id2           from term_app_table t          where t.teminal_info_id = i.teminal_info_id            and t.status = 1            and t.apptype = '101') ||  (select '收付宝账单号:' || a.order_no           from apppay_102 a          where a.apppay_id = temp.apppay_id            and temp.status = 1            and temp.apptype = '102') ||      (select '便捷付:' || t.term_id1 || ' 终端编号' || t.term_id2           from term_app_table t          where t.teminal_info_id = i.teminal_info_id            and t.status = 1            and t.apptype = '103') as demo,        i.unit_installed_man,        i.unit_installed_tel,        c.contact_name_1,        i.unit_installed_add,        (select a.account_name from Apppay_105 a where a.apppay_id=temp.apppay_id and temp.apptype=105)||        (select a.account_name from Apppay_101 a where a.apppay_id=temp.apppay_id and temp.apptype=101)||        (select a.account_name from Apppay_103 a where a.apppay_id=temp.apppay_id and temp.apptype=103) as account_name        ,        (select (select b.bank_name from bank_info b where b.bank_code = a.account_bank) from Apppay_105 a where a.apppay_id=temp.apppay_id and temp.apptype=105)||        (select (select b.bank_name from bank_info b where b.bank_code = a.account_bank) from Apppay_101 a where a.apppay_id=temp.apppay_id and temp.apptype=101)||        (select (select b.bank_name from bank_info b where b.bank_code = a.account_bank) from Apppay_103 a where a.apppay_id=temp.apppay_id and temp.apptype=103) as account_bank                 ,                (select a.account_no from Apppay_105 a where a.apppay_id=temp.apppay_id and temp.apptype=105)||'-'||        (select a.account_no from Apppay_101 a where a.apppay_id=temp.apppay_id and temp.apptype=101)||'-'||        (select a.account_no from Apppay_103 a where a.apppay_id=temp.apppay_id and temp.apptype=103) as account_no                 ,        case          when i.equi_type = 0 then           '固定POS'          when i.equi_type = 1 then           '移动POS'          when i.equi_type = 2 then           '分体POS'          else           '其他类型'        end as equi_type,        i.serial1,        i.serial2,        (select money           from temicost t          where t.cost_type = 0            and i.teminal_info_id = t.teminal_info_id) as yajin,        (select money           from temicost t          where t.cost_type = 2            and i.teminal_info_id = t.teminal_info_id) as txf,(select money           from temicost t          where t.cost_type = 1            and i.teminal_info_id = t.teminal_info_id) as fwf,        (select (select o.operman_name from operman_info o where o.operman_id = a.e_id) from Apppay_105 a where a.apppay_id=temp.apppay_id and temp.apptype=105)||        (select (select o.operman_name from operman_info o where o.operman_id = a.e_id) from Apppay_101 a where a.apppay_id=temp.apppay_id and temp.apptype=101)||        (select (select o.operman_name from operman_info o where o.operman_id = a.e_id) from Apppay_103 a where a.apppay_id=temp.apppay_id and temp.apptype=103) as e_id              from teminal_info i, term_app_table temp, commercial_info c  where i.teminal_info_id = "+teminal_info_id+"          and i.teminal_info_id = temp.teminal_info_id    and c.commercial_id = temp.commercial_id    and temp.status = 1";

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
<html xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:w="urn:schemas-microsoft-com:office:word"
	xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<title>特约商户现场装机培训登记表</title>
<!--[if gte mso 9]><xml><w:WordDocument><w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel><w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEvery><w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery><w:DocumentKind>DocumentNotSpecified</w:DocumentKind><w:DrawingGridVerticalSpacing>7.8</w:DrawingGridVerticalSpacing><w:View>Web</w:View><w:Compatibility><w:DontGrowAutofit/></w:Compatibility><w:Zoom>0</w:Zoom></w:WordDocument></xml><![endif]-->
<!--[if gte mso 9]><xml><w:LatentStyles DefLockedState="false"  DefUnhideWhenUsed="true"  DefSemiHidden="true"  DefQFormat="false"  DefPriority="99"  LatentStyleCount="156" ><w:LsdException Locked="false"  Priority="0"  SemiHidden="false"  UnhideWhenUsed="false"  QFormat="true"  Name="Normal" ></w:LsdException><w:LsdException Locked="false"  Priority="9"  SemiHidden="false"  UnhideWhenUsed="false"  QFormat="true"  Name="heading 1" ></w:LsdException><w:LsdException Locked="false"  Priority="9"  QFormat="true"  Name="heading 2" ></w:LsdException><w:LsdException Locked="false"  Priority="9"  QFormat="true"  Name="heading 3" ></w:LsdException><w:LsdException Locked="false"  Priority="9"  QFormat="true"  Name="heading 4" ></w:LsdException><w:LsdException Locked="false"  Priority="9"  QFormat="true"  Name="heading 5" ></w:LsdException><w:LsdException Locked="false"  Priority="9"  QFormat="true"  Name="heading 6" ></w:LsdException><w:LsdException Locked="false"  Priority="9"  QFormat="true"  Name="heading 7" ></w:LsdException><w:LsdException Locked="false"  Priority="9"  QFormat="true"  Name="heading 8" ></w:LsdException><w:LsdException Locked="false"  Priority="9"  QFormat="true"  Name="heading 9" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="index 1" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="index 2" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="index 3" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="index 4" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="index 5" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="index 6" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="index 7" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="index 8" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="index 9" ></w:LsdException><w:LsdException Locked="false"  Priority="39"  Name="toc 1" ></w:LsdException><w:LsdException Locked="false"  Priority="39"  Name="toc 2" ></w:LsdException><w:LsdException Locked="false"  Priority="39"  Name="toc 3" ></w:LsdException><w:LsdException Locked="false"  Priority="39"  Name="toc 4" ></w:LsdException><w:LsdException Locked="false"  Priority="39"  Name="toc 5" ></w:LsdException><w:LsdException Locked="false"  Priority="39"  Name="toc 6" ></w:LsdException><w:LsdException Locked="false"  Priority="39"  Name="toc 7" ></w:LsdException><w:LsdException Locked="false"  Priority="39"  Name="toc 8" ></w:LsdException><w:LsdException Locked="false"  Priority="39"  Name="toc 9" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Normal Indent" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="footnote text" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="annotation text" ></w:LsdException><w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="header" ></w:LsdException><w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footer" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="index heading" ></w:LsdException><w:LsdException Locked="false"  Priority="35"  QFormat="true"  Name="caption" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="table of figures" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="envelope address" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="envelope return" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="footnote reference" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="annotation reference" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="line number" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="page number" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="endnote reference" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="endnote text" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="table of authorities" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="macro" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="toa heading" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Bullet" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Number" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List 2" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List 3" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List 4" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List 5" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Bullet 2" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Bullet 3" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Bullet 4" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Bullet 5" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Number 2" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Number 3" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Number 4" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Number 5" ></w:LsdException><w:LsdException Locked="false"  Priority="10"  SemiHidden="false"  UnhideWhenUsed="false"  QFormat="true"  Name="Title" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Closing" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Signature" ></w:LsdException><w:LsdException Locked="false"  Priority="1"  Name="Default Paragraph Font" ></w:LsdException><w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  UnhideWhenUsed="false"  Name="Body Text" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Body Text Indent" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Continue" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Continue 2" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Continue 3" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Continue 4" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="List Continue 5" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Message Header" ></w:LsdException><w:LsdException Locked="false"  Priority="11"  SemiHidden="false"  UnhideWhenUsed="false"  QFormat="true"  Name="Subtitle" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Salutation" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Date" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Body Text First Indent" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Body Text First Indent 2" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Note Heading" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Body Text 2" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Body Text 3" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Body Text Indent 2" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Body Text Indent 3" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Block Text" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Hyperlink" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="FollowedHyperlink" ></w:LsdException><w:LsdException Locked="false"  Priority="22"  SemiHidden="false"  UnhideWhenUsed="false"  QFormat="true"  Name="Strong" ></w:LsdException><w:LsdException Locked="false"  Priority="20"  SemiHidden="false"  UnhideWhenUsed="false"  QFormat="true"  Name="Emphasis" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Document Map" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Plain Text" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="E-mail Signature" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="Normal (Web)" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="HTML Acronym" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="HTML Address" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="HTML Cite" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="HTML Code" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="HTML Definition" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="HTML Keyboard" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="HTML Preformatted" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="HTML Sample" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="HTML Typewriter" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="HTML Variable" ></w:LsdException><w:LsdException Locked="false"  Priority="99"  Name="Normal Table" ></w:LsdException><w:LsdException Locked="false"  Priority="0"  Name="annotation subject" ></w:LsdException><w:LsdException Locked="false"  Priority="99"  Name="No List" ></w:LsdException><w:LsdException Locked="false"  Priority="99"  Name="Balloon Text" ></w:LsdException></w:LatentStyles></xml><![endif]-->
<style>
@font-face {
	font-family: "Times New Roman";
}

@font-face {
	font-family: "宋体";
}

@font-face {
	font-family: "微软雅黑";
}

@font-face {
	font-family: "Tahoma";
}

@font-face {
	font-family: "Symbol";
}

@font-face {
	font-family: "Arial";
}

@font-face {
	font-family: "黑体";
}

@font-face {
	font-family: "Courier New";
}

@font-face {
	font-family: "Wingdings";
}

@font-face {
	font-family: "Calibri";
}

@font-face {
	font-family: "仿宋_GB2312";
}

@font-face {
	font-family: "Cambria";
}

@
list l0:level1 {
	mso-level-number-format: decimal;
	mso-level-suffix: tab;
	mso-level-text: "%1.";
	mso-level-tab-stop: 39.0000pt;
	mso-level-number-position: left;
	margin-left: 39.0000pt;
	text-indent: -18.0000pt;
	margin-bottom: 0pt;
	margin-top: 0pt;
	font-family: 'Times New Roman';
}

@
list l1:level1 {
	mso-level-number-format: bullet;
	mso-level-suffix: tab;
	mso-level-text: \F06C;
	mso-level-tab-stop: 81.0000pt;
	mso-level-number-position: left;
	margin-left: 81.0000pt;
	text-indent: -18.0000pt;
	margin-bottom: 0pt;
	margin-top: 0pt;
	font-family: 'Wingdings';
}

@
list l2:level1 {
	mso-level-number-format: decimal;
	mso-level-suffix: tab;
	mso-level-text: "%1.";
	mso-level-tab-stop: 18.0000pt;
	mso-level-number-position: left;
	margin-left: 18.0000pt;
	text-indent: -18.0000pt;
	margin-bottom: 0pt;
	margin-top: 0pt;
	font-family: 'Times New Roman';
}

@
list l3:level1 {
	mso-level-number-format: bullet;
	mso-level-suffix: tab;
	mso-level-text: \F06C;
	mso-level-tab-stop: 18.0000pt;
	mso-level-number-position: left;
	margin-left: 18.0000pt;
	text-indent: -18.0000pt;
	margin-bottom: 0pt;
	margin-top: 0pt;
	font-family: 'Wingdings';
}

@
list l4:level1 {
	mso-level-number-format: bullet;
	mso-level-suffix: tab;
	mso-level-text: \F06C;
	mso-level-tab-stop: 60.0000pt;
	mso-level-number-position: left;
	margin-left: 60.0000pt;
	text-indent: -18.0000pt;
	margin-bottom: 0pt;
	margin-top: 0pt;
	font-family: 'Wingdings';
}

@
list l5:level1 {
	mso-level-number-format: decimal;
	mso-level-suffix: tab;
	mso-level-text: "%1.";
	mso-level-tab-stop: 60.0000pt;
	mso-level-number-position: left;
	margin-left: 60.0000pt;
	text-indent: -18.0000pt;
	margin-bottom: 0pt;
	margin-top: 0pt;
	font-family: 'Times New Roman';
}

@
list l6:level1 {
	mso-level-number-format: bullet;
	mso-level-suffix: tab;
	mso-level-text: \F06C;
	mso-level-tab-stop: 39.0000pt;
	mso-level-number-position: left;
	margin-left: 39.0000pt;
	text-indent: -18.0000pt;
	margin-bottom: 0pt;
	margin-top: 0pt;
	font-family: 'Wingdings';
}

@
list l7:level1 {
	mso-level-number-format: bullet;
	mso-level-suffix: tab;
	mso-level-text: \F06C;
	mso-level-tab-stop: 102.0000pt;
	mso-level-number-position: left;
	margin-left: 102.0000pt;
	text-indent: -18.0000pt;
	margin-bottom: 0pt;
	margin-top: 0pt;
	font-family: 'Wingdings';
}

@
list l8:level1 {
	mso-level-number-format: decimal;
	mso-level-suffix: tab;
	mso-level-text: "%1.";
	mso-level-tab-stop: 81.0000pt;
	mso-level-number-position: left;
	margin-left: 81.0000pt;
	text-indent: -18.0000pt;
	margin-bottom: 0pt;
	margin-top: 0pt;
	font-family: 'Times New Roman';
}

@
list l9:level1 {
	mso-level-number-format: decimal;
	mso-level-suffix: tab;
	mso-level-text: "%1.";
	mso-level-tab-stop: 102.0000pt;
	mso-level-number-position: left;
	margin-left: 102.0000pt;
	text-indent: -18.0000pt;
	margin-bottom: 0pt;
	margin-top: 0pt;
	font-family: 'Times New Roman';
}

p.p0 {
	margin: 0pt;
	margin-bottom: 0.0001pt;
	margin-bottom: 0pt;
	margin-top: 0pt;
	text-align: justify;
	font-size: 10.5000pt;
	font-family: 'Times New Roman';
}

h1 {
	margin-bottom: 16.5000pt;
	margin-top: 17.0000pt;
	page-break-after: void;
	text-align: justify;
	line-height: 240%;
	font-weight: bold;
	font-size: 22.0000pt;
	font-family: 'Times New Roman';
}

span.10 {
	font-family: 'Calibri';
}

span.15 {
	font-weight: bold;
	font-size: 22.0000pt;
	font-family: 'Times New Roman';
}

span.16 {
	font-size: 9.0000pt;
	font-family: 'Calibri';
}

span.17 {
	font-size: 9.0000pt;
	font-family: 'Calibri';
}

span.18 {
	font-size: 15.0000pt;
	font-family: 'Arial';
}

span.19 {
	font-size: 9.0000pt;
	font-family: 'Times New Roman';
}

p.p20 {
	margin-bottom: 0pt;
	margin-top: 0pt;
	layout-grid-mode: char;
	text-align: left;
	vertical-align:;
	font-size: 12.0000pt;
	font-family: 'Arial';
}

p.p21 {
	margin-bottom: 0pt;
	margin-top: 0pt;
	text-align: justify;
	font-size: 9.0000pt;
	font-family: 'Times New Roman';
}

p.p22 {
	margin-bottom: 0pt;
	margin-top: 0pt;
	border-bottom: 0.7500pt solid rgb(0, 0, 0);
	mso-border-bottom-alt: 0.7500pt solid rgb(0, 0, 0);
	padding: 0pt 0pt 1pt 0pt;
	text-align: center;
	font-size: 9.0000pt;
	font-family: 'Calibri';
}

p.p23 {
	margin-bottom: 0pt;
	margin-top: 0pt;
	text-align: left;
	font-size: 9.0000pt;
	font-family: 'Calibri';
}

p.p24 {
	margin-bottom: 0pt;
	margin-top: 0pt;
	text-align: justify;
	font-size: 10.5000pt;
	font-family: 'Times New Roman';
}

@page {
	mso-page-border-surround-header: no;
	mso-page-border-surround-footer: no;
}

@page Section0 {
	margin-top: 56.7000pt;
	margin-bottom: 63.8000pt;
	margin-left: 70.9000pt;
	margin-right: 90.0000pt;
	size: 595.3000pt 841.9000pt;
	layout-grid: 15.6000pt;
}

div.Section0 {
	page: Section0;
}
</style>
</head>
<body style="tab-interval:21pt; text-justify-trim:punctuation; ">
	<!--StartFragment-->
	<div class="Section0" style="layout-grid:15.6000pt;
">
		<p class=p24
			style="margin-left:84.0000pt; text-indent:21.0000pt; margin-bottom:0pt; margin-top:0pt; text-align:justify; line-height:22.0000pt; ">
			<span
				style="mso-spacerun:'yes'; font-weight:bold; font-size:14.0000pt; font-family:'仿宋_GB2312'; ">特约商户现场装机培训登记表</span><span
				style="mso-spacerun:'yes'; font-weight:bold; font-size:14.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
		</p>
		<p class=p0
			style="margin-left:105.0000pt; text-indent:21.0000pt; margin-right:5.5000pt; margin-bottom:0pt; margin-top:0pt; text-align:justify; line-height:22.0000pt; ">
			<span
				style="mso-spacerun:'yes'; font-weight:bold; font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;&nbsp;</span><span
				style="mso-spacerun:'yes'; font-weight:bold; font-size:12.0000pt; font-family:'仿宋_GB2312'; "><span id="year">2014</span>年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="mon"><%=UtilTime.getMouth() %></span>月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="day"><%=UtilTime.getDay() %></span>日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编号：<span id="no"><%=rs.getString("f")%></span></span><span
				style="mso-spacerun:'yes'; font-weight:bold; font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
		</p>
		<table
			style="border-collapse:collapse;
width:466.1000pt; margin-left:-8.8000pt; mso-table-layout-alt:fixed;
padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; ">
			<tr style="height:19.8500pt; ">
				<td width=95 valign=center colspan=3
					style="width:71.7500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">注册名称</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=235 valign=center colspan=6
					style="width:176.3500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><span id="unit_name"><%=rs.getString("comm_name")%></span> </o:p></span>
					</p></td>
				<td width=85 valign=center colspan=2
					style="width:63.8000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">经营名称</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=205 valign=center colspan=6
					style="width:154.2000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><span id="comm_name"><%=rs.getString("trade_name")%></span></o:p></span>
					</p></td>
			</tr>
			<tr style="height:20.2000pt; ">
				<td width=95 valign=center colspan=3
					style="width:71.7500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-left:-5.3550pt; text-indent:1.5600pt; margin-left:-1.5600pt; margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">商户编码</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=235 valign=center colspan=6
					style="width:176.3500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p> <span id="term_id1"><%=rs.getString("term_id1")%></span></o:p></span>
					</p></td>
				<td width=85 valign=center colspan=2
					style="width:63.8000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">终端编码</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=205 valign=center colspan=6
					style="width:154.2000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><span id="term_id2"><%=rs.getString("term_id2")%></span> </o:p></span>
					</p></td>
			</tr>
			<tr style="height:19.8500pt; ">
				<td width=95 valign=center colspan=3
					style="width:71.7500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">备&nbsp;&nbsp;&nbsp;&nbsp;注</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=525 valign=center colspan=14
					style="width:394.3500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><span id="remark_info"><%=(rs.getString("demo")==null?"":rs.getString("demo"))%></span> </o:p></span>
					</p></td>
			</tr>
			<tr style="height:19.8500pt; ">
				<td width=95 valign=center colspan=3
					style="width:71.7500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">装机联系人</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=93 valign=center
					style="width:70.0500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><span id="unit_installed_man"><%=rs.getString("unit_installed_man")%></span> </o:p></span>
					</p></td>
				<td width=85 valign=center colspan=3
					style="width:63.8000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">移动电话</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=139 valign=center colspan=3
					style="width:104.2500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><span id="unit_installed_tel"><%=rs.getString("unit_installed_tel")%></span></o:p></span>
					</p></td>
				<td width=87 valign=center colspan=4
					style="width:65.8500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">座机电话</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=120 valign=center colspan=3
					style="width:90.4000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><span id="contact_tel_2"><%=rs.getString("contact_tel_2")%></span></o:p></span>
					</p></td>
			</tr>
			<tr style="height:19.8500pt; ">
				<td width=95 valign=center colspan=3
					style="width:71.7500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">装机地址</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=525 valign=center colspan=14
					style="width:394.3500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><%=rs.getString("unit_installed_add")%></o:p></span>
					</p></td>
			</tr>
			<tr style="height:19.8500pt; ">
				<td width=95 valign=center colspan=3
					style="width:71.7500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">账户名称</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=235 valign=center colspan=6
					style="width:176.3500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><%=rs.getString("account_name")%></o:p></span>
					</p></td>
				<td width=85 valign=center colspan=2
					style="width:63.8000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">开户银行</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=205 valign=center colspan=6
					style="width:154.2000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><%=rs.getString("account_bank")%></o:p></span>
					</p></td>
			</tr>
			<tr style="height:19.8500pt; ">
				<td width=95 valign=center colspan=3
					style="width:71.7500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">结算账号</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=525 valign=center colspan=14
					style="width:394.3500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><%=rs.getString("account_no")%></o:p></span>
					</p></td>
			</tr>
			<tr style="height:18.8500pt; ">
				<td width=95 valign=center colspan=3
					style="width:71.7500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">机具类型</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=150 valign=center colspan=3
					style="width:112.5500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><%=rs.getString("equi_type")%></o:p></span>
					</p></td>
				<td width=85 valign=center colspan=3
					style="width:63.8000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">机身号</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=122 valign=center colspan=4
					style="width:92.1500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><%=rs.getString("serial1")%></o:p></span>
					</p></td>
				<td width=66 valign=center colspan=2
					style="width:49.6000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">键盘号</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=101 valign=center colspan=2
					style="width:76.2500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><%=rs.getString("serial2")%></o:p></span>
					</p></td>
			</tr>
			<tr style="height:19.8500pt; ">
				<td width=95 valign=center colspan=3
					style="width:71.7500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">开通类型</span><span
							style="font-size:11.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=525 valign=center colspan=14
					style="width:394.3500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&#9633;查询</span><span
							style="font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;</span><span
							style="mso-spacerun:'yes'; font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&#9633;消费类</span><span
							style="font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;</span><span
							style="mso-spacerun:'yes'; font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&#9633;撤销类</span><span
							style="font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;</span><span
							style="mso-spacerun:'yes'; font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&#9633;预授权类</span><span
							style="font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;</span><span
							style="mso-spacerun:'yes'; font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&#9633;退货</span><span
							style="font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;</span><span
							style="mso-spacerun:'yes'; font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&#9633;离线交易</span><span
							style="font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;</span><span
							style="mso-spacerun:'yes'; font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&#9633;转账</span><span
							style="font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;</span><span
							style="mso-spacerun:'yes'; font-size:11.0000pt; font-family:'仿宋_GB2312'; ">&#9633;其它</span><span
							style="font-size:11.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height:19.8500pt; ">
				<td width=621 valign=top colspan=17
					style="width:466.1000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">一、培训资料</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&#9633;&nbsp;业务受理培训手册&nbsp;&nbsp;&nbsp;<a
							name="OLE_LINK1">&#9633;</a>&nbsp;终端操作手册&nbsp;&nbsp;&nbsp;&#9633;&nbsp;受理商户操作指南&nbsp;&nbsp;&nbsp;
						</span><span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">二、主要培训内容</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p0
						style="margin-bottom:3.0000pt; margin-top:3.0000pt; page-break-after:void; text-align:left; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&#9633;银行卡基本知识&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#9633;POS终端机具操作流程和要求</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p0
						style="margin-bottom:3.0000pt; margin-top:3.0000pt; page-break-after:void; text-align:left; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&#9633;银行卡的识别及受理要求&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#9633;交易单据的保管和调单处理要求&nbsp;&nbsp;</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p0
						style="margin-bottom:3.0000pt; margin-top:3.0000pt; page-break-after:void; text-align:left; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&#9633;没收卡的处理流程&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#9633;商户风险责任及风险防范知识</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p0
						style="margin-bottom:3.0000pt; margin-top:3.0000pt; page-break-after:void; text-align:left; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&#9633;常见欺诈行为的识别及应对技巧&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#9633;IC卡受理流程</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p0
						style="margin-bottom:3.0000pt; margin-top:3.0000pt; page-break-after:void; text-align:left; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&#9633;客服电话及片区客户经理服务电话</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&#9;</span><span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#9633;协议书条款的解释和说明&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p0
						style="margin-bottom:3.0000pt; margin-top:3.0000pt; page-break-after:void; text-align:left; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&#9633;银行卡交易资金结算、对账、差错处理流程&nbsp;&nbsp;&nbsp;&#9633;手工单业务申请流程</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p0
						style="margin-bottom:3.0000pt; margin-top:3.0000pt; page-break-after:void; text-align:left; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&#9633;银行分期业务受理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#9633;预授权类交易的受理流程&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&#9633;持卡人跑单处理方法&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#9633;银联标贴与机具标贴粘贴到位</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height:19.8500pt; ">
				<td width=621 valign=top colspan=17
					style="width:466.1000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-left:32.4500pt; text-indent:-32.3400pt; margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-weight:bold; font-size:11.0000pt; font-family:'仿宋_GB2312'; ">声明：本人已接受对以上资料及内容的培训，并将按以上培训资料及内容的规定进行实际操作，明确银行卡受理须核对签名，所有交易单据须保存两年时间以上！</span><span
							style="font-weight:bold; font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height:19.8500pt; ">
				<td width=621 valign=center colspan=17
					style="width:466.1000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:left; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">受训人员签名处：</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height:19.8500pt; ">
				<td width=80 valign=center colspan=2
					style="width:60.1500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">姓名</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=151 valign=center colspan=3
					style="width:113.9000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">联系电话</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=79 valign=center colspan=3
					style="width:59.9500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">姓名</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=129 valign=center colspan=4
					style="width:97.3500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">联系电话</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=83 valign=center colspan=4
					style="width:62.6000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">姓名</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=96 valign=center
					style="width:72.1500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:center; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">联系电话</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height:19.8500pt; ">
				<td width=80 valign=top colspan=2
					style="width:60.1500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p>&nbsp;</o:p></span>
					</p></td>
				<td width=151 valign=top colspan=3
					style="width:113.9000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p>&nbsp;</o:p></span>
					</p></td>
				<td width=79 valign=top colspan=3
					style="width:59.9500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p>&nbsp;</o:p></span>
					</p></td>
				<td width=129 valign=top colspan=4
					style="width:97.3500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p>&nbsp;</o:p></span>
					</p></td>
				<td width=83 valign=top colspan=4
					style="width:62.6000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p>&nbsp;</o:p></span>
					</p></td>
				<td width=96 valign=top
					style="width:72.1500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0 style="margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p>&nbsp;</o:p></span>
					</p></td>
			</tr>
			<tr style="height:19.8500pt; ">
				<td width=59 valign=center
					style="width:44.5500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p20 style="margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-weight:bold; font-size:14.0000pt; font-family:'仿宋_GB2312'; ">商户确认</span><span
							style="font-weight:bold; font-size:10.5000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=562 valign=top colspan=16
					style="width:421.5500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p20
						style="text-indent:21.0000pt; margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">我单位收到通联支付湖南分公司POS终端</span><span
							style="mso-spacerun:'yes'; text-decoration:underline ;font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;&nbsp;&nbsp;&nbsp;</span><span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">台。押金编号&nbsp;</span><span
							style="mso-spacerun:'yes'; text-decoration:underline ;font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">，押金金额&nbsp;</span><span
							style="mso-spacerun:'yes'; text-decoration:underline ;font-size:12.0000pt; font-family:'仿宋_GB2312'; "><%=rs.getString("yajin")==null?"":rs.getString("yajin")%></span><span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">元；</span><span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">通讯费（维护费）</span><span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">金额&nbsp;</span><span
							style="mso-spacerun:'yes'; text-decoration:underline ;font-size:12.0000pt; font-family:'仿宋_GB2312'; "><%=rs.getString("txf")==null?"0":rs.getString("txf")%> / <%=rs.getString("fwf")==null?"0":rs.getString("fwf")%></span><span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">元。签购单</span><span
							style="mso-spacerun:'yes'; text-decoration:underline ;font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">卷（本），业务受理标识</span><span
							style="mso-spacerun:'yes'; text-decoration:underline ;font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">个及其它业务受理用品&nbsp;</span><span
							style="mso-spacerun:'yes'; text-decoration:underline ;font-size:12.0000pt; font-family:'仿宋_GB2312'; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">，经检查，终端状况良好，将按《特约商户受理银行卡协议书》的要求保管使用终端设备，并按培训资料及培训内容的要求进行实际操作，并接受了通联支付公司的业务受理培训。</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p20 style="margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">服务质量：&#9633;&nbsp;很满意&nbsp;&nbsp;&#9633;&nbsp;满意&nbsp;&nbsp;&nbsp;&#9633;一般&nbsp;&nbsp;&#9633;不满意&nbsp;&nbsp;&nbsp;&nbsp;其他：</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p20
						style="text-indent:215.2500pt; margin-right:48.0000pt; margin-bottom:0pt; margin-top:0pt; ">
						<span style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p>&nbsp;</o:p></span>
					</p>
					<p class=p20
						style="text-indent:215.2500pt; margin-right:48.0000pt; margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">商户签章：</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p>
					<p class=p20
						style="text-indent:215.2500pt; margin-right:24.0000pt; margin-bottom:0pt; margin-top:0pt; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">日&nbsp;&nbsp;&nbsp;&nbsp;期：</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height:28.0000pt; ">
				<td width=189 valign=center colspan=4
					style="width:141.8000pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:0.5000pt solid rgb(0,0,0); mso-border-left-alt:0.5000pt solid rgb(0,0,0); border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:left; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">拓展人：</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p><%=rs.getString("e_id") %> </o:p></span>
					</p></td>
				<td width=252 valign=center colspan=8
					style="width:189.5500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:none; ; mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:left; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">装机人签字：</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
				<td width=179 valign=center colspan=5
					style="width:134.7500pt; padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ; border-left:none; ; mso-border-left-alt:none; ; border-right:0.5000pt solid rgb(0,0,0); mso-border-right-alt:0.5000pt solid rgb(0,0,0); border-top:0.5000pt solid rgb(0,0,0); mso-border-top-alt:0.5000pt solid rgb(0,0,0); border-bottom:0.5000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0); "><p
						class=p0
						style="margin-bottom:0pt; margin-top:0pt; text-align:left; ">
						<span
							style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'仿宋_GB2312'; ">日&nbsp;期：</span><span
							style="font-size:12.0000pt; font-family:'仿宋_GB2312'; "><o:p></o:p></span>
					</p></td>
			</tr>
		</table>
		<p class=p20
			style="margin-left:-15.7500pt; text-indent:8.5800pt; margin-left:-8.5800pt; margin-bottom:0pt; margin-top:0pt; text-align:justify; ">
			<span
				style="mso-spacerun:'yes'; font-size:11.0000pt; font-family:'仿宋_GB2312'; ">通联支付湖南分公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客服电话：&nbsp;95156&nbsp;&nbsp;&nbsp;&nbsp;0731-</span><span
				style="mso-spacerun:'yes'; font-size:11.0000pt; font-family:'仿宋_GB2312'; ">82802335</span><span
				style="mso-spacerun:'yes'; font-size:12.0000pt; font-family:'Arial'; "><o:p></o:p></span>
		</p>
	</div>
	<%
	try{
		rs.close();
		dba.release();
	}catch(Exception e){}
	%>
	<!--EndFragment-->
</body>
</html>