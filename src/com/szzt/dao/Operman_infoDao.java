package com.szzt.dao;

import java.sql.ResultSet;

import com.dodou.db.DatabaseAccess;
import com.dodou.log.Log;
import com.dodou.table.Operman_info;
import com.dodou.util.CreatePage;
import com.szzt.util.Md5Util;

public class Operman_infoDao extends CreatePage
{
	/**
	 * 默认的员工密码
	 */
	public static final String DEFAULT_PASS = Md5Util.md5("123456");

	public static final String TABLE = "OPERMAN_INFO";

	public Operman_info[] select() throws Exception
	{
		String sql = "select o.*,area.city,market.DEPA_NAME from MARKETDEPARTMENT market,OPERMAN_INFO o,WS_AREA area "
				+ "where o.oper_address=area.AREAID and market.DEPA_ID=DEPARTID order by OPERMAN_ID desc";
		return this.select(sql);
	}

	public Operman_info[] select(String sql) throws Exception
	{
		String s = "select o.*, (select a.city from WS_AREA a where o.oper_address = a.AREAID) as city,market.DEPA_NAME from MARKETDEPARTMENT market,OPERMAN_INFO o "
				+ "where market.DEPA_ID=DEPARTID ";

		if (null != sql)
		{
			s += sql;
		}
		s += " order by OPERMAN_ID desc";

		Operman_info[] Operman_infoArray = new Operman_info[getPageSize()];
		Log.getLogger().debug("Operman_info [查找],SQL:[" + s + "]");
		DatabaseAccess dba = new DatabaseAccess();
		ResultSet rs = dba.executeQuery(s);
		rs.last();
		this.setTotalCount(rs.getRow());
		rs.first();
		int j = 0;
		for (int i = this.getStart(); i < this.getEnd(); i++)
		{
			if (this.getTotalCount() == 0)
				break;
			rs.absolute(i + 1);
			Operman_info operman_info = new Operman_info();
			operman_info.setOperman_id(rs.getInt("operman_id"));
			operman_info.setPost_id(rs.getInt("post_id"));
			operman_info.setOperman_name(rs.getString("operman_name"));
			operman_info.setOper_pass(rs.getString("oper_pass"));
			operman_info.setOper_comp(rs.getString("oper_comp"));
			operman_info.setOper_status(rs.getInt("oper_status"));
			operman_info.setOper_address(rs.getString("oper_address"));
			operman_info.setAccout(rs.getString("accout"));
			operman_info.setDepartid(rs.getInt("departid"));
			operman_info.setBank_account(rs.getString("bank_account"));
			operman_info.setCity(rs.getString("city"));
			operman_info.setDepart(rs.getString("DEPA_NAME"));
			Operman_infoArray[j++] = operman_info;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Operman_infoArray;
	}

	public Operman_info[] select(Operman_info operman_info) throws Exception
	{
		String sql = "select * from OPERMAN_INFO where 1 = 1 ";
		if (operman_info.getOperman_id() != 0)
		{
			sql += " and operman_id = " + operman_info.getOperman_id() + "";
		}
		if (operman_info.getPost_id() != 0)
		{
			sql += " and post_id = " + operman_info.getPost_id() + "";
		}
		if (operman_info.getOperman_name() != null)
		{
			sql += " and operman_name = '" + operman_info.getOperman_name()
					+ "'";
		}
		if (operman_info.getOper_pass() != null)
		{
			sql += " and oper_pass = '" + operman_info.getOper_pass() + "'";
		}
		if (operman_info.getOper_comp() != null)
		{
			sql += " and oper_comp = '" + operman_info.getOper_comp() + "'";
		}
		if (operman_info.getOper_status() != 0)
		{
			sql += " and oper_status = " + operman_info.getOper_status() + "";
		}
		if (operman_info.getOper_address() != null)
		{
			sql += " and oper_address = '" + operman_info.getOper_address()
					+ "'";
		}
		if (operman_info.getAccout() != null)
		{
			sql += " and accout = '" + operman_info.getAccout() + "'";
		}
		if (operman_info.getDepartid() != 0)
		{
			sql += " and departid = " + operman_info.getDepartid() + "";
		}
		sql += " order by OPERMAN_ID desc";
		return this.select(sql);
	}

	public void insert(Operman_info operman_info) throws Exception
	{
		String sql = "insert into OPERMAN_INFO ";
		String fields = "OPERMAN_ID";
		String values = "OPERMAN_INFO_ID_SEQ.nextval";
		if (operman_info.getPost_id() != 0)
		{
			fields += ",post_id";
			values += "," + operman_info.getPost_id() + "";
		}
		if (operman_info.getOperman_name() != null)
		{
			fields += ",operman_name";
			values += ",'" + operman_info.getOperman_name() + "'";
		}
		if (operman_info.getOper_pass() != null)
		{
			fields += ",oper_pass";
			values += ",'" + operman_info.getOper_pass() + "'";
		}
		if (operman_info.getOper_comp() != null)
		{
			fields += ",oper_comp";
			values += ",'" + operman_info.getOper_comp() + "'";
		}

		fields += ",oper_status";
		values += "," + operman_info.getOper_status() + "";
		fields += ",POST_ID";
		values += ",-" + 1 + "";
		// 初始化密码为123456
		fields += ",oper_pass";
		values += ",'" + DEFAULT_PASS + "'";

		if (operman_info.getOper_address() != null)
		{
			fields += ",oper_address";
			values += ",'" + operman_info.getOper_address() + "'";
		}
		if (operman_info.getAccout() != null)
		{
			fields += ",accout";
			values += ",'" + operman_info.getAccout() + "'";
		}
		if (operman_info.getDepartid() != 0)
		{
			fields += ",departid";
			values += "," + operman_info.getDepartid() + "";
		}

		if (operman_info.getBank_account() != null)
		{
			fields += ",bank_account";
			values += "," + operman_info.getBank_account() + "";
		}

		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Operman_info [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Operman_info operman_info) throws Exception
	{
		String sql = "update OPERMAN_INFO set OPERMAN_ID=OPERMAN_ID";

		if (operman_info.getPost_id() != 0)
		{
			sql += ",post_id=" + operman_info.getPost_id() + "";
		}
		if (operman_info.getOperman_name() != null)
		{
			sql += ",operman_name='" + operman_info.getOperman_name() + "'";
		}
		if (operman_info.getOper_pass() != null)
		{
			sql += ",oper_pass='" + operman_info.getOper_pass() + "'";
		}
		if (operman_info.getOper_comp() != null)
		{
			sql += ",oper_comp='" + operman_info.getOper_comp() + "'";
		}

		sql += ",oper_status=" + operman_info.getOper_status() + "";

		if (operman_info.getOper_address() != null)
		{
			sql += ",oper_address='" + operman_info.getOper_address() + "'";
		}
		if (operman_info.getAccout() != null)
		{
			sql += ",accout='" + operman_info.getAccout() + "'";
		}
		if (operman_info.getDepartid() != 0)
		{
			sql += ",departid=" + operman_info.getDepartid() + "";
		}
		if (operman_info.getBank_account() != null)
		{
			sql += ",bank_account='" + operman_info.getBank_account() + "'";
		}
		sql += " where OPERMAN_ID=" + operman_info.getOperman_id() + "";
		Log.getLogger().debug("Operman_info [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		// String sql = "delete from OPERMAN_INFO where OPERMAN_ID=" + id;
		String sql = "update " + TABLE + " set OPER_STATUS=0 where OPERMAN_ID="
				+ id;
		Log.getLogger().debug("Operman_info [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Operman_info [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Operman_info whereOperman_id(int operman_id) throws Exception
	{
		String sql = "select * from operman_info where operman_id="
				+ operman_id + "";
		DatabaseAccess dba = new DatabaseAccess();
		ResultSet rs = dba.executeQuery(sql);
		Operman_info operman_info = new Operman_info();
		if (rs.next())
		{
			operman_info.setOperman_id(rs.getInt("operman_id"));
			operman_info.setPost_id(rs.getInt("post_id"));
			operman_info.setOperman_name(rs.getString("operman_name"));
			operman_info.setOper_pass(rs.getString("oper_pass"));
			operman_info.setOper_comp(rs.getString("oper_comp"));
			operman_info.setOper_status(rs.getInt("oper_status"));
			operman_info.setOper_address(rs.getString("oper_address"));
			operman_info.setAccout(rs.getString("accout"));
			operman_info.setDepartid(rs.getInt("departid"));
			operman_info.setBank_account(rs.getString("bank_account"));
		}
		rs.close();
		dba.release();
		return operman_info;
	}

	public Operman_info[] wherePost_id(int post_id, int departId)
			throws Exception
	{
		String sql = "select * from operman_info where OPERMAN_ID in (select distinct OPERMAN_ID from USE_ROLE_INFO where POST_ID="
				+ post_id + ") and DEPARTID=" + departId + " ";
		return this.select(sql);
	}

	public Operman_info[] whereOperman_name(String operman_name)
			throws Exception
	{
		String sql = "select * from operman_info where operman_name='"
				+ operman_name + "'";
		return this.select(sql);
	}

	public Operman_info[] whereOper_pass(String oper_pass) throws Exception
	{
		String sql = "select * from operman_info where oper_pass='" + oper_pass
				+ "'";
		return this.select(sql);
	}

	public Operman_info[] whereOper_comp(String oper_comp) throws Exception
	{
		String sql = "select * from operman_info where oper_comp='" + oper_comp
				+ "'";
		return this.select(sql);
	}

	public Operman_info[] whereOper_status(int oper_status) throws Exception
	{
		String sql = "select * from operman_info where oper_status="
				+ oper_status + "";
		return this.select(sql);
	}

	public Operman_info[] whereOper_address(String oper_address)
			throws Exception
	{
		String sql = "select * from operman_info where oper_address='"
				+ oper_address + "'";
		return this.select(sql);
	}

	public Operman_info[] whereAccout(String accout) throws Exception
	{
		String sql = "select * from operman_info where accout='" + accout + "'";
		return this.select(sql);
	}

	public Operman_info[] whereDepartid(int departid) throws Exception
	{
		String sql = "select * from operman_info where departid=" + departid
				+ "";
		return this.select(sql);
	}

	public Operman_info[] wherePost_id(int post_id, String areaId)
			throws Exception
	{
		String sql = "select * from operman_info where OPERMAN_ID in (select distinct OPERMAN_ID from USE_ROLE_INFO where POST_ID="
				+ post_id + ") and trim(OPER_ADDRESS)='" + areaId + "' ";
		return this.select(sql);
	}
}
