<%@page import="com.szzt.exception.OutOfStoreException"%>
<%@page import="com.szzt.exception.SerialExistsException"%>
<%@page import="com.dodou.inferface.LogService"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.exception.ForbidUpdateException"%>
<%@page import="com.szzt.util.TermiCostUtils"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.dao.*"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	Permission per = new PositionPermessionImpl();
	//归档岗权限
	if (!per.hasPermission(session, Permission.FILE_POSITION))
	{
		out.print(-1);
		return;
	}
	DatabaseAccess dba = new DatabaseAccess();
	try
	{
		BindRequest bind = new BindRequest();
		Terminal_Info info = bind.toModel(request, Terminal_Info.class);
		Operman_info man = (Operman_info) session.getAttribute("man");

		//确定主机序列号唯一
		Terminal_InfoDao dao = new Terminal_InfoDao();
		
		//判断主机序列号是否改变
		boolean c = (request.getParameter("SERIAL1").equals(request
				.getParameter("SER")));
		//通联产权判断主机序列号
		if (info.getTEMINAL_PRODUCT() == 0 && !c)
			dao.checkSerialSigleton(info);

		Terminal_Info old = dao.findById(info.getTEMINAL_INFO_ID());
		LogService service = new LogService();

		dba.executeUpdate("insert into TEMINAL_INFO_BAK (select * from "
				+ Terminal_InfoDao.TABLE
				+ " where TEMINAL_INFO_ID="
				+ info.getTEMINAL_INFO_ID() + ")");

		StringBuffer buffer = new StringBuffer();
		buffer.append("update ").append(Terminal_InfoDao.TABLE)
				.append(" set ");
		buffer.append("UNIT_INSTALLED_MAN=")
				.append(info.getUNIT_INSTALLED_MAN()).append(",");

		service.appendDirty(old.getUNIT_INSTALLED_MAN(),
				info.getUNIT_INSTALLED_MAN(), "客户装机联系人");

		buffer.append("UNIT_INSTALLED_TEL=")
				.append(info.getUNIT_INSTALLED_TEL()).append(",");
		service.appendDirty(old.getUNIT_INSTALLED_TEL(),
				info.getUNIT_INSTALLED_TEL(), "客户装机联系电话");

		buffer.append("UNIT_INSTALLED_CITY=")
				.append(info.getUNIT_INSTALLED_CITY()).append(",");
		buffer.append("UNIT_INSTALLED_STREET=")
				.append(info.getUNIT_INSTALLED_STREET()).append(",");
		service.appendDirty(old.getUNIT_INSTALLED_STREET(),
				info.getUNIT_INSTALLED_STREET(), "装机街道");

		buffer.append("UNIT_INSTALLED_ADD=")
				.append(info.getUNIT_INSTALLED_ADD()).append(",");
		service.appendDirty(old.getUNIT_INSTALLED_ADD(),
				info.getUNIT_INSTALLED_ADD(), "客户装机地址:");

		buffer.append("TEMINAL_PRODUCT=")
				.append(info.getTEMINAL_PRODUCT()).append(",");

		String v = "";
		if (old.getTEMINAL_PRODUCT() != info.getTEMINAL_PRODUCT())
		{
			if (info.getTEMINAL_PRODUCT() == 0)
			{
				v = "通联产权";
			} else if (info.getTEMINAL_PRODUCT() == 1)
			{
				v = "银行产权";
			} else
			{
				v = "代理商产权";
			}
			service.append("机具产权改为:" + v);
		}

		buffer.append("IS_HURRY=").append(info.getIS_HURRY())
				.append(",");
		if (info.getIS_HURRY() != old.getIS_HURRY())
		{
			if (info.getIS_HURRY() == 0)
			{
				v = "不加急";
			} else
			{
				v = "加急";
			}
			service.append("是否加急改为:" + v);

		}

		buffer.append("COMM_TYPE=").append(info.getCOMM_TYPE())
				.append(",");
		if (old.getCOMM_TYPE() != info.getCOMM_TYPE())
		{
			if (info.getCOMM_TYPE() == 0)
			{
				v = "电话模式";
			} else
				v = "网络模式";
			service.append("终端通讯方式改为:" + v);
		}
		buffer.append("SERIAL1=").append(info.getSERIAL1()).append(",");

		service.appendDirty(old.getSERIAL1(), info.getSERIAL1(),
				"主机序列号");

		if (null != info.getSERIAL2())
		{
			buffer.append("SERIAL2=").append(info.getSERIAL2())
					.append(",");
			service.appendDirty(old.getSERIAL2(), info.getSERIAL2(),
					"键盘序列号改为:");
		}

		buffer.append("IS_BIND=").append(info.getIS_BIND()).append(",");

		buffer.append("INST_MAN=").append(info.getINST_MAN())
				.append(",");

		service.updateMan(old.getINST_MAN() + "", info.getINST_MAN()
				+ "", "机具安装人");
		buffer.append("SAFE_MAN=").append(info.getSAFE_MAN());
		service.updateMan(old.getSAFE_MAN() + "", info.getSAFE_MAN()
				+ "", "机具维护人");

		if (info.getIS_BIND() != old.getIS_BIND())
		{
			if (info.getIS_BIND() == 0)
			{
				v = "不绑定";
			} else
				v = "绑定";
			service.append("是否绑定改为：" + v);
		}

		if (null != info.getCOMM())
		{
			buffer.append(",COMM=").append(info.getCOMM());
			service.appendDirty(old.getCOMM(), info.getCOMM(), "通讯方式描述");
		}

		buffer.append(" where TEMINAL_INFO_ID=").append(
				info.getTEMINAL_INFO_ID());

		dba.executeUpdate(buffer.toString());
		if (!old.getSERIAL1()
				.equals(info.getSERIAL1().replace("'", "")))
		{
			dba.executeUpdate(service.newLog(Terminal_InfoDao.TABLE,
					man.getOperman_name(), info.getTEMINAL_INFO_ID(),
					200, "主机序列号:" + old.getSERIAL1() + "-"
							+ info.getSERIAL1().replace("'", "")));
		}
		dba.executeUpdate(service.insertLog(Terminal_InfoDao.TABLE,
				man.getOperman_name(), info.getTEMINAL_INFO_ID(), 100));

		dba.release();
		out.print(1);
	} catch (OutOfStoreException o)
	{
		out.print(-2);
	} catch (SerialExistsException ee)
	{
		dba.release();
		out.print(-1);
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>