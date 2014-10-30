package com.dodou.dao;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.*;
import com.dodou.table.*;
import com.dodou.log.*;
import java.sql.Timestamp;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;

public class Bill_opera_roleDao extends CreatePage
{
	public Bill_opera_role[] select() throws Exception
	{
		String sql = "select * from BILL_OPERA_ROLE order by BILL_OPERA_ROLE_ID desc";
		return this.select(sql);
	}

	public Bill_opera_role[] select(String sql) throws Exception
	{
		Bill_opera_role[] Bill_opera_roleArray = new Bill_opera_role[getPageSize()];
		Log.getLogger().debug("Bill_opera_role [查找],SQL:[" + sql + "]");
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
			Bill_opera_role bill_opera_role = new Bill_opera_role();
			bill_opera_role.setBill_opera_role_id(rs
					.getInt("bill_opera_role_id"));
			bill_opera_role.setBill_role_id(rs.getInt("bill_role_id"));
			bill_opera_role.setBill_opera_id(rs.getInt("bill_opera_id"));
			Bill_opera_roleArray[j++] = bill_opera_role;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Bill_opera_roleArray;
	}

	public Bill_opera_role[] select(Bill_opera_role bill_opera_role)
			throws Exception
	{
		String sql = "select * from BILL_OPERA_ROLE where 1 = 1 ";
		if (bill_opera_role.getBill_opera_role_id() != 0)
		{
			sql += " and bill_opera_role_id = "
					+ bill_opera_role.getBill_opera_role_id() + "";
		}
		if (bill_opera_role.getBill_role_id() != 0)
		{
			sql += " and bill_role_id = " + bill_opera_role.getBill_role_id()
					+ "";
		}
		if (bill_opera_role.getBill_opera_id() != 0)
		{
			sql += " and bill_opera_id = " + bill_opera_role.getBill_opera_id()
					+ "";
		}
		sql += " order by BILL_OPERA_ROLE_ID desc";
		return this.select(sql);
	}

	public void insert(Bill_opera_role bill_opera_role) throws Exception
	{
		String sql = "insert into BILL_OPERA_ROLE ";
		String fields = "BILL_OPERA_ROLE_ID";
		String values = "BILL_OPERA_ROLE_ID_SEQ.nextval";
		if (bill_opera_role.getBill_role_id() != 0)
		{
			fields += ",bill_role_id";
			values += "," + bill_opera_role.getBill_role_id() + "";
		}
		if (bill_opera_role.getBill_opera_id() != 0)
		{
			fields += ",bill_opera_id";
			values += "," + bill_opera_role.getBill_opera_id() + "";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Bill_opera_role [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Bill_opera_role bill_opera_role) throws Exception
	{
		String sql = "update BILL_OPERA_ROLE set BILL_OPERA_ROLE_ID=BILL_OPERA_ROLE_ID";
		if (bill_opera_role.getBill_role_id() != 0)
		{
			sql += ",bill_role_id=" + bill_opera_role.getBill_role_id() + "";
		}
		if (bill_opera_role.getBill_opera_id() != 0)
		{
			sql += ",bill_opera_id=" + bill_opera_role.getBill_opera_id() + "";
		}
		sql += " where BILL_OPERA_ROLE_ID="
				+ bill_opera_role.getBill_opera_role_id() + "";
		Log.getLogger().debug("Bill_opera_role [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from BILL_OPERA_ROLE where BILL_OPERA_ROLE_ID="
				+ id;
		Log.getLogger().debug("Bill_opera_role [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Bill_opera_role [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Bill_opera_role whereBill_opera_role_id(int bill_opera_role_id)
			throws Exception
	{
		String sql = "select * from bill_opera_role where bill_opera_role_id="
				+ bill_opera_role_id + "";
		return this.select(sql)[0];
	}

	public Bill_opera_role[] whereBill_role_id(int bill_role_id)
			throws Exception
	{
		String sql = "select * from bill_opera_role where bill_role_id="
				+ bill_role_id + "";
		return this.select(sql);
	}

	public Bill_opera_role[] whereBill_opera_id(int bill_opera_id)
			throws Exception
	{
		String sql = "select * from bill_opera_role where bill_opera_id="
				+ bill_opera_id + "";
		return this.select(sql);
	}
}
