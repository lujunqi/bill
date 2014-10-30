<%@page import="com.szzt.util.BindRequest"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@ page import="com.szzt.dao.*"%>
<%
	try
	{
		if (null != request.getParameter("APPPAY_ID"))
		{
			BindRequest bind = new BindRequest();
			Apppay103_Info info = bind.toModel(request,
					Apppay103_Info.class);
			Apppay103_InfoDao dao = new Apppay103_InfoDao();

			Operman_info man = (Operman_info) session
					.getAttribute("man");
			dao.setWho(man.getOperman_name());
			dao.update(info);
			out.print(info.getAPPPAY_ID());
			out.flush();
			//response.sendRedirect("../insert/commercialInsert.jsp?info=11&show=1&CommercialId="
			//	+ session.getAttribute("COMMERCIAL_ID"));
		}
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		response.sendRedirect("../insert/commercialInsert.jsp?info=10&show=1&CommercialId="
				+ session.getAttribute("COMMERCIAL_ID"));
	}
%>