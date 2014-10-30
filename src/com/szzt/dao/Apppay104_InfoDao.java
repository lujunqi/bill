package com.szzt.dao;

import java.sql.ResultSet;

import com.dodou.db.DatabaseAccess;
import com.dodou.service.MainServlet;
import com.dodou.table.Terminal_Info;

public class Apppay104_InfoDao
{
	public static final String TYPE = "01";// 便民支付
	public static final String MCC = "4900";// 便民支付
	public static final String SEQUENCE = "APPPAY_104_ID";

	private DatabaseAccess acc = new DatabaseAccess();

	private int loadNextSq() throws Exception
	{
		ResultSet set = acc.executeQuery("select " + SEQUENCE
				+ ".nextval from dual");
		set.next();
		return set.getInt(1);
	}

	/**
	 * 转换成00000001格式
	 * 
	 * @param v
	 * @return
	 */
	private String changeToNum(String v)
	{
		for (int i = v.length(); i < 8; i++)
		{
			v = "0" + v;
		}
		return v;
	}

	public void insert(Terminal_Info ter) throws Exception
	{
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ")
				.append(ApppayTerminalDao.TABLE)
				.append("(COMMERCIAL_ID,TEMINAL_INFO_ID,APPTYPE,APP_NAME,TERM_ID1,TERM_ID2,MENU_VER,")
				.append("APPDATA_NAME,STATUS,APPPAY_ID)");
		sql.append(" values(").append(ter.getCOMMERCIAL_ID()).append(",")
				.append(ter.getTEMINAL_INFO_ID()).append(",").append("104")
				.append(",'便民支付',").append("'" + this.loadSequence(ter) + "',")
				.append("'" + this.loadSequence(ter) + "',")
				.append("'MENU_VER',").append("'APPDATA_NAME',").append(1)
				.append(",").append("0)");
		acc.executeUpdate(sql.toString());
		acc.release();
	}

	private String loadSequence(Terminal_Info ter) throws Exception
	{
		String city = ter.getUNIT_INSTALLED_CITY();
		String number = null;
		if (null != city)
		{
			city = city.substring(city.length() - 2);
			number = TYPE + city + MCC
					+ this.changeToNum(this.loadNextSq() + "");
		}

		return number;
	}

}
