function login(type){}
function logincall(json){
	if(json.code=='0'){
		document.location.href='http://188.0.4.131:9000/vacct/welcome.dsr;jsessionid='+json.sessionid;
	}if(json.code=='1'){
		var error_msg = $("#error_msg");
		error_msg.html(json.message);
		return false;
	}
}
login.check = function(type){
	var userId = $("#userId").val();
	var password = $("#password").val();
	var error_msg = $("#error_msg");
	if(userId.length==0){
		error_msg.html("请输入用户名");
		return false;
	}
	if(password.length==0){
		error_msg.html("请输入密码");
		return false;
	}
	var url=webPath+"/login.dsr";
	if(type!=null && type=='2')
	{
		url=webPath+"/merlogin.dsr";
	}
	var piccode='';
	
	if(type!=null && type=='2')
	{
		piccode=$('#piccode').val();
		if(piccode=='')
		{
			error_msg.html("验证码不能为空");
			return false;
		}
	}
	var usertype = $("input[type=radio]:checked").val();
	if(usertype=='2'){
		//url = 'http://188.0.4.131:9000/vacct/login.dsr';
		//url = 'http://www.baidu.com';
		url = 'http://188.0.4.131:9000/vacct/login.dsr';
		aipgUtil.setCookie("isfen","is",1);
		aipgUtil.setCookie("userId_cookies",userId);
		try{
		  $.ajax({
	             type: "get",
	             async: false,
	             url:url,
	             dataType: "jsonp",
	             data:{userId:userId,password:password,piccode:'da',isjsonp:true},
	             jsonp: "callback",
	             jsonpCallback:"logincall",
	             success: function(json){
	            	// alert(json);
	               //  alert('您查询到航班信息：票价： ' + json.message + ' 元');
	             },
	             error: function(){
	                 alert('fail');
	             }
	         });
		}catch(Exception){}
		  return false;
	}
	
	aipgUtil.setCookie("isfen","not",1);
	var data =  $.ajax({
		  type: "post",
		  async:false,
		  cache:false,
		  data:{userId:userId,password:password,piccode:piccode},
		  url: url,
		  dataType: "json"
	}).responseText;
	try{
		data = eval("("+data+")");
		if(data.code=='0'){
			aipgUtil.setCookie("userId_cookies",userId);
			return true;
		}else if(data.code=='1'){
			error_msg.html(data.message);
	         var timenow = new Date().getTime();    
	         if('2'==type)
        	 {
	        	 document.getElementById("safecode").src=webPath+"/ValidcodeServlet.dsr?d="+timenow;  
        	 }
			return false;
		}
	}catch(e){
        var timenow = new Date().getTime();                          
        document.getElementById("safecode").src=webPath+"/ValidcodeServlet.dsr?d="+timenow; 
		alert("登录失败");
	}
	return false;
};

$(document).ready(function(data){
	var userId = aipgUtil.getCookie("userId_cookies");
	var isfen = aipgUtil.getCookie("isfen");
	if(isfen=='is'){
		$("#sub").attr("checked","checked");
	}
	if(userId){
		$("#userId").val(userId);
		$("#password").focus();
	}else{
		$("#userId").focus();
	}
});
