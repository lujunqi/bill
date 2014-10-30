<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String com = request.getParameter("COMM_NO");
		if (null != com && com.length() > 0)
		{
			Commercial_InfoDao dao = new Commercial_InfoDao();
			out.print(dao.checkSigletonComNum(com));
			dao.release();

		} else
		{
			out.print(-1);
		}
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>