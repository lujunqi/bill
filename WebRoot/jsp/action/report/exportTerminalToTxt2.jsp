<%@page import="com.dodou.inferface.Export"%><%@ page contentType="text/html;charset=utf-8" language="java"%><%@ include	file="../../../import.jsp"%><%
	response.setContentType("text/html;charset=utf-8");
	String date = request.getParameter("date");
	response.setHeader("Content-disposition",
			"attachment; filename=term_" + date + ".txt");
	
	String sql = "select temp.term_id3,c.unit_add,c.contact_name_1,c.contact_tel_1,temp.term_id4 from teminal_info i, Apppay_105 m,term_app_table temp,commercial_info c where to_char(i.approval_date,'yyyy-MM-dd') = '"
			+ date
			+ "'  and i.teminal_status >= 3 and m.appr_status = 2 and i.teminal_info_id=temp.teminal_info_id and m.apppay_id=temp.apppay_id and c.commercial_id=temp.commercial_id and temp.apptype='105' and (m.fee_chan = 1 or m.fee_chan is null)";
			System.out.println(sql);
	DatabaseAccess dba = new DatabaseAccess();
	ResultSet rs = dba.executeQuery(sql);
	StringBuffer content = new StringBuffer();
	while (rs.next())
	{
		content.append("I,");
		content.append(rs.getString("term_id3").trim() + ",");
		content.append(rs.getString("term_id4").trim() + ",");
		content.append("0848215500,0848215500,0800085500,00,1,");
		content.append(rs.getString("term_id3").trim().substring(3, 7) + ",");
		content.append("0,1,,,,,110000000000000000000000000000,,,,,3,1,02,02,01,01,01,01,,,,,,,1,0118,1,1,0,1,1,,,D00,P,00000000000000000000,156,");
		//客户单位联系人
		content.append(rs.getString("contact_name_1") + ",");
		//固定电话
		content.append(rs.getString("contact_tel_1") + ",");
		//工商营业执照地址
		content.append(rs.getString("unit_add") + ",");
		content.append(",,,,,");
		content.append(",,,,,,,,,,,,,,,,,,,");
		content.append("156,20140801,20991230");
		content.append(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
		content.append("\n");
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
