<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.model.AssignOrderModel"%>
<%@page import="com.szzt.model.VisitBacklogModel"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.dodou.table.*"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		AssignOrderDao dao = new AssignOrderDao();
		AssignOrderModel model = new BindRequest().toModel(request,
				AssignOrderModel.class);
		Operman_info info = (Operman_info) session.getAttribute("man");
		model.setINPUT_MAN(info.getOperman_id());
		dao.insert(model);
		response.sendRedirect("../insert/AssignOrder.jsp?info=1&terminalId="
				+ model.getTEMINAL_INFO_ID()
				+ "&commercialId="
				+ model.getCOMMERCIAL_ID());

	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>