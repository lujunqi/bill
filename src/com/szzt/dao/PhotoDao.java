package com.szzt.dao;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.AbstractDao;
import com.dodou.table.Photo;
import com.dodou.table.Terminal_Info;

public class PhotoDao extends AbstractDao<Photo>
{
	public static final String TABLE = "PHOTO";

	public PhotoDao()
	{
	}

	@Override
	public void operate(Photo info) throws Exception
	{

	}

	@Override
	public Photo[] select(String sql) throws Exception
	{
		if (null == sql)
		{
			sql = "select * from " + TABLE;
		}
		ResultSet result = super.execQuery(sql);
		result.last();
		Photo[] infos = new Photo[result.getRow()];
		result.first();
		int j = 0;
		for (int i = 0; i < infos.length; i++)
		{
			result.absolute(i + 1);
			Photo info = new Photo();
			info.setAPPPAY_ID(result.getInt("APPPAY_ID"));
			info.setAPPPAY_TYPE(result.getInt("APPPAY_TYPE"));
			info.setPHOTO_ID(result.getInt("PHOTO_ID"));
			info.setURL(result.getString("URL"));
			info.setUP_DAY(result.getString("UP_DAY"));
			info.setTYPE(result.getString("TYPE"));

			infos[j++] = info;
		}
		result.close();
		super.release();
		return infos;
	}

	@Override
	public Photo[] select(Photo data) throws Exception
	{
		return null;
	}

	@Override
	public int insert(Photo data) throws Exception
	{
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String day = format.format(new Date(System.currentTimeMillis()));

		String sql = "insert into " + TABLE;
		String fields = "PHOTO_ID";
		String values = "PHOTO_ID_ID.nextval";

		fields += ",APPPAY_ID";
		values += "," + data.getAPPPAY_ID();

		fields += ",URL";
		values += ",'" + data.getURL() + "'";
		fields += ",TYPE";
		values += ",'" + data.getTYPE() + "'";
		fields += ",UP_DAY";
		values += ",'" + day + "'";
		fields += ",APPPAY_TYPE";
		values += "," + data.getAPPPAY_TYPE();
		sql += "(" + fields + ") values (" + values + ")";
		return super.loadCurrentId(super.executeUpdate(sql), TABLE, "PHOTO_ID");
	}

	@Override
	public void update(Photo data) throws Exception
	{

	}

	@Override
	public void delete(int id) throws Exception
	{
		String sql = "delete from " + TABLE + " where PHOTO_ID=" + id;
		super.executeUpdate(sql);
	}

	@Override
	public Photo findById(int id) throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}

}
