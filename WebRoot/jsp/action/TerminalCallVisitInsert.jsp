<%@page import="com.google.gson.Gson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		Teminal_info_visit_call info = new Teminal_info_visit_call();
		info.requestGetParameter(request);
		
		Teminal_info_visit_callDao dao = new Teminal_info_visit_callDao();
		
		if (info.getTeminal_info_visit_call_id() > 0)
		{
			dao.delete(info.getTeminal_info_visit_call_id());
		}

		dao.insert(info);
		response.sendRedirect("../insert/commercialInsert.jsp?info=back1&show=1&CommercialId="
				+ request.getParameter("comId"));
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>