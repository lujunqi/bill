<%@page import="com.szzt.exception.ForbidUpdateException"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@ page import="com.szzt.dao.*"%>
<%
	int comId = -1;
	try
	{
		Commercial_Info info = new BindRequest().toModel(request,
				Commercial_Info.class);
		comId = info.getCOMMERCIAL_ID();
		Commercial_InfoDao dao = new Commercial_InfoDao();
		dao.update(info);
		dao.release();
		response.sendRedirect("../insert/commercialInsert.jsp?info=11&show=1&CommercialId="
				+ info.getCOMMERCIAL_ID());
	} catch (ForbidUpdateException f)
	{
		response.sendRedirect("../insert/commercialInsert.jsp?info=10&show=1&CommercialId="
				+ comId);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		response.sendRedirect("../insert/commercialInsert.jsp?info=10&show=1&CommercialId="
				+ comId);
	}
%>