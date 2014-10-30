<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@ page import="com.dodou.*"%>
<%
	try
	{
		Apppay_105Dao Apppay_105dao = new Apppay_105Dao();
		Apppay_105 Apppay_105x = new Apppay_105();
		Apppay_105x.requestGetParameter(request);
		
		Apppay_105dao.insert(Apppay_105x);

		Apppay_105x = Apppay_105dao
				.select("select * from APPPAY_105 t where t.commercial_id="
						+ request.getParameter("cId")
						+ " and apppay_id=(select max(apppay_id) from APPPAY_105)")[0];
		out.println(Apppay_105x.getApppay_id());
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		Log.getLogger().error(e);
		e.printStackTrace();
	}
%>
