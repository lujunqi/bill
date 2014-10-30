<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.dodou.table.Operman_info"%>
<%@page import="com.szzt.util.Md5Util"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{

		String id = request.getParameter("id");
		if (null == id)
		{
			out.println(new Object());
			return;
		}
		Operman_infoDao dao = new Operman_infoDao();
		Operman_info info = dao.whereOperman_id(Integer.parseInt(id));
		Gson gson=new Gson();
		out.println(gson.toJson(info));
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>