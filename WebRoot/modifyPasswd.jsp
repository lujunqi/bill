<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../import.jsp"%>
<%
try {
	String oldPassword = request.getParameter("oldPassword");
	String newPassword = request.getParameter("newPassword");
	MessageDigest md = MessageDigest.getInstance("MD5");
	byte[] bytes = md.digest(newPassword.getBytes("utf8"));
	StringBuilder ret=new StringBuilder(bytes.length<<1);
	for(int i=0;i<bytes.length;i++){
	  ret.append(Character.forDigit((bytes[i]>>4)&0xf,16));
	  ret.append(Character.forDigit(bytes[i]&0xf,16));
	}
	bill_opera.setPasswd(ret.toString());
	Bill_operaDao operadao = new Bill_operaDao();
	operadao.update(bill_opera);
	out.println("密码修改成功!");
} catch (Exception e) {
	response.setStatus(500);
	e.printStackTrace(response.getWriter());
	e.printStackTrace();
}
%>