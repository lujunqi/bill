package com.cml.zyh;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.*;
import com.dodou.table.*;
import com.dodou.log.*;

import java.sql.Timestamp;
import java.sql.ResultSet;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

public class Commercial_infoDao extends CreatePage
{
	public Commercial_info[] select() throws Exception
	{
		String sql = "select * from COMMERCIAL_INFO order by COMMERCIAL_ID desc";
		return this.select(sql);
	}

	public Commercial_info[] select(String sql) throws Exception
	{
		Commercial_info[] Commercial_infoArray = new Commercial_info[getPageSize()];
		Log.getLogger().debug("Commercial_info [查找],SQL:[" + sql + "]");
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
			Commercial_info commercial_info = new Commercial_info();
			commercial_info.setCommercial_id(rs.getInt("commercial_id"));
			commercial_info.setUnit_name(rs.getString("unit_name"));
			commercial_info.setUnit_attr(rs.getString("unit_attr"));
			commercial_info.setUnit_add(rs.getString("unit_add"));
			commercial_info.setUnit_area(rs.getString("unit_area"));
			commercial_info.setComm_no(rs.getString("comm_no"));
			commercial_info.setComm_name(rs.getString("comm_name"));
			commercial_info.setComm_ad(rs.getString("comm_ad"));
			commercial_info.setTrade_name(rs.getString("trade_name"));
			commercial_info.setContact_name_1(rs.getString("contact_name_1"));
			commercial_info.setContact_tel_1(rs.getString("contact_tel_1"));
			commercial_info.setContact_name_2(rs.getString("contact_name_2"));
			commercial_info.setContact_tel_2(rs.getString("contact_tel_2"));
			commercial_info.setChan_type(rs.getString("chan_type"));
			commercial_info.setChan_name(rs.getString("chan_name"));
			commercial_info.setService_man(rs.getInt("service_man"));
			commercial_info.setComm_rating(rs.getString("comm_rating"));
			commercial_info.setOpen_busi(rs.getString("open_busi"));
			commercial_info.setRemark_info(rs.getString("remark_info"));
			commercial_info.setUnit_status(rs.getInt("unit_status"));
			commercial_info.setInput_date(rs.getString("input_date"));
			commercial_info.setChange_date(rs.getString("change_date"));
			commercial_info.setSales_man(rs.getInt("sales_man"));
			Commercial_infoArray[j++] = commercial_info;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Commercial_infoArray;
	}

	public Commercial_info[] select(Commercial_info commercial_info)
			throws Exception
	{
		String sql = "select * from COMMERCIAL_INFO where 1 = 1 ";
		if (commercial_info.getCommercial_id() != 0)
		{
			sql += " and commercial_id = " + commercial_info.getCommercial_id()
					+ "";
		}
		if (commercial_info.getUnit_name() != null)
		{
			sql += " and unit_name = '" + commercial_info.getUnit_name() + "'";
		}
		if (commercial_info.getUnit_attr() != null)
		{
			sql += " and unit_attr = '" + commercial_info.getUnit_attr() + "'";
		}
		if (commercial_info.getUnit_add() != null)
		{
			sql += " and unit_add = '" + commercial_info.getUnit_add() + "'";
		}
		if (commercial_info.getUnit_area() != null)
		{
			sql += " and unit_area = '" + commercial_info.getUnit_area() + "'";
		}
		if (commercial_info.getComm_no() != null)
		{
			sql += " and comm_no = '" + commercial_info.getComm_no() + "'";
		}
		if (commercial_info.getComm_name() != null)
		{
			sql += " and comm_name = '" + commercial_info.getComm_name() + "'";
		}
		if (commercial_info.getComm_ad() != null)
		{
			sql += " and comm_ad = '" + commercial_info.getComm_ad() + "'";
		}
		if (commercial_info.getTrade_name() != null)
		{
			sql += " and trade_name = '" + commercial_info.getTrade_name()
					+ "'";
		}
		if (commercial_info.getContact_name_1() != null)
		{
			sql += " and contact_name_1 = '"
					+ commercial_info.getContact_name_1() + "'";
		}
		if (commercial_info.getContact_tel_1() != null)
		{
			sql += " and contact_tel_1 = '"
					+ commercial_info.getContact_tel_1() + "'";
		}
		if (commercial_info.getContact_name_2() != null)
		{
			sql += " and contact_name_2 = '"
					+ commercial_info.getContact_name_2() + "'";
		}
		if (commercial_info.getContact_tel_2() != null)
		{
			sql += " and contact_tel_2 = '"
					+ commercial_info.getContact_tel_2() + "'";
		}
		if (commercial_info.getChan_type() != null)
		{
			sql += " and chan_type = '" + commercial_info.getChan_type() + "'";
		}
		if (commercial_info.getChan_name() != null)
		{
			sql += " and chan_name = '" + commercial_info.getChan_name() + "'";
		}
		if (commercial_info.getService_man() != 0)
		{
			sql += " and service_man = " + commercial_info.getService_man()
					+ "";
		}
		if (commercial_info.getComm_rating() != null)
		{
			sql += " and comm_rating = '" + commercial_info.getComm_rating()
					+ "'";
		}
		if (commercial_info.getOpen_busi() != null)
		{
			sql += " and open_busi = '" + commercial_info.getOpen_busi() + "'";
		}
		if (commercial_info.getRemark_info() != null)
		{
			sql += " and remark_info = '" + commercial_info.getRemark_info()
					+ "'";
		}
		if (commercial_info.getUnit_status() != 0)
		{
			sql += " and unit_status = " + commercial_info.getUnit_status()
					+ "";
		}
		if (commercial_info.getInput_date() != null)
		{
			sql += " and input_date = to_date('"
					+ commercial_info.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_info.getChange_date() != null)
		{
			sql += " and change_date = to_date('"
					+ commercial_info.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		sql += " order by COMMERCIAL_ID desc";
		return this.select(sql);
	}

	public void insert(Commercial_info commercial_info) throws Exception
	{
		// String dateString = DateConventer.dateWithTimeToStr(new Date());
		// commercial_info.setInput_date(dateString);
		// commercial_info.setChange_date(dateString)
		String sql = "insert into COMMERCIAL_INFO ";
		String fields = "COMMERCIAL_ID";
		String values = "COMMERCIAL_INFO_ID_SEQ.nextval";
		if (commercial_info.getUnit_name() != null)
		{
			fields += ",unit_name";
			values += ",'" + commercial_info.getUnit_name() + "'";
		}
		if (commercial_info.getUnit_attr() != null)
		{
			fields += ",unit_attr";
			values += ",'" + commercial_info.getUnit_attr() + "'";
		}
		if (commercial_info.getUnit_add() != null)
		{
			fields += ",unit_add";
			values += ",'" + commercial_info.getUnit_add() + "'";
		}
		if (commercial_info.getUnit_area() != null)
		{
			fields += ",unit_area";
			values += ",'" + commercial_info.getUnit_area() + "'";
		}
		if (commercial_info.getComm_no() != null)
		{
			fields += ",comm_no";
			values += ",'" + commercial_info.getComm_no() + "'";
		}
		if (commercial_info.getComm_name() != null)
		{
			fields += ",comm_name";
			values += ",'" + commercial_info.getComm_name() + "'";
		}
		if (commercial_info.getComm_ad() != null)
		{
			fields += ",comm_ad";
			values += ",'" + commercial_info.getComm_ad() + "'";
		}
		if (commercial_info.getTrade_name() != null)
		{
			fields += ",trade_name";
			values += ",'" + commercial_info.getTrade_name() + "'";
		}
		if (commercial_info.getContact_name_1() != null)
		{
			fields += ",contact_name_1";
			values += ",'" + commercial_info.getContact_name_1() + "'";
		}
		if (commercial_info.getContact_tel_1() != null)
		{
			fields += ",contact_tel_1";
			values += ",'" + commercial_info.getContact_tel_1() + "'";
		}
		if (commercial_info.getContact_name_2() != null)
		{
			fields += ",contact_name_2";
			values += ",'" + commercial_info.getContact_name_2() + "'";
		}
		if (commercial_info.getContact_tel_2() != null)
		{
			fields += ",contact_tel_2";
			values += ",'" + commercial_info.getContact_tel_2() + "'";
		}
		if (commercial_info.getChan_type() != null)
		{
			fields += ",chan_type";
			values += ",'" + commercial_info.getChan_type() + "'";
		}
		if (commercial_info.getChan_name() != null)
		{
			fields += ",chan_name";
			values += ",'" + commercial_info.getChan_name() + "'";
		}
		if (commercial_info.getService_man() != 0)
		{
			fields += ",service_man";
			values += "," + commercial_info.getService_man() + "";
		}
		if (commercial_info.getSales_man() != 0)
		{
			fields += ",sales_man";
			values += "," + commercial_info.getSales_man() + "";
		}
		if (commercial_info.getComm_rating() != null)
		{
			fields += ",comm_rating";
			values += ",'" + commercial_info.getComm_rating() + "'";
		}
		if (commercial_info.getOpen_busi() != null)
		{
			fields += ",open_busi";
			values += ",'" + commercial_info.getOpen_busi() + "'";
		}
		if (commercial_info.getRemark_info() != null)
		{
			fields += ",remark_info";
			values += ",'" + commercial_info.getRemark_info() + "'";
		}
		if (commercial_info.getUnit_status() != 0)
		{
			fields += ",unit_status";
			values += "," + commercial_info.getUnit_status() + "";
		}
		
		fields += ",input_date";
		values += ",sysdate";
		fields += ",change_date";
		values += ",sysdate ";
		
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Commercial_info [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Commercial_info commercial_info) throws Exception
	{
		String sql = "update COMMERCIAL_INFO set COMMERCIAL_ID=COMMERCIAL_ID";
		if (commercial_info.getUnit_name() != null)
		{
			sql += ",unit_name='" + commercial_info.getUnit_name() + "'";
		}
		if (commercial_info.getUnit_attr() != null)
		{
			sql += ",unit_attr='" + commercial_info.getUnit_attr() + "'";
		}
		if (commercial_info.getUnit_add() != null)
		{
			sql += ",unit_add='" + commercial_info.getUnit_add() + "'";
		}
		if (commercial_info.getUnit_area() != null)
		{
			sql += ",unit_area='" + commercial_info.getUnit_area() + "'";
		}
		if (commercial_info.getComm_no() != null)
		{
			sql += ",comm_no='" + commercial_info.getComm_no() + "'";
		}
		if (commercial_info.getComm_name() != null)
		{
			sql += ",comm_name='" + commercial_info.getComm_name() + "'";
		}
		if (commercial_info.getComm_ad() != null)
		{
			sql += ",comm_ad='" + commercial_info.getComm_ad() + "'";
		}
		if (commercial_info.getTrade_name() != null)
		{
			sql += ",trade_name='" + commercial_info.getTrade_name() + "'";
		}
		if (commercial_info.getContact_name_1() != null)
		{
			sql += ",contact_name_1='" + commercial_info.getContact_name_1()
					+ "'";
		}
		if (commercial_info.getContact_tel_1() != null)
		{
			sql += ",contact_tel_1='" + commercial_info.getContact_tel_1()
					+ "'";
		}
		if (commercial_info.getContact_name_2() != null)
		{
			sql += ",contact_name_2='" + commercial_info.getContact_name_2()
					+ "'";
		}
		if (commercial_info.getContact_tel_2() != null)
		{
			sql += ",contact_tel_2='" + commercial_info.getContact_tel_2()
					+ "'";
		}
		if (commercial_info.getChan_type() != null)
		{
			sql += ",chan_type='" + commercial_info.getChan_type() + "'";
		}
		if (commercial_info.getChan_name() != null)
		{
			sql += ",chan_name='" + commercial_info.getChan_name() + "'";
		}
		if (commercial_info.getService_man() != 0)
		{
			sql += ",service_man=" + commercial_info.getService_man() + "";
		}
		if (commercial_info.getComm_rating() != null)
		{
			sql += ",comm_rating='" + commercial_info.getComm_rating() + "'";
		}
		if (commercial_info.getOpen_busi() != null)
		{
			sql += ",open_busi='" + commercial_info.getOpen_busi() + "'";
		}
		if (commercial_info.getRemark_info() != null)
		{
			sql += ",remark_info='" + commercial_info.getRemark_info() + "'";
		}
		if (commercial_info.getUnit_status() != 0)
		{
			sql += ",unit_status=" + commercial_info.getUnit_status() + "";
		}
		if (commercial_info.getInput_date() != null)
		{
			sql += ",input_date=to_date('" + commercial_info.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_info.getChange_date() != null)
		{
			sql += ",change_date=to_date('" + commercial_info.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		sql += " where COMMERCIAL_ID=" + commercial_info.getCommercial_id()
				+ "";
		Log.getLogger().debug("Commercial_info [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from COMMERCIAL_INFO where COMMERCIAL_ID=" + id;
		Log.getLogger().debug("Commercial_info [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Commercial_info [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Commercial_info whereCommercial_id(int commercial_id)
			throws Exception
	{
		String sql = "select * from commercial_info where commercial_id="
				+ commercial_id + "";
		return this.select(sql)[0];
	}

	public Commercial_info[] whereUnit_name(String unit_name) throws Exception
	{
		String sql = "select * from commercial_info where unit_name='"
				+ unit_name + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereUnit_attr(String unit_attr) throws Exception
	{
		String sql = "select * from commercial_info where unit_attr='"
				+ unit_attr + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereUnit_add(String unit_add) throws Exception
	{
		String sql = "select * from commercial_info where unit_add='"
				+ unit_add + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereUnit_area(String unit_area) throws Exception
	{
		String sql = "select * from commercial_info where unit_area='"
				+ unit_area + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereComm_no(String comm_no) throws Exception
	{
		String sql = "select * from commercial_info where comm_no='" + comm_no
				+ "'";
		return this.select(sql);
	}

	public Commercial_info[] whereComm_name(String comm_name) throws Exception
	{
		String sql = "select * from commercial_info where comm_name='"
				+ comm_name + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereComm_ad(String comm_ad) throws Exception
	{
		String sql = "select * from commercial_info where comm_ad='" + comm_ad
				+ "'";
		return this.select(sql);
	}

	public Commercial_info[] whereTrade_name(String trade_name)
			throws Exception
	{
		String sql = "select * from commercial_info where trade_name='"
				+ trade_name + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereContact_name_1(String contact_name_1)
			throws Exception
	{
		String sql = "select * from commercial_info where contact_name_1='"
				+ contact_name_1 + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereContact_tel_1(String contact_tel_1)
			throws Exception
	{
		String sql = "select * from commercial_info where contact_tel_1='"
				+ contact_tel_1 + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereContact_name_2(String contact_name_2)
			throws Exception
	{
		String sql = "select * from commercial_info where contact_name_2='"
				+ contact_name_2 + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereContact_tel_2(String contact_tel_2)
			throws Exception
	{
		String sql = "select * from commercial_info where contact_tel_2='"
				+ contact_tel_2 + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereChan_type(String chan_type) throws Exception
	{
		String sql = "select * from commercial_info where chan_type='"
				+ chan_type + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereChan_name(String chan_name) throws Exception
	{
		String sql = "select * from commercial_info where chan_name='"
				+ chan_name + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereService_man(int service_man) throws Exception
	{
		String sql = "select * from commercial_info where service_man="
				+ service_man + "";
		return this.select(sql);
	}

	public Commercial_info[] whereComm_rating(String comm_rating)
			throws Exception
	{
		String sql = "select * from commercial_info where comm_rating='"
				+ comm_rating + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereOpen_busi(String open_busi) throws Exception
	{
		String sql = "select * from commercial_info where open_busi='"
				+ open_busi + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereRemark_info(String remark_info)
			throws Exception
	{
		String sql = "select * from commercial_info where remark_info='"
				+ remark_info + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereUnit_status(int unit_status) throws Exception
	{
		String sql = "select * from commercial_info where unit_status="
				+ unit_status + "";
		return this.select(sql);
	}

	public Commercial_info[] whereInput_date(String input_date)
			throws Exception
	{
		String sql = "select * from commercial_info where input_date='"
				+ input_date + "'";
		return this.select(sql);
	}

	public Commercial_info[] whereChange_date(String change_date)
			throws Exception
	{
		String sql = "select * from commercial_info where change_date='"
				+ change_date + "'";
		return this.select(sql);
	}
}
