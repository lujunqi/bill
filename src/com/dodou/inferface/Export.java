package com.dodou.inferface;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Types;

import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.dodou.db.DatabaseAccess;
import com.dodou.log.Log;
import com.dodou.table.Operman_info;
import com.dodou.util.Config;
import com.dodou.util.UtilTime;

/**
 * 导出文件的通用实现类
 * 
 * @author 陈孟琳
 * 
 */
public abstract class Export
{
	private String fileName;
	private String sql;

	public void release() throws Exception
	{
		this.dba.release();
	}

	protected DatabaseAccess dba = new DatabaseAccess();

	/**
	 * 初始化查询条件以及将字段名称转换成中文名称
	 * 
	 * @param where
	 */
	public abstract void initSql(String where);

	/**
	 * 插入导出日志
	 * 
	 * @param session
	 * @throws Exception
	 */
	public final void exportLog(HttpSession session) throws Exception
	{
		Operman_info info = (Operman_info) session.getAttribute("man");

		DatabaseAccess acc = new DatabaseAccess();
		StringBuffer buffer = new StringBuffer();
		buffer.append("insert into common_log(id,target_id,table_name,do_type,who,do_what) ");
		buffer.append("values(common_log_id.nextval").append(",");
		buffer.append("1").append(",");
		buffer.append("'报表导出日志'").append(",");
		buffer.append("111").append(",");
		buffer.append("'" + info.getOperman_name() + "'").append(",");
		buffer.append("'").append("导出报表---》" + this.getFileName()).append("'")
				.append(")");
		acc.executeUpdate(buffer.toString());
		acc.release();
	}

	/**
	 * 生成excel文件
	 * 
	 * @param sql
	 * @param filePath
	 * @return
	 * @throws Exception
	 */
	public final String export(String filePath) throws Exception
	{
		ResultSet rs = this.dba.executeQuery(sql);
		if (!rs.next())
		{
			rs.close();
			dba.release();
			return "  <SCRIPT LANGUAGE=\'JavaScript\'> 	alert(\'没有找到此商户任何数据!\');</SCRIPT>";
		}
		rs.beforeFirst();
		String filename = this.getFileName() + ".xls";
		Log.getLogger().info(sql);

		FileOutputStream fos = new FileOutputStream(filePath + "/" + filename);

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
		return "导出文件:<a href=../../../report/" + filename + ">" + filename
				+ "</a>";
	}

	public String getFileName()
	{
		return fileName;
	}

	public void setFileName(String fileName)
	{
		this.fileName = fileName;
	}

	public DatabaseAccess getDba()
	{
		return dba;
	}

	public void setDba(DatabaseAccess dba)
	{
		this.dba = dba;
	}

	public String getSql()
	{
		return sql;
	}

	public void setSql(String sql)
	{
		this.sql = sql;
	}
}
