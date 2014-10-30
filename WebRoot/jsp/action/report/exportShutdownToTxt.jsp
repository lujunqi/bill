<%@page import="com.dodou.inferface.Export"%><%@ page contentType="text/html;charset=utf-8" language="java"%><%@ include	file="../../../import.jsp"%><%
	response.setContentType("text/html;charset=utf-8");
	String date = request.getParameter("date");
	response.setHeader("Content-disposition",
			"attachment; filename=term_" + date + ".txt");
	
	String sql = "select trim(temp.term_id1) as term_id1,'0848215500',trim(temp.term_id2) as term_id2,i.cancel_time from term_app_table temp,teminal_info i where temp.status>1 "
				+" and i.teminal_info_id=temp.teminal_info_id and i.cancel_time=to_date('"+date+"','yyyy-mm-dd')";
	DatabaseAccess dba = new DatabaseAccess();
	ResultSet rs = dba.executeQuery(sql);
	StringBuffer content = new StringBuffer();
	while (rs.next())
	{
		content.append("D,");
		if(rs.getString("term_id1") !=null && rs.getString("term_id2") != null){
			content.append(rs.getString("term_id1").trim() + ",");
			content.append("0848215500,");
			content.append(rs.getString("term_id2").trim() + "\n");
		}else{
			content.append(rs.getString("term_id1").trim() + ",");
			content.append("0848215500,");
			content.append(rs.getString("term_id2").trim() + "\n");
		}
	
	}
	rs.close();
	dba.release();
	Log.getLogger().info(content.toString());
	Export ex = new Export()
	{
		public void initSql(String where)
		{
		}
	};
	ex.release();
	ex.setFileName("导出注销终端资料报表");
	ex.exportLog(session);
	out.print(content);
%>
