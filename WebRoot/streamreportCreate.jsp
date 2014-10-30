<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@ include file="import.jsp"%>
<%
	String col1 = request.getParameter("col1");
	String date1 = request.getParameter("date1");
	String date2 = request.getParameter("date2");
	String chan_type = request.getParameter("chan_type");
	String sql= "";
	//to_date(coma.col4,'MMDDHH24miss')
	if(chan_type.equals("1")){
		sql="SELECT   to_date(substr(file_name,4,2) || col4,'YYMMddHH24miss') as 交易时间,coma.col3 as 系统跟踪号,coma.col13 as 商户编号,coma.col12 as 终端编号,(select col39 from cms.gw_customer c where c.col41=coma.col13) as 商户名称,coma.col5 as  主账,coma.col29 as 发卡机构代码,coma.col10 as 交易类型,coma.col6 / 100 as 交易金额,coma.col21 / 100 as 通联应收,coma.col22/100 as 通联应付, coma.col21 / 100 - coma.col22/100 as 通联手续,substr(coma.col44,2) /100 as 商户手续,coma.col37 as 冲正标志,col38 as 撤销标志 from cms.gw_coma coma where col13 in ('"+col1+"') and substr(file_name,4,6)  between '"+date1+"' and '"+date2+"' order by coma.col4";
	}else{
		sql="select a.col5 as 商户编号,col22 as 终端编号,col6 as 商户名称,col11 as 交易时间,col13 as 交易类型,col14 as 交易状态, col16 as 交易金额,col23 as 商户手续费,col27 as 通联收益,col50 as 交易笔数  from cms.gw_apmstrans a where a.col5='"+col1+"' and a.col11 between '20"+date1+"' and '20"+date2+"' order by col11 desc";
	}
	DatabaseAccess dba = new DatabaseAccess();
	ResultSet rs = dba.executeQuery(sql);
	if(!rs.next()){
		rs.close();
		dba.release();
		out.println("  <SCRIPT LANGUAGE=\'JavaScript\'> 	alert(\'没有找到此商户任何数据!!!!!!!!!\'); this.window.opener = null;window.close();     </SCRIPT>");
		return;	
	}
	rs.beforeFirst();
	String filename = request.getParameter("filename") + ".xls";
	String path = Config.getConfiguration().getString("REPORT-PATH");
	FileOutputStream fos = new FileOutputStream(path + filename);
	HSSFWorkbook wb = new HSSFWorkbook();
	HSSFSheet s = wb.createSheet();
	wb.setSheetName(0, filename);


	
	HSSFRow row = s.createRow(0);
	ResultSetMetaData rsmd = rs.getMetaData();
	int count = rsmd.getColumnCount();
	for (int j = 0; j < count; j++) {
		HSSFCell cell = row.createCell((short)j);
		cell.setCellValue(rsmd.getColumnName(j + 1));
	}
	int i = 1;
	while (rs.next()) {
		row = s.createRow(i++);
		for (int j = 0; j < count; j++) {
			String val;
			if (rsmd.getColumnType((j + 1)) == Types.TIMESTAMP) {
				val = UtilTime.getChinaFormat2String(rs
						.getTimestamp((j + 1)));
			} else {
				val = rs.getString((j + 1));
			}
			if (val == null) {
				val = "";
			}
			HSSFCell cell = row.createCell((short)j);
			cell.setCellValue(val);
		}
	}
	rs.close();
	dba.release();
	wb.write(fos);
	fos.close();
	//out.println("<a href=./"+filename+">"+filename+"</a>");
	response.sendRedirect("report"+File.separator+filename);
%>