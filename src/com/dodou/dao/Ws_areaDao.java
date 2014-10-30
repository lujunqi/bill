package com.dodou.dao;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.*;
import com.dodou.table.*;
import com.dodou.log.*;
import java.sql.Timestamp;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;

public class Ws_areaDao extends CreatePage
{
	public Ws_area[] select() throws Exception
	{
		String sql = "select * from WS_AREA order by AREAID desc";
		return this.select(sql);
	}

	public Ws_area[] select(String sql) throws Exception
	{
		Ws_area[] Ws_areaArray = new Ws_area[getPageSize()];
		Log.getLogger().debug("Ws_area [查找],SQL:[" + sql + "]");
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
			Ws_area ws_area = new Ws_area();
			ws_area.setAreaid(rs.getString("areaid"));
			ws_area.setProvice(rs.getString("provice"));
			ws_area.setCity(rs.getString("city"));
			ws_area.setMemo(rs.getString("memo"));
			Ws_areaArray[j++] = ws_area;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Ws_areaArray;
	}

	public Ws_area[] select(Ws_area ws_area) throws Exception
	{
		String sql = "select * from WS_AREA where 1 = 1 ";
		if (ws_area.getAreaid() != null)
		{
			sql += " and areaid = '" + ws_area.getAreaid() + "'";
		}
		if (ws_area.getProvice() != null)
		{
			sql += " and provice = '" + ws_area.getProvice() + "'";
		}
		if (ws_area.getCity() != null)
		{
			sql += " and city = '" + ws_area.getCity() + "'";
		}
		if (ws_area.getMemo() != null)
		{
			sql += " and memo = '" + ws_area.getMemo() + "'";
		}
		sql += " order by AREAID desc";
		return this.select(sql);
	}

	public void insert(Ws_area ws_area) throws Exception
	{
		String sql = "insert into WS_AREA ";
		String fields = "AREAID";
		String values = "WS_AREA_ID_SEQ.nextval";
		if (ws_area.getProvice() != null)
		{
			fields += ",provice";
			values += ",'" + ws_area.getProvice() + "'";
		}
		if (ws_area.getCity() != null)
		{
			fields += ",city";
			values += ",'" + ws_area.getCity() + "'";
		}
		if (ws_area.getMemo() != null)
		{
			fields += ",memo";
			values += ",'" + ws_area.getMemo() + "'";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Ws_area [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Ws_area ws_area) throws Exception
	{
		String sql = "update WS_AREA set AREAID=AREAID";
		if (ws_area.getProvice() != null)
		{
			sql += ",provice='" + ws_area.getProvice() + "'";
		}
		if (ws_area.getCity() != null)
		{
			sql += ",city='" + ws_area.getCity() + "'";
		}
		if (ws_area.getMemo() != null)
		{
			sql += ",memo='" + ws_area.getMemo() + "'";
		}
		sql += " where AREAID=" + ws_area.getAreaid() + "";
		Log.getLogger().debug("Ws_area [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from WS_AREA where AREAID=" + id;
		Log.getLogger().debug("Ws_area [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Ws_area [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Ws_area whereAreaid(String areaid) throws Exception
	{
		String sql = "select * from ws_area where areaid=" + areaid + "";
		return this.select(sql)[0];
	}

	public Ws_area[] whereProvice(String provice) throws Exception
	{
		String sql = "select * from ws_area where provice='" + provice + "'";
		return this.select(sql);
	}

	public Ws_area[] whereCity(String city) throws Exception
	{
		String sql = "select * from ws_area where city='" + city + "'";
		return this.select(sql);
	}

	public Ws_area[] whereMemo(String memo) throws Exception
	{
		String sql = "select * from ws_area where memo='" + memo + "'";
		return this.select(sql);
	}
}
