<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.awt.image.SampleModel"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.dodou.db.DatabaseAccess"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		String INST_MAN = request.getParameter("INST_MAN");
		String SAFE_MAN = request.getParameter("SAFE_MAN");
		if (null != INST_MAN && null != SAFE_MAN)
		{
			String sql = "select operman_name from OPERMAN_INFO where operman_id=";
			DatabaseAccess acc = new DatabaseAccess();
			ResultSet rs = acc.executeQuery(sql + INST_MAN);
			if (rs.next())
			{
				INST_MAN = rs.getString("operman_name");
			}
			rs = acc.executeQuery(sql + SAFE_MAN);
			if (rs.next())
			{
				SAFE_MAN = rs.getString("operman_name");
			}
			rs.close();
			acc.release();
			JSONObject object=new JSONObject();
			object.put("INST_MAN", INST_MAN);
			object.put("SAFE_MAN", SAFE_MAN);
			out.print(object);
		}

	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
