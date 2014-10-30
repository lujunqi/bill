<%@page import="com.szzt.exception.ForbidUpdateException"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		Apppay_105Dao Apppay_105dao = new Apppay_105Dao();
		Apppay_105 Apppay_105x = new Apppay_105();
		Apppay_105x.setChange_date(UtilTime.getOtherFormat2String(
				"yyyy-MM-dd", new java.util.Date()));
		Apppay_105x.requestGetParameter(request);

		Operman_info man = (Operman_info) session.getAttribute("man");
		Apppay_105dao.setWho(man.getOperman_name());
		Apppay_105dao.update(Apppay_105x);
		Log.getLogger().info("111111111111");
		out.println(Apppay_105x.getApppay_id());
		Apppay_105dao.release();
	} catch (Exception e)
	{
		out.println(-1);
		//response.setStatus(500);
		//e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
