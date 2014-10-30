<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		Teminal_info_servDao teminal_info_servdao = new Teminal_info_servDao();
		Teminal_info_serv Teminal_infox = new Teminal_info_serv();
		Teminal_infox.requestGetParameter(request);
		teminal_info_servdao.update(Teminal_infox);
		//out.println("{success:true}");
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>