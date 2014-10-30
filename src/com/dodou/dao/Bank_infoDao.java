package com.dodou.dao;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.*;
import com.dodou.table.*;
import com.dodou.log.*;
import java.sql.ResultSet;

public class Bank_infoDao extends CreatePage
{
	public Bank_info[] select() throws Exception
	{
		String sql = "select * from BANK_INFO order by BANK_CODE desc";
		return this.select(sql);
	}

	public Bank_info[] select(String sql) throws Exception
	{
		Bank_info[] Bank_infoArray = new Bank_info[getPageSize()];
		Log.getLogger().debug("Bank_info [查找],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		ResultSet rs = dba.executeQuery(sql);
		rs.last();
		this.setTotalCount(rs.getRow());
		rs.first();
		int j = 0;
		for (int i = this.getStart(); i < this.getEnd(); i++)
		{
			if (this.getTotalCount() == 0)
				break;
			rs.absolute(i + 1);
			Bank_info bank_info = new Bank_info();
			bank_info.setBank_code(rs.getString("bank_code"));
			bank_info.setBank_name(rs.getString("bank_name"));
			bank_info.setQingsuanno(rs.getString("qingsuanno"));
			Bank_infoArray[j++] = bank_info;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Bank_infoArray;
	}

	public Bank_info[] select(Bank_info bank_info) throws Exception
	{
		String sql = "select * from BANK_INFO where 1 = 1 ";
		if (bank_info.getBank_code() != null)
		{
			sql += " and bank_code = '" + bank_info.getBank_code() + "'";
		}
		if (bank_info.getBank_name() != null)
		{
			sql += " and bank_name = '" + bank_info.getBank_name() + "'";
		}
		if (bank_info.getQingsuanno() != null)
		{
			sql += " and qingsuanno = '" + bank_info.getQingsuanno() + "'";
		}
		sql += " order by BANK_CODE desc";
		return this.select(sql);
	}

	public void insert(Bank_info bank_info) throws Exception
	{
		String sql = "insert into BANK_INFO ";
		String fields = "BANK_CODE";
		String values = "BANK_INFO_ID_SEQ.nextval";
		if (bank_info.getBank_name() != null)
		{
			fields += ",bank_name";
			values += ",'" + bank_info.getBank_name() + "'";
		}
		if (bank_info.getQingsuanno() != null)
		{
			fields += ",qingsuanno";
			values += ",'" + bank_info.getQingsuanno() + "'";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Bank_info [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Bank_info bank_info) throws Exception
	{
		String sql = "update BANK_INFO set BANK_CODE=BANK_CODE";
		if (bank_info.getBank_name() != null)
		{
			sql += ",bank_name='" + bank_info.getBank_name() + "'";
		}
		if (bank_info.getQingsuanno() != null)
		{
			sql += ",qingsuanno='" + bank_info.getQingsuanno() + "'";
		}
		sql += " where BANK_CODE=" + bank_info.getBank_code() + "";
		Log.getLogger().debug("Bank_info [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from BANK_INFO where BANK_CODE=" + id;
		Log.getLogger().debug("Bank_info [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Bank_info [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Bank_info whereBank_code(String bank_code) throws Exception
	{
		String sql = "select * from bank_info where bank_code=" + bank_code
				+ "";
		return this.select(sql)[0];
	}

	public Bank_info[] whereBank_name(String bank_name) throws Exception
	{
		String sql = "select * from bank_info where bank_name='" + bank_name
				+ "'";
		return this.select(sql);
	}

	public Bank_info[] whereQingsuanno(String qingsuanno) throws Exception
	{
		String sql = "select * from bank_info where qingsuanno='" + qingsuanno
				+ "'";
		return this.select(sql);
	}
}
