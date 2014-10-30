<%@page import="com.szzt.util.PhotoUtils"%>
<%@page import="com.szzt.exception.DeleteException"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.dao.*"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	String terminalId = request.getParameter("delId");
	if (null == terminalId)
	{
		response.sendRedirect("../insert/commercialInsert.jsp?info=del0&show=1&CommercialId="
				+ session.getAttribute("COMMERCIAL_ID"));
		return;
	}
	int comId = -1;
	try
	{
		Terminal_InfoDao dao = new Terminal_InfoDao();
		comId = dao.loadCommercialIdByTerId(Integer
				.parseInt(terminalId));
		dao.delete(Integer.parseInt(terminalId));

		dao.release();
		PhotoUtils utils = new PhotoUtils();
		utils.delTPhotoByTerminalId(session, terminalId);
		response.sendRedirect("../insert/commercialInsert.jsp?info=del1&show=1&CommercialId="
				+ comId);
	} catch (DeleteException d)
	{
		response.sendRedirect("../insert/commercialInsert.jsp?info=delError&show=1&CommercialId="
				+ comId);
		return;
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		response.sendRedirect("../insert/commercialInsert.jsp?info=del0&show=1&CommercialId="
				+ comId);
	}
%>