<%@ include file="../../import.jsp"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%
	try
	{
		String id = request.getParameter("id");
		if (null != id)
		{
			String sql = "update teminal_info_serv t set TEMINAL_STATUS=6,depo_time=sysdate where t.TEMINAL_INFO_SERV_ID="
					+ id;
			DatabaseAccess acc = new DatabaseAccess();
			acc.executeUpdate(sql);
			acc.release();
			out.print(1);
			Log.getLogger().debug("撤机成功ID" + id);
		}
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>