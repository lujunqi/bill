<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@ include file="../../../import.jsp"%>
<%
	String sql = "";
	DatabaseAccess dba = new DatabaseAccess();
	ResultSet rs = dba.executeQuery(sql);
	if (!rs.next())
	{
		rs.close();
		dba.release();
		out.println("  <SCRIPT LANGUAGE=\'JavaScript\'> 	alert(\'没有找到此商户任何数据!\'); this.window.opener = null;window.close();     </SCRIPT>");
		return;
	}
	rs.beforeFirst();
	String filename = request.getParameter("filename") + ".xls";
	Log.getLogger().info(sql);
	String path = Config.getConfiguration().getString("REPORT-PATH");
	FileOutputStream fos = new FileOutputStream(
			application.getRealPath("/report") + filename);
	HSSFWorkbook wb = new HSSFWorkbook();
	HSSFSheet s = wb.createSheet();
	wb.setSheetName(0, filename);

	HSSFRow row = s.createRow(0);
	ResultSetMetaData rsmd = rs.getMetaData();
	int count = rsmd.getColumnCount();
	for (int j = 0; j < count; j++)
	{
		HSSFCell cell = row.createCell((short) j);
		cell.setCellValue(rsmd.getColumnName(j + 1));
	}
	int i = 1;
	while (rs.next())
	{
		row = s.createRow(i++);
		for (int j = 0; j < count; j++)
		{
			String val;
			if (rsmd.getColumnType((j + 1)) == Types.TIMESTAMP)
			{
				val = UtilTime.getChinaFormat2String(rs
						.getTimestamp((j + 1)));
			} else
			{
				val = rs.getString((j + 1));
			}
			if (val == null)
			{
				val = "";
			}
			HSSFCell cell = row.createCell((short) j);
			cell.setCellValue(val);
		}
	}
	rs.close();
	dba.release();
	wb.write(fos);
	fos.close();
	out.println();
	//response.sendRedirect("report"+File.separator+filename);
	//response.sendRedirect(application.getRealPath("/report") + filename);
%>


