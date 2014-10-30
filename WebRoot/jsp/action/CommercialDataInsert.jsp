<%@page import="com.szzt.exception.DumplicateException"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@ page import="com.szzt.dao.*"%>
<%
	Permission per = new PositionPermessionImpl();
	if (!per.hasPermission(session, Permission.EXPAND_POSITION))
	{
		response.sendRedirect("../insert/error.jsp");
		return;
	}

	Commercial_InfoDao dao = new Commercial_InfoDao();
	try
	{
		//Commercial_Info info = new Commercial_Info();
		Commercial_Info info = new BindRequest().toModel(request,
				Commercial_Info.class);

		Operman_info man = (Operman_info) session.getAttribute("man");
		info.setINPUT_USER_ID(man.getOperman_id());

		//保存客户信息到session中
		int id = dao.insert(info);
		if (id < 0)
		{
			throw new RuntimeException();
		}
		session.setAttribute("COMMERCIAL_ID", id);
		response.sendRedirect("../insert/commercialInsert.jsp?info=1&show=1&CommercialId="
				+ id);
		dao.release();
	} catch (DumplicateException dd)
	{
		dao.release();
		response.sendRedirect("../insertFail.jsp?info=-1");
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		response.sendRedirect("../insertFail.jsp?info=-1");
	} 
%>