package com.szzt.dao;

import java.sql.ResultSet;

import com.dodou.inferface.AbstractDao;
import com.dodou.table.TerminalAppTemp;
import com.dodou.table.Terminal_Info;

/**
 * 终端所有业务查询
 * 
 * @author 陈孟琳
 * 
 */
public class ApppayQueryDao extends AbstractDao<TerminalAppTemp>
{
	public static final String TABLE = "TERM_APP_TABLE";

	@Override
	public TerminalAppTemp[] select(String sql) throws Exception
	{
		if (null == sql)
		{
			return this.select();
		}
		TerminalAppTemp[] infos = new TerminalAppTemp[this.getPageSize()];
		ResultSet rs = super.execQuery(sql);
		rs.last();
		this.setTotalCount(rs.getRow());
		rs.first();
		int j = 0;
		for (int i = this.getStart(); i < this.getEnd(); i++)
		{
			if (this.getTotalCount() == 0)
				break;
			rs.absolute(i + 1);
			TerminalAppTemp info = new TerminalAppTemp();
			info.setCOMMERCIAL_ID(rs.getInt("COMMERCIAL_ID"));
			info.setTEMINAL_INFO_ID(rs.getInt("TEMINAL_INFO_ID"));
			info.setAPPTYPE(rs.getString("APPTYPE"));
			info.setAPP_NAME(rs.getString("APP_NAME"));
			info.setTERM_ID1(rs.getString("TERM_ID1"));
			info.setTERM_ID2(rs.getString("TERM_ID2"));
			info.setMENU_VER(rs.getString("MENU_VER"));
			info.setAPPDATA_NAME(rs.getString("APPDATA_NAME"));
			info.setSTATUS(rs.getInt("STATUS"));
			info.setAPPPAY_ID(rs.getInt("APPPAY_ID"));
			infos[j++] = info;
		}

		super.debug("查询出Terminal_info信息总数为：" + this.getTotalCount());
		rs.close();

		return infos;
	}

	@Override
	public TerminalAppTemp[] select(TerminalAppTemp data) throws Exception
	{
		return null;
	}

	@Override
	public int insert(TerminalAppTemp data) throws Exception
	{
		return 0;
	}

	@Override
	public void update(TerminalAppTemp data) throws Exception
	{

	}

	@Override
	public void delete(int id) throws Exception
	{

	}

	public ApppayQueryDao()
	{
	}

	public ApppayQueryDao(String where, String table)
	{
		super(where, table);
	}

	@Override
	public void operate(TerminalAppTemp info) throws Exception
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	public TerminalAppTemp findById(int id) throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}
}
