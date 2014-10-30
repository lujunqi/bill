package com.dodou.dao;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.*;
import com.dodou.table.*;
import com.dodou.log.*;
import java.sql.Timestamp;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;

public class Bill_depaDao extends CreatePage
{
	public Bill_depa[] select() throws Exception
	{
		String sql = "select * from BILL_DEPA order by BILL_DEPA_ID desc";
		return this.select(sql);
	}

	public Bill_depa[] select(String sql) throws Exception
	{
		Bill_depa[] Bill_depaArray = new Bill_depa[getPageSize()];
		Log.getLogger().debug("Bill_depa [查找],SQL:[" + sql + "]");
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
			Bill_depa bill_depa = new Bill_depa();
			bill_depa.setBank_code(rs.getString("bank_code"));
			bill_depa.setBill_depa_id(rs.getInt("bill_depa_id"));
			bill_depa.setDepa_name(rs.getString("depa_name"));
			bill_depa.setDepa_area(rs.getString("depa_area"));
			bill_depa.setDepa_level(rs.getInt("depa_level"));
			bill_depa.setParent_depa_id(rs.getInt("parent_depa_id"));
			Bill_depaArray[j++] = bill_depa;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Bill_depaArray;
	}

	public Bill_depa[] select(Bill_depa bill_depa) throws Exception
	{
		String sql = "select * from BILL_DEPA where 1 = 1 ";
		if (bill_depa.getBank_code() != null)
		{
			sql += " and bank_code = '" + bill_depa.getBank_code() + "'";
		}
		if (bill_depa.getBill_depa_id() != 0)
		{
			sql += " and bill_depa_id = " + bill_depa.getBill_depa_id() + "";
		}
		if (bill_depa.getDepa_name() != null)
		{
			sql += " and depa_name = '" + bill_depa.getDepa_name() + "'";
		}
		if (bill_depa.getDepa_area() != null)
		{
			sql += " and depa_area = '" + bill_depa.getDepa_area() + "'";
		}
		if (bill_depa.getDepa_level() != 0)
		{
			sql += " and depa_level = " + bill_depa.getDepa_level() + "";
		}
		if (bill_depa.getParent_depa_id() != 0)
		{
			sql += " and parent_depa_id = " + bill_depa.getParent_depa_id()
					+ "";
		}
		sql += " order by BILL_DEPA_ID desc";
		return this.select(sql);
	}

	public void insert(Bill_depa bill_depa) throws Exception
	{
		String sql = "insert into BILL_DEPA ";
		String fields = "BILL_DEPA_ID";
		String values = "BILL_DEPA_ID_SEQ.nextval";
		if (bill_depa.getBank_code() != null)
		{
			fields += ",bank_code";
			values += ",'" + bill_depa.getBank_code() + "'";
		}
		if (bill_depa.getDepa_name() != null)
		{
			fields += ",depa_name";
			values += ",'" + bill_depa.getDepa_name() + "'";
		}
		if (bill_depa.getDepa_area() != null)
		{
			fields += ",depa_area";
			values += ",'" + bill_depa.getDepa_area() + "'";
		}
		if (bill_depa.getDepa_level() != 0)
		{
			fields += ",depa_level";
			values += "," + bill_depa.getDepa_level() + "";
		}
		if (bill_depa.getParent_depa_id() != 0)
		{
			fields += ",parent_depa_id";
			values += "," + bill_depa.getParent_depa_id() + "";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Bill_depa [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Bill_depa bill_depa) throws Exception
	{
		String sql = "update BILL_DEPA set BILL_DEPA_ID=BILL_DEPA_ID";
		if (bill_depa.getBank_code() != null)
		{
			sql += ",bank_code='" + bill_depa.getBank_code() + "'";
		}
		if (bill_depa.getDepa_name() != null)
		{
			sql += ",depa_name='" + bill_depa.getDepa_name() + "'";
		}
		if (bill_depa.getDepa_area() != null)
		{
			sql += ",depa_area='" + bill_depa.getDepa_area() + "'";
		}
		if (bill_depa.getDepa_level() != 0)
		{
			sql += ",depa_level=" + bill_depa.getDepa_level() + "";
		}
		if (bill_depa.getParent_depa_id() != 0)
		{
			sql += ",parent_depa_id=" + bill_depa.getParent_depa_id() + "";
		}
		sql += " where BILL_DEPA_ID=" + bill_depa.getBill_depa_id() + "";
		Log.getLogger().debug("Bill_depa [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from BILL_DEPA where BILL_DEPA_ID=" + id;
		Log.getLogger().debug("Bill_depa [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Bill_depa [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Bill_depa[] whereBank_code(String bank_code) throws Exception
	{
		String sql = "select * from bill_depa where bank_code='" + bank_code
				+ "'";
		return this.select(sql);
	}

	public Bill_depa whereBill_depa_id(int bill_depa_id) throws Exception
	{
		String sql = "select * from bill_depa where bill_depa_id="
				+ bill_depa_id + "";
		return this.select(sql)[0];
	}

	public Bill_depa[] whereDepa_name(String depa_name) throws Exception
	{
		String sql = "select * from bill_depa where depa_name='" + depa_name
				+ "'";
		return this.select(sql);
	}

	public Bill_depa[] whereDepa_area(String depa_area) throws Exception
	{
		String sql = "select * from bill_depa where depa_area='" + depa_area
				+ "'";
		return this.select(sql);
	}

	public Bill_depa[] whereDepa_level(int depa_level) throws Exception
	{
		String sql = "select * from bill_depa where depa_level=" + depa_level
				+ "";
		return this.select(sql);
	}

	public Bill_depa[] whereParent_depa_id(int parent_depa_id) throws Exception
	{
		String sql = "select * from bill_depa where parent_depa_id="
				+ parent_depa_id + "";
		return this.select(sql);
	}
}
