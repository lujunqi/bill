package com.szzt.dao;

import com.dodou.db.DatabaseAccess;

public class PageAndTempDao
{
	public static final String TABLE = "page_post_temp";
	private DatabaseAccess acc = new DatabaseAccess();

	public void release() throws Exception
	{
		this.acc.release();
	}

	public void roll() throws Exception
	{
		this.acc.rollback();
	}

	public void bind(String post, String[] pages) throws Exception
	{
		String del = "delete from " + TABLE + " where post_id=" + post;
		acc.executeUpdate(del);
		String insert = "insert into " + TABLE
				+ "(id,post_id,page_id) values(page_post_temp_id.nextval,"
				+ post + ",";
		if (null != pages)
		{
			for (String page : pages)
			{
				acc.executeUpdate(insert + page + ")");
			}
		}

	}

}
