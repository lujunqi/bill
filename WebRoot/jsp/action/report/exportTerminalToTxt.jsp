<%@page import="com.dodou.inferface.Export"%><%@ page contentType="text/html;charset=utf-8" language="java"%><%@ include	file="../../../import.jsp"%><%
	response.setContentType("text/html;charset=utf-8");
	String date = request.getParameter("date");
	response.setHeader("Content-disposition",
			"attachment; filename=term_" + date + ".txt");
	
	String sql = "select temp.term_id1,c.unit_area, temp.term_id2 from teminal_info i, Apppay_105 m,term_app_table temp,commercial_info c where i.approval_date = to_date('"
			+ date
			+ "','yyyy-MM-dd')  and i.teminal_status >= 3 and m.appr_status = 2 and i.teminal_info_id=temp.teminal_info_id and m.apppay_id=temp.apppay_id and c.commercial_id=temp.commercial_id and temp.apptype='105' and temp.status=1  and (m.fee_chan = 1 or m.fee_chan is null)";
	DatabaseAccess dba = new DatabaseAccess();
	ResultSet rs = dba.executeQuery(sql);
	StringBuffer content = new StringBuffer();
	while (rs.next())
	{
		content.append("I,");
		content.append(rs.getString("term_id1").trim() + ",");
		content.append(rs.getString("term_id2").trim() + ",");
		content.append("0848215500,0848215500,00,1,0,1,D00,156,1,1,01,3,,,");
		//开通时间k
		content.append(UtilTime.getOtherFormat2String("yyyyMMdd",
				new java.util.Date()) + ",");
		content.append("20991230,1,1,0,1,1,02,02,01,01,156,S,01,0848215500,0848215500,0848215500,0848215500,");
		//行政区划代码
		content.append(rs.getString("unit_area") + ",");
		content.append("CS003&CS094&#,,\n");
	}
	rs.close();
	dba.release();
	Log.getLogger().info(content.toString());
	Log.getLogger().info(content.toString());
	Export ex = new Export()
	{
		public void initSql(String where)
		{
		}
	};
	ex.release();
	ex.setFileName("导出终端资料报表");
	ex.exportLog(session);
	out.print(content);
%>
