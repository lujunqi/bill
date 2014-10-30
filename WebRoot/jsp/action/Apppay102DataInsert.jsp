<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@ page import="com.szzt.dao.*"%>
<%
	Permission per = new PositionPermessionImpl();
	if (!per.hasPermission(session, Permission.EXPAND_POSITION))
	{
		response.sendRedirect("../insert/error.jsp");
		return;
	}
	try
	{
		Apppay102_Info info = new Apppay102_Info();
		info.requestGetParameter(request);
		Apppay102_InfoDao dao = new Apppay102_InfoDao();
		
		int id = dao.insert(info);
		dao.release();
		out.print(id);
		out.flush();
		//if (id < 0)
		//	throw new Exception();
		//	ApppayTerminalDao atd = new ApppayTerminalDao();
		//	atd.insert(request, "102",id);
		//	response.sendRedirect("../insert/commercialInsert.jsp?show=1&info=1&CommercialId="
		//		+ session.getAttribute("COMMERCIAL_ID"));
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		//response.sendRedirect("../insert/commercialInsert.jsp?show=1&info=-1&CommercialId="
		//	+ session.getAttribute("COMMERCIAL_ID"));
	}
%>