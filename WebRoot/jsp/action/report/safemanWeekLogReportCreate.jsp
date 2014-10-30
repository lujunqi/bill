<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@ include file="../../../import.jsp"%>
<%
	String date1 = request.getParameter("date1");
	String date2 = request.getParameter("date2");
	String defaultSql = "select  t.teminal_count,(select o.operman_name from operman_info o where o.operman_id = t.safe_man) as opera_man,t1.gain,round(t1.gain / t.teminal_count,2) as per_gain,round(t2.zero_count /t.teminal_count,2) as rate from (select count(*) as teminal_count,ii.safe_man from teminal_info ii, apppay_105 a,term_app_table temp where  ii.teminal_info_id=temp.teminal_info_id and a.apppay_id=temp.apppay_id and a.fee_chan=1 and ii.teminal_status=13 and ii.installed_status=4 group by ii.safe_man) t left join (  select sum(gain) as gain,i.safe_man from rep_teminal r,teminal_info i, apppay_105 a where r.total_date>='"
		+ date1
		+ "' and r.total_date<='"
		+ date2
		+ "'   and a.fee_chan=1 and r.merchantsno_id=a.apppay_id   and i.teminal_info_id=r.teminal_info_id group by i.safe_man) t1   on t1.safe_man=t.safe_man left join ( select count(*)as zero_count,i.safe_man   from (select m.merchantsno_id,                m.teminal_info_id,                sum(fee_count) as fee_count           from rep_teminal m          where m.total_date <= '"
		+ date2
		+ "'            and m.total_date >= '"
		+ date1
		+ "'          group by m.teminal_info_id, m.merchantsno_id) gain,        teminal_info i,        term_app_table temp,        apppay_105 a  where   gain.merchantsno_id=temp.apppay_id   and gain.teminal_info_id = temp.teminal_info_id   and i.teminal_info_id=temp.teminal_info_id   and a.apppay_id=temp.apppay_id   and gain.fee_count > 0   and i.teminal_status = 13   and i.installed_status=4   and a.fee_chan=1   group by i.safe_man) t2   on t2.safe_man=t.safe_man";

	DatabaseAccess dba = new DatabaseAccess();
	ResultSet rs = dba.executeQuery(defaultSql);
	if (!rs.next())
	{
		rs.close();
		dba.release();
		out.println("  <SCRIPT LANGUAGE=\'JavaScript\'> 	alert(\'没有找到此商户任何数据!\'); this.window.opener = null;window.close();     </SCRIPT>");
		return;
	}
	rs.beforeFirst();
	String filename = "safemanWeekLog.xls";
	Log.getLogger().info(defaultSql);
	String path = Config.getConfiguration().getString("REPORT-PATH");
	FileOutputStream fos = new FileOutputStream(
			application.getRealPath("/report") + File.separator + filename);
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
	//out.println();
	response.sendRedirect("../../../report"+File.separator+filename);
	//response.sendRedirect(application.getRealPath("/report") + filename);
%>


