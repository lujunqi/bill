<%@page import="com.szzt.exception.DeleteException"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@ page import="com.szzt.dao.*"%>
<%
	String delId = request.getParameter("delId");
	if (null == delId)
	{
		response.sendRedirect("../show/CommercialShow.jsp?info=del0");
		return;
	}
	try
	{
		Commercial_InfoDao dao = new Commercial_InfoDao();
		dao.delete(Integer.parseInt(delId));
		dao.deletePhotos(session, Integer.parseInt(delId));
		dao.release();
		response.sendRedirect("../show/CommercialShow.jsp?info=del1");
	} catch (DeleteException d)
	{
		response.sendRedirect("../show/CommercialShow.jsp?info=del0");
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		response.sendRedirect("../show/CommercialShow.jsp?info=del0");
	}
%>