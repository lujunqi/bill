<%@page import="com.cml.zyh.Teminal_info"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@page import="com.cml.zyh.Commercial_info"%>
<%@page import="com.dodou.table.Commercial_merchantsno"%>
<%@page import="com.dodou.dao.Commercial_merchantsnoDao"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		Commercial_merchantsnoDao Commercial_merchantsnodao = new Commercial_merchantsnoDao();
		Commercial_merchantsno commercial_merchantsnox = new Commercial_merchantsno();
		commercial_merchantsnox.requestGetParameter(request);
		
		String sales_man1 = request.getParameter("sales_man1");
		commercial_merchantsnox.setSales_man(Integer
				.parseInt(sales_man1));

		Commercial_info commercial_info = new Commercial_info();
		commercial_info.requestGetParameter(request);
		Teminal_info teminal_info = new Teminal_info();
		teminal_info.requestGetParameter(request);
		
		int merchantsno_id = Commercial_merchantsnodao.quickInsert(
				commercial_info, commercial_merchantsnox, teminal_info);
		out.println(merchantsno_id);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
