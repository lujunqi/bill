package com.szzt.export;

import java.io.FileOutputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Types;
import java.util.*;

import javax.servlet.ServletContext;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.dodou.db.DatabaseAccess;
import com.dodou.log.Log;
import com.dodou.util.UtilTime;
import com.ljq.MyDatabase;

public class APMSImportExcel
{
	public String createAPMSData2Excel(String yesterday,
			ServletContext application,String filename) throws Exception
	{
		SqlPropertiesUtil util = new SqlPropertiesUtil();

		String path = application.getRealPath("/report");

		Log.getLogger().info("创建[" + filename + "]Excel文件，路径在[" + path + "]");
		FileOutputStream fos = new FileOutputStream(path + "/" + filename);
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet s = wb.createSheet();
		/****************************************************/
		DatabaseAccess dba = new DatabaseAccess();
		ResultSet rs = dba.executeQuery(util.load(SqlPropertiesUtil.SHANG_HU));
		wb.setSheetName(0, "商户");

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

	
	public String createAPMSData2Excel2(String yesterday,
		ServletContext application,String filename) throws Exception
{
	SqlPropertiesUtil2 util = new SqlPropertiesUtil2();

	String path = application.getRealPath("/report");

	Log.getLogger().info("创建[" + filename + "]Excel文件，路径在[" + path + "]");
	FileOutputStream fos = new FileOutputStream(path + "/" + filename);
	HSSFWorkbook wb = new HSSFWorkbook();
	HSSFSheet s = wb.createSheet();
	/****************************************************/
	DatabaseAccess dba = new DatabaseAccess();
//	ResultSet rs = dba.executeQuery(util.load(SqlPropertiesUtil2.SHANG_HU));
	MyDatabase md = new MyDatabase();
	md.init("createAPMSData2Excel2_shanghu",dba.getConnection());
	Map<String, Object> map = new HashMap<String,Object>();
	map.put("yesterday", yesterday);
	ResultSet rs = md.getResultSet(map);
	wb.setSheetName(0, "商户");
	createSheet(s, rs);
	rs.close();
	/****************************************************/

	// 分店
	dba = new DatabaseAccess();
	//rs = dba.executeQuery(util.load(SqlPropertiesUtil2.FENG_DIAN));
	md.init("createAPMSData2Excel2_fendian",dba.getConnection());
	 rs = md.getResultSet(map);
	HSSFSheet s1 = wb.createSheet();
	wb.setSheetName(1, "分店");
	createSheet(s1, rs);
	rs.close();
	/****************************************************/

	dba = new DatabaseAccess();
	md.init("createAPMSData2Excel2_zhongduan",dba.getConnection());
	rs = md.getResultSet(map);
	//	rs = dba.executeQuery(util.load(SqlPropertiesUtil2.ZHONG_DUAN));
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
	
	public String createAPMSData2Excel3(String yesterday,
		ServletContext application,String filename) throws Exception
{
	SqlPropertiesUtil3 util = new SqlPropertiesUtil3();

	String path = application.getRealPath("/report");

	Log.getLogger().info("创建[" + filename + "]Excel文件，路径在[" + path + "]");
	FileOutputStream fos = new FileOutputStream(path + "/" + filename);
	HSSFWorkbook wb = new HSSFWorkbook();
	HSSFSheet s = wb.createSheet();
	/****************************************************/
	DatabaseAccess dba = new DatabaseAccess();
//	ResultSet rs = dba.executeQuery(util.load(SqlPropertiesUtil3.SHANG_HU));
	MyDatabase md = new MyDatabase();
	md.init("createAPMSData2Excel3_shanghu",dba.getConnection());
	Map<String, Object> map = new HashMap<String,Object>();
	map.put("yesterday", yesterday);
	ResultSet rs = md.getResultSet(map);
	wb.setSheetName(0, "商户");
	createSheet(s, rs);
	rs.close();
	/****************************************************/

	// 分店
	dba = new DatabaseAccess();
//	rs = dba.executeQuery(util.load(SqlPropertiesUtil3.FENG_DIAN));
	md.init("createAPMSData2Excel3_fendian",dba.getConnection());
	 rs = md.getResultSet(map);
	HSSFSheet s1 = wb.createSheet();
	wb.setSheetName(1, "分店");
	createSheet(s1, rs);
	rs.close();
	/****************************************************/

	dba = new DatabaseAccess();
//	rs = dba.executeQuery(util.load(SqlPropertiesUtil3.ZHONG_DUAN));
	md.init("createAPMSData2Excel3_zhongduan",dba.getConnection());
	rs = md.getResultSet(map);
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
