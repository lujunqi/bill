package com.szzt.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ArrayBlockingQueue;

import com.dodou.db.DatabaseAccess;
import com.dodou.table.TEMINAL_INFO_KEY;
import com.dodou.util.CreatePage;

public class TerminalInfoKeyDao extends CreatePage
{
	private DatabaseAccess acc = new DatabaseAccess();
	private String where;
	public static final String TABLE = "TEMINAL_INFO_KEY";

	public TerminalInfoKeyDao(String where)
	{
		this.where = where;
	}

	private String initQuery(String w)
	{
		if (null == w)
		{
			w = "";
		}
		StringBuffer buffer = new StringBuffer();
		buffer.append("select * from (");
		buffer.append("select t.*,rownum rn,(select a.city from ws_area a where a.areaid=t.area) as t_area, case when exists (select i.serial1 from teminal_info i where i.serial1=t.host_no and (i.teminal_status in (4,5) or  (i.teminal_status=13 and i.installed_status=4))) then 2  when exists (select ser.teminal_status                   from TEMINAL_INFO_SERV ser                  where 1 = 1     and ser.host_seq=t.host_no  "
				+ w
				+ "            and (ser.teminal_status != 6 or ser.teminal_status is null)) then                   2 else 1 end as t_status from TEMINAL_INFO_KEY t ");
		buffer.append(" where 1=1 and rownum<=").append(this.getCurPage() * 20);
		if (this.where != null)
		{
			buffer.append(where);
		}
		buffer.append(" ) where rn>").append((this.getCurPage() - 1) * 20);
		System.out.println("sql" + buffer.toString());
		return buffer.toString();
	}

	private TEMINAL_INFO_KEY wrapToMode(ResultSet rs) throws SQLException
	{
		TEMINAL_INFO_KEY key = new TEMINAL_INFO_KEY();
		String area = rs.getString("t_area");
		key.setArea(rs.getInt("area"));
		key.setT_area(area);
		key.setStatus(rs.getInt("t_status"));
		key.setHost_no(rs.getString("host_no"));
		key.setTeminal_info_key_id(rs.getInt("teminal_info_key_id"));
		key.setIn_time(rs.getDate("in_time"));
		return key;
	}

	public int size() throws Exception
	{
		StringBuffer buffer = new StringBuffer();
		buffer.append("select count(*) from (");
		buffer.append("select t.*,(select a.city from ws_area a where a.areaid=t.area) as t_area, case when exists (select i.serial1 from teminal_info i where i.serial1=t.host_no) then 2 else 1 end as t_status from TEMINAL_INFO_KEY t ");
		buffer.append(" where 1=1 ");
		if (this.where != null)
		{
			buffer.append(where);
		}
		buffer.append(" )");

		ResultSet set = acc.executeQuery(buffer.toString());
		int size = 0;
		if (set.next())
		{
			size = set.getInt(1);
		}
		set.close();
		acc.release();
		return size;
	}

	public List<TEMINAL_INFO_KEY> selectList(String where) throws Exception
	{
		List<TEMINAL_INFO_KEY> list = new ArrayList<TEMINAL_INFO_KEY>();
		ResultSet rs = this.acc.executeQuery(this.initQuery(where));
		while (rs.next())
		{
			list.add(this.wrapToMode(rs));
		}
		rs.close();
		return list;
	}

}
