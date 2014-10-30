<%@page import="com.szzt.exception.OutOfStoreException"%>
<%@page import="com.szzt.exception.SerialExistsException"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	//唯一的主机序列号
	try
	{
		String no = request.getParameter("ser");
		String area = request.getParameter("area");
		if (null != no)
		{
			Terminal_InfoDao dao = new Terminal_InfoDao();
			Terminal_Info info = new Terminal_Info();
			info.setSERIAL1("'" + no.trim() + "'");
			dao.checkSerialSigleton(info);
			out.println(1);
			dao.release();
			return;
		}
		out.print(-1);
	} catch (OutOfStoreException o)
	{
		//主机序列号不在仓库
		out.print(-2);
	} catch (SerialExistsException ee)
	{
		//主机序列号在使用
		out.print(-1);
	} catch (Exception e)
	{
		out.print(-3);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>