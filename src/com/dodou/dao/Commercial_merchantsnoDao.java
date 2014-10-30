package com.dodou.dao;

import java.sql.ResultSet;
import java.util.Date;

import com.cml.zyh.Commercial_info;
import com.cml.zyh.DateConvert;
import com.cml.zyh.Teminal_info;
import com.dodou.db.DatabaseAccess;
import com.dodou.log.Log;
import com.dodou.table.Commercial_merchantsno;
import com.dodou.util.CreatePage;

public class Commercial_merchantsnoDao extends CreatePage
{
	public Commercial_merchantsno[] select() throws Exception
	{
		String sql = "select * from COMMERCIAL_MERCHANTSNO order by MERCHANTSNO_ID desc";
		return this.select(sql);
	}

	public Commercial_merchantsno[] select(String sql) throws Exception
	{
		Commercial_merchantsno[] Commercial_merchantsnoArray = new Commercial_merchantsno[getPageSize()];
		Log.getLogger().debug("Commercial_merchantsno [查找],SQL:[" + sql + "]");
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
			Commercial_merchantsno commercial_merchantsno = new Commercial_merchantsno();
			commercial_merchantsno.setMcc(rs.getString("mcc"));
			commercial_merchantsno.setMerchantsno_id(rs
					.getInt("merchantsno_id"));
			commercial_merchantsno.setCommercial_id(rs.getInt("commercial_id"));
			commercial_merchantsno.setRatededuction(rs
					.getString("ratededuction"));
			commercial_merchantsno.setAccount_no(rs.getString("account_no"));
			commercial_merchantsno
					.setAccount_bank(rs.getString("account_bank"));
			commercial_merchantsno
					.setAccount_name(rs.getString("account_name"));
			commercial_merchantsno.setInput_date(rs.getString("input_date"));
			commercial_merchantsno.setMerchantsno(rs.getString("merchantsno"));
			commercial_merchantsno.setAppr_man(rs.getInt("appr_man"));
			commercial_merchantsno.setAppr_status(rs.getInt("appr_status"));
			if (rs.getDate("appr_date") != null)
			{
				commercial_merchantsno.setAppr_date(rs.getDate("appr_date")
						.toString());
			}
			commercial_merchantsno.setAppr_remark(rs.getInt("appr_remark"));
			commercial_merchantsno.setStatus(rs.getInt("status"));
			commercial_merchantsno.setChange_date(rs.getString("change_date"));
			commercial_merchantsno.setMerchant_busi(rs
					.getString("merchant_busi"));
			commercial_merchantsno.setSales_man(rs.getInt("sales_man"));

			// ljn add
			commercial_merchantsno.setMerchant_name(rs
					.getString("merchant_name"));
			commercial_merchantsno
					.setMarchantType(rs.getString("marchantType"));
			commercial_merchantsno.setLq_rule(rs.getString("lq_rule"));
			commercial_merchantsno.setFee_rule1(rs.getString("fee_rule1"));
			commercial_merchantsno.setFee_rule2(rs.getString("fee_rule2"));

			commercial_merchantsno.setChan_type(rs.getString("chan_type"));
			commercial_merchantsno.setChan_name(rs.getString("chan_name"));
			commercial_merchantsno.setAccount_bank_brach(rs
					.getString("account_bank_brach"));
			commercial_merchantsno.setUnit_area(rs.getString("unit_area"));
			commercial_merchantsno.setMcc18(rs.getString("mcc18"));
			// end
			commercial_merchantsno.setFee_content(rs.getString("fee_content"));
			commercial_merchantsno.setFee_lev(rs.getString("fee_lev"));
			commercial_merchantsno.setFile_name(rs.getString("file_name"));
			commercial_merchantsno.setFee_chan(rs.getInt("fee_chan"));
			commercial_merchantsno.setReason(rs.getString("reason"));
			commercial_merchantsno.setBank_no(rs.getString("bank_no"));

			Commercial_merchantsnoArray[j++] = commercial_merchantsno;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Commercial_merchantsnoArray;
	}

	public Commercial_merchantsno[] select(
			Commercial_merchantsno commercial_merchantsno) throws Exception
	{
		String sql = "select * from COMMERCIAL_MERCHANTSNO where 1 = 1 ";
		if (commercial_merchantsno.getMcc() != null)
		{
			sql += " and mcc = '" + commercial_merchantsno.getMcc() + "'";
		}
		if (commercial_merchantsno.getMerchantsno_id() != 0)
		{
			sql += " and merchantsno_id = "
					+ commercial_merchantsno.getMerchantsno_id() + "";
		}
		if (commercial_merchantsno.getCommercial_id() != 0)
		{
			sql += " and commercial_id = "
					+ commercial_merchantsno.getCommercial_id() + "";
		}
		if (commercial_merchantsno.getRatededuction() != null)
		{
			sql += " and ratededuction = '"
					+ commercial_merchantsno.getRatededuction() + "'";
		}
		if (commercial_merchantsno.getAccount_no() != null)
		{
			sql += " and account_no = '"
					+ commercial_merchantsno.getAccount_no() + "'";
		}
		if (commercial_merchantsno.getAccount_bank() != null)
		{
			sql += " and account_bank = '"
					+ commercial_merchantsno.getAccount_bank() + "'";
		}
		if (commercial_merchantsno.getAccount_name() != null)
		{
			sql += " and account_name = '"
					+ commercial_merchantsno.getAccount_name() + "'";
		}
		if (commercial_merchantsno.getInput_date() != null)
		{
			sql += " and input_date = to_date('"
					+ commercial_merchantsno.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_merchantsno.getMerchantsno() != null)
		{
			sql += " and merchantsno = '"
					+ commercial_merchantsno.getMerchantsno() + "'";
		}
		if (commercial_merchantsno.getAppr_man() != 0)
		{
			sql += " and appr_man = " + commercial_merchantsno.getAppr_man()
					+ "";
		}
		if (commercial_merchantsno.getAppr_status() != 0)
		{
			sql += " and appr_status = "
					+ commercial_merchantsno.getAppr_status() + "";
		}
		if (commercial_merchantsno.getAppr_date() != null)
		{
			sql += " and appr_date = to_date('"
					+ commercial_merchantsno.getAppr_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_merchantsno.getAppr_remark() != 0)
		{
			sql += " and appr_remark = "
					+ commercial_merchantsno.getAppr_remark() + "";
		}
		if (commercial_merchantsno.getStatus() != 0)
		{
			sql += " and status = " + commercial_merchantsno.getStatus() + "";
		}
		if (commercial_merchantsno.getChange_date() != null)
		{
			sql += " and change_date = to_date('"
					+ commercial_merchantsno.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_merchantsno.getMerchant_busi() != null)
		{
			sql += " and merchant_busi = '"
					+ commercial_merchantsno.getMerchant_busi() + "'";
		}
		if (commercial_merchantsno.getSales_man() != 0)
		{
			sql += " and sales_man = " + commercial_merchantsno.getSales_man()
					+ "";
		}
		if (commercial_merchantsno.getMcc18() != null)
		{
			sql += " and mcc18 = " + commercial_merchantsno.getMcc18() + "";
		}
		if (commercial_merchantsno.getFee_content() != null)
		{
			sql += " and fee_content = '"
					+ commercial_merchantsno.getFee_content() + "'";
		}
		if (commercial_merchantsno.getFee_lev() != null)
		{
			sql += " and fee_lev = '" + commercial_merchantsno.getFee_lev()
					+ "'";
		}
		if (commercial_merchantsno.getFee_chan() != 0)
		{
			sql += " and fee_chan = " + commercial_merchantsno.getFee_chan()
					+ "";
		}
		sql += " order by APPR_DATE desc,input_date desc";
		return this.select(sql);
	}

	public void insert(Commercial_merchantsno commercial_merchantsno)
			throws Exception
	{
		// String dateString = DateConventer.dateWithTimeToStr(new Date());
		// commercial_merchantsno.setInput_date(dateString);
		String sql = "insert into COMMERCIAL_MERCHANTSNO ";
		String fields = "MERCHANTSNO_ID";
		String values = "COMMERCIAL_MERCHANTSNO_ID_SEQ.nextval";
		if (commercial_merchantsno.getMcc() != null)
		{
			fields += ",mcc";
			values += ",'" + commercial_merchantsno.getMcc() + "'";
		}
		if (commercial_merchantsno.getCommercial_id() != 0)
		{
			fields += ",commercial_id";
			values += "," + commercial_merchantsno.getCommercial_id() + "";
		}
		if (commercial_merchantsno.getRatededuction() != null)
		{
			fields += ",ratededuction";
			values += ",'" + commercial_merchantsno.getRatededuction() + "'";
		}
		if (commercial_merchantsno.getAccount_no() != null)
		{
			fields += ",account_no";
			values += ",'" + commercial_merchantsno.getAccount_no() + "'";
		}
		if (commercial_merchantsno.getAccount_bank() != null)
		{
			fields += ",account_bank";
			values += ",'" + commercial_merchantsno.getAccount_bank() + "'";
		}
		if (commercial_merchantsno.getAccount_name() != null)
		{
			fields += ",account_name";
			values += ",'" + commercial_merchantsno.getAccount_name() + "'";
		}
		if (commercial_merchantsno.getInput_date() != null)
		{
			fields += ",input_date";
			values += ",to_date('" + commercial_merchantsno.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_merchantsno.getMerchantsno() != null)
		{
			fields += ",merchantsno";
			values += ",'" + commercial_merchantsno.getMerchantsno() + "'";
		}
		if (commercial_merchantsno.getAppr_man() != 0)
		{
			fields += ",appr_man";
			values += "," + commercial_merchantsno.getAppr_man() + "";
		}
		if (commercial_merchantsno.getAppr_status() != 0)
		{
			fields += ",appr_status";
			values += "," + commercial_merchantsno.getAppr_status() + "";
		}
		if (commercial_merchantsno.getAppr_date() != null)
		{
			fields += ",appr_date";
			values += ",to_date('" + commercial_merchantsno.getAppr_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_merchantsno.getAppr_remark() != 0)
		{
			fields += ",appr_remark";
			values += "," + commercial_merchantsno.getAppr_remark() + "";
		}
		if (commercial_merchantsno.getStatus() != 0)
		{
			fields += ",status";
			values += "," + commercial_merchantsno.getStatus() + "";
		}
		if (commercial_merchantsno.getChange_date() != null)
		{
			fields += ",change_date";
			values += ",to_date('" + commercial_merchantsno.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_merchantsno.getMerchant_busi() != null)
		{
			fields += ",merchant_busi";
			values += ",'" + commercial_merchantsno.getMerchant_busi() + "'";
		}
		if (commercial_merchantsno.getSales_man() != 0)
		{
			fields += ",sales_man";
			values += "," + commercial_merchantsno.getSales_man() + "";
		}

		// ljn add

		if (commercial_merchantsno.getFee_rule1() != null)
		{
			fields += ",fee_rule1";
			values += ",'" + commercial_merchantsno.getFee_rule1() + "'";
		}
		if (commercial_merchantsno.getFee_rule2() != null)
		{
			fields += ",fee_rule2";
			values += ",'" + commercial_merchantsno.getFee_rule2() + "'";
		}
		if (commercial_merchantsno.getLq_rule() != null)
		{
			fields += ",lq_rule";
			values += ",'" + commercial_merchantsno.getLq_rule() + "'";
		}
		if (commercial_merchantsno.getMarchantType() != null)
		{
			fields += ",marchantType";
			values += ",'" + commercial_merchantsno.getMarchantType() + "'";
		}
		if (commercial_merchantsno.getMerchant_name() != null)
		{
			fields += ",merchant_name";
			values += ",'" + commercial_merchantsno.getMerchant_name() + "'";
		}

		if (commercial_merchantsno.getChan_type() != null)
		{
			fields += ",chan_type";
			values += ",'" + commercial_merchantsno.getChan_type() + "'";
		}
		if (commercial_merchantsno.getChan_name() != null)
		{
			fields += ",chan_name";
			values += ",'" + commercial_merchantsno.getChan_name() + "'";
		}
		if (commercial_merchantsno.getAccount_bank_brach() != null)
		{
			fields += ",account_bank_brach";
			values += ",'" + commercial_merchantsno.getAccount_bank_brach()
					+ "'";
		}
		if (commercial_merchantsno.getUnit_area() != null)
		{
			fields += ",unit_area";
			values += ",'" + commercial_merchantsno.getUnit_area() + "'";
		}
		if (commercial_merchantsno.getMcc18() != null)
		{
			fields += ",mcc18";
			values += ",'" + commercial_merchantsno.getMcc18() + "'";
		}
		// end
		if (commercial_merchantsno.getFee_content() != null)
		{
			fields += ",fee_content";
			values += ",'" + commercial_merchantsno.getFee_content() + "'";
		}
		if (commercial_merchantsno.getFee_lev() != null)
		{
			fields += ",fee_lev";
			values += ",'" + commercial_merchantsno.getFee_lev() + "'";
		}
		if (commercial_merchantsno.getFee_chan() != 0)
		{
			fields += ",fee_chan";
			values += "," + commercial_merchantsno.getFee_chan() + "";
		}
		if (commercial_merchantsno.getReason() != null)
		{
			fields += ",reason";
			values += ",'" + commercial_merchantsno.getReason() + "'";
		}
		if (commercial_merchantsno.getBank_no() != null)
		{
			fields += ",bank_no";
			values += ",'" + commercial_merchantsno.getBank_no() + "'";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Commercial_merchantsno [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Commercial_merchantsno commercial_merchantsno)
			throws Exception
	{
		String sql = "update COMMERCIAL_MERCHANTSNO set MERCHANTSNO_ID=MERCHANTSNO_ID";
		if (commercial_merchantsno.getMcc() != null)
		{
			sql += ",mcc='" + commercial_merchantsno.getMcc() + "'";
		}
		if (commercial_merchantsno.getCommercial_id() != 0)
		{
			sql += ",commercial_id="
					+ commercial_merchantsno.getCommercial_id() + "";
		}
		if (commercial_merchantsno.getRatededuction() != null)
		{
			sql += ",ratededuction='"
					+ commercial_merchantsno.getRatededuction() + "'";
		}
		if (commercial_merchantsno.getAccount_no() != null)
		{
			sql += ",account_no='" + commercial_merchantsno.getAccount_no()
					+ "'";
		}
		if (commercial_merchantsno.getAccount_bank() != null)
		{
			sql += ",account_bank='" + commercial_merchantsno.getAccount_bank()
					+ "'";
		}
		if (commercial_merchantsno.getAccount_name() != null)
		{
			sql += ",account_name='" + commercial_merchantsno.getAccount_name()
					+ "'";
		}
		if (commercial_merchantsno.getInput_date() != null)
		{
			sql += ",input_date=to_date('"
					+ commercial_merchantsno.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_merchantsno.getMerchantsno() != null)
		{
			sql += ",merchantsno='" + commercial_merchantsno.getMerchantsno()
					+ "'";
		}
		if (commercial_merchantsno.getAppr_man() != 0)
		{
			sql += ",appr_man=" + commercial_merchantsno.getAppr_man() + "";
		}
		if (commercial_merchantsno.getAppr_status() != 0)
		{
			sql += ",appr_status=" + commercial_merchantsno.getAppr_status()
					+ "";
		}
		if (commercial_merchantsno.getAppr_date() != null)
		{
			sql += ",appr_date=to_date('"
					+ commercial_merchantsno.getAppr_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_merchantsno.getAppr_remark() != 0)
		{
			sql += ",appr_remark=" + commercial_merchantsno.getAppr_remark()
					+ "";
		}
		if (commercial_merchantsno.getStatus() != 0)
		{
			sql += ",status=" + commercial_merchantsno.getStatus() + "";
		}
		if (commercial_merchantsno.getChange_date() != null)
		{
			sql += ",change_date=to_date('"
					+ commercial_merchantsno.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_merchantsno.getMerchant_busi() != null)
		{
			sql += ",merchant_busi='"
					+ commercial_merchantsno.getMerchant_busi() + "'";
		}
		if (commercial_merchantsno.getSales_man() != 0)
		{
			sql += ",sales_man=" + commercial_merchantsno.getSales_man() + "";
		}
		if (commercial_merchantsno.getMcc18() != null)
		{
			sql += ",mcc18=" + commercial_merchantsno.getMcc18() + "";
		}

		// ljn add

		if (commercial_merchantsno.getFee_rule1() != null)
		{
			sql += ",fee_rule1='" + commercial_merchantsno.getFee_rule1() + "'";
		}
		if (commercial_merchantsno.getFee_rule2() != null)
		{
			sql += ",fee_rule2='" + commercial_merchantsno.getFee_rule2() + "'";
		}
		if (commercial_merchantsno.getLq_rule() != null)
		{
			sql += ",lq_rule='" + commercial_merchantsno.getLq_rule() + "'";
		}
		if (commercial_merchantsno.getMarchantType() != null)
		{
			sql += ",marchantType='" + commercial_merchantsno.getMarchantType()
					+ "'";
		}
		if (commercial_merchantsno.getMerchant_name() != null)
		{
			sql += ",merchant_name='"
					+ commercial_merchantsno.getMerchant_name() + "'";
		}

		if (commercial_merchantsno.getChan_type() != null)
		{
			sql += ",chan_type='" + commercial_merchantsno.getChan_type() + "'";
		}
		if (commercial_merchantsno.getChan_name() != null)
		{
			sql += ",chan_name='" + commercial_merchantsno.getChan_name() + "'";
		}
		if (commercial_merchantsno.getAccount_bank_brach() != null)
		{
			sql += ",account_bank_brach='"
					+ commercial_merchantsno.getAccount_bank_brach() + "'";
		}
		if (commercial_merchantsno.getUnit_area() != null)
		{
			sql += ",unit_area='" + commercial_merchantsno.getUnit_area() + "'";
		}
		// end
		if (commercial_merchantsno.getFee_content() != null)
		{
			sql += ",fee_content='" + commercial_merchantsno.getFee_content()
					+ "'";
		}
		if (commercial_merchantsno.getFee_lev() != null)
		{
			sql += ",fee_lev='" + commercial_merchantsno.getFee_lev() + "'";
		}
		if (commercial_merchantsno.getFile_name() != null)
		{
			sql += ",file_name='" + commercial_merchantsno.getFile_name() + "'";
		}
		if (commercial_merchantsno.getFee_chan() != 0)
		{
			sql += ",fee_chan=" + commercial_merchantsno.getFee_chan() + "";
		}
		if (commercial_merchantsno.getReason() != null)
		{
			sql += ",reason='" + commercial_merchantsno.getReason() + "'";
		}
		if (commercial_merchantsno.getBank_no() != null)
		{
			sql += ",bank_no='" + commercial_merchantsno.getBank_no() + "'";
		}
		sql += " where MERCHANTSNO_ID="
				+ commercial_merchantsno.getMerchantsno_id() + "";
		Log.getLogger().debug("Commercial_merchantsno [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from COMMERCIAL_MERCHANTSNO where MERCHANTSNO_ID="
				+ id;
		Log.getLogger().debug("Commercial_merchantsno [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Commercial_merchantsno [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Commercial_merchantsno[] whereMcc(String mcc) throws Exception
	{
		String sql = "select * from commercial_merchantsno where mcc='" + mcc
				+ "'";
		return this.select(sql);
	}

	public Commercial_merchantsno whereMerchantsno_id(int merchantsno_id)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where merchantsno_id="
				+ merchantsno_id + "";
		return this.select(sql)[0];
	}

	public Commercial_merchantsno[] whereCommercial_id(int commercial_id)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where commercial_id="
				+ commercial_id + "";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereRatededuction(String ratededuction)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where ratededuction='"
				+ ratededuction + "'";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereAccount_no(String account_no)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where account_no='"
				+ account_no + "'";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereAccount_bank(String account_bank)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where account_bank='"
				+ account_bank + "'";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereAccount_name(String account_name)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where account_name='"
				+ account_name + "'";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereInput_date(String input_date)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where input_date='"
				+ input_date + "'";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereMerchantsno(String merchantsno)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where merchantsno='"
				+ merchantsno + "'";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereAppr_man(int appr_man)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where appr_man="
				+ appr_man + "";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereAppr_status(int appr_status)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where appr_status="
				+ appr_status + "";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereAppr_date(String appr_date)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where appr_date='"
				+ appr_date + "'";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereAppr_remark(int appr_remark)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where appr_remark="
				+ appr_remark + "";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereStatus(int status) throws Exception
	{
		String sql = "select * from commercial_merchantsno where status="
				+ status + "";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereChange_date(String change_date)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where change_date='"
				+ change_date + "'";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereMerchant_busi(String merchant_busi)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where merchant_busi='"
				+ merchant_busi + "'";
		return this.select(sql);
	}

	public Commercial_merchantsno[] whereSales_man(int sales_man)
			throws Exception
	{
		String sql = "select * from commercial_merchantsno where sales_man="
				+ sales_man + "";
		return this.select(sql);
	}

	public int quickInsert(Commercial_info commercial_info,
			Commercial_merchantsno commercial_merchantsno,
			Teminal_info teminal_info) throws Exception
	{
		DatabaseAccess dba = new DatabaseAccess();
		int merchantsno_id = 0;
		try
		{
			dba.autoCommit = false;
			String dateString = DateConvert.currentDate();
			// String dateString = DateConventer.dateWithTimeToStr(new Date());

			commercial_info.setInput_date(dateString);
			String sql = getInsertCommercial(commercial_info);
			dba.executeUpdate(sql, false);

			sql = "select COMMERCIAL_ID from COMMERCIAL_INFO where sales_man='"
					+ commercial_info.getSales_man()
					+ "' and input_date=to_date('" + dateString
					+ "','yyyy-MM-dd hh24:mi:ss')";
			ResultSet rs = dba.executeQuery(sql);
			// Log.getLogger().debug("COMMERCIAL_INFO [查询],SQL:["+sql+"]");
			Integer commercial_id = null;
			if (rs.next())
			{
				// Log.getLogger().debug("COMMERCIAL_INFO [查询],SQL:["+rs+"]");
				commercial_id = rs.getInt("COMMERCIAL_ID");
			}
			Log.getLogger()
					.debug("commercial_id [commercial_id],SQL:["
							+ commercial_id + "]");

			commercial_merchantsno.setCommercial_id(commercial_id.intValue());
			Log.getLogger().debug(
					"commercial_id.intValue():" + commercial_id.intValue());
			commercial_merchantsno.setInput_date(dateString);
			// Log.getLogger().debug("dateString:"+dateString);
			sql = getInsertCommercial_merchNo(commercial_merchantsno);
			// Log.getLogger().debug("COMMERCIAL_MERCHANTSNO [插入之前],SQL:["+sql+"]");
			dba.executeUpdate(sql, false);

			Log.getLogger().debug(
					"COMMERCIAL_MERCHANTSNO [插入],SQL:[" + sql + "]");

			sql = "select MERCHANTSNO_ID from COMMERCIAL_MERCHANTSNO where commercial_id="
					+ commercial_id
					+ " and input_date=to_date('"
					+ dateString
					+ "','yyyy-MM-dd hh24:mi:ss')";
			rs = dba.executeQuery(sql);

			if (rs.next())
			{
				merchantsno_id = rs.getInt("MERCHANTSNO_ID");
			}

			Log.getLogger().debug(
					"Commercial_merchantsno [插入],SQL:[" + sql + "]");

			teminal_info.setMerchantsno_id(merchantsno_id);
			teminal_info.setInput_date(dateString);
			sql = getInsertTeminal(teminal_info);
			dba.executeUpdate(sql, false);

			dba.autoCommit = true;
			dba.commit();
			dba.release();

		} catch (Exception e)
		{
			merchantsno_id = 0;
			Log.getLogger().error(e.toString(), e);
			try
			{
				dba.rollback();
			} catch (Exception e1)
			{
				e1.printStackTrace();
			}
			throw new Exception("快速录入异常");
		}

		return merchantsno_id;
	}

	private String getInsertCommercial(Commercial_info commercial_info)
	{
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
		if (commercial_info.getInput_date() != null)
		{
			fields += ",input_date";
			values += ",to_date('" + commercial_info.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_info.getChange_date() != null)
		{
			fields += ",change_date";
			values += ",to_date('" + commercial_info.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		sql += "(" + fields + ") values (" + values + ")";
		return sql;
	}

	private String getInsertCommercial_merchNo(
			Commercial_merchantsno commercial_merchantsno)
	{
		String sql = "insert into COMMERCIAL_MERCHANTSNO ";
		String fields = "MERCHANTSNO_ID";
		String values = "COMMERCIAL_MERCHANTSNO_ID_SEQ.nextval";
		if (commercial_merchantsno.getMcc() != null)
		{
			fields += ",mcc";
			values += ",'" + commercial_merchantsno.getMcc() + "'";
		}
		if (commercial_merchantsno.getCommercial_id() != 0)
		{
			fields += ",commercial_id";
			values += "," + commercial_merchantsno.getCommercial_id() + "";
		}
		if (commercial_merchantsno.getRatededuction() != null)
		{
			fields += ",ratededuction";
			values += ",'" + commercial_merchantsno.getRatededuction() + "'";
		}
		if (commercial_merchantsno.getAccount_no() != null)
		{
			fields += ",account_no";
			values += ",'" + commercial_merchantsno.getAccount_no() + "'";
		}
		if (commercial_merchantsno.getAccount_bank() != null)
		{
			fields += ",account_bank";
			values += ",'" + commercial_merchantsno.getAccount_bank() + "'";
		}
		if (commercial_merchantsno.getAccount_name() != null)
		{
			fields += ",account_name";
			values += ",'" + commercial_merchantsno.getAccount_name() + "'";
		}
		if (commercial_merchantsno.getInput_date() != null)
		{
			fields += ",input_date";
			values += ",to_date('" + commercial_merchantsno.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_merchantsno.getMerchantsno() != null)
		{
			fields += ",merchantsno";
			values += ",'" + commercial_merchantsno.getMerchantsno() + "'";
		}
		if (commercial_merchantsno.getAppr_man() != 0)
		{
			fields += ",appr_man";
			values += "," + commercial_merchantsno.getAppr_man() + "";
		}
		if (commercial_merchantsno.getAppr_status() != 0)
		{
			fields += ",appr_status";
			values += "," + commercial_merchantsno.getAppr_status() + "";
		}
		if (commercial_merchantsno.getAppr_date() != null)
		{
			fields += ",appr_date";
			values += ",to_date('" + commercial_merchantsno.getAppr_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_merchantsno.getAppr_remark() != 0)
		{
			fields += ",appr_remark";
			values += "," + commercial_merchantsno.getAppr_remark() + "";
		}
		if (commercial_merchantsno.getStatus() != 0)
		{
			fields += ",status";
			values += "," + commercial_merchantsno.getStatus() + "";
		}
		if (commercial_merchantsno.getChange_date() != null)
		{
			fields += ",change_date";
			values += ",to_date('" + commercial_merchantsno.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (commercial_merchantsno.getMerchant_busi() != null)
		{
			fields += ",merchant_busi";
			values += ",'" + commercial_merchantsno.getMerchant_busi() + "'";
		}
		if (commercial_merchantsno.getSales_man() != 0)
		{
			fields += ",sales_man";
			values += "," + commercial_merchantsno.getSales_man() + "";
		}

		if (commercial_merchantsno.getMerchant_name() != null)
		{
			fields += ",merchant_name";
			values += ",'" + commercial_merchantsno.getMerchant_name() + "'";
		}

		if (commercial_merchantsno.getChan_type() != null)
		{
			fields += ",chan_type";
			values += ",'" + commercial_merchantsno.getChan_type() + "'";
		}
		if (commercial_merchantsno.getChan_name() != null)
		{
			fields += ",chan_name";
			values += ",'" + commercial_merchantsno.getChan_name() + "'";
		}
		if (commercial_merchantsno.getAccount_bank_brach() != null)
		{
			fields += ",account_bank_brach";
			values += ",'" + commercial_merchantsno.getAccount_bank_brach()
					+ "'";
		}
		if (commercial_merchantsno.getUnit_area() != null)
		{
			fields += ",unit_area";
			values += ",'" + commercial_merchantsno.getUnit_area() + "'";
		}
		if (commercial_merchantsno.getFee_chan() != 0)
		{
			fields += ",fee_chan";
			values += "," + commercial_merchantsno.getFee_chan() + "";
		}
		if (commercial_merchantsno.getBank_no() != null)
		{
			fields += ",bank_no";
			values += ",'" + commercial_merchantsno.getBank_no() + "'";
		}
		sql += "(" + fields + ") values (" + values + ")";
		return sql;
	}

	private String getInsertTeminal(Teminal_info teminal_info)
	{
		String sql = "insert into TEMINAL_INFO ";
		String fields = "TEMINAL_INFO_ID";
		String values = "TEMINAL_INFO_ID_SEQ.nextval";
		if (teminal_info.getInstall_comp_date() != null)
		{
			fields += ",install_comp_date";
			values += ",to_date('" + teminal_info.getInstall_comp_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info.getHost_seq() != null)
		{
			fields += ",host_seq";
			values += ",'" + teminal_info.getHost_seq() + "'";
		}
		if (teminal_info.getKey_seq() != null)
		{
			fields += ",key_seq";
			values += ",'" + teminal_info.getKey_seq() + "'";
		}
		if (teminal_info.getEqui_type() != null)
		{
			fields += ",equi_type";
			values += ",'" + teminal_info.getEqui_type() + "'";
		}
		if (teminal_info.getEqui_tel_no() != null)
		{
			fields += ",equi_tel_no";
			values += ",'" + teminal_info.getEqui_tel_no() + "'";
		}
		if (teminal_info.getIs_hurry() != 0)
		{
			fields += ",is_hurry";
			values += "," + teminal_info.getIs_hurry() + "";
		}
		if (teminal_info.getSecu_depo() != null)
		{
			fields += ",secu_depo";
			values += ",'" + teminal_info.getSecu_depo() + "'";
		}
		if (teminal_info.getTeminalno() != null)
		{
			fields += ",teminalno";
			values += ",'" + teminal_info.getTeminalno() + "'";
		}
		if (teminal_info.getApproval_date() != null)
		{
			fields += ",approval_date";
			values += ",to_date('" + teminal_info.getApproval_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info.getTeminal_busi() != null)
		{
			fields += ",teminal_busi";
			values += ",'" + teminal_info.getTeminal_busi() + "'";
		}
		if (teminal_info.getDebug_man() != 0)
		{
			fields += ",debug_man";
			values += "," + teminal_info.getDebug_man() + "";
		}
		if (teminal_info.getInst_man() != 0)
		{
			fields += ",inst_man";
			values += "," + teminal_info.getInst_man() + "";
		}
		if (teminal_info.getSafe_man() != 0)
		{
			fields += ",safe_man";
			values += "," + teminal_info.getSafe_man() + "";
		}
		if (teminal_info.getAcco_no() != null)
		{
			fields += ",acco_no";
			values += ",'" + teminal_info.getAcco_no() + "'";
		}
		if (teminal_info.getTeminal_status() != 0)
		{
			fields += ",teminal_status";
			values += "," + teminal_info.getTeminal_status() + "";
		}
		if (teminal_info.getInstall_date() != null)
		{
			fields += ",install_date";
			values += ",to_date('" + teminal_info.getInstall_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info.getInput_date() != null)
		{
			fields += ",input_date";
			values += ",to_date('" + teminal_info.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info.getChange_date() != null)
		{
			fields += ",change_date";
			values += ",to_date('" + teminal_info.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info.getMerchantsno_id() != 0)
		{
			fields += ",merchantsno_id";
			values += "," + teminal_info.getMerchantsno_id() + "";
		}
		if (teminal_info.getMerchantsno() != null)
		{
			fields += ",merchantsno";
			values += ",'" + teminal_info.getMerchantsno() + "'";
		}
		if (teminal_info.getInstalled_man() != null)
		{
			fields += ",installed_man";
			values += ",'" + teminal_info.getInstalled_man() + "'";
		}
		if (teminal_info.getInstalled_tel() != null)
		{
			fields += ",installed_tel";
			values += ",'" + teminal_info.getInstalled_tel() + "'";
		}
		if (teminal_info.getInstalled_add() != null)
		{
			fields += ",installed_add";
			values += ",'" + teminal_info.getInstalled_add() + "'";
		}
		if (teminal_info.getTeminal_product() != null)
		{
			fields += ",teminal_product";
			values += ",'" + teminal_info.getTeminal_product() + "'";
		}
		if (teminal_info.getComm_fee() != null)
		{
			fields += ",comm_fee";
			values += "," + teminal_info.getComm_fee() + "";
		}
		if (teminal_info.getComm_fee_time() != null)
		{
			fields += ",comm_fee_time";
			values += ",'" + teminal_info.getComm_fee_time() + "'";
		}
		if (teminal_info.getRecipet_date() != null)
		{
			fields += ",recipet_date";
			values += ",'" + teminal_info.getRecipet_date() + "'";
		}
		if (teminal_info.getServ_fee() != null)
		{
			fields += ",serv_fee";
			values += "," + teminal_info.getServ_fee() + "";
		}
		if (teminal_info.getServ_fee_time() != null)
		{
			fields += ",serv_fee_time";
			values += ",'" + teminal_info.getServ_fee_time() + "'";
		}
		if (teminal_info.getDemo() != null)
		{
			fields += ",demo";
			values += ",'" + teminal_info.getDemo() + "'";
		}
		if (teminal_info.getS_city() != null)
		{
			fields += ",S_city";
			values += ",'" + teminal_info.getS_city() + "'";
		}
		if (teminal_info.getS_county() != null)
		{
			fields += ",S_county";
			values += ",'" + teminal_info.getS_county() + "'";
		}
		sql += "(" + fields + ") values (" + values + ")";
		return sql;
	}
}
