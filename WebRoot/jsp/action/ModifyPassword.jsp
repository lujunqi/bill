<%@page import="com.szzt.util.Md5Util"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String oldPass = request.getParameter("oldPass");
		String newPass = request.getParameter("newPass");
		String newPassCheck = request.getParameter("newPassCheck");
		Operman_info info = (Operman_info) session.getAttribute("man");
		if (null != oldPass && null != newPass && null != newPassCheck)
		{
			String sql = "update OPERMAN_INFO set OPER_PASS='"
					+ Md5Util.md5(newPass) + "' where OPERMAN_ID="
					+ info.getOperman_id() + " and oper_pass='"
					+ Md5Util.md5(oldPass) + "'";
			DatabaseAccess dba = new DatabaseAccess();
			int c = dba.executeUpdate(sql);
			String result = "";
			if (1 == c)
			{
				result = "修改成功！";
			} else
			{
				result = "修改失败,密码错误！";
			}
			request.setAttribute("result", result);
			//转向登录界面
			if (null != request.getParameter("def"))
			{
				session.invalidate();
				response.sendRedirect("../../login.jsp?mod=4");
				return;
			}
			request.getRequestDispatcher("../result.jsp").forward(
					request, response);
		} else
		{
			System.out.println("哈哈哈哈" + oldPass + ":" + newPass + ":"
					+ newPassCheck);
		}

	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>