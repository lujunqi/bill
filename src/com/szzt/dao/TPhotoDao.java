package com.szzt.dao;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.AbstractDao;
import com.dodou.table.Photo;
import com.dodou.table.TPhoto;
import com.dodou.table.Terminal_Info;

public class TPhotoDao extends AbstractDao<TPhoto>
{
	public static final String TABLE = "T_PHOTO";

	public TPhotoDao()
	{
	}

	@Override
	public void operate(TPhoto info) throws Exception
	{

	}

	@Override
	public TPhoto[] select(String sql) throws Exception
	{
		if (null == sql)
		{
			sql = "select * from " + TABLE;
		}
		ResultSet result = super.execQuery(sql);
		result.last();
		TPhoto[] infos = new TPhoto[result.getRow()];
		result.first();
		int j = 0;
		for (int i = 0; i < infos.length; i++)
		{
			result.absolute(i + 1);
			TPhoto info = new TPhoto();
			info.setTERMINAL_INFO_ID(result.getInt("terminal_info_id"));
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
	public TPhoto[] select(TPhoto data) throws Exception
	{
		return null;
	}

	@Override
	public int insert(TPhoto data) throws Exception
	{
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String day = format.format(new Date(System.currentTimeMillis()));

		String sql = "insert into " + TABLE;
		String fields = "PHOTO_ID";
		String values = "T_PHOTO_ID_ID.nextval";

		fields += ",terminal_info_id";
		values += "," + data.getTERMINAL_INFO_ID();

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
	public void update(TPhoto data) throws Exception
	{

	}

	@Override
	public void delete(int id) throws Exception
	{
		String sql = "delete from " + TABLE + " where PHOTO_ID=" + id;
		super.executeUpdate(sql);
	}

	@Override
	public TPhoto findById(int id) throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}

}
