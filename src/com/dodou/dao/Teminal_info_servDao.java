package com.dodou.dao;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.*;
import com.dodou.table.*;
import com.dodou.log.*;
import java.sql.Timestamp;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;

public class Teminal_info_servDao extends CreatePage
{
	public String sql;

	public Teminal_info_serv[] select() throws Exception
	{
		sql = "select * from TEMINAL_INFO_SERV order by TEMINAL_INFO_SERV_ID desc";
		return this.select(sql);
	}

	public Teminal_info_serv[] select(String sql) throws Exception
	{
		Teminal_info_serv[] Teminal_info_servArray = new Teminal_info_serv[getPageSize()];
		Log.getLogger().debug("Teminal_info_serv [查找],SQL:[" + sql + "]");
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
			Teminal_info_serv teminal_info_serv = new Teminal_info_serv();
			teminal_info_serv.setContact_tel_1(rs.getString("contact_tel_1"));
			teminal_info_serv.setContact_name_2(rs.getString("contact_name_2"));
			teminal_info_serv.setContact_tel_2(rs.getString("contact_tel_2"));
			teminal_info_serv.setService_man(rs.getString("service_man"));
			teminal_info_serv.setComm_rating(rs.getString("comm_rating"));
			teminal_info_serv.setOpen_busi(rs.getString("open_busi"));
			teminal_info_serv.setRemark_info(rs.getString("remark_info"));
			teminal_info_serv.setUnit_status(rs.getInt("unit_status"));
			teminal_info_serv.setSales_man(rs.getString("sales_man"));
			teminal_info_serv.setRatededuction(rs.getString("ratededuction"));
			teminal_info_serv.setAccount_no(rs.getString("account_no"));
			teminal_info_serv.setAccount_bank(rs.getString("account_bank"));
			teminal_info_serv.setAccount_name(rs.getString("account_name"));
			teminal_info_serv.setMerchantsno(rs.getString("merchantsno"));
			teminal_info_serv.setAppr_man(rs.getInt("appr_man"));
			teminal_info_serv.setAppr_status(rs.getInt("appr_status"));
			teminal_info_serv.setAppr_date(rs.getString("appr_date"));
			teminal_info_serv.setAppr_remark(rs.getInt("appr_remark"));
			teminal_info_serv.setStatus(rs.getInt("status"));
			teminal_info_serv.setChange_date(rs.getString("change_date"));
			teminal_info_serv.setMerchant_busi(rs.getString("merchant_busi"));
			teminal_info_serv.setMcc(rs.getString("mcc"));
			teminal_info_serv.setMerchant_name(rs.getString("merchant_name"));
			teminal_info_serv.setMcc18(rs.getString("mcc18"));
			teminal_info_serv.setLq_rule(rs.getString("lq_rule"));
			teminal_info_serv.setFee_rule1(rs.getString("fee_rule1"));
			teminal_info_serv.setFee_rule2(rs.getString("fee_rule2"));
			teminal_info_serv.setMarchanttype(rs.getString("marchanttype"));
			teminal_info_serv.setUnit_area(rs.getString("unit_area"));
			teminal_info_serv.setChan_type(rs.getString("chan_type"));
			teminal_info_serv.setChan_name(rs.getString("chan_name"));
			teminal_info_serv.setAccount_bank_brach(rs
					.getString("account_bank_brach"));
			teminal_info_serv.setFee_content(rs.getString("fee_content"));
			teminal_info_serv.setFee_lev(rs.getString("fee_lev"));
			teminal_info_serv.setInstalled_man(rs.getString("installed_man"));
			teminal_info_serv.setInstalled_tel(rs.getString("installed_tel"));
			teminal_info_serv.setInstalled_add(rs.getString("installed_add"));
			teminal_info_serv.setTeminal_product(rs
					.getString("teminal_product"));
			teminal_info_serv.setEqui_type(rs.getString("equi_type"));
			teminal_info_serv.setEqui_tel_no(rs.getString("equi_tel_no"));
			teminal_info_serv.setSecu_depo(rs.getString("secu_depo"));
			teminal_info_serv.setTeminalno(rs.getString("teminalno"));
			teminal_info_serv.setApproval_date(rs.getString("approval_date"));
			teminal_info_serv.setTeminal_busi(rs.getString("teminal_busi"));
			teminal_info_serv.setDebug_man(rs.getString("debug_man"));
			teminal_info_serv.setInst_man(rs.getString("inst_man"));
			teminal_info_serv.setSafe_man(rs.getString("safe_man"));
			teminal_info_serv.setAcco_no(rs.getString("acco_no"));
			teminal_info_serv.setTeminal_status(rs.getInt("teminal_status"));
			teminal_info_serv.setInstall_date(rs.getString("install_date"));
			teminal_info_serv.setInput_date(rs.getString("input_date"));
			teminal_info_serv.setInstall_comp_date(rs
					.getString("install_comp_date"));
			teminal_info_serv.setHost_seq(rs.getString("host_seq"));
			teminal_info_serv.setKey_seq(rs.getString("key_seq"));
			teminal_info_serv.setDepo_time(rs.getString("depo_time"));
			teminal_info_serv.setInstall_end_date(rs
					.getString("install_end_date"));
			teminal_info_serv.setIs_success(rs.getInt("is_success"));
			teminal_info_serv.setDemo(rs.getString("demo"));
			teminal_info_serv.setComm_fee(rs.getInt("comm_fee"));
			teminal_info_serv.setComm_fee_time(rs.getString("comm_fee_time"));
			teminal_info_serv.setServ_fee(rs.getInt("serv_fee"));
			teminal_info_serv.setServ_fee_time(rs.getString("serv_fee_time"));
			teminal_info_serv.setRecipet_date(rs.getString("recipet_date"));
			teminal_info_serv.setServ_recipet_date(rs
					.getString("serv_recipet_date"));
			teminal_info_serv.setComm_recipet_date(rs
					.getString("comm_recipet_date"));
			teminal_info_serv.setTeminal_info_serv_id(rs
					.getInt("teminal_info_serv_id"));
			teminal_info_serv.setUnit_name(rs.getString("unit_name"));
			teminal_info_serv.setUnit_attr(rs.getString("unit_attr"));
			teminal_info_serv.setUnit_add(rs.getString("unit_add"));
			teminal_info_serv.setComm_no(rs.getString("comm_no"));
			teminal_info_serv.setComm_name(rs.getString("comm_name"));
			teminal_info_serv.setComm_ad(rs.getString("comm_ad"));
			teminal_info_serv.setTrade_name(rs.getString("trade_name"));
			teminal_info_serv.setContact_name_1(rs.getString("contact_name_1"));
			teminal_info_serv.setS_city(rs.getString("s_city"));
			teminal_info_serv.setS_county(rs.getString("s_county"));
			Teminal_info_servArray[j++] = teminal_info_serv;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Teminal_info_servArray;
	}

	public Teminal_info_serv[] select(Teminal_info_serv teminal_info_serv)
			throws Exception
	{
		sql = "select * from TEMINAL_INFO_SERV where 1 = 1 ";
		if (teminal_info_serv.getContact_tel_1() != null)
		{
			sql += " and contact_tel_1 = '"
					+ teminal_info_serv.getContact_tel_1() + "'";
		}
		if (teminal_info_serv.getContact_name_2() != null)
		{
			sql += " and contact_name_2 = '"
					+ teminal_info_serv.getContact_name_2() + "'";
		}
		if (teminal_info_serv.getContact_tel_2() != null)
		{
			sql += " and contact_tel_2 = '"
					+ teminal_info_serv.getContact_tel_2() + "'";
		}
		if (teminal_info_serv.getService_man() != null)
		{
			sql += " and service_man = '" + teminal_info_serv.getService_man()
					+ "'";
		}
		if (teminal_info_serv.getComm_rating() != null)
		{
			sql += " and comm_rating = '" + teminal_info_serv.getComm_rating()
					+ "'";
		}
		if (teminal_info_serv.getOpen_busi() != null)
		{
			sql += " and open_busi = '" + teminal_info_serv.getOpen_busi()
					+ "'";
		}
		if (teminal_info_serv.getRemark_info() != null)
		{
			sql += " and remark_info = '" + teminal_info_serv.getRemark_info()
					+ "'";
		}
		if (teminal_info_serv.getUnit_status() != 0)
		{
			sql += " and unit_status = " + teminal_info_serv.getUnit_status()
					+ "";
		}
		if (teminal_info_serv.getSales_man() != null)
		{
			sql += " and sales_man = '" + teminal_info_serv.getSales_man()
					+ "'";
		}
		if (teminal_info_serv.getRatededuction() != null)
		{
			sql += " and ratededuction = '"
					+ teminal_info_serv.getRatededuction() + "'";
		}
		if (teminal_info_serv.getAccount_no() != null)
		{
			sql += " and account_no = '" + teminal_info_serv.getAccount_no()
					+ "'";
		}
		if (teminal_info_serv.getAccount_bank() != null)
		{
			sql += " and account_bank = '"
					+ teminal_info_serv.getAccount_bank() + "'";
		}
		if (teminal_info_serv.getAccount_name() != null)
		{
			sql += " and account_name = '"
					+ teminal_info_serv.getAccount_name() + "'";
		}
		if (teminal_info_serv.getMerchantsno() != null)
		{
			sql += " and merchantsno = '" + teminal_info_serv.getMerchantsno()
					+ "'";
		}
		if (teminal_info_serv.getAppr_man() != 0)
		{
			sql += " and appr_man = " + teminal_info_serv.getAppr_man() + "";
		}
		if (teminal_info_serv.getAppr_status() != 0)
		{
			sql += " and appr_status = " + teminal_info_serv.getAppr_status()
					+ "";
		}
		if (teminal_info_serv.getAppr_date() != null)
		{
			sql += " and appr_date = to_date('"
					+ teminal_info_serv.getAppr_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getAppr_remark() != 0)
		{
			sql += " and appr_remark = " + teminal_info_serv.getAppr_remark()
					+ "";
		}
		if (teminal_info_serv.getStatus() != 0)
		{
			sql += " and status = " + teminal_info_serv.getStatus() + "";
		}
		if (teminal_info_serv.getChange_date() != null)
		{
			sql += " and change_date = to_date('"
					+ teminal_info_serv.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getMerchant_busi() != null)
		{
			sql += " and merchant_busi = '"
					+ teminal_info_serv.getMerchant_busi() + "'";
		}
		if (teminal_info_serv.getMcc() != null)
		{
			sql += " and mcc = '" + teminal_info_serv.getMcc() + "'";
		}
		if (teminal_info_serv.getMerchant_name() != null)
		{
			sql += " and merchant_name = '"
					+ teminal_info_serv.getMerchant_name() + "'";
		}
		if (teminal_info_serv.getMcc18() != null)
		{
			sql += " and mcc18 = '" + teminal_info_serv.getMcc18() + "'";
		}
		if (teminal_info_serv.getLq_rule() != null)
		{
			sql += " and lq_rule = '" + teminal_info_serv.getLq_rule() + "'";
		}
		if (teminal_info_serv.getFee_rule1() != null)
		{
			sql += " and fee_rule1 = '" + teminal_info_serv.getFee_rule1()
					+ "'";
		}
		if (teminal_info_serv.getFee_rule2() != null)
		{
			sql += " and fee_rule2 = '" + teminal_info_serv.getFee_rule2()
					+ "'";
		}
		if (teminal_info_serv.getMarchanttype() != null)
		{
			sql += " and marchanttype = '"
					+ teminal_info_serv.getMarchanttype() + "'";
		}
		if (teminal_info_serv.getUnit_area() != null)
		{
			sql += " and unit_area = '" + teminal_info_serv.getUnit_area()
					+ "'";
		}
		if (teminal_info_serv.getChan_type() != null)
		{
			sql += " and chan_type = '" + teminal_info_serv.getChan_type()
					+ "'";
		}
		if (teminal_info_serv.getChan_name() != null)
		{
			sql += " and chan_name = '" + teminal_info_serv.getChan_name()
					+ "'";
		}
		if (teminal_info_serv.getAccount_bank_brach() != null)
		{
			sql += " and account_bank_brach = '"
					+ teminal_info_serv.getAccount_bank_brach() + "'";
		}
		if (teminal_info_serv.getFee_content() != null)
		{
			sql += " and fee_content = '" + teminal_info_serv.getFee_content()
					+ "'";
		}
		if (teminal_info_serv.getFee_lev() != null)
		{
			sql += " and fee_lev = '" + teminal_info_serv.getFee_lev() + "'";
		}
		if (teminal_info_serv.getInstalled_man() != null)
		{
			sql += " and installed_man = '"
					+ teminal_info_serv.getInstalled_man() + "'";
		}
		if (teminal_info_serv.getInstalled_tel() != null)
		{
			sql += " and installed_tel = '"
					+ teminal_info_serv.getInstalled_tel() + "'";
		}
		if (teminal_info_serv.getInstalled_add() != null)
		{
			sql += " and installed_add = '"
					+ teminal_info_serv.getInstalled_add() + "'";
		}
		if (teminal_info_serv.getTeminal_product() != null)
		{
			sql += " and teminal_product = '"
					+ teminal_info_serv.getTeminal_product() + "'";
		}
		if (teminal_info_serv.getEqui_type() != null)
		{
			sql += " and equi_type = '" + teminal_info_serv.getEqui_type()
					+ "'";
		}
		if (teminal_info_serv.getEqui_tel_no() != null)
		{
			sql += " and equi_tel_no = '" + teminal_info_serv.getEqui_tel_no()
					+ "'";
		}
		if (teminal_info_serv.getSecu_depo() != null)
		{
			sql += " and secu_depo = '" + teminal_info_serv.getSecu_depo()
					+ "'";
		}
		if (teminal_info_serv.getTeminalno() != null)
		{
			sql += " and teminalno = '" + teminal_info_serv.getTeminalno()
					+ "'";
		}
		if (teminal_info_serv.getApproval_date() != null)
		{
			sql += " and approval_date = to_date('"
					+ teminal_info_serv.getApproval_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getTeminal_busi() != null)
		{
			sql += " and teminal_busi = '"
					+ teminal_info_serv.getTeminal_busi() + "'";
		}
		if (teminal_info_serv.getDebug_man() != null)
		{
			sql += " and debug_man = '" + teminal_info_serv.getDebug_man()
					+ "'";
		}
		if (teminal_info_serv.getInst_man() != null)
		{
			sql += " and inst_man = '" + teminal_info_serv.getInst_man() + "'";
		}
		if (teminal_info_serv.getSafe_man() != null)
		{
			sql += " and safe_man = '" + teminal_info_serv.getSafe_man() + "'";
		}
		if (teminal_info_serv.getAcco_no() != null)
		{
			sql += " and acco_no = '" + teminal_info_serv.getAcco_no() + "'";
		}
		if (teminal_info_serv.getTeminal_status() != 0)
		{
			sql += " and teminal_status = "
					+ teminal_info_serv.getTeminal_status() + "";
		}
		if (teminal_info_serv.getInstall_date() != null)
		{
			sql += " and install_date = to_date('"
					+ teminal_info_serv.getInstall_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getInput_date() != null)
		{
			sql += " and input_date = to_date('"
					+ teminal_info_serv.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getInstall_comp_date() != null)
		{
			sql += " and install_comp_date = to_date('"
					+ teminal_info_serv.getInstall_comp_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getHost_seq() != null)
		{
			sql += " and host_seq = '" + teminal_info_serv.getHost_seq() + "'";
		}
		if (teminal_info_serv.getKey_seq() != null)
		{
			sql += " and key_seq = '" + teminal_info_serv.getKey_seq() + "'";
		}
		if (teminal_info_serv.getDepo_time() != null)
		{
			sql += " and depo_time = to_date('"
					+ teminal_info_serv.getDepo_time()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getInstall_end_date() != null)
		{
			sql += " and install_end_date = to_date('"
					+ teminal_info_serv.getInstall_end_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getIs_success() != 0)
		{
			sql += " and is_success = " + teminal_info_serv.getIs_success()
					+ "";
		}
		if (teminal_info_serv.getDemo() != null)
		{
			sql += " and demo = '" + teminal_info_serv.getDemo() + "'";
		}
		if (teminal_info_serv.getComm_fee() != 0)
		{
			sql += " and comm_fee = " + teminal_info_serv.getComm_fee() + "";
		}
		if (teminal_info_serv.getComm_fee_time() != null)
		{
			sql += " and comm_fee_time = '"
					+ teminal_info_serv.getComm_fee_time() + "'";
		}
		if (teminal_info_serv.getServ_fee() != 0)
		{
			sql += " and serv_fee = " + teminal_info_serv.getServ_fee() + "";
		}
		if (teminal_info_serv.getServ_fee_time() != null)
		{
			sql += " and serv_fee_time = '"
					+ teminal_info_serv.getServ_fee_time() + "'";
		}
		if (teminal_info_serv.getRecipet_date() != null)
		{
			sql += " and recipet_date = to_date('"
					+ teminal_info_serv.getRecipet_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getServ_recipet_date() != null)
		{
			sql += " and serv_recipet_date = to_date('"
					+ teminal_info_serv.getServ_recipet_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getComm_recipet_date() != null)
		{
			sql += " and comm_recipet_date = to_date('"
					+ teminal_info_serv.getComm_recipet_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getTeminal_info_serv_id() != 0)
		{
			sql += " and teminal_info_serv_id = "
					+ teminal_info_serv.getTeminal_info_serv_id() + "";
		}
		if (teminal_info_serv.getUnit_name() != null)
		{
			sql += " and unit_name = '" + teminal_info_serv.getUnit_name()
					+ "'";
		}
		if (teminal_info_serv.getUnit_attr() != null)
		{
			sql += " and unit_attr = '" + teminal_info_serv.getUnit_attr()
					+ "'";
		}
		if (teminal_info_serv.getUnit_add() != null)
		{
			sql += " and unit_add = '" + teminal_info_serv.getUnit_add() + "'";
		}
		if (teminal_info_serv.getComm_no() != null)
		{
			sql += " and comm_no = '" + teminal_info_serv.getComm_no() + "'";
		}
		if (teminal_info_serv.getComm_name() != null)
		{
			sql += " and comm_name = '" + teminal_info_serv.getComm_name()
					+ "'";
		}
		if (teminal_info_serv.getComm_ad() != null)
		{
			sql += " and comm_ad = '" + teminal_info_serv.getComm_ad() + "'";
		}
		if (teminal_info_serv.getTrade_name() != null)
		{
			sql += " and trade_name = '" + teminal_info_serv.getTrade_name()
					+ "'";
		}
		if (teminal_info_serv.getContact_name_1() != null)
		{
			sql += " and contact_name_1 = '"
					+ teminal_info_serv.getContact_name_1() + "'";
		}
		if (teminal_info_serv.getDemo() != null)
		{
			sql += " and demo = '" + teminal_info_serv.getDemo() + "'";
		}
		if (teminal_info_serv.getS_county() != null)
		{
			sql += " and S_county = '" + teminal_info_serv.getS_county() + "'";
		}
		sql += " order by TEMINAL_INFO_SERV_ID desc";
		return this.select(sql);
	}

	public void insert(Teminal_info_serv teminal_info_serv) throws Exception
	{
		sql = "insert into TEMINAL_INFO_SERV ";
		String fields = "TEMINAL_INFO_SERV_ID";
		String values = "TEMINAL_INFO_SERV_ID_SEQ.nextval";
		if (teminal_info_serv.getContact_tel_1() != null)
		{
			fields += ",contact_tel_1";
			values += ",'" + teminal_info_serv.getContact_tel_1() + "'";
		}
		if (teminal_info_serv.getContact_name_2() != null)
		{
			fields += ",contact_name_2";
			values += ",'" + teminal_info_serv.getContact_name_2() + "'";
		}
		if (teminal_info_serv.getContact_tel_2() != null)
		{
			fields += ",contact_tel_2";
			values += ",'" + teminal_info_serv.getContact_tel_2() + "'";
		}
		if (teminal_info_serv.getService_man() != null)
		{
			fields += ",service_man";
			values += ",'" + teminal_info_serv.getService_man() + "'";
		}
		if (teminal_info_serv.getComm_rating() != null)
		{
			fields += ",comm_rating";
			values += ",'" + teminal_info_serv.getComm_rating() + "'";
		}
		if (teminal_info_serv.getOpen_busi() != null)
		{
			fields += ",open_busi";
			values += ",'" + teminal_info_serv.getOpen_busi() + "'";
		}
		if (teminal_info_serv.getRemark_info() != null)
		{
			fields += ",remark_info";
			values += ",'" + teminal_info_serv.getRemark_info() + "'";
		}
		if (teminal_info_serv.getUnit_status() != 0)
		{
			fields += ",unit_status";
			values += "," + teminal_info_serv.getUnit_status() + "";
		}
		if (teminal_info_serv.getSales_man() != null)
		{
			fields += ",sales_man";
			values += ",'" + teminal_info_serv.getSales_man() + "'";
		}
		if (teminal_info_serv.getRatededuction() != null)
		{
			fields += ",ratededuction";
			values += ",'" + teminal_info_serv.getRatededuction() + "'";
		}
		if (teminal_info_serv.getAccount_no() != null)
		{
			fields += ",account_no";
			values += ",'" + teminal_info_serv.getAccount_no() + "'";
		}
		if (teminal_info_serv.getAccount_bank() != null)
		{
			fields += ",account_bank";
			values += ",'" + teminal_info_serv.getAccount_bank() + "'";
		}
		if (teminal_info_serv.getAccount_name() != null)
		{
			fields += ",account_name";
			values += ",'" + teminal_info_serv.getAccount_name() + "'";
		}
		if (teminal_info_serv.getMerchantsno() != null)
		{
			fields += ",merchantsno";
			values += ",'" + teminal_info_serv.getMerchantsno() + "'";
		}
		if (teminal_info_serv.getAppr_man() != 0)
		{
			fields += ",appr_man";
			values += "," + teminal_info_serv.getAppr_man() + "";
		}
		if (teminal_info_serv.getAppr_status() != 0)
		{
			fields += ",appr_status";
			values += "," + teminal_info_serv.getAppr_status() + "";
		}
		if (teminal_info_serv.getAppr_date() != null)
		{
			fields += ",appr_date";
			values += ",to_date('" + teminal_info_serv.getAppr_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getAppr_remark() != 0)
		{
			fields += ",appr_remark";
			values += "," + teminal_info_serv.getAppr_remark() + "";
		}
		if (teminal_info_serv.getStatus() != 0)
		{
			fields += ",status";
			values += "," + teminal_info_serv.getStatus() + "";
		}
		if (teminal_info_serv.getChange_date() != null)
		{
			fields += ",change_date";
			values += ",to_date('" + teminal_info_serv.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getMerchant_busi() != null)
		{
			fields += ",merchant_busi";
			values += ",'" + teminal_info_serv.getMerchant_busi() + "'";
		}
		if (teminal_info_serv.getMcc() != null)
		{
			fields += ",mcc";
			values += ",'" + teminal_info_serv.getMcc() + "'";
		}
		if (teminal_info_serv.getMerchant_name() != null)
		{
			fields += ",merchant_name";
			values += ",'" + teminal_info_serv.getMerchant_name() + "'";
		}
		if (teminal_info_serv.getMcc18() != null)
		{
			fields += ",mcc18";
			values += ",'" + teminal_info_serv.getMcc18() + "'";
		}
		if (teminal_info_serv.getLq_rule() != null)
		{
			fields += ",lq_rule";
			values += ",'" + teminal_info_serv.getLq_rule() + "'";
		}
		if (teminal_info_serv.getFee_rule1() != null)
		{
			fields += ",fee_rule1";
			values += ",'" + teminal_info_serv.getFee_rule1() + "'";
		}
		if (teminal_info_serv.getFee_rule2() != null)
		{
			fields += ",fee_rule2";
			values += ",'" + teminal_info_serv.getFee_rule2() + "'";
		}
		if (teminal_info_serv.getMarchanttype() != null)
		{
			fields += ",marchanttype";
			values += ",'" + teminal_info_serv.getMarchanttype() + "'";
		}
		if (teminal_info_serv.getUnit_area() != null)
		{
			fields += ",unit_area";
			values += ",'" + teminal_info_serv.getUnit_area() + "'";
		}
		if (teminal_info_serv.getChan_type() != null)
		{
			fields += ",chan_type";
			values += ",'" + teminal_info_serv.getChan_type() + "'";
		}
		if (teminal_info_serv.getChan_name() != null)
		{
			fields += ",chan_name";
			values += ",'" + teminal_info_serv.getChan_name() + "'";
		}
		if (teminal_info_serv.getAccount_bank_brach() != null)
		{
			fields += ",account_bank_brach";
			values += ",'" + teminal_info_serv.getAccount_bank_brach() + "'";
		}
		if (teminal_info_serv.getFee_content() != null)
		{
			fields += ",fee_content";
			values += ",'" + teminal_info_serv.getFee_content() + "'";
		}
		if (teminal_info_serv.getFee_lev() != null)
		{
			fields += ",fee_lev";
			values += ",'" + teminal_info_serv.getFee_lev() + "'";
		}
		if (teminal_info_serv.getInstalled_man() != null)
		{
			fields += ",installed_man";
			values += ",'" + teminal_info_serv.getInstalled_man() + "'";
		}
		if (teminal_info_serv.getInstalled_tel() != null)
		{
			fields += ",installed_tel";
			values += ",'" + teminal_info_serv.getInstalled_tel() + "'";
		}
		if (teminal_info_serv.getInstalled_add() != null)
		{
			fields += ",installed_add";
			values += ",'" + teminal_info_serv.getInstalled_add() + "'";
		}
		if (teminal_info_serv.getTeminal_product() != null)
		{
			fields += ",teminal_product";
			values += ",'" + teminal_info_serv.getTeminal_product() + "'";
		}
		if (teminal_info_serv.getEqui_type() != null)
		{
			fields += ",equi_type";
			values += ",'" + teminal_info_serv.getEqui_type() + "'";
		}
		if (teminal_info_serv.getEqui_tel_no() != null)
		{
			fields += ",equi_tel_no";
			values += ",'" + teminal_info_serv.getEqui_tel_no() + "'";
		}
		if (teminal_info_serv.getSecu_depo() != null)
		{
			fields += ",secu_depo";
			values += ",'" + teminal_info_serv.getSecu_depo() + "'";
		}
		if (teminal_info_serv.getTeminalno() != null)
		{
			fields += ",teminalno";
			values += ",'" + teminal_info_serv.getTeminalno() + "'";
		}
		if (teminal_info_serv.getApproval_date() != null)
		{
			fields += ",approval_date";
			values += ",to_date('" + teminal_info_serv.getApproval_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getTeminal_busi() != null)
		{
			fields += ",teminal_busi";
			values += ",'" + teminal_info_serv.getTeminal_busi() + "'";
		}
		if (teminal_info_serv.getDebug_man() != null)
		{
			fields += ",debug_man";
			values += ",'" + teminal_info_serv.getDebug_man() + "'";
		}
		if (teminal_info_serv.getInst_man() != null)
		{
			fields += ",inst_man";
			values += ",'" + teminal_info_serv.getInst_man() + "'";
		}
		if (teminal_info_serv.getSafe_man() != null)
		{
			fields += ",safe_man";
			values += ",'" + teminal_info_serv.getSafe_man() + "'";
		}
		if (teminal_info_serv.getAcco_no() != null)
		{
			fields += ",acco_no";
			values += ",'" + teminal_info_serv.getAcco_no() + "'";
		}
		if (teminal_info_serv.getTeminal_status() != 0)
		{
			fields += ",teminal_status";
			values += "," + teminal_info_serv.getTeminal_status() + "";
		}
		if (teminal_info_serv.getInstall_date() != null)
		{
			fields += ",install_date";
			values += ",to_date('" + teminal_info_serv.getInstall_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getInput_date() != null)
		{
			fields += ",input_date";
			values += ",to_date('" + teminal_info_serv.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getInstall_comp_date() != null)
		{
			fields += ",install_comp_date";
			values += ",to_date('" + teminal_info_serv.getInstall_comp_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getHost_seq() != null)
		{
			fields += ",host_seq";
			values += ",'" + teminal_info_serv.getHost_seq() + "'";
		}
		if (teminal_info_serv.getKey_seq() != null)
		{
			fields += ",key_seq";
			values += ",'" + teminal_info_serv.getKey_seq() + "'";
		}
		if (teminal_info_serv.getDepo_time() != null)
		{
			fields += ",depo_time";
			values += ",to_date('" + teminal_info_serv.getDepo_time()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getInstall_end_date() != null)
		{
			fields += ",install_end_date";
			values += ",to_date('" + teminal_info_serv.getInstall_end_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getIs_success() != 0)
		{
			fields += ",is_success";
			values += "," + teminal_info_serv.getIs_success() + "";
		}
		if (teminal_info_serv.getDemo() != null)
		{
			fields += ",demo";
			values += ",'" + teminal_info_serv.getDemo() + "'";
		}
		if (teminal_info_serv.getComm_fee() != 0)
		{
			fields += ",comm_fee";
			values += "," + teminal_info_serv.getComm_fee() + "";
		}
		if (teminal_info_serv.getComm_fee_time() != null)
		{
			fields += ",comm_fee_time";
			values += ",'" + teminal_info_serv.getComm_fee_time() + "'";
		}
		if (teminal_info_serv.getServ_fee() != 0)
		{
			fields += ",serv_fee";
			values += "," + teminal_info_serv.getServ_fee() + "";
		}
		if (teminal_info_serv.getServ_fee_time() != null)
		{
			fields += ",serv_fee_time";
			values += ",'" + teminal_info_serv.getServ_fee_time() + "'";
		}
		if (teminal_info_serv.getRecipet_date() != null)
		{
			fields += ",recipet_date";
			values += ",to_date('" + teminal_info_serv.getRecipet_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getServ_recipet_date() != null)
		{
			fields += ",serv_recipet_date";
			values += ",to_date('" + teminal_info_serv.getServ_recipet_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getComm_recipet_date() != null)
		{
			fields += ",comm_recipet_date";
			values += ",to_date('" + teminal_info_serv.getComm_recipet_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getUnit_name() != null)
		{
			fields += ",unit_name";
			values += ",'" + teminal_info_serv.getUnit_name() + "'";
		}
		if (teminal_info_serv.getUnit_attr() != null)
		{
			fields += ",unit_attr";
			values += ",'" + teminal_info_serv.getUnit_attr() + "'";
		}
		if (teminal_info_serv.getUnit_add() != null)
		{
			fields += ",unit_add";
			values += ",'" + teminal_info_serv.getUnit_add() + "'";
		}
		if (teminal_info_serv.getComm_no() != null)
		{
			fields += ",comm_no";
			values += ",'" + teminal_info_serv.getComm_no() + "'";
		}
		if (teminal_info_serv.getComm_name() != null)
		{
			fields += ",comm_name";
			values += ",'" + teminal_info_serv.getComm_name() + "'";
		}
		if (teminal_info_serv.getComm_ad() != null)
		{
			fields += ",comm_ad";
			values += ",'" + teminal_info_serv.getComm_ad() + "'";
		}
		if (teminal_info_serv.getTrade_name() != null)
		{
			fields += ",trade_name";
			values += ",'" + teminal_info_serv.getTrade_name() + "'";
		}
		if (teminal_info_serv.getContact_name_1() != null)
		{
			fields += ",contact_name_1";
			values += ",'" + teminal_info_serv.getContact_name_1() + "'";
		}
		if (teminal_info_serv.getS_city() != null)
		{
			fields += ",S_city";
			values += ",'" + teminal_info_serv.getS_city() + "'";
		}
		if (teminal_info_serv.getS_county() != null)
		{
			fields += ",S_county";
			values += ",'" + teminal_info_serv.getS_county() + "'";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Teminal_info_serv [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void update(Teminal_info_serv teminal_info_serv) throws Exception
	{
		sql = "update TEMINAL_INFO_SERV set TEMINAL_INFO_SERV_ID=TEMINAL_INFO_SERV_ID";
		if (teminal_info_serv.getContact_tel_1() != null)
		{
			sql += ",contact_tel_1='" + teminal_info_serv.getContact_tel_1()
					+ "'";
		}
		if (teminal_info_serv.getContact_name_2() != null)
		{
			sql += ",contact_name_2='" + teminal_info_serv.getContact_name_2()
					+ "'";
		}
		if (teminal_info_serv.getContact_tel_2() != null)
		{
			sql += ",contact_tel_2='" + teminal_info_serv.getContact_tel_2()
					+ "'";
		}
		if (teminal_info_serv.getService_man() != null)
		{
			sql += ",service_man='" + teminal_info_serv.getService_man() + "'";
		}
		if (teminal_info_serv.getComm_rating() != null)
		{
			sql += ",comm_rating='" + teminal_info_serv.getComm_rating() + "'";
		}
		if (teminal_info_serv.getOpen_busi() != null)
		{
			sql += ",open_busi='" + teminal_info_serv.getOpen_busi() + "'";
		}
		if (teminal_info_serv.getRemark_info() != null)
		{
			sql += ",remark_info='" + teminal_info_serv.getRemark_info() + "'";
		}
		if (teminal_info_serv.getUnit_status() != 0)
		{
			sql += ",unit_status=" + teminal_info_serv.getUnit_status() + "";
		}
		if (teminal_info_serv.getSales_man() != null)
		{
			sql += ",sales_man='" + teminal_info_serv.getSales_man() + "'";
		}
		if (teminal_info_serv.getRatededuction() != null)
		{
			sql += ",ratededuction='" + teminal_info_serv.getRatededuction()
					+ "'";
		}
		if (teminal_info_serv.getAccount_no() != null)
		{
			sql += ",account_no='" + teminal_info_serv.getAccount_no() + "'";
		}
		if (teminal_info_serv.getAccount_bank() != null)
		{
			sql += ",account_bank='" + teminal_info_serv.getAccount_bank()
					+ "'";
		}
		if (teminal_info_serv.getAccount_name() != null)
		{
			sql += ",account_name='" + teminal_info_serv.getAccount_name()
					+ "'";
		}
		if (teminal_info_serv.getMerchantsno() != null)
		{
			sql += ",merchantsno='" + teminal_info_serv.getMerchantsno() + "'";
		}
		if (teminal_info_serv.getAppr_man() != 0)
		{
			sql += ",appr_man=" + teminal_info_serv.getAppr_man() + "";
		}
		if (teminal_info_serv.getAppr_status() != 0)
		{
			sql += ",appr_status=" + teminal_info_serv.getAppr_status() + "";
		}
		if (teminal_info_serv.getAppr_date() != null)
		{
			sql += ",appr_date=to_date('" + teminal_info_serv.getAppr_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getAppr_remark() != 0)
		{
			sql += ",appr_remark=" + teminal_info_serv.getAppr_remark() + "";
		}
		if (teminal_info_serv.getStatus() != 0)
		{
			sql += ",status=" + teminal_info_serv.getStatus() + "";
		}
		if (teminal_info_serv.getChange_date() != null)
		{
			sql += ",change_date=to_date('"
					+ teminal_info_serv.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getMerchant_busi() != null)
		{
			sql += ",merchant_busi='" + teminal_info_serv.getMerchant_busi()
					+ "'";
		}
		if (teminal_info_serv.getMcc() != null)
		{
			sql += ",mcc='" + teminal_info_serv.getMcc() + "'";
		}
		if (teminal_info_serv.getMerchant_name() != null)
		{
			sql += ",merchant_name='" + teminal_info_serv.getMerchant_name()
					+ "'";
		}
		if (teminal_info_serv.getMcc18() != null)
		{
			sql += ",mcc18='" + teminal_info_serv.getMcc18() + "'";
		}
		if (teminal_info_serv.getLq_rule() != null)
		{
			sql += ",lq_rule='" + teminal_info_serv.getLq_rule() + "'";
		}
		if (teminal_info_serv.getFee_rule1() != null)
		{
			sql += ",fee_rule1='" + teminal_info_serv.getFee_rule1() + "'";
		}
		if (teminal_info_serv.getFee_rule2() != null)
		{
			sql += ",fee_rule2='" + teminal_info_serv.getFee_rule2() + "'";
		}
		if (teminal_info_serv.getMarchanttype() != null)
		{
			sql += ",marchanttype='" + teminal_info_serv.getMarchanttype()
					+ "'";
		}
		if (teminal_info_serv.getUnit_area() != null)
		{
			sql += ",unit_area='" + teminal_info_serv.getUnit_area() + "'";
		}
		if (teminal_info_serv.getChan_type() != null)
		{
			sql += ",chan_type='" + teminal_info_serv.getChan_type() + "'";
		}
		if (teminal_info_serv.getChan_name() != null)
		{
			sql += ",chan_name='" + teminal_info_serv.getChan_name() + "'";
		}
		if (teminal_info_serv.getAccount_bank_brach() != null)
		{
			sql += ",account_bank_brach='"
					+ teminal_info_serv.getAccount_bank_brach() + "'";
		}
		if (teminal_info_serv.getFee_content() != null)
		{
			sql += ",fee_content='" + teminal_info_serv.getFee_content() + "'";
		}
		if (teminal_info_serv.getFee_lev() != null)
		{
			sql += ",fee_lev='" + teminal_info_serv.getFee_lev() + "'";
		}
		if (teminal_info_serv.getInstalled_man() != null)
		{
			sql += ",installed_man='" + teminal_info_serv.getInstalled_man()
					+ "'";
		}
		if (teminal_info_serv.getInstalled_tel() != null)
		{
			sql += ",installed_tel='" + teminal_info_serv.getInstalled_tel()
					+ "'";
		}
		if (teminal_info_serv.getInstalled_add() != null)
		{
			sql += ",installed_add='" + teminal_info_serv.getInstalled_add()
					+ "'";
		}
		if (teminal_info_serv.getTeminal_product() != null)
		{
			sql += ",teminal_product='"
					+ teminal_info_serv.getTeminal_product() + "'";
		}
		if (teminal_info_serv.getEqui_type() != null)
		{
			sql += ",equi_type='" + teminal_info_serv.getEqui_type() + "'";
		}
		if (teminal_info_serv.getEqui_tel_no() != null)
		{
			sql += ",equi_tel_no='" + teminal_info_serv.getEqui_tel_no() + "'";
		}
		if (teminal_info_serv.getSecu_depo() != null)
		{
			sql += ",secu_depo='" + teminal_info_serv.getSecu_depo() + "'";
		}
		if (teminal_info_serv.getTeminalno() != null)
		{
			sql += ",teminalno='" + teminal_info_serv.getTeminalno() + "'";
		}
		if (teminal_info_serv.getApproval_date() != null)
		{
			sql += ",approval_date=to_date('"
					+ teminal_info_serv.getApproval_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getTeminal_busi() != null)
		{
			sql += ",teminal_busi='" + teminal_info_serv.getTeminal_busi()
					+ "'";
		}
		if (teminal_info_serv.getDebug_man() != null)
		{
			sql += ",debug_man='" + teminal_info_serv.getDebug_man() + "'";
		}
		if (teminal_info_serv.getInst_man() != null)
		{
			sql += ",inst_man='" + teminal_info_serv.getInst_man() + "'";
		}
		if (teminal_info_serv.getSafe_man() != null)
		{
			sql += ",safe_man='" + teminal_info_serv.getSafe_man() + "'";
		}
		if (teminal_info_serv.getAcco_no() != null)
		{
			sql += ",acco_no='" + teminal_info_serv.getAcco_no() + "'";
		}
		if (teminal_info_serv.getTeminal_status() != 0)
		{
			sql += ",teminal_status=" + teminal_info_serv.getTeminal_status()
					+ "";
		}
		if (teminal_info_serv.getInstall_date() != null)
		{
			sql += ",install_date=to_date('"
					+ teminal_info_serv.getInstall_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getInput_date() != null)
		{
			sql += ",input_date=to_date('" + teminal_info_serv.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getInstall_comp_date() != null)
		{
			sql += ",install_comp_date=to_date('"
					+ teminal_info_serv.getInstall_comp_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getHost_seq() != null)
		{
			sql += ",host_seq='" + teminal_info_serv.getHost_seq() + "'";
		}
		if (teminal_info_serv.getKey_seq() != null)
		{
			sql += ",key_seq='" + teminal_info_serv.getKey_seq() + "'";
		}
		if (teminal_info_serv.getDepo_time() != null)
		{
			sql += ",depo_time=to_date('" + teminal_info_serv.getDepo_time()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getInstall_end_date() != null)
		{
			sql += ",install_end_date=to_date('"
					+ teminal_info_serv.getInstall_end_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getIs_success() != 0)
		{
			sql += ",is_success=" + teminal_info_serv.getIs_success() + "";
		}
		if (teminal_info_serv.getDemo() != null)
		{
			sql += ",demo='" + teminal_info_serv.getDemo() + "'";
		}
		if (teminal_info_serv.getComm_fee() != 0)
		{
			sql += ",comm_fee=" + teminal_info_serv.getComm_fee() + "";
		}
		if (teminal_info_serv.getComm_fee_time() != null)
		{
			sql += ",comm_fee_time='" + teminal_info_serv.getComm_fee_time()
					+ "'";
		}
		if (teminal_info_serv.getServ_fee() != 0)
		{
			sql += ",serv_fee=" + teminal_info_serv.getServ_fee() + "";
		}
		if (teminal_info_serv.getServ_fee_time() != null)
		{
			sql += ",serv_fee_time='" + teminal_info_serv.getServ_fee_time()
					+ "'";
		}
		if (teminal_info_serv.getRecipet_date() != null)
		{
			sql += ",recipet_date=to_date('"
					+ teminal_info_serv.getRecipet_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getServ_recipet_date() != null)
		{
			sql += ",serv_recipet_date=to_date('"
					+ teminal_info_serv.getServ_recipet_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getComm_recipet_date() != null)
		{
			sql += ",comm_recipet_date=to_date('"
					+ teminal_info_serv.getComm_recipet_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_serv.getUnit_name() != null)
		{
			sql += ",unit_name='" + teminal_info_serv.getUnit_name() + "'";
		}
		if (teminal_info_serv.getUnit_attr() != null)
		{
			sql += ",unit_attr='" + teminal_info_serv.getUnit_attr() + "'";
		}
		if (teminal_info_serv.getUnit_add() != null)
		{
			sql += ",unit_add='" + teminal_info_serv.getUnit_add() + "'";
		}
		if (teminal_info_serv.getComm_no() != null)
		{
			sql += ",comm_no='" + teminal_info_serv.getComm_no() + "'";
		}
		if (teminal_info_serv.getComm_name() != null)
		{
			sql += ",comm_name='" + teminal_info_serv.getComm_name() + "'";
		}
		if (teminal_info_serv.getComm_ad() != null)
		{
			sql += ",comm_ad='" + teminal_info_serv.getComm_ad() + "'";
		}
		if (teminal_info_serv.getTrade_name() != null)
		{
			sql += ",trade_name='" + teminal_info_serv.getTrade_name() + "'";
		}
		if (teminal_info_serv.getContact_name_1() != null)
		{
			sql += ",contact_name_1='" + teminal_info_serv.getContact_name_1()
					+ "'";
		}
		sql += " where TEMINAL_INFO_SERV_ID="
				+ teminal_info_serv.getTeminal_info_serv_id() + "";
		Log.getLogger().debug("Teminal_info_serv [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		sql = "delete from TEMINAL_INFO_SERV where TEMINAL_INFO_SERV_ID=" + id;
		Log.getLogger().debug("Teminal_info_serv [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Teminal_info_serv [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public Teminal_info_serv[] whereContact_tel_1(String contact_tel_1)
			throws Exception
	{
		sql = "select * from teminal_info_serv where contact_tel_1='"
				+ contact_tel_1 + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereContact_name_2(String contact_name_2)
			throws Exception
	{
		sql = "select * from teminal_info_serv where contact_name_2='"
				+ contact_name_2 + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereContact_tel_2(String contact_tel_2)
			throws Exception
	{
		sql = "select * from teminal_info_serv where contact_tel_2='"
				+ contact_tel_2 + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereService_man(String service_man)
			throws Exception
	{
		sql = "select * from teminal_info_serv where service_man='"
				+ service_man + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereComm_rating(String comm_rating)
			throws Exception
	{
		sql = "select * from teminal_info_serv where comm_rating='"
				+ comm_rating + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereOpen_busi(String open_busi)
			throws Exception
	{
		sql = "select * from teminal_info_serv where open_busi='" + open_busi
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereRemark_info(String remark_info)
			throws Exception
	{
		sql = "select * from teminal_info_serv where remark_info='"
				+ remark_info + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereUnit_status(int unit_status)
			throws Exception
	{
		sql = "select * from teminal_info_serv where unit_status="
				+ unit_status + "";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereSales_man(String sales_man)
			throws Exception
	{
		sql = "select * from teminal_info_serv where sales_man='" + sales_man
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereRatededuction(String ratededuction)
			throws Exception
	{
		sql = "select * from teminal_info_serv where ratededuction='"
				+ ratededuction + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereAccount_no(String account_no)
			throws Exception
	{
		sql = "select * from teminal_info_serv where account_no='" + account_no
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereAccount_bank(String account_bank)
			throws Exception
	{
		sql = "select * from teminal_info_serv where account_bank='"
				+ account_bank + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereAccount_name(String account_name)
			throws Exception
	{
		sql = "select * from teminal_info_serv where account_name='"
				+ account_name + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereMerchantsno(String merchantsno)
			throws Exception
	{
		sql = "select * from teminal_info_serv where merchantsno='"
				+ merchantsno + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereAppr_man(int appr_man) throws Exception
	{
		sql = "select * from teminal_info_serv where appr_man=" + appr_man + "";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereAppr_status(int appr_status)
			throws Exception
	{
		sql = "select * from teminal_info_serv where appr_status="
				+ appr_status + "";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereAppr_date(String appr_date)
			throws Exception
	{
		sql = "select * from teminal_info_serv where appr_date='" + appr_date
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereAppr_remark(int appr_remark)
			throws Exception
	{
		sql = "select * from teminal_info_serv where appr_remark="
				+ appr_remark + "";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereStatus(int status) throws Exception
	{
		sql = "select * from teminal_info_serv where status=" + status + "";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereChange_date(String change_date)
			throws Exception
	{
		sql = "select * from teminal_info_serv where change_date='"
				+ change_date + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereMerchant_busi(String merchant_busi)
			throws Exception
	{
		sql = "select * from teminal_info_serv where merchant_busi='"
				+ merchant_busi + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereMcc(String mcc) throws Exception
	{
		sql = "select * from teminal_info_serv where mcc='" + mcc + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereMerchant_name(String merchant_name)
			throws Exception
	{
		sql = "select * from teminal_info_serv where merchant_name='"
				+ merchant_name + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereMcc18(String mcc18) throws Exception
	{
		sql = "select * from teminal_info_serv where mcc18='" + mcc18 + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereLq_rule(String lq_rule) throws Exception
	{
		sql = "select * from teminal_info_serv where lq_rule='" + lq_rule + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereFee_rule1(String fee_rule1)
			throws Exception
	{
		sql = "select * from teminal_info_serv where fee_rule1='" + fee_rule1
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereFee_rule2(String fee_rule2)
			throws Exception
	{
		sql = "select * from teminal_info_serv where fee_rule2='" + fee_rule2
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereMarchanttype(String marchanttype)
			throws Exception
	{
		sql = "select * from teminal_info_serv where marchanttype='"
				+ marchanttype + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereUnit_area(String unit_area)
			throws Exception
	{
		sql = "select * from teminal_info_serv where unit_area='" + unit_area
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereChan_type(String chan_type)
			throws Exception
	{
		sql = "select * from teminal_info_serv where chan_type='" + chan_type
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereChan_name(String chan_name)
			throws Exception
	{
		sql = "select * from teminal_info_serv where chan_name='" + chan_name
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereAccount_bank_brach(String account_bank_brach)
			throws Exception
	{
		sql = "select * from teminal_info_serv where account_bank_brach='"
				+ account_bank_brach + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereFee_content(String fee_content)
			throws Exception
	{
		sql = "select * from teminal_info_serv where fee_content='"
				+ fee_content + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereFee_lev(String fee_lev) throws Exception
	{
		sql = "select * from teminal_info_serv where fee_lev='" + fee_lev + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereInstalled_man(String installed_man)
			throws Exception
	{
		sql = "select * from teminal_info_serv where installed_man='"
				+ installed_man + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereInstalled_tel(String installed_tel)
			throws Exception
	{
		sql = "select * from teminal_info_serv where installed_tel='"
				+ installed_tel + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereInstalled_add(String installed_add)
			throws Exception
	{
		sql = "select * from teminal_info_serv where installed_add='"
				+ installed_add + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereTeminal_product(String teminal_product)
			throws Exception
	{
		sql = "select * from teminal_info_serv where teminal_product='"
				+ teminal_product + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereEqui_type(String equi_type)
			throws Exception
	{
		sql = "select * from teminal_info_serv where equi_type='" + equi_type
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereEqui_tel_no(String equi_tel_no)
			throws Exception
	{
		sql = "select * from teminal_info_serv where equi_tel_no='"
				+ equi_tel_no + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereSecu_depo(String secu_depo)
			throws Exception
	{
		sql = "select * from teminal_info_serv where secu_depo='" + secu_depo
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereTeminalno(String teminalno)
			throws Exception
	{
		sql = "select * from teminal_info_serv where teminalno='" + teminalno
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereApproval_date(String approval_date)
			throws Exception
	{
		sql = "select * from teminal_info_serv where approval_date='"
				+ approval_date + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereTeminal_busi(String teminal_busi)
			throws Exception
	{
		sql = "select * from teminal_info_serv where teminal_busi='"
				+ teminal_busi + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereDebug_man(String debug_man)
			throws Exception
	{
		sql = "select * from teminal_info_serv where debug_man='" + debug_man
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereInst_man(String inst_man) throws Exception
	{
		sql = "select * from teminal_info_serv where inst_man='" + inst_man
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereSafe_man(String safe_man) throws Exception
	{
		sql = "select * from teminal_info_serv where safe_man='" + safe_man
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereAcco_no(String acco_no) throws Exception
	{
		sql = "select * from teminal_info_serv where acco_no='" + acco_no + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereTeminal_status(int teminal_status)
			throws Exception
	{
		sql = "select * from teminal_info_serv where teminal_status="
				+ teminal_status + "";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereInstall_date(String install_date)
			throws Exception
	{
		sql = "select * from teminal_info_serv where install_date='"
				+ install_date + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereInput_date(String input_date)
			throws Exception
	{
		sql = "select * from teminal_info_serv where input_date='" + input_date
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereInstall_comp_date(String install_comp_date)
			throws Exception
	{
		sql = "select * from teminal_info_serv where install_comp_date='"
				+ install_comp_date + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereHost_seq(String host_seq) throws Exception
	{
		sql = "select * from teminal_info_serv where host_seq='" + host_seq
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereKey_seq(String key_seq) throws Exception
	{
		sql = "select * from teminal_info_serv where key_seq='" + key_seq + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereDepo_time(String depo_time)
			throws Exception
	{
		sql = "select * from teminal_info_serv where depo_time='" + depo_time
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereInstall_end_date(String install_end_date)
			throws Exception
	{
		sql = "select * from teminal_info_serv where install_end_date='"
				+ install_end_date + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereIs_success(int is_success) throws Exception
	{
		sql = "select * from teminal_info_serv where is_success=" + is_success
				+ "";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereDemo(String demo) throws Exception
	{
		sql = "select * from teminal_info_serv where demo='" + demo + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereComm_fee(int comm_fee) throws Exception
	{
		sql = "select * from teminal_info_serv where comm_fee=" + comm_fee + "";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereComm_fee_time(String comm_fee_time)
			throws Exception
	{
		sql = "select * from teminal_info_serv where comm_fee_time='"
				+ comm_fee_time + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereServ_fee(int serv_fee) throws Exception
	{
		sql = "select * from teminal_info_serv where serv_fee=" + serv_fee + "";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereServ_fee_time(String serv_fee_time)
			throws Exception
	{
		sql = "select * from teminal_info_serv where serv_fee_time='"
				+ serv_fee_time + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereRecipet_date(String recipet_date)
			throws Exception
	{
		sql = "select * from teminal_info_serv where recipet_date='"
				+ recipet_date + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereServ_recipet_date(String serv_recipet_date)
			throws Exception
	{
		sql = "select * from teminal_info_serv where serv_recipet_date='"
				+ serv_recipet_date + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereComm_recipet_date(String comm_recipet_date)
			throws Exception
	{
		sql = "select * from teminal_info_serv where comm_recipet_date='"
				+ comm_recipet_date + "'";
		return this.select(sql);
	}

	public Teminal_info_serv whereTeminal_info_serv_id(int teminal_info_serv_id)
			throws Exception
	{
		sql = "select * from teminal_info_serv where teminal_info_serv_id="
				+ teminal_info_serv_id + "";
		return this.select(sql)[0];
	}

	public Teminal_info_serv[] whereUnit_name(String unit_name)
			throws Exception
	{
		sql = "select * from teminal_info_serv where unit_name='" + unit_name
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereUnit_attr(String unit_attr)
			throws Exception
	{
		sql = "select * from teminal_info_serv where unit_attr='" + unit_attr
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereUnit_add(String unit_add) throws Exception
	{
		sql = "select * from teminal_info_serv where unit_add='" + unit_add
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereComm_no(String comm_no) throws Exception
	{
		sql = "select * from teminal_info_serv where comm_no='" + comm_no + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereComm_name(String comm_name)
			throws Exception
	{
		sql = "select * from teminal_info_serv where comm_name='" + comm_name
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereComm_ad(String comm_ad) throws Exception
	{
		sql = "select * from teminal_info_serv where comm_ad='" + comm_ad + "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereTrade_name(String trade_name)
			throws Exception
	{
		sql = "select * from teminal_info_serv where trade_name='" + trade_name
				+ "'";
		return this.select(sql);
	}

	public Teminal_info_serv[] whereContact_name_1(String contact_name_1)
			throws Exception
	{
		sql = "select * from teminal_info_serv where contact_name_1='"
				+ contact_name_1 + "'";
		return this.select(sql);
	}
}
