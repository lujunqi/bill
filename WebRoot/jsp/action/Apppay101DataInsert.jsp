<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
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
		Apppay101_Info info = new BindRequest().toModel(request,
				Apppay101_Info.class);
		System.out.print("++++++++++++++++++++++++:"
				+ info.getCOMMERCIAL_ID());
		Apppay101_InfoDao dao = new Apppay101_InfoDao();
		int id = dao.insert(info);
		dao.release();
		out.print(id);
		out.flush();
		//response.sendRedirect("../insert/commercialInsert.jsp?show=1&info=1&CommercialId="
		//	+ session.getAttribute("COMMERCIAL_ID"));
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace();
		//	response.sendRedirect("../insert/commercialInsert.jsp?show=1&info=-1&CommercialId="
		//	+ session.getAttribute("COMMERCIAL_ID"));
	}
%>