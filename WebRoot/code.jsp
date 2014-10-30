<%@page import="java.util.Random"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="com.cml.verficode.VerfiCodeUtils"%>
<%@page import="com.cml.verficode.SecurityImage"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%
	try
	{
		SecurityImage image = new SecurityImage();
		Random random = new Random();
		int tempCode = random.nextInt(53);
		String code = VerfiCodeUtils.getCode(tempCode);
		session.setAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY, code);
		ByteArrayInputStream in = image.getImageAsInputStream(code);
		byte[] data = new byte[in.available()];
		in.read(data);
		in.close();
		ServletOutputStream os = response.getOutputStream();
		os.write(data);
		os.close();
		out.clear();   
		out = pageContext.pushBody();
	} catch (Exception e)
	{
		e.printStackTrace();
	}
%>
