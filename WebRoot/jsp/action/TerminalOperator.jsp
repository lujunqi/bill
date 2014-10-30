<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.szzt.exception.OutOfStoreException"%>
<%@page import="com.szzt.exception.SerialExistsException"%>
<%@page import="com.szzt.util.TermiCostUtils"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.dodou.inferface.TerminalWorkFlow"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.dao.*"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	String terminalId = request.getParameter("TEMINAL_INFO_ID");
	String type = request.getParameter("node");
	int comId = -1;
	try
	{
		boolean success = false;
		Permission permission = new PositionPermessionImpl();

		Terminal_Info info = new BindRequest().toModel(request,
				Terminal_Info.class);

		TerminalWorkFlow work = new Terminal_InfoDao();

		comId = ((Terminal_InfoDao) work)
				.loadCommercialIdByTerId(Integer.parseInt(terminalId));

		int typeId = Integer.parseInt(type);

		switch (typeId)
		{
		case 2:
			if (permission.hasPermission(session,
					Permission.OPERAT_POSITION))
			{
				((TerminalWorkFlow) work).operate(info);
				success = true;
			}
			break;
		case 5:
			if (permission.hasPermission(session,
					Permission.FILE_POSITION))
			{
				success = work.assign(info);
			}
			break;
		case 4://调试岗
			if (permission.hasPermission(session,
					Permission.DEBUG_POSITION))
			{
				Operman_info in = (Operman_info) session
						.getAttribute("man");
				info.setDEBUG_MAN(in.getOperman_id());
				success = work.debugTerminal(info);
			}
			break;
		case 13://归档
			if (permission.hasPermission(session,
					Permission.FILE_POSITION))
			{
				success = work.fileTerminal(info);
				if (success)
				{
					SimpleDateFormat format = new SimpleDateFormat(
							"yyyy-MM-dd");
					TermiCostDao terDao = new TermiCostDao();
					TemiCost cost1 = new TemiCost();
					cost1.setCOST_TYPE(0);
					cost1.setCOSTNUMBER(request
							.getParameter("COSTNUMBER0"));
					if (null != request.getParameter("REFUNDDATE0")
							&& request.getParameter("REFUNDDATE0")
									.trim().length() > 0)
					{
						cost1.setREFUNDDATE(format.parse(request
								.getParameter("REFUNDDATE0")));
					}
					cost1.setTEMINAL_INFO_ID(Integer
							.parseInt(terminalId));
					cost1.setCOST_TYPE(0);

					TemiCost cost2 = new TemiCost();
					cost2.setCOST_TYPE(1);
					if (null != request.getParameter("REFUNDDATE1")
							&& request.getParameter("REFUNDDATE1")
									.trim().length() > 0)
					{
						cost2.setREFUNDDATE(format.parse(request
								.getParameter("REFUNDDATE1")));
					}
					cost2.setCOSTNUMBER(request
							.getParameter("COSTNUMBER1"));
					cost2.setTEMINAL_INFO_ID(Integer
							.parseInt(terminalId));

					TemiCost cost3 = new TemiCost();
					if (null != request.getParameter("REFUNDDATE2")
							&& request.getParameter("REFUNDDATE2")
									.trim().length() > 0)
					{
						cost3.setREFUNDDATE(format.parse(request
								.getParameter("REFUNDDATE2")));
					}
					cost3.setCOST_TYPE(2);
					cost3.setCOSTNUMBER(request
							.getParameter("COSTNUMBER2"));
					cost3.setTEMINAL_INFO_ID(Integer
							.parseInt(terminalId));
					terDao.operate(cost1, Integer.parseInt(terminalId));
					terDao.operate(cost2, Integer.parseInt(terminalId));
					terDao.operate(cost3, Integer.parseInt(terminalId));
					terDao.release();
				}
			}
			break;
		case 6:
			if (permission.hasPermission(session,
					Permission.LEADER_POSITION)
					|| permission.hasPermission(session,
							Permission.FILE_POSITION))
			{
				success = work.cancelTerminal(info);
			}
			break;
		case 10://未调试
			Operman_info in = (Operman_info) session
					.getAttribute("man");
			work.notDebug(info.getTEMINAL_INFO_ID(), in.getOperman_id());
			success = true;
			break;
		case 11://待归档
			work.waitingFile(info.getTEMINAL_INFO_ID());
			success = true;
			break;
		case 12://待调试
			//归档岗和领导岗的权限
			if (permission.hasPermission(session,
					Permission.FILE_POSITION)
					|| permission.hasPermission(session,
							Permission.LEADER_POSITION))
			{
				work.waitingDebug(info.getTEMINAL_INFO_ID());
				success = true;
			}
			break;
		}

		if (success)
			response.sendRedirect("../insert/terminalInsert.jsp?show=1&info=o1&terminalId="
					+ terminalId + "&CommercialId=" + comId);
		else
			response.sendRedirect("../insert/terminalInsert.jsp?show=1&info=o0&terminalId="
					+ terminalId + "&CommercialId=" + comId);
	} catch (OutOfStoreException o)
	{
		//主机序列号不在仓库
		response.sendRedirect("../insert/terminalInsert.jsp?show=1&info=e2&terminalId="
				+ terminalId + "&CommercialId=" + comId);
	} catch (SerialExistsException s)
	{
		response.sendRedirect("../insert/terminalInsert.jsp?show=1&info=e1&terminalId="
				+ terminalId + "&CommercialId=" + comId);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		response.sendRedirect("../insert/terminalInsert.jsp?show=1&info=o0&terminalId="
				+ terminalId + "&CommercialId=" + comId);

	}
%>