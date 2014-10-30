<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.model.AssignOrderModel"%>
<%@page import="com.szzt.model.VisitBacklogModel"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		AssignOrderModel model = new BindRequest().toModel(request,
				AssignOrderModel.class);
		System.out.println(model.getCOMP_ID()+":"+model.getSLOVE_CONT());
		if (model.getCOMP_ID() <= 0 || null == model.getSLOVE_CONT())
		{
			throw new RuntimeException();
		}
		AssignOrderDao dao = new AssignOrderDao();
		dao.update(model);
		out.println(1);
	} catch (Exception e)
	{
		out.println(-1);
	}
%>