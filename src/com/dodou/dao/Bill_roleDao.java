package com.dodou.dao;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.*;
import com.dodou.table.*;
import com.dodou.log.*;
import java.sql.Timestamp;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;

public class Bill_roleDao extends CreatePage
{
	public Bill_role[] select() throws Exception
	{
		String sql = "select * from BILL_ROLE order by BILL_ROLE_ID desc";
		return this.select(sql);
	}

	public Bill_role[] select(String sql) throws Exception
	{
		Bill_role[] Bill_roleArray = new Bill_role[getPageSize()];
		Log.getLogger().debug("Bill_role [查找],SQL:[" + sql + "]");
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
			Bill_role bill_role = new Bill_role();
			bill_role.setBill_role_id(rs.getInt("bill_role_id"));
			bill_role.setName(rs.getString("name"));
			bill_role.setPage_url(rs.getString("page_url"));
			Bill_roleArray[j++] = bill_role;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Bill_roleArray;
	}

	public Bill_role[] select(Bill_role bill_role) throws Exception
	{
		String sql = "select * from BILL_ROLE where 1 = 1 ";
		if (bill_role.getBill_role_id() != 0)
		{
			sql += " and bill_role_id = " + bill_role.getBill_role_id() + "";
		}
		if (bill_role.getName() != null)
		{
			sql += " and name = '" + bill_role.getName() + "'";
		}
		if (bill_role.getPage_url() != null)
		{
			sql += " and page_url = '" + bill_role.getPage_url() + "'";
		}
		sql += " order by BILL_ROLE_ID desc";
		return this.select(sql);
	}

	public void insert(Bill_role bill_role) throws Exception
	{
		String sql = "insert into BILL_ROLE ";
		String fields = "BILL_ROLE_ID";
		String values = "BILL_ROLE_ID_SEQ.nextval";
		if (bill_role.getName() != null)
		{
			fields += ",name";
			values += ",'" + bill_role.getName() + "'";
		}
		if (bill_role.getPage_url() != null)
		{
			fields += ",page_url";
			values += ",'" + bill_role.getPage_url() + "'";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Bill_role [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Bill_role bill_role) throws Exception
	{
		String sql = "update BILL_ROLE set BILL_ROLE_ID=BILL_ROLE_ID";
		if (bill_role.getName() != null)
		{
			sql += ",name='" + bill_role.getName() + "'";
		}
		if (bill_role.getPage_url() != null)
		{
			sql += ",page_url='" + bill_role.getPage_url() + "'";
		}
		sql += " where BILL_ROLE_ID=" + bill_role.getBill_role_id() + "";
		Log.getLogger().debug("Bill_role [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from BILL_ROLE where BILL_ROLE_ID=" + id;
		Log.getLogger().debug("Bill_role [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Bill_role [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Bill_role whereBill_role_id(int bill_role_id) throws Exception
	{
		String sql = "select * from bill_role where bill_role_id="
				+ bill_role_id + "";
		return this.select(sql)[0];
	}

	public Bill_role[] whereName(String name) throws Exception
	{
		String sql = "select * from bill_role where name='" + name + "'";
		return this.select(sql);
	}

	public Bill_role[] wherePage_url(String page_url) throws Exception
	{
		String sql = "select * from bill_role where page_url='" + page_url
				+ "'";
		return this.select(sql);
	}
}
