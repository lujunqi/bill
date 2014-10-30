<%@page import="com.szzt.exception.DeleteException"%>
<%@page import="com.szzt.util.PhotoUtils"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@ page import="com.szzt.dao.*"%>
<%
	String delId = request.getParameter("delId");
	if (null == delId)
	{
		response.sendRedirect("../insert/commercialInsert.jsp?info=del0&show=1&CommercialId="
				+ session.getAttribute("COMMERCIAL_ID"));
		return;
	}
	int comId = -1;
	try
	{
		Apppay102_InfoDao dao = new Apppay102_InfoDao();
		comId = dao.loadCommercialIdByAppayId(Integer.parseInt(delId),
				102);
		dao.delete(Integer.parseInt(delId));
		dao.release();
		PhotoUtils utils = new PhotoUtils();
		utils.delPhotoByApp(session, "102", delId);
		response.sendRedirect("../insert/commercialInsert.jsp?info=del1&show=1&CommercialId="
				+ comId);
	} catch (DeleteException d)
	{
		response.sendRedirect("../insert/commercialInsert.jsp?info=del0&show=1&CommercialId="
				+ comId);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		response.sendRedirect("../insert/commercialInsert.jsp?info=del0&show=1&CommercialId="
				+ comId);
	}
%>