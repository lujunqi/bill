<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="import.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>用户信息</title>

		<link rel="stylesheet" type="text/css" href="css/common.css" />
		<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
		<script type="text/javascript">
        
        function test()
        {
        
        	var oldPassword = document.getElementById('oldPassword');
        	if(oldPassword.value == null || oldPassword.value == '' )
        	{
        		alert('原密码不能为空');
        		oldPassword.focus();
        		return false;
        	}
        	var newPassword = document.getElementById('newPassword');
        	if(newPassword.value == null || newPassword.value == '' )
        	{
        		alert('新密码不能为空');
        		newPassword.focus();
        		return false;
        	}
        	var confirmPassword = document.getElementById('confirmPassword');
        	if(confirmPassword.value == null || confirmPassword.value == '' )
        	{
        		alert('密码确认不能为空');
        		confirmPassword.focus();
        		return false;
        	}
        	
        	if(confirmPassword.value != newPassword.value)
        	{
        		alert('两次密码输入不同，请确认');
        		return false;
        	}
         	$.ajax({
        		url:'modifyPasswd.jsp',
        		dataType:'text',
        		type:'POST',
        		data:{'oldPassword':oldPassword.value,'newPassword':newPassword.value},
        		success: function(txt){
        			alert(txt);
            	},  
        		error : function(json) {
        			alert(json.responseText);
        	    }
        	 });
        }
     </script>
	</head>

	<body>
		<br />
		<table width="100%" cellpadding="0" cellspacing="1px" style="background:#8EC2F5">  
					<tr class="detail_list_center_1">
	  					<td colspan="2" align="center">
	  					<b>修改密码</b> &nbsp;
	  					</td>
	  				</tr>
					<tr class="detail_list_center_0">
						<td width="40%" class="detail_result_right_black">
							登录账号：
						</td>
						<td width="60%">
							&nbsp;&nbsp;<%=bill_opera.getName() %>
						</td>
					</tr>
					<tr class="detail_list_center_1">
						<td width="40%" class="detail_result_right_black">
							原密码：
						</td>
						<td width="60%">
							<input type="password" name="oldPassword" id="oldPassword"/></td>
						</td>
					</tr>
                    <tr class="detail_list_center_0">
						<td width="40%" class="detail_result_right_black">
							新密码：
						</td>
						<td width="70%">
							<input type="password" name="newPassword" id="newPassword"/></td>
						</td>
					</tr>
					<tr class="detail_list_center_1">
						<td width="40%" class="detail_result_right_black">
							确认密码：
						</td>
						<td width="70%">
							<input type="password" name="confirmPassword" id="confirmPassword"/>
						</td>
					</tr>
					<tr class="detail_list_center_0">
						<td width="40%" align="center" colspan="2" >
						<input type="button" onclick="test();" value="保存" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onclick="history.go(-1)"   value="取消"/>
						</td>
					</tr>
				</table>
			</form>
	</body>
</html>
