<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	Permission per = new PositionPermessionImpl();
	if (!per.hasPermission(session, Permission.OPERAT_POSITION))
	{
		response.sendRedirect("../insert/error.jsp");
		return;
	}
	String id = request.getParameter("id");
	String commercial = request.getParameter("commercial");
	try
	{
		if (null != id && null != commercial)
		{
			Apppay_105Dao dao = new Apppay_105Dao();
			dao.zhengGai(Integer.parseInt(id));
			response.sendRedirect("../insert/bussinessInsert105.jsp?info=z1&show=1&appayId="
					+ id + "&CommercialId=" + commercial);
		}

	} catch (Exception e)
	{
		response.sendRedirect("../insert/bussinessInsert105.jsp?info=z0&show=1&appayId="
				+ id + "&CommercialId=" + commercial);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>