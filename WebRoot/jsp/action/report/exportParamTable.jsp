<%@page import="com.dodou.inferface.Export"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%><%@page
	import="org.apache.poi.hssf.usermodel.*"%><%@ include file="../../../import.jsp"%>
<%
	String date = request.getParameter("date");
	String sql = "select rownum, i.teminal_info_id, m.fee_chan, temp.term_id1, m.marchant_name2, (select a.city from ws_area a where a.areaid = c.unit_area), temp.term_id2, m.mcc, m.contract_fee, (select b.bank_name from bank_info b where b.bank_code = m.account_bank), m.account_name, m.account_no, c.comm_no, i.unit_installed_man, c.contact_tel_2 || '/' || i.unit_installed_tel, i.unit_installed_add, i.remark_info, (select cost.money from temicost cost where cost.cost_type = 0 and cost.teminal_info_id = i.teminal_info_id) as secu_depo, (select o.operman_name from operman_info o where o.operman_id = m.e_id), i.equi_type, (select cost.money from temicost cost where cost.cost_type = 2 and cost.teminal_info_id = i.teminal_info_id) as comm_fee, (select cost.money from temicost cost where cost.cost_type = 1 and cost.teminal_info_id = i.teminal_info_id) as service_fee, m.account_bank_brach, m.lq_rule, m.fee_rule1, m.fee_rule2 "
			+ " from teminal_info i, Apppay_105 m, commercial_info c, term_app_table temp "
			+ " where i.teminal_info_id = temp.teminal_info_id and m.apppay_id = temp.apppay_id and c.commercial_id = temp.commercial_id and temp.apptype = '105' and temp.status = 1  and m.appr_status = 2 and (m.fee_chan= 1 or m.fee_chan is null) and (m.appr_date = to_date(' "
			+ date
			+ "','yyyy-mm-dd') or i.approval_date = to_date('"
			+ date + "', 'yyyy-mm-dd'))";
	sql = new String(sql.getBytes("ISO-8859-1"), "UTF-8");
	DatabaseAccess dba = new DatabaseAccess();
	ResultSet rs = dba.executeQuery(sql);
	if (!rs.next())
	{
		rs.close();
		dba.release();
		out.println("  <SCRIPT LANGUAGE=\'JavaScript\'> 	alert(\'没有找到任何数据!\'); this.window.opener = null;window.close();     </SCRIPT>");
		return;
	}
	rs.beforeFirst();
	String filename = request.getParameter("date") + ".xls";
	String path = application.getRealPath("/report");
	FileOutputStream fos = new FileOutputStream(path + "/" + filename);
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

	Export ex = new Export()
	{
		public void initSql(String where)
		{
		}
	};
	ex.release();
	ex.setFileName("导出银联参数报表");
	ex.exportLog(session);
	out.println("<a href='../../../report/" + filename + "'>" + filename
			+ "</a>");
	//response.sendRedirect("report" + File.separator + filename);
%>


