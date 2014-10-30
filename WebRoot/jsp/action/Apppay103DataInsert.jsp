<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
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
		Apppay103_Info info = new BindRequest().toModel(request,
				Apppay103_Info.class);
		//info.setCOMMERCIAL_ID((Integer) session
		//	.getAttribute("COMMERCIAL_ID"));
		//info.requestGetParameter(request);
		Apppay103_InfoDao dao = new Apppay103_InfoDao();
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