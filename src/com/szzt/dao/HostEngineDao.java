package com.szzt.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.dodou.db.DatabaseAccess;
import com.dodou.table.HostEngine;
import com.dodou.util.CreatePage;

public class HostEngineDao extends CreatePage
{
	private String where;
	private DatabaseAccess acc = new DatabaseAccess();

	public HostEngineDao(String where)
	{
		this.where = where;
	}

	public List<HostEngine> selectList() throws Exception
	{

		ResultSet rs = acc.executeQuery(this.initQuery());
		List<HostEngine> list = new ArrayList<HostEngine>();
		while (rs.next())
		{
			HostEngine engine = new HostEngine();
			engine.setEqui_type(rs.getString("equi_type"));
			engine.setTeminal_info_id(rs.getInt("teminal_info_id"));
			engine.setTerm_id1(rs.getString("term_id1"));
			engine.setTerm_id2(rs.getString("term_id2"));
			engine.setUnit_Installed_Add(rs.getString("Unit_Installed_Add"));
			engine.setUNIT_INSTALLED_STREET(rs
					.getString("UNIT_INSTALLED_STREET"));
			engine.setCommercial_id(rs.getInt("commercial_id"));
			list.add(engine);
		}
		rs.close();
		return list;
	}

	private String initQuery()
	{
		StringBuffer buffer = new StringBuffer();
		buffer.append("select * from(select rownum rn,ter.commercial_id,ter.teminal_info_id,temp.term_id1,  temp.term_id2 ,");
		buffer.append(" case ter.equi_type  when 0 then '普通POS' when 1 then '移动POS' when 2 then '分体POS' when 3 then'其他类型POS' end as equi_type,");
		buffer.append(" ter.Unit_Installed_Add,   ter.UNIT_INSTALLED_STREET");
		buffer.append("  from Teminal_Info ter, Term_App_Table temp where temp.teminal_info_id = ter.teminal_info_id    and temp.apptype = '105'");
		buffer.append(" and rownum<=").append(this.getCurPage() * 20);
		if (this.where != null)
		{
			buffer.append(where);
		}
		buffer.append(" ) where rn>").append((this.getCurPage() - 1) * 20);
		System.out.println("sql" + buffer.toString());
		return buffer.toString();
	}

	public int size() throws Exception
	{
		StringBuffer buffer = new StringBuffer();
		buffer.append("select count(*)");
		buffer.append("  from Teminal_Info ter, Term_App_Table temp where temp.teminal_info_id = ter.teminal_info_id    and temp.apptype = '105' ");
		if (this.where != null)
		{
			buffer.append(where);
		}

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
}
