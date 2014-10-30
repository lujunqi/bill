package com.dodou.dao;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.*;
import com.dodou.table.*;
import com.dodou.log.*;
import java.sql.Timestamp;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;

public class Teminal_info_keyDao extends CreatePage
{
	public Teminal_info_key[] select() throws Exception
	{
		String sql = "select * from TEMINAL_INFO_KEY order by TEMINAL_INFO_KEY_ID desc";
		return this.select(sql);
	}

	public Teminal_info_key[] select(String sql) throws Exception
	{
		Teminal_info_key[] Teminal_info_keyArray = new Teminal_info_key[getPageSize()];
		Log.getLogger().debug("Teminal_info_key [查找],SQL:[" + sql + "]");
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
			Teminal_info_key teminal_info_key = new Teminal_info_key();
			teminal_info_key.setTeminal_info_key_id(rs
					.getInt("teminal_info_key_id"));
			teminal_info_key.setHost_no(rs.getString("host_no"));
			teminal_info_key.setArea(rs.getInt("area"));
			teminal_info_key.setStatus(rs.getInt("status"));
			teminal_info_key.setIn_time(rs.getString("in_time"));
			teminal_info_key.setUp_time(rs.getString("up_time"));
			Teminal_info_keyArray[j++] = teminal_info_key;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Teminal_info_keyArray;
	}

	public Teminal_info_key[] select(Teminal_info_key teminal_info_key)
			throws Exception
	{
		String sql = "select * from TEMINAL_INFO_KEY where 1 = 1 ";
		if (teminal_info_key.getTeminal_info_key_id() != 0)
		{
			sql += " and teminal_info_key_id = "
					+ teminal_info_key.getTeminal_info_key_id() + "";
		}
		if (teminal_info_key.getHost_no() != null)
		{
			sql += " and host_no = '" + teminal_info_key.getHost_no() + "'";
		}
		if (teminal_info_key.getArea() != 0)
		{
			sql += " and area = " + teminal_info_key.getArea() + "";
		}
		if (teminal_info_key.getStatus() != 0)
		{
			sql += " and status = " + teminal_info_key.getStatus() + "";
		}
		if (teminal_info_key.getIn_time() != null)
		{
			sql += " and in_time = to_date('" + teminal_info_key.getIn_time()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_key.getUp_time() != null)
		{
			sql += " and up_time = to_date('" + teminal_info_key.getUp_time()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		sql += " order by TEMINAL_INFO_KEY_ID desc";
		return this.select(sql);
	}

	public void insert(Teminal_info_key teminal_info_key) throws Exception
	{
		String sql = "insert into TEMINAL_INFO_KEY ";
		String fields = "TEMINAL_INFO_KEY_ID";
		String values = "TEMINAL_INFO_KEY_ID_SEQ.nextval";
		if (teminal_info_key.getHost_no() != null)
		{
			fields += ",host_no";
			values += ",'" + teminal_info_key.getHost_no() + "'";
		}
		if (teminal_info_key.getArea() != 0)
		{
			fields += ",area";
			values += "," + teminal_info_key.getArea() + "";
		}
		if (teminal_info_key.getStatus() != 0)
		{
			fields += ",status";
			values += "," + teminal_info_key.getStatus() + "";
		}
		if (teminal_info_key.getIn_time() != null)
		{
			fields += ",in_time";
			values += ",to_date('" + teminal_info_key.getIn_time()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_key.getUp_time() != null)
		{
			fields += ",up_time";
			values += ",to_date('" + teminal_info_key.getUp_time()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Teminal_info_key [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Teminal_info_key teminal_info_key) throws Exception
	{
		String sql = "update TEMINAL_INFO_KEY set TEMINAL_INFO_KEY_ID=TEMINAL_INFO_KEY_ID";
		if (teminal_info_key.getHost_no() != null)
		{
			sql += ",host_no='" + teminal_info_key.getHost_no() + "'";
		}
		if (teminal_info_key.getArea() != 0)
		{
			sql += ",area=" + teminal_info_key.getArea() + "";
		}
		if (teminal_info_key.getStatus() != 0)
		{
			sql += ",status=" + teminal_info_key.getStatus() + "";
		}
		if (teminal_info_key.getIn_time() != null)
		{
			sql += ",in_time=to_date('" + teminal_info_key.getIn_time()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_key.getUp_time() != null)
		{
			sql += ",up_time=to_date('" + teminal_info_key.getUp_time()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		sql += " where TEMINAL_INFO_KEY_ID="
				+ teminal_info_key.getTeminal_info_key_id() + "";
		Log.getLogger().debug("Teminal_info_key [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from TEMINAL_INFO_KEY where TEMINAL_INFO_KEY_ID="
				+ id;
		Log.getLogger().debug("Teminal_info_key [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Teminal_info_key [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Teminal_info_key whereTeminal_info_key_id(int teminal_info_key_id)
			throws Exception
	{
		String sql = "select * from teminal_info_key where teminal_info_key_id="
				+ teminal_info_key_id + "";
		return this.select(sql)[0];
	}

	public Teminal_info_key[] whereHost_no(String host_no) throws Exception
	{
		String sql = "select * from teminal_info_key where host_no='" + host_no
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_key[] whereArea(int area) throws Exception
	{
		String sql = "select * from teminal_info_key where area=" + area + "";
		return this.select(sql);
	}

	public Teminal_info_key[] whereStatus(int status) throws Exception
	{
		String sql = "select * from teminal_info_key where status=" + status
				+ "";
		return this.select(sql);
	}

	public Teminal_info_key[] whereIn_time(String in_time) throws Exception
	{
		String sql = "select * from teminal_info_key where in_time='" + in_time
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_key[] whereUp_time(String up_time) throws Exception
	{
		String sql = "select * from teminal_info_key where up_time='" + up_time
				+ "'";
		return this.select(sql);
	}
}
