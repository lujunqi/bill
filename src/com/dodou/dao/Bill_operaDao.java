package com.dodou.dao;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.*;
import com.dodou.table.*;
import com.dodou.log.*;
import java.sql.Timestamp;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;

public class Bill_operaDao extends CreatePage
{
	public Bill_opera[] select() throws Exception
	{
		String sql = "select * from BILL_OPERA order by BILL_OPERA_ID desc";
		return this.select(sql);
	}

	public Bill_opera[] select(String sql) throws Exception
	{
		Bill_opera[] Bill_operaArray = new Bill_opera[getPageSize()];
		Log.getLogger().debug("Bill_opera [查找],SQL:[" + sql + "]");
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
			Bill_opera bill_opera = new Bill_opera();
			bill_opera.setBill_opera_id(rs.getInt("bill_opera_id"));
			bill_opera.setBill_depa_id(rs.getInt("bill_depa_id"));
			bill_opera.setTele_no(rs.getString("tele_no"));
			bill_opera.setPasswd(rs.getString("passwd"));
			bill_opera.setName(rs.getString("name"));
			bill_opera.setOpera_type(rs.getInt("opera_type"));
			bill_opera.setOperr_status(rs.getInt("operr_status"));
			Bill_operaArray[j++] = bill_opera;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Bill_operaArray;
	}

	public Bill_opera[] select(Bill_opera bill_opera) throws Exception
	{
		String sql = "select * from BILL_OPERA where 1 = 1 ";
		if (bill_opera.getBill_opera_id() != 0)
		{
			sql += " and bill_opera_id = " + bill_opera.getBill_opera_id() + "";
		}
		if (bill_opera.getBill_depa_id() != 0)
		{
			sql += " and bill_depa_id = " + bill_opera.getBill_depa_id() + "";
		}
		if (bill_opera.getTele_no() != null)
		{
			sql += " and tele_no = '" + bill_opera.getTele_no() + "'";
		}
		if (bill_opera.getPasswd() != null)
		{
			sql += " and passwd = '" + bill_opera.getPasswd() + "'";
		}
		if (bill_opera.getName() != null)
		{
			sql += " and name = '" + bill_opera.getName() + "'";
		}
		if (bill_opera.getOpera_type() != 0)
		{
			sql += " and opera_type = " + bill_opera.getOpera_type() + "";
		}
		if (bill_opera.getOperr_status() != 0)
		{
			sql += " and operr_status = " + bill_opera.getOperr_status() + "";
		}
		sql += " order by BILL_OPERA_ID desc";
		return this.select(sql);
	}

	public void insert(Bill_opera bill_opera) throws Exception
	{
		String sql = "insert into BILL_OPERA ";
		String fields = "BILL_OPERA_ID";
		String values = "BILL_OPERA_ID_SEQ.nextval";
		if (bill_opera.getBill_depa_id() != 0)
		{
			fields += ",bill_depa_id";
			values += "," + bill_opera.getBill_depa_id() + "";
		}
		if (bill_opera.getTele_no() != null)
		{
			fields += ",tele_no";
			values += ",'" + bill_opera.getTele_no() + "'";
		}
		if (bill_opera.getPasswd() != null)
		{
			fields += ",passwd";
			values += ",'" + bill_opera.getPasswd() + "'";
		}
		if (bill_opera.getName() != null)
		{
			fields += ",name";
			values += ",'" + bill_opera.getName() + "'";
		}
		if (bill_opera.getOpera_type() != 0)
		{
			fields += ",opera_type";
			values += "," + bill_opera.getOpera_type() + "";
		}
		if (bill_opera.getOperr_status() != 0)
		{
			fields += ",operr_status";
			values += "," + bill_opera.getOperr_status() + "";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Bill_opera [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Bill_opera bill_opera) throws Exception
	{
		String sql = "update BILL_OPERA set BILL_OPERA_ID=BILL_OPERA_ID";
		if (bill_opera.getBill_depa_id() != 0)
		{
			sql += ",bill_depa_id=" + bill_opera.getBill_depa_id() + "";
		}
		if (bill_opera.getTele_no() != null)
		{
			sql += ",tele_no='" + bill_opera.getTele_no() + "'";
		}
		if (bill_opera.getPasswd() != null)
		{
			sql += ",passwd='" + bill_opera.getPasswd() + "'";
		}
		if (bill_opera.getName() != null)
		{
			sql += ",name='" + bill_opera.getName() + "'";
		}
		if (bill_opera.getOpera_type() != 0)
		{
			sql += ",opera_type=" + bill_opera.getOpera_type() + "";
		}
		if (bill_opera.getOperr_status() != 0)
		{
			sql += ",operr_status=" + bill_opera.getOperr_status() + "";
		}
		sql += " where BILL_OPERA_ID=" + bill_opera.getBill_opera_id() + "";
		Log.getLogger().debug("Bill_opera [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from BILL_OPERA where BILL_OPERA_ID=" + id;
		Log.getLogger().debug("Bill_opera [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Bill_opera [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Bill_opera whereBill_opera_id(int bill_opera_id) throws Exception
	{
		String sql = "select * from bill_opera where bill_opera_id="
				+ bill_opera_id + "";
		return this.select(sql)[0];
	}

	public Bill_opera[] whereBill_depa_id(int bill_depa_id) throws Exception
	{
		String sql = "select * from bill_opera where bill_depa_id="
				+ bill_depa_id + "";
		return this.select(sql);
	}

	public Bill_opera[] whereTele_no(String tele_no) throws Exception
	{
		String sql = "select * from bill_opera where tele_no='" + tele_no + "'";
		return this.select(sql);
	}

	public Bill_opera[] wherePasswd(String passwd) throws Exception
	{
		String sql = "select * from bill_opera where passwd='" + passwd + "'";
		return this.select(sql);
	}

	public Bill_opera[] whereName(String name) throws Exception
	{
		String sql = "select * from bill_opera where name='" + name + "'";
		return this.select(sql);
	}

	public Bill_opera[] whereOpera_type(int opera_type) throws Exception
	{
		String sql = "select * from bill_opera where opera_type=" + opera_type
				+ "";
		return this.select(sql);
	}

	public Bill_opera[] whereOperr_status(int operr_status) throws Exception
	{
		String sql = "select * from bill_opera where operr_status="
				+ operr_status + "";
		return this.select(sql);
	}
}
