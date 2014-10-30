<%@page import="com.szzt.exception.ForbidUpdateException"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@ page import="com.szzt.dao.*"%>
<%
	try
	{
		BindRequest bind = new BindRequest();
		Apppay101_Info info = bind.toModel(request,
				Apppay101_Info.class);
		if (null != request.getParameter("APPPAY_ID"))
		{
			Apppay101_InfoDao dao = new Apppay101_InfoDao();
			Operman_info man = (Operman_info) session
					.getAttribute("man");
			dao.setWho(man.getOperman_name());
			dao.update(info);
			out.print(info.getAPPPAY_ID());
			out.flush();
			//response.sendRedirect("../insert/commercialInsert.jsp?info=11&show=1&CommercialId="
			//	+ session.getAttribute("COMMERCIAL_ID"));
		}
	} catch (ForbidUpdateException f)
	{
		out.print(-1);
		out.flush();
		//response.sendRedirect("../insert/commercialInsert.jsp?info=10&show=1&CommercialId="
		//	+ session.getAttribute("COMMERCIAL_ID"));
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		response.sendRedirect("../insert/commercialInsert.jsp?info=10&show=1&CommercialId="
				+ session.getAttribute("COMMERCIAL_ID"));
	}
%>