package com.szzt.dao;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.*;
import com.dodou.table.*;
import com.dodou.log.*;
import java.sql.ResultSet;

public class Post_infoDao extends CreatePage
{
	public Post_info[] select() throws Exception
	{
		String sql = "select * from POST_INFO order by POST_ID desc";
		return this.select(sql);
	}

	public Post_info[] select(String sql) throws Exception
	{
		Post_info[] Post_infoArray = new Post_info[getPageSize()];
		Log.getLogger().debug("Post_info [查找],SQL:[" + sql + "]");
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
			Post_info post_info = new Post_info();
			post_info.setPost_id(rs.getInt("post_id"));
			post_info.setPost_name(rs.getString("post_name"));
			Post_infoArray[j++] = post_info;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Post_infoArray;
	}

	public Post_info[] select(Post_info post_info) throws Exception
	{
		String sql = "select * from POST_INFO where 1 = 1 ";
		if (post_info.getPost_id() != 0)
		{
			sql += " and post_id = " + post_info.getPost_id() + "";
		}
		if (post_info.getPost_name() != null)
		{
			sql += " and post_name = '" + post_info.getPost_name() + "'";
		}
		sql += " order by POST_ID desc";
		return this.select(sql);
	}

	public void insert(Post_info post_info) throws Exception
	{
		String sql = "insert into POST_INFO ";
		String fields = "POST_ID";
		String values = "POST_INFO_ID_SEQ.nextval";
		if (post_info.getPost_name() != null)
		{
			fields += ",post_name";
			values += ",'" + post_info.getPost_name() + "'";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Post_info [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Post_info post_info) throws Exception
	{
		String sql = "update POST_INFO set POST_ID=POST_ID";
		if (post_info.getPost_name() != null)
		{
			sql += ",post_name='" + post_info.getPost_name() + "'";
		}
		sql += " where POST_ID=" + post_info.getPost_id() + "";
		Log.getLogger().debug("Post_info [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from POST_INFO where POST_ID=" + id;
		Log.getLogger().debug("Post_info [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Post_info [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Post_info wherePost_id(int post_id) throws Exception
	{
		String sql = "select * from post_info where post_id=" + post_id + "";
		return this.select(sql)[0];
	}

	public Post_info[] wherePost_name(String post_name) throws Exception
	{
		String sql = "select * from post_info where post_name='" + post_name
				+ "'";
		return this.select(sql);
	}
}
