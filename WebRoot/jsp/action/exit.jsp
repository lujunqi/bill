<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	session.invalidate();
	response.sendRedirect("../../login.jsp");
%>

