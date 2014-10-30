package com.szzt.dao;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.*;
import com.dodou.table.*;
import com.dodou.log.*;
import java.sql.ResultSet;

public class Ws_stasticDao extends CreatePage
{
	public Ws_stastic[] select() throws Exception
	{
		String sql = "select * from WS_STASTIC order by WS_STASTIC_ID desc";
		return this.select(sql);
	}

	public Ws_stastic[] select(String sql) throws Exception
	{
		Ws_stastic[] Ws_stasticArray = new Ws_stastic[getPageSize()];
		Log.getLogger().debug("Ws_stastic [查找],SQL:[" + sql + "]");
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
			Ws_stastic ws_stastic = new Ws_stastic();
			ws_stastic.setWs_stastic_id(rs.getInt("ws_stastic_id"));
			ws_stastic.setName(rs.getString("name"));
			ws_stastic.setVal(rs.getString("val"));
			ws_stastic.setKey(rs.getString("key"));
			Ws_stasticArray[j++] = ws_stastic;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Ws_stasticArray;
	}

	public Ws_stastic[] select(Ws_stastic ws_stastic) throws Exception
	{
		String sql = "select * from WS_STASTIC where 1 = 1 ";
		if (ws_stastic.getWs_stastic_id() != 0)
		{
			sql += " and ws_stastic_id = " + ws_stastic.getWs_stastic_id() + "";
		}
		if (ws_stastic.getName() != null)
		{
			sql += " and name = '" + ws_stastic.getName() + "'";
		}
		if (ws_stastic.getVal() != null)
		{
			sql += " and val = '" + ws_stastic.getVal() + "'";
		}
		if (ws_stastic.getKey() != null)
		{
			sql += " and key = '" + ws_stastic.getKey() + "'";
		}
		sql += " order by WS_STASTIC_ID desc";
		return this.select(sql);
	}

	public void insert(Ws_stastic ws_stastic) throws Exception
	{
		String sql = "insert into WS_STASTIC ";
		String fields = "WS_STASTIC_ID";
		String values = "WS_STASTIC_ID_SEQ.nextval";
		if (ws_stastic.getName() != null)
		{
			fields += ",name";
			values += ",'" + ws_stastic.getName() + "'";
		}
		if (ws_stastic.getVal() != null)
		{
			fields += ",val";
			values += ",'" + ws_stastic.getVal() + "'";
		}
		if (ws_stastic.getKey() != null)
		{
			fields += ",key";
			values += ",'" + ws_stastic.getKey() + "'";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Ws_stastic [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Ws_stastic ws_stastic) throws Exception
	{
		String sql = "update WS_STASTIC set WS_STASTIC_ID=WS_STASTIC_ID";
		if (ws_stastic.getName() != null)
		{
			sql += ",name='" + ws_stastic.getName() + "'";
		}
		if (ws_stastic.getVal() != null)
		{
			sql += ",val='" + ws_stastic.getVal() + "'";
		}
		if (ws_stastic.getKey() != null)
		{
			sql += ",key='" + ws_stastic.getKey() + "'";
		}
		sql += " where WS_STASTIC_ID=" + ws_stastic.getWs_stastic_id() + "";
		Log.getLogger().debug("Ws_stastic [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from WS_STASTIC where WS_STASTIC_ID=" + id;
		Log.getLogger().debug("Ws_stastic [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Ws_stastic [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Ws_stastic whereWs_stastic_id(int ws_stastic_id) throws Exception
	{
		String sql = "select * from ws_stastic where ws_stastic_id="
				+ ws_stastic_id + "";
		return this.select(sql)[0];
	}

	public Ws_stastic[] whereName(String name) throws Exception
	{
		String sql = "select * from ws_stastic where name='" + name + "'";
		return this.select(sql);
	}

	public Ws_stastic[] whereVal(String val) throws Exception
	{
		String sql = "select * from ws_stastic where val='" + val + "'";
		return this.select(sql);
	}

	public Ws_stastic[] whereKey(String key) throws Exception
	{
		String sql = "select * from ws_stastic where key='" + key + "'";
		return this.select(sql);
	}
}
