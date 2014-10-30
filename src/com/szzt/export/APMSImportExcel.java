package com.szzt.export;

import java.io.FileOutputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Types;

import javax.servlet.ServletContext;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.dodou.db.DatabaseAccess;
import com.dodou.log.Log;
import com.dodou.util.UtilTime;

public class APMSImportExcel
{
	public String createAPMSData2Excel(String yesterday,
			ServletContext application) throws Exception
	{
		SqlPropertiesUtil util = new SqlPropertiesUtil();

		String filename = "apms" + yesterday + ".xls";
		String path = application.getRealPath("/report");

		Log.getLogger().info("创建[" + filename + "]Excel文件，路径在[" + path + "]");
		FileOutputStream fos = new FileOutputStream(path + "/" + filename);
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet s = wb.createSheet();
		/****************************************************/
		DatabaseAccess dba = new DatabaseAccess();
		ResultSet rs = dba.executeQuery(util.load(SqlPropertiesUtil.SHANG_HU));
		wb.setSheetName(0, "客户");

		createSheet(s, rs);
		rs.close();
		/****************************************************/

		// 分店
		dba = new DatabaseAccess();
		rs = dba.executeQuery(util.load(SqlPropertiesUtil.FENG_DIAN));
		HSSFSheet s1 = wb.createSheet();
		wb.setSheetName(1, "分店");
		createSheet(s1, rs);
		rs.close();
		/****************************************************/

		dba = new DatabaseAccess();
		rs = dba.executeQuery(util.load(SqlPropertiesUtil.ZHONG_DUAN));
		HSSFSheet s2 = wb.createSheet();
		wb.setSheetName(2, "终端");
		createSheet(s2, rs);
		rs.close();
		/****************************************************/
		dba.release();
		wb.write(fos);
		fos.close();
		return path + "/" + filename;
	}

	public void createSheet(HSSFSheet s, ResultSet rs) throws Exception
	{
		HSSFRow row = s.createRow(0);
		ResultSetMetaData rsmd = rs.getMetaData();
		int count = rsmd.getColumnCount();
		int k = 0;
		for (; k < count; k++)
		{
			HSSFCell cell = row.createCell((short) k);
			cell.setCellValue(rsmd.getColumnName(k + 1));
		}

		int i = 1;
		while (rs.next())
		{
			row = s.createRow(i++);
			int j = 0;
			for (; j < count; j++)
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
	}
}
