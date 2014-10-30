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
		Operman_info info = new Operman_info();
		info.requestGetParameter(request);
		Operman_infoDao dao = new Operman_infoDao();
		dao.insert(info);
		request.setAttribute("result", "添加成功！");
		request.getRequestDispatcher("../../result.jsp").forward(request,
				response);
	} catch (Exception e)
	{
		request.setAttribute("result", "添加失败！");
		request.getRequestDispatcher("../../result.jsp").forward(request,
				response);
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>