package com.szzt.dao;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.*;
import com.dodou.table.*;
import com.dodou.log.*;
import java.sql.Timestamp;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;

public class Complaints_infoDao extends CreatePage
{
	public Complaints_info[] select() throws Exception
	{
		String sql = "select * from COMPLAINTS_INFO order by COMP_ID desc";
		return this.select(sql);
	}

	public Complaints_info[] select(String sql) throws Exception
	{
		Complaints_info[] Complaints_infoArray = new Complaints_info[getPageSize()];
		Log.getLogger().debug("Complaints_info [查找],SQL:[" + sql + "]");
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
			Complaints_info complaints_info = new Complaints_info();
			complaints_info.setComp_id(rs.getInt("comp_id"));
			complaints_info.setCommercial_id(rs.getInt("commercial_id"));
			complaints_info.setComp_type(rs.getString("comp_type"));
			complaints_info.setComp_cont(rs.getString("comp_cont"));
			complaints_info.setSolve_cont(rs.getString("solve_cont"));
			complaints_info.setComp_status(rs.getInt("comp_status"));
			complaints_info.setComp_date(rs.getString("comp_date"));
			complaints_info.setChange_date(rs.getString("change_date"));
			Complaints_infoArray[j++] = complaints_info;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Complaints_infoArray;
	}

	public Complaints_info[] select(Complaints_info complaints_info)
			throws Exception
	{
		String sql = "select * from COMPLAINTS_INFO where 1 = 1 ";
		if (complaints_info.getComp_id() != 0)
		{
			sql += " and comp_id = " + complaints_info.getComp_id() + "";
		}
		if (complaints_info.getCommercial_id() != 0)
		{
			sql += " and commercial_id = " + complaints_info.getCommercial_id()
					+ "";
		}
		if (complaints_info.getComp_type() != null)
		{
			sql += " and comp_type = '" + complaints_info.getComp_type() + "'";
		}
		if (complaints_info.getComp_cont() != null)
		{
			sql += " and comp_cont = '" + complaints_info.getComp_cont() + "'";
		}
		if (complaints_info.getSolve_cont() != null)
		{
			sql += " and solve_cont = '" + complaints_info.getSolve_cont()
					+ "'";
		}
		if (complaints_info.getComp_status() != 0)
		{
			sql += " and comp_status = " + complaints_info.getComp_status()
					+ "";
		}
		if (complaints_info.getComp_date() != null)
		{
			sql += " and comp_date = to_date('"
					+ complaints_info.getComp_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (complaints_info.getChange_date() != null)
		{
			sql += " and change_date = to_date('"
					+ complaints_info.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		sql += " order by COMP_ID desc";
		return this.select(sql);
	}

	public void insert(Complaints_info complaints_info) throws Exception
	{
		String sql = "insert into COMPLAINTS_INFO ";
		String fields = "COMP_ID";
		String values = "COMPLAINTS_INFO_ID_SEQ.nextval";
		if (complaints_info.getCommercial_id() != 0)
		{
			fields += ",commercial_id";
			values += "," + complaints_info.getCommercial_id() + "";
		}
		if (complaints_info.getComp_type() != null)
		{
			fields += ",comp_type";
			values += ",'" + complaints_info.getComp_type() + "'";
		}
		if (complaints_info.getComp_cont() != null)
		{
			fields += ",comp_cont";
			values += ",'" + complaints_info.getComp_cont() + "'";
		}
		if (complaints_info.getSolve_cont() != null)
		{
			fields += ",solve_cont";
			values += ",'" + complaints_info.getSolve_cont() + "'";
		}
		if (complaints_info.getComp_status() != 0)
		{
			fields += ",comp_status";
			values += "," + complaints_info.getComp_status() + "";
		}
		if (complaints_info.getComp_date() != null)
		{
			fields += ",comp_date";
			values += ",to_date('" + complaints_info.getComp_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (complaints_info.getChange_date() != null)
		{
			fields += ",change_date";
			values += ",to_date('" + complaints_info.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Complaints_info [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Complaints_info complaints_info) throws Exception
	{
		String sql = "update COMPLAINTS_INFO set COMP_ID=COMP_ID";
		if (complaints_info.getCommercial_id() != 0)
		{
			sql += ",commercial_id=" + complaints_info.getCommercial_id() + "";
		}
		if (complaints_info.getComp_type() != null)
		{
			sql += ",comp_type='" + complaints_info.getComp_type() + "'";
		}
		if (complaints_info.getComp_cont() != null)
		{
			sql += ",comp_cont='" + complaints_info.getComp_cont() + "'";
		}
		if (complaints_info.getSolve_cont() != null)
		{
			sql += ",solve_cont='" + complaints_info.getSolve_cont() + "'";
		}
		if (complaints_info.getComp_status() != 0)
		{
			sql += ",comp_status=" + complaints_info.getComp_status() + "";
		}
		if (complaints_info.getComp_date() != null)
		{
			sql += ",comp_date=to_date('" + complaints_info.getComp_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (complaints_info.getChange_date() != null)
		{
			sql += ",change_date=to_date('" + complaints_info.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		sql += " where COMP_ID=" + complaints_info.getComp_id() + "";
		Log.getLogger().debug("Complaints_info [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from COMPLAINTS_INFO where COMP_ID=" + id;
		Log.getLogger().debug("Complaints_info [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Complaints_info [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Complaints_info whereComp_id(int comp_id) throws Exception
	{
		String sql = "select * from complaints_info where comp_id=" + comp_id
				+ "";
		return this.select(sql)[0];
	}

	public Complaints_info[] whereCommercial_id(int commercial_id)
			throws Exception
	{
		String sql = "select * from complaints_info where commercial_id="
				+ commercial_id + "";
		return this.select(sql);
	}

	public Complaints_info[] whereComp_type(String comp_type) throws Exception
	{
		String sql = "select * from complaints_info where comp_type='"
				+ comp_type + "'";
		return this.select(sql);
	}

	public Complaints_info[] whereComp_cont(String comp_cont) throws Exception
	{
		String sql = "select * from complaints_info where comp_cont='"
				+ comp_cont + "'";
		return this.select(sql);
	}

	public Complaints_info[] whereSolve_cont(String solve_cont)
			throws Exception
	{
		String sql = "select * from complaints_info where solve_cont='"
				+ solve_cont + "'";
		return this.select(sql);
	}

	public Complaints_info[] whereComp_status(int comp_status) throws Exception
	{
		String sql = "select * from complaints_info where comp_status="
				+ comp_status + "";
		return this.select(sql);
	}

	public Complaints_info[] whereComp_date(String comp_date) throws Exception
	{
		String sql = "select * from complaints_info where comp_date='"
				+ comp_date + "'";
		return this.select(sql);
	}

	public Complaints_info[] whereChange_date(String change_date)
			throws Exception
	{
		String sql = "select * from complaints_info where change_date='"
				+ change_date + "'";
		return this.select(sql);
	}
}
