package com.dodou.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.AbstractDao;
import com.dodou.inferface.AppayStatus;
import com.dodou.log.Log;
import com.dodou.table.Apppay_105;
import com.szzt.dao.ApppayTerminalDao;
import com.szzt.dao.TerminalAndTempDao;
import com.szzt.dao.Terminal_InfoDao;
import com.szzt.exception.DeleteException;
import com.szzt.exception.ForbidUpdateException;
import com.szzt.model.Temp;

public class Apppay_105Dao extends AbstractDao<Apppay_105>
{
	public static final String TABLE = "APPPAY_105";

	/**
	 * 判断商户编号是否唯一，true 唯一 false 不唯一
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public boolean sigletonTermId(String id) throws Exception
	{
		if (null == id)
		{
			return true;
		}
		String sql = "select count(*) from TERM_APP_TABLE where TERM_ID1='"
				+ id + "'";

		ResultSet set = execQuery(sql);

		boolean singleton = false;

		if (set.next())
		{
			int exists = set.getInt(1);
			singleton = (exists == 0);
		}
		set.close();
		if (!singleton)
		{
			this.release();
		}
		return singleton;
	}

	public void zhengGai(int id) throws Exception
	{
		// 查询该业务下的所有终端(非整改的信息)
		// 将该业务的状态设置为整改状态

		// 复制终端记录 设置为待调试
		// 复制中间表记录 设置为新录入状态

		// 终端新纪录状态改为待调试
		// 原始终端，中间表状态设置为整改状态

		String ters = "select TEMINAL_INFO_ID,COMMERCIAL_ID,APPPAY_ID from TERM_APP_TABLE where APPPAY_ID="
				+ id + " and STATUS!=" + TerminalAndTempDao.ZHENG_GAI;

		String appay = "update " + TABLE
				+ " set appr_status=0 where apppay_id=" + id;

		try
		{
			ResultSet rs = super.execQuery(ters);
			// 获取该业务下的所有终端，以及中间表信息
			List<Temp> list = new ArrayList<Temp>();
			while (rs.next())
			{
				Temp temp = new Temp();
				temp.setAPPPAY_ID(rs.getInt("APPPAY_ID"));
				temp.setCOMMERCIAL_ID(rs.getInt("COMMERCIAL_ID"));
				temp.setTEMINAL_INFO_ID(rs.getInt("TEMINAL_INFO_ID"));
				list.add(temp);
			}
			rs.close();

			for (Temp t : list)
			{
				// 复制终端，将终端状态改为待审批
				int newId = this.terminalNextval();
				copyTerminal(t.getTEMINAL_INFO_ID(), newId);
				// 将原始终端记录改为整改状态
				updateTerminal(t.getTEMINAL_INFO_ID());
				// 复制中间表数据，将中间表设置为启用状态
				copyTemp(t, newId);
				// 将原始中间表数据改为整改状态
				updateTemp(t);
			}
			// 将业务设置为待审批状态
			super.executeUpdate(appay);
			super.debug("-------------->业务整改成功！<-----------");

		} catch (Exception e)
		{
			try
			{
				super.rollback();
			} catch (Exception e1)
			{
				e1.printStackTrace();
			}
			throw new Exception();
		} finally
		{
			super.release();
		}

	}

	// 将中间表改为整改
	private void updateTemp(Temp temp) throws Exception
	{
		StringBuffer sql = new StringBuffer();
		sql.append("update " + ApppayTerminalDao.TABLE + " set STATUS=3 where ");
		sql.append(" COMMERCIAL_ID=" + temp.getCOMMERCIAL_ID())
				.append(" and TEMINAL_INFO_ID=" + temp.getTEMINAL_INFO_ID())
				.append(" and APPPAY_ID=" + temp.getAPPPAY_ID());
		super.executeUpdate(sql.toString());
		System.out.println("-------》更新中间表成功！《-------");
	}

	// 将原始终端状态设置为整改
	private void updateTerminal(int id) throws Exception
	{
		String sql = "update " + Terminal_InfoDao.TABLE
				+ " set TEMINAL_STATUS=" + Terminal_InfoDao.ZHENG_GAI
				+ " where TEMINAL_INFO_ID=" + id;
		super.executeUpdate(sql);
		System.out.println("-------》更新终端成功！《-------");
	}

	// 复制中间表，将中间表状态设置为启用状态
	private void copyTemp(Temp temp, int terId) throws Exception
	{
		StringBuffer sql = new StringBuffer();

		sql.append("insert into ").append(ApppayTerminalDao.TABLE)
				.append("(COMMERCIAL_ID,").append("TEMINAL_INFO_ID,")
				.append("APPTYPE,").append("APP_NAME,").append("TERM_ID1,")
				.append("TERM_ID2,").append("MENU_VER,")
				.append("APPDATA_NAME,").append("STATUS,").append("APPPAY_ID)");

		sql.append("select ").append("COMMERCIAL_ID,").append(terId + ",")
				.append("APPTYPE,").append("APP_NAME,").append("' ',")
				.append("' ',").append("MENU_VER,").append("APPDATA_NAME,")
				.append("1,").append("APPPAY_ID ").append(" from ")
				.append(ApppayTerminalDao.TABLE).append(" where ");

		sql.append(" COMMERCIAL_ID=" + temp.getCOMMERCIAL_ID())
				.append(" and TEMINAL_INFO_ID=" + temp.getTEMINAL_INFO_ID())
				.append(" and APPPAY_ID=" + temp.getAPPPAY_ID());

		super.executeUpdate(sql.toString());
		System.out.println("-------》复制中间表成功！《-------");
	}

	private int terminalNextval() throws Exception
	{
		String sql = "select TEMINAL_INFO_ID.nextval from dual";
		ResultSet set = super.execQuery(sql);
		int id = -1;
		if (set.next())
		{
			id = set.getInt(1);
		}
		set.close();
		return id;
	}

	// 复制终端
	private void copyTerminal(int id, int newId) throws Exception
	{
		StringBuffer copyTer = new StringBuffer("insert into "
				+ Terminal_InfoDao.TABLE + "(");
		copyTer.append("TEMINAL_INFO_ID,E_ID,");
		copyTer.append("UNIT_INSTALLED_MAN,");
		copyTer.append("UNIT_INSTALLED_TEL,");
		copyTer.append("UNIT_INSTALLED_CITY,");
		copyTer.append("UNIT_INSTALLED_STREET,");
		copyTer.append("UNIT_INSTALLED_ADD,");
		copyTer.append("INPUT_DATE,");
		copyTer.append("CHANGE_DATE,");
		copyTer.append("TEMINAL_PRODUCT,");
		copyTer.append("EQUI_TYPE,");
		copyTer.append("IS_OVERLAY,");
		copyTer.append("IS_HURRY,");
		copyTer.append("COMM_TYPE,");
		copyTer.append("IS_BIND,");
		copyTer.append("COMMERCIAL_ID,");
		copyTer.append("UNIT_INSTALLED_NAME,");
		copyTer.append("SERIAL1,");
		copyTer.append("INSTALLED_STATUS,");
		copyTer.append("TEMINAL_STATUS,");
		copyTer.append("COMM)");

		copyTer.append("select " + newId + ",");
		// TEMINAL_INFO_ID.nextval
		copyTer.append("E_ID,");
		copyTer.append("UNIT_INSTALLED_MAN,");
		copyTer.append("UNIT_INSTALLED_TEL,");
		copyTer.append("UNIT_INSTALLED_CITY,");
		copyTer.append("UNIT_INSTALLED_STREET,");
		copyTer.append("UNIT_INSTALLED_ADD,");
		copyTer.append("INPUT_DATE,");
		copyTer.append("CHANGE_DATE,");
		copyTer.append("TEMINAL_PRODUCT,");
		copyTer.append("EQUI_TYPE,");
		copyTer.append("IS_OVERLAY,");
		copyTer.append("IS_HURRY,");
		copyTer.append("COMM_TYPE,");
		copyTer.append("IS_BIND,");
		copyTer.append("COMMERCIAL_ID,");
		copyTer.append("UNIT_INSTALLED_NAME,");
		copyTer.append("SERIAL1,");
		copyTer.append("INSTALLED_STATUS,");
		copyTer.append("1,");
		copyTer.append("COMM from ").append(Terminal_InfoDao.TABLE)
				.append(" where TEMINAL_INFO_ID=").append(id);
		super.executeUpdate(copyTer.toString());
		System.out.println("-------》复制终端成功！《-------");
	}

	public Apppay_105[] select() throws Exception
	{
		String sql = "select * from APPPAY_105 order by APPPAY_ID desc";
		return this.select(sql);
	}

	public Apppay_105[] select(String sql) throws Exception
	{
		Apppay_105[] Apppay_105Array = new Apppay_105[getPageSize()];
		Log.getLogger().debug("Apppay_105 [查找],SQL:[" + sql + "]");
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
			Apppay_105 apppay_105 = wrapToModel(rs);
			Apppay_105Array[j++] = apppay_105;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Apppay_105Array;
	}

	private Apppay_105 wrapToModel(ResultSet rs) throws SQLException
	{
		Apppay_105 apppay_105 = new Apppay_105();
		apppay_105.setApppay_id(rs.getInt("apppay_id"));
		apppay_105.setCommercial_id(rs.getInt("commercial_id"));
		apppay_105.setApptype(rs.getString("apptype"));
		apppay_105.setAccount_type(rs.getInt("account_type"));
		apppay_105.setAccount_no(rs.getString("account_no"));
		apppay_105.setAccount_bank(rs.getString("account_bank"));
		apppay_105.setAccount_bank_brach(rs.getString("account_bank_brach"));
		apppay_105.setAccount_bank_id(rs.getString("account_bank_id"));
		apppay_105.setAccount_province(rs.getString("account_province"));
		apppay_105.setAccount_city(rs.getString("account_city"));
		apppay_105.setAccount_name(rs.getString("account_name"));
		apppay_105.setContract_type(rs.getInt("contract_type"));
		apppay_105.setContract_fee(rs.getString("contract_fee"));
		apppay_105.setEc_id(rs.getInt("ec_id"));
		apppay_105.setEc_branch(rs.getString("ec_branch"));
		apppay_105.setEc_branch_name(rs.getString("ec_branch_name"));
		apppay_105.setE_id(rs.getInt("e_id"));
		apppay_105.setAppr_man(rs.getString("appr_man"));
		apppay_105.setAppr_status(rs.getInt("appr_status"));
		apppay_105.setAppr_date(rs.getString("appr_date"));
		apppay_105.setReason(rs.getString("reason"));
		apppay_105.setAppr_remark(rs.getString("appr_remark"));
		apppay_105.setStatus(rs.getInt("status"));
		apppay_105.setCredit_flag(rs.getString("credit_flag"));
		apppay_105.setCredit_card_limit(rs.getString("credit_card_limit"));
		apppay_105.setCredit_m_a_limit(rs.getString("credit_m_a_limit"));
		apppay_105.setCredit_m_c_limit(rs.getString("credit_m_c_limit"));
		apppay_105.setDebit_card_limit(rs.getString("debit_card_limit"));
		apppay_105.setDebit_m_a_limit(rs.getString("debit_m_a_limit"));
		apppay_105.setDebit_m_c_limit(rs.getString("debit_m_c_limit"));
		apppay_105.setInput_date(rs.getString("input_date"));
		apppay_105.setChange_date(rs.getString("change_date"));
		apppay_105.setMcc(rs.getString("mcc"));
		apppay_105.setMcc18(rs.getString("mcc18"));
		apppay_105.setLq_rule(rs.getString("lq_rule"));
		apppay_105.setFee_rule1(rs.getString("fee_rule1"));
		apppay_105.setFee_rule2(rs.getString("fee_rule2"));
		apppay_105.setMarchanttype(rs.getString("marchanttype"));
		apppay_105.setFee_content(rs.getString("fee_content"));
		apppay_105.setFee_lev(rs.getString("fee_lev"));
		apppay_105.setFee_chan(rs.getString("fee_chan"));
		apppay_105.setUNIT_NO(rs.getInt("UNIT_NO"));
		apppay_105.setREMARK_INFO(rs.getString("REMARK_INFO"));

		apppay_105.setMARCHANT_NAME(rs.getString("MARCHANT_NAME"));
		apppay_105.setMARCHANT_NAME2(rs.getString("MARCHANT_NAME2"));
		
		
		apppay_105.setLC_FEE_PRE(rs.getString("LC_FEE_PRE"));
		apppay_105.setLC_FEE_TOP(rs.getString("LC_FEE_TOP"));
		apppay_105.setOUT_FEE_PRE(rs.getString("OUT_FEE_PRE"));
		apppay_105.setOUT_FEE_TOP(rs.getString("OUT_FEE_TOP"));

		return apppay_105;
	}

	public Apppay_105[] select(Apppay_105 apppay_105) throws Exception
	{
		String sql = "select * from APPPAY_105 where 1 = 1 ";
		if (apppay_105.getApppay_id() != 0)
		{
			sql += " and apppay_id = " + apppay_105.getApppay_id() + "";
		}
		if (apppay_105.getCommercial_id() != 0)
		{
			sql += " and commercial_id = " + apppay_105.getCommercial_id() + "";
		}
		if (apppay_105.getApptype() != null)
		{
			sql += " and apptype = '" + apppay_105.getApptype() + "'";
		}
		if (apppay_105.getAccount_type() != 0)
		{
			sql += " and account_type = " + apppay_105.getAccount_type() + "";
		}
		if (apppay_105.getAccount_no() != null)
		{
			sql += " and account_no = '" + apppay_105.getAccount_no() + "'";
		}
		if (apppay_105.getAccount_bank() != null)
		{
			sql += " and account_bank = '" + apppay_105.getAccount_bank() + "'";
		}
		if (apppay_105.getAccount_bank_brach() != null)
		{
			sql += " and account_bank_brach = '"
					+ apppay_105.getAccount_bank_brach() + "'";
		}
		if (apppay_105.getAccount_bank_id() != null)
		{
			sql += " and account_bank_id = '" + apppay_105.getAccount_bank_id()
					+ "'";
		}
		if (apppay_105.getAccount_province() != null)
		{
			sql += " and account_province = '"
					+ apppay_105.getAccount_province() + "'";
		}
		if (apppay_105.getAccount_city() != null)
		{
			sql += " and account_city = '" + apppay_105.getAccount_city() + "'";
		}
		if (apppay_105.getAccount_name() != null)
		{
			sql += " and account_name = '" + apppay_105.getAccount_name() + "'";
		}
		if (apppay_105.getContract_type() != 0)
		{
			sql += " and contract_type = " + apppay_105.getContract_type() + "";
		}
		if (apppay_105.getContract_fee() != null)
		{
			sql += " and contract_fee = " + apppay_105.getContract_fee() + "";
		}
		if (apppay_105.getEc_id() != 0)
		{
			sql += " and ec_id = " + apppay_105.getEc_id() + "";
		}
		if (apppay_105.getEc_branch() != null)
		{
			sql += " and ec_branch = '" + apppay_105.getEc_branch() + "'";
		}
		if (apppay_105.getEc_branch_name() != null)
		{
			sql += " and ec_branch_name = '" + apppay_105.getEc_branch_name()
					+ "'";
		}
		if (apppay_105.getE_id() != 0)
		{
			sql += " and e_id = " + apppay_105.getE_id() + "";
		}
		if (apppay_105.getAppr_man() != null)
		{
			sql += " and appr_man = '" + apppay_105.getAppr_man() + "'";
		}
		if (apppay_105.getAppr_status() != 0)
		{
			sql += " and appr_status = " + apppay_105.getAppr_status() + "";
		}
		if (apppay_105.getAppr_date() != null)
		{
			sql += " and appr_date = to_date('" + apppay_105.getAppr_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (apppay_105.getReason() != null)
		{
			sql += " and reason = '" + apppay_105.getReason() + "'";
		}
		if (apppay_105.getAppr_remark() != null)
		{
			sql += " and appr_remark = '" + apppay_105.getAppr_remark() + "'";
		}
		if (apppay_105.getStatus() != 0)
		{
			sql += " and status = " + apppay_105.getStatus() + "";
		}
		if (apppay_105.getCredit_flag() != null)
		{
			sql += " and credit_flag = '" + apppay_105.getCredit_flag() + "'";
		}
		if (apppay_105.getCredit_card_limit() != null)
		{
			sql += " and credit_card_limit = '"
					+ apppay_105.getCredit_card_limit() + "'";
		}
		if (apppay_105.getCredit_m_a_limit() != null)
		{
			sql += " and credit_m_a_limit = '"
					+ apppay_105.getCredit_m_a_limit() + "'";
		}
		if (apppay_105.getCredit_m_c_limit() != null)
		{
			sql += " and credit_m_c_limit = '"
					+ apppay_105.getCredit_m_c_limit() + "'";
		}
		if (apppay_105.getDebit_card_limit() != null)
		{
			sql += " and debit_card_limit = '"
					+ apppay_105.getDebit_card_limit() + "'";
		}
		if (apppay_105.getDebit_m_a_limit() != null)
		{
			sql += " and debit_m_a_limit = '" + apppay_105.getDebit_m_a_limit()
					+ "'";
		}
		if (apppay_105.getDebit_m_c_limit() != null)
		{
			sql += " and debit_m_c_limit = '" + apppay_105.getDebit_m_c_limit()
					+ "'";
		}
		if (apppay_105.getInput_date() != null)
		{
			sql += " and input_date = to_date('" + apppay_105.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (apppay_105.getChange_date() != null)
		{
			sql += " and change_date = to_date('" + apppay_105.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (apppay_105.getMcc() != null)
		{
			sql += " and mcc = '" + apppay_105.getMcc() + "'";
		}
		if (apppay_105.getMcc18() != null)
		{
			sql += " and mcc18 = '" + apppay_105.getMcc18() + "'";
		}
		if (apppay_105.getLq_rule() != null)
		{
			sql += " and lq_rule = '" + apppay_105.getLq_rule() + "'";
		}
		if (apppay_105.getFee_rule1() != null)
		{
			sql += " and fee_rule1 = '" + apppay_105.getFee_rule1() + "'";
		}
		if (apppay_105.getFee_rule2() != null)
		{
			sql += " and fee_rule2 = '" + apppay_105.getFee_rule2() + "'";
		}
		if (apppay_105.getMarchanttype() != null)
		{
			sql += " and marchanttype = '" + apppay_105.getMarchanttype() + "'";
		}
		if (apppay_105.getFee_content() != null)
		{
			sql += " and fee_content = '" + apppay_105.getFee_content() + "'";
		}
		if (apppay_105.getFee_lev() != null)
		{
			sql += " and fee_lev = '" + apppay_105.getFee_lev() + "'";
		}
		if (apppay_105.getFee_chan() != null)
		{
			sql += " and fee_chan = '" + apppay_105.getFee_chan() + "'";
		}
		sql += " order by APPPAY_ID desc";
		return this.select(sql);
	}

	public int insert(Apppay_105 apppay_105) throws Exception
	{
		String sql = "insert into APPPAY_105 ";
		String fields = "APPPAY_ID";
		String values = "APPPAY_105_ID_SEQ.nextval";

		fields += ",MARCHANT_NAME";
		values += ",'" + apppay_105.getMARCHANT_NAME() + "'";

		fields += ",MARCHANT_NAME2";
		values += ",'" + apppay_105.getMARCHANT_NAME() + "'";

		if (apppay_105.getCommercial_id() != 0)
		{
			fields += ",commercial_id";
			values += "," + apppay_105.getCommercial_id() + "";
		}
		if (apppay_105.getApptype() != null)
		{
			fields += ",apptype";
			values += ",'" + apppay_105.getApptype() + "'";
		}
		
		if (apppay_105.getLC_FEE_PRE() != null)
		{
			fields += ",LC_FEE_PRE";
			values += ",'" + apppay_105.getLC_FEE_PRE() + "'";
		}
		
		if (apppay_105.getLC_FEE_TOP() != null)
		{
			fields += ",LC_FEE_TOP";
			values += ",'" + apppay_105.getLC_FEE_TOP() + "'";
		}
		
		if (apppay_105.getOUT_FEE_TOP() != null)
		{
			fields += ",OUT_FEE_TOP";
			values += ",'" + apppay_105.getOUT_FEE_TOP() + "'";
		}
		
		if (apppay_105.getOUT_FEE_PRE() != null)
		{
			fields += ",OUT_FEE_PRE";
			values += ",'" + apppay_105.getOUT_FEE_PRE() + "'";
		}
		
		if (apppay_105.getAccount_type() != 0)
		{
			fields += ",account_type";
			values += "," + apppay_105.getAccount_type() + "";
		}
		if (apppay_105.getAccount_no() != null)
		{
			fields += ",account_no";
			values += ",'" + apppay_105.getAccount_no() + "'";
		}
		if (apppay_105.getAccount_bank() != null)
		{
			fields += ",account_bank";
			values += ",'" + apppay_105.getAccount_bank() + "'";
		}
		if (apppay_105.getAccount_bank_brach() != null)
		{
			fields += ",account_bank_brach";
			values += ",'" + apppay_105.getAccount_bank_brach() + "'";
		}
		if (apppay_105.getAccount_bank_id() != null)
		{
			fields += ",account_bank_id";
			values += ",'" + apppay_105.getAccount_bank_id() + "'";
		}
		if (apppay_105.getAccount_province() != null)
		{
			fields += ",account_province";
			values += ",'" + apppay_105.getAccount_province() + "'";
		}
		if (apppay_105.getAccount_city() != null)
		{
			fields += ",account_city";
			values += ",'" + apppay_105.getAccount_city() + "'";
		}
		if (apppay_105.getAccount_name() != null)
		{
			fields += ",account_name";
			values += ",'" + apppay_105.getAccount_name() + "'";
		}
		if (apppay_105.getContract_type() != 0)
		{
			fields += ",contract_type";
			values += "," + apppay_105.getContract_type() + "";
		}
		if (apppay_105.getContract_fee() != null)
		{
			fields += ",contract_fee";
			values += ",'" + apppay_105.getContract_fee() + "'";
		}
		if (apppay_105.getREMARK_INFO() != null)
		{
			fields += ",REMARK_INFO";
			values += ",'" + apppay_105.getREMARK_INFO() + "'";
		}
		if (apppay_105.getEc_id() != 0)
		{
			fields += ",ec_id";
			values += "," + apppay_105.getEc_id() + "";
		}
		if (apppay_105.getEc_branch() != null)
		{
			fields += ",ec_branch";
			values += ",'" + apppay_105.getEc_branch() + "'";
		}
		if (apppay_105.getEc_branch_name() != null)
		{
			fields += ",ec_branch_name";
			values += ",'" + apppay_105.getEc_branch_name() + "'";
		}
		if (apppay_105.getE_id() != 0)
		{
			fields += ",e_id";
			values += "," + apppay_105.getE_id() + "";
		}
		if (apppay_105.getAppr_man() != null)
		{
			fields += ",appr_man";
			values += ",'" + apppay_105.getAppr_man() + "'";
		}

		fields += ",appr_status";
		values += "," + 0 + "";

		// fields += ",appr_date";
		// values += ",to_date(sysdate,'yyyy-MM-dd hh24:mi:ss')";

		if (apppay_105.getReason() != null)
		{
			fields += ",reason";
			values += ",'" + apppay_105.getReason() + "'";
		}
		if (apppay_105.getAppr_remark() != null)
		{
			fields += ",appr_remark";
			values += ",'" + apppay_105.getAppr_remark() + "'";
		}
		if (apppay_105.getStatus() != 0)
		{
			fields += ",status";
			values += "," + apppay_105.getStatus() + "";
		}
		if (apppay_105.getCredit_flag() != null)
		{
			fields += ",credit_flag";
			values += ",'" + apppay_105.getCredit_flag() + "'";
		}
		if (apppay_105.getCredit_card_limit() != null)
		{
			fields += ",credit_card_limit";
			values += ",'" + apppay_105.getCredit_card_limit() + "'";
		}
		if (apppay_105.getCredit_m_a_limit() != null)
		{
			fields += ",credit_m_a_limit";
			values += ",'" + apppay_105.getCredit_m_a_limit() + "'";
		}
		if (apppay_105.getCredit_m_c_limit() != null)
		{
			fields += ",credit_m_c_limit";
			values += ",'" + apppay_105.getCredit_m_c_limit() + "'";
		}
		if (apppay_105.getDebit_card_limit() != null)
		{
			fields += ",debit_card_limit";
			values += ",'" + apppay_105.getDebit_card_limit() + "'";
		}
		if (apppay_105.getDebit_m_a_limit() != null)
		{
			fields += ",debit_m_a_limit";
			values += ",'" + apppay_105.getDebit_m_a_limit() + "'";
		}
		if (apppay_105.getDebit_m_c_limit() != null)
		{
			fields += ",debit_m_c_limit";
			values += ",'" + apppay_105.getDebit_m_c_limit() + "'";
		}

		fields += ",input_date";
		values += ",sysdate";

		fields += ",change_date";
		values += ",sysdate";

		if (apppay_105.getMcc() != null)
		{
			fields += ",mcc";
			values += ",'" + apppay_105.getMcc() + "'";
		}
		if (apppay_105.getMcc18() != null)
		{
			fields += ",mcc18";
			values += ",'" + apppay_105.getMcc18() + "'";
		}
		if (apppay_105.getLq_rule() != null)
		{
			fields += ",lq_rule";
			values += ",'" + apppay_105.getLq_rule() + "'";
		}
		if (apppay_105.getFee_rule1() != null)
		{
			fields += ",fee_rule1";
			values += ",'" + apppay_105.getFee_rule1() + "'";
		}
		if (apppay_105.getFee_rule2() != null)
		{
			fields += ",fee_rule2";
			values += ",'" + apppay_105.getFee_rule2() + "'";
		}
		if (apppay_105.getMarchanttype() != null)
		{
			fields += ",marchanttype";
			values += ",'" + apppay_105.getMarchanttype() + "'";
		}
		if (apppay_105.getFee_content() != null)
		{
			fields += ",fee_content";
			values += ",'" + apppay_105.getFee_content() + "'";
		}
		if (apppay_105.getFee_lev() != null)
		{
			fields += ",fee_lev";
			values += ",'" + apppay_105.getFee_lev() + "'";
		}
		if (apppay_105.getFee_chan() != null)
		{
			fields += ",fee_chan";
			values += ",'" + apppay_105.getFee_chan() + "'";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Apppay_105 [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
		return -1;
	}

	public void update(Apppay_105 apppay_105) throws Exception
	{
		String sql = "update APPPAY_105 set APPPAY_ID=APPPAY_ID";

		int status = super.loadAppayStatus("APPPAY_105",
				apppay_105.getApppay_id());

		switch (status)
		{
		// 新增终端审批中 账号信息修改中禁止更新
		case AppayStatus.APPAY_UPDATE:
		case AppayStatus.NEW_TER:
			throw new ForbidUpdateException();
			// 新增业务 驳回业务可以修改全部
		case AppayStatus.NOT_ALLOW:
			sql += ",appr_status=" + AppayStatus.INPUT;
			break;
		case AppayStatus.NEW_TER_NOT_ALLOW:
			sql += ",appr_status=" + AppayStatus.NEW_TER;
			break;
		case AppayStatus.APPAY_UPDATE_NOW_ALLOW:
			sql += ",appr_status=" + AppayStatus.APPAY_UPDATE;
			break;			
		case AppayStatus.INPUT:

			break;
		// 已审批状态只能修改部分信息--- 账户、帐号、支付行号、扣率、账户所在省
		case AppayStatus.ALLOW:
			super.initLogService();
			Apppay_105 info = this.findById(apppay_105.getApppay_id());

			// 账户账号
			if (apppay_105.getAccount_no() != null)
			{
				sql += ",account_no='" + apppay_105.getAccount_no() + "'";
				logService.appendDirty(info.getAccount_no(),
						apppay_105.getAccount_no(), "账户账号");
			}
			// 账户支行号
			if (apppay_105.getAccount_bank_id() != null)
			{
				sql += ",account_bank_id='" + apppay_105.getAccount_bank_id()
						+ "'";
				logService.appendDirty(info.getAccount_bank_id(),
						apppay_105.getAccount_bank_id(), "账户支行号");
			}

			// 签约回扣率
			if (apppay_105.getContract_fee() != null)
			{
				sql += ",contract_fee='" + apppay_105.getContract_fee() + "'";
				logService.appendDirty(info.getContract_fee(),
						apppay_105.getContract_fee(), "签约回扣率");
			}

			sql += ",contract_type=" + apppay_105.getContract_type() + "";
			logService.appendFeeType(info.getContract_type() + "",
					apppay_105.getContract_type() + "");

			sql += ",appr_status=" + AppayStatus.APPAY_UPDATE + "";

			// 第一次测试后修改
			if (apppay_105.getAccount_type() != 0)
			{
				sql += ",account_type=" + apppay_105.getAccount_type() + "";
				logService.appendAccountType(info.getAccount_type(),
						apppay_105.getAccount_type());
			}
			if (apppay_105.getAccount_bank() != null)
			{
				sql += ",account_bank='" + apppay_105.getAccount_bank() + "'";
				logService.appendAccountBank(info.getAccount_bank(),
						apppay_105.getAccount_bank());
			}
			// sql.append("BASE=").append(data.getBASE()).append(",");
			// sql.append("TOP=").append(data.getTOP()).append(",");

			// sql.append("CHARGE_CYCLE=").append(data.getCHARGE_CYCLE())
			// .append(",");

			// 市
			if (apppay_105.getAccount_city() != null)
			{
				sql += ",account_city='" + apppay_105.getAccount_city() + "'";
				logService.appendCity(info.getAccount_city(),
						apppay_105.getAccount_city());
			}

			if (apppay_105.getMARCHANT_NAME() != null)
			{
				sql += ",MARCHANT_NAME='" + apppay_105.getMARCHANT_NAME() + "'";
				logService.appendDirty(info.getMARCHANT_NAME(),
						apppay_105.getMARCHANT_NAME(), "门店名称");
			}
			if (apppay_105.getAccount_bank_brach() != null)
			{
				sql += ",account_bank_brach='"
						+ apppay_105.getAccount_bank_brach() + "'";

				logService.appendDirty(info.getAccount_bank_brach(),
						apppay_105.getAccount_bank_brach(), "账户支行号");
			}
			if (apppay_105.getAccount_name() != null)
			{
				sql += ",account_name='" + apppay_105.getAccount_name() + "'";
				logService.appendDirty(info.getAccount_name(),
						apppay_105.getAccount_name(), "账户户名");
			}

			sql += ",change_date=sysdate";

			if (apppay_105.getAccount_province() != null)
			{
				sql += ",account_province='" + apppay_105.getAccount_province()
						+ "'";
			}
			sql += " where APPPAY_ID=" + apppay_105.getApppay_id() + "";

			super.executeUpdate(logService.insertLog(TABLE, super.getWho(),
					info.getApppay_id(), 105));
			super.executeUpdate(sql.toString());
			return;
		}
		if (apppay_105.getREMARK_INFO() != null)
		{
			sql += ",REMARK_INFO='" + apppay_105.getREMARK_INFO() + "'";
		}
		if (apppay_105.getCommercial_id() != 0)
		{
			sql += ",commercial_id=" + apppay_105.getCommercial_id() + "";
		}
		if (apppay_105.getApptype() != null)
		{
			sql += ",apptype='" + apppay_105.getApptype() + "'";
		}
		if (apppay_105.getAccount_type() != 0)
		{
			sql += ",account_type=" + apppay_105.getAccount_type() + "";
		}
		if (apppay_105.getAccount_no() != null)
		{
			sql += ",account_no='" + apppay_105.getAccount_no() + "'";
		}
		if (apppay_105.getAccount_bank() != null)
		{
			sql += ",account_bank='" + apppay_105.getAccount_bank() + "'";
		}
		if (apppay_105.getAccount_bank_brach() != null)
		{
			sql += ",account_bank_brach='" + apppay_105.getAccount_bank_brach()
					+ "'";
		}
		if (apppay_105.getAccount_bank_id() != null)
		{
			sql += ",account_bank_id='" + apppay_105.getAccount_bank_id() + "'";
		}
		if (apppay_105.getAccount_province() != null)
		{
			sql += ",account_province='" + apppay_105.getAccount_province()
					+ "'";
		}
		if (apppay_105.getAccount_city() != null)
		{
			sql += ",account_city='" + apppay_105.getAccount_city() + "'";
		}
		if (apppay_105.getAccount_name() != null)
		{
			sql += ",account_name='" + apppay_105.getAccount_name() + "'";
		}
		if (apppay_105.getContract_type() != 0)
		{
			sql += ",contract_type=" + apppay_105.getContract_type() + "";
		}
		if (apppay_105.getContract_fee() != null)
		{
			sql += ",contract_fee='" + apppay_105.getContract_fee() + "'";
		}
		if (apppay_105.getEc_id() != 0)
		{
			sql += ",ec_id=" + apppay_105.getEc_id() + "";
		}
		if (apppay_105.getEc_branch() != null)
		{
			sql += ",ec_branch='" + apppay_105.getEc_branch() + "'";
		}
		if (apppay_105.getEc_branch_name() != null)
		{
			sql += ",ec_branch_name='" + apppay_105.getEc_branch_name() + "'";
		}
		if (apppay_105.getE_id() != 0)
		{
			sql += ",e_id=" + apppay_105.getE_id() + "";
		}
		if (apppay_105.getAppr_man() != null)
		{
			sql += ",appr_man='" + apppay_105.getAppr_man() + "'";
		}
		if (apppay_105.getAppr_status() != 0)
		{
			sql += ",appr_status=" + apppay_105.getAppr_status() + "";
		}
		if (apppay_105.getAppr_date() != null)
		{
			sql += ",appr_date=to_date('" + apppay_105.getAppr_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (apppay_105.getReason() != null)
		{
			sql += ",reason='" + apppay_105.getReason() + "'";
		}
		if (apppay_105.getAppr_remark() != null)
		{
			sql += ",appr_remark='" + apppay_105.getAppr_remark() + "'";
		}
		if (apppay_105.getStatus() != 0)
		{
			sql += ",status=" + apppay_105.getStatus() + "";
		}
		if (apppay_105.getCredit_flag() != null)
		{
			sql += ",credit_flag='" + apppay_105.getCredit_flag() + "'";
		}
		if (apppay_105.getCredit_card_limit() != null)
		{
			sql += ",credit_card_limit='" + apppay_105.getCredit_card_limit()
					+ "'";
		}
		if (apppay_105.getCredit_m_a_limit() != null)
		{
			sql += ",credit_m_a_limit='" + apppay_105.getCredit_m_a_limit()
					+ "'";
		}
		if (apppay_105.getCredit_m_c_limit() != null)
		{
			sql += ",credit_m_c_limit='" + apppay_105.getCredit_m_c_limit()
					+ "'";
		}
		if (apppay_105.getDebit_card_limit() != null)
		{
			sql += ",debit_card_limit='" + apppay_105.getDebit_card_limit()
					+ "'";
		}
		if (apppay_105.getDebit_m_a_limit() != null)
		{
			sql += ",debit_m_a_limit='" + apppay_105.getDebit_m_a_limit() + "'";
		}
		if (apppay_105.getDebit_m_c_limit() != null)
		{
			sql += ",debit_m_c_limit='" + apppay_105.getDebit_m_c_limit() + "'";
		}
		if (apppay_105.getInput_date() != null)
		{
			sql += ",input_date=to_date('" + apppay_105.getInput_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (apppay_105.getChange_date() != null)
		{
			sql += ",change_date=to_date('" + apppay_105.getChange_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (apppay_105.getMcc() != null)
		{
			sql += ",mcc='" + apppay_105.getMcc() + "'";
		}
		if (apppay_105.getMcc18() != null)
		{
			sql += ",mcc18='" + apppay_105.getMcc18() + "'";
		}
		if (apppay_105.getLq_rule() != null)
		{
			sql += ",lq_rule='" + apppay_105.getLq_rule() + "'";
		}
		if (apppay_105.getFee_rule1() != null)
		{
			sql += ",fee_rule1='" + apppay_105.getFee_rule1() + "'";
		}
		if (apppay_105.getFee_rule2() != null)
		{
			sql += ",fee_rule2='" + apppay_105.getFee_rule2() + "'";
		}

		if (apppay_105.getOUT_FEE_PRE() != null)
		{
			sql += ",OUT_FEE_PRE='" + apppay_105.getOUT_FEE_PRE() + "'";
		}
		if (apppay_105.getOUT_FEE_TOP() != null)
		{
			sql += ",OUT_FEE_TOP='" + apppay_105.getOUT_FEE_TOP() + "'";
		}
		if (apppay_105.getLC_FEE_TOP() != null)
		{
			sql += ",LC_FEE_TOP='" + apppay_105.getLC_FEE_TOP() + "'";
		}
		if (apppay_105.getLC_FEE_PRE() != null)
		{
			sql += ",LC_FEE_PRE='" + apppay_105.getLC_FEE_PRE() + "'";
		}
		
		if (apppay_105.getMarchanttype() != null)
		{
			sql += ",marchanttype='" + apppay_105.getMarchanttype() + "'";
		}
		if (apppay_105.getFee_content() != null)
		{
			sql += ",fee_content='" + apppay_105.getFee_content() + "'";
		}
		if (apppay_105.getFee_lev() != null)
		{
			sql += ",fee_lev='" + apppay_105.getFee_lev() + "'";
		}
		if (apppay_105.getFee_chan() != null)
		{
			sql += ",fee_chan='" + apppay_105.getFee_chan() + "'";
		}
		sql += " where APPPAY_ID=" + apppay_105.getApppay_id() + "";
		Log.getLogger().debug("Apppay_105 [更新],SQL:[" + sql + "]");
		System.out.println(sql+"===");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		// String sql = "delete from APPPAY_105 where APPPAY_ID=" + id;
		// Log.getLogger().debug("Apppay_105 [删除],SQL:[" + sql + "]");
		// DatabaseAccess dba = new DatabaseAccess();
		// dba.executeUpdate(sql);
		// dba.release();

		if (super.loadAppayStatus(TABLE, id) < 2)
		{
			String delTemp = "delete from TERM_APP_TABLE where APPPAY_ID=" + id;
			String delApp01 = "delete from APPPAY_105 where APPPAY_ID=" + id;
			DatabaseAccess dba = null;
			try
			{
				dba = super.executeUpdate(delApp01);
				int temp = dba.executeUpdate(delTemp);
				super.debug("------->Apppay105删除<---------");
				super.debug("删除中间表个数--》" + temp);
				super.debug("------->Apppay105删除成功<---------");
			} catch (Exception e)
			{
				if (null != dba)
					dba.rollback();
				e.printStackTrace();
			}
		} else
			throw new DeleteException();
	}

	public DatabaseAccess executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug("Apppay_105 [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
		return null;
	}

	public Apppay_105 whereApppay_id(int apppay_id) throws Exception
	{
		String sql = "select * from apppay_105 where apppay_id=" + apppay_id
				+ "";
		return this.select(sql)[0];
	}

	public Apppay_105[] whereCommercial_id(int commercial_id) throws Exception
	{
		String sql = "select * from apppay_105 where commercial_id="
				+ commercial_id + "";
		return this.select(sql);
	}

	public Apppay_105[] whereApptype(String apptype) throws Exception
	{
		String sql = "select * from apppay_105 where apptype='" + apptype + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereAccount_type(int account_type) throws Exception
	{
		String sql = "select * from apppay_105 where account_type="
				+ account_type + "";
		return this.select(sql);
	}

	public Apppay_105[] whereAccount_no(String account_no) throws Exception
	{
		String sql = "select * from apppay_105 where account_no='" + account_no
				+ "'";
		return this.select(sql);
	}

	public Apppay_105[] whereAccount_bank(String account_bank) throws Exception
	{
		String sql = "select * from apppay_105 where account_bank='"
				+ account_bank + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereAccount_bank_brach(String account_bank_brach)
			throws Exception
	{
		String sql = "select * from apppay_105 where account_bank_brach='"
				+ account_bank_brach + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereAccount_bank_id(String account_bank_id)
			throws Exception
	{
		String sql = "select * from apppay_105 where account_bank_id='"
				+ account_bank_id + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereAccount_province(String account_province)
			throws Exception
	{
		String sql = "select * from apppay_105 where account_province='"
				+ account_province + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereAccount_city(String account_city) throws Exception
	{
		String sql = "select * from apppay_105 where account_city='"
				+ account_city + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereAccount_name(String account_name) throws Exception
	{
		String sql = "select * from apppay_105 where account_name='"
				+ account_name + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereContract_type(int contract_type) throws Exception
	{
		String sql = "select * from apppay_105 where contract_type="
				+ contract_type + "";
		return this.select(sql);
	}

	public Apppay_105[] whereContract_fee(int contract_fee) throws Exception
	{
		String sql = "select * from apppay_105 where contract_fee="
				+ contract_fee + "";
		return this.select(sql);
	}

	public Apppay_105[] whereEc_id(int ec_id) throws Exception
	{
		String sql = "select * from apppay_105 where ec_id=" + ec_id + "";
		return this.select(sql);
	}

	public Apppay_105[] whereEc_branch(String ec_branch) throws Exception
	{
		String sql = "select * from apppay_105 where ec_branch='" + ec_branch
				+ "'";
		return this.select(sql);
	}

	public Apppay_105[] whereEc_branch_name(String ec_branch_name)
			throws Exception
	{
		String sql = "select * from apppay_105 where ec_branch_name='"
				+ ec_branch_name + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereE_id(int e_id) throws Exception
	{
		String sql = "select * from apppay_105 where e_id=" + e_id + "";
		return this.select(sql);
	}

	public Apppay_105[] whereAppr_man(String appr_man) throws Exception
	{
		String sql = "select * from apppay_105 where appr_man='" + appr_man
				+ "'";
		return this.select(sql);
	}

	public Apppay_105[] whereAppr_status(int appr_status) throws Exception
	{
		String sql = "select * from apppay_105 where appr_status="
				+ appr_status + "";
		return this.select(sql);
	}

	public Apppay_105[] whereAppr_date(String appr_date) throws Exception
	{
		String sql = "select * from apppay_105 where appr_date='" + appr_date
				+ "'";
		return this.select(sql);
	}

	public Apppay_105[] whereReason(String reason) throws Exception
	{
		String sql = "select * from apppay_105 where reason='" + reason + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereAppr_remark(String appr_remark) throws Exception
	{
		String sql = "select * from apppay_105 where appr_remark='"
				+ appr_remark + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereStatus(int status) throws Exception
	{
		String sql = "select * from apppay_105 where status=" + status + "";
		return this.select(sql);
	}

	public Apppay_105[] whereCredit_flag(String credit_flag) throws Exception
	{
		String sql = "select * from apppay_105 where credit_flag='"
				+ credit_flag + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereCredit_card_limit(String credit_card_limit)
			throws Exception
	{
		String sql = "select * from apppay_105 where credit_card_limit='"
				+ credit_card_limit + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereCredit_m_a_limit(String credit_m_a_limit)
			throws Exception
	{
		String sql = "select * from apppay_105 where credit_m_a_limit='"
				+ credit_m_a_limit + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereCredit_m_c_limit(String credit_m_c_limit)
			throws Exception
	{
		String sql = "select * from apppay_105 where credit_m_c_limit='"
				+ credit_m_c_limit + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereDebit_card_limit(String debit_card_limit)
			throws Exception
	{
		String sql = "select * from apppay_105 where debit_card_limit='"
				+ debit_card_limit + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereDebit_m_a_limit(String debit_m_a_limit)
			throws Exception
	{
		String sql = "select * from apppay_105 where debit_m_a_limit='"
				+ debit_m_a_limit + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereDebit_m_c_limit(String debit_m_c_limit)
			throws Exception
	{
		String sql = "select * from apppay_105 where debit_m_c_limit='"
				+ debit_m_c_limit + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereInput_date(String input_date) throws Exception
	{
		String sql = "select * from apppay_105 where input_date='" + input_date
				+ "'";
		return this.select(sql);
	}

	public Apppay_105[] whereChange_date(String change_date) throws Exception
	{
		String sql = "select * from apppay_105 where change_date='"
				+ change_date + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereMcc(String mcc) throws Exception
	{
		String sql = "select * from apppay_105 where mcc='" + mcc + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereMcc18(String mcc18) throws Exception
	{
		String sql = "select * from apppay_105 where mcc18='" + mcc18 + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereLq_rule(String lq_rule) throws Exception
	{
		String sql = "select * from apppay_105 where lq_rule='" + lq_rule + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereFee_rule1(String fee_rule1) throws Exception
	{
		String sql = "select * from apppay_105 where fee_rule1='" + fee_rule1
				+ "'";
		return this.select(sql);
	}

	public Apppay_105[] whereFee_rule2(String fee_rule2) throws Exception
	{
		String sql = "select * from apppay_105 where fee_rule2='" + fee_rule2
				+ "'";
		return this.select(sql);
	}

	public Apppay_105[] whereMarchanttype(String marchanttype) throws Exception
	{
		String sql = "select * from apppay_105 where marchanttype='"
				+ marchanttype + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereFee_content(String fee_content) throws Exception
	{
		String sql = "select * from apppay_105 where fee_content='"
				+ fee_content + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereFee_lev(String fee_lev) throws Exception
	{
		String sql = "select * from apppay_105 where fee_lev='" + fee_lev + "'";
		return this.select(sql);
	}

	public Apppay_105[] whereFee_chan(String fee_chan) throws Exception
	{
		String sql = "select * from apppay_105 where fee_chan='" + fee_chan
				+ "'";
		return this.select(sql);
	}

	@Override
	public void operate(Apppay_105 apppay_105) throws Exception
	{
		String sql = "update APPPAY_105 set APPPAY_ID=APPPAY_ID";
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		if (null != apppay_105.getAppr_remark()
				&& apppay_105.getAppr_remark().trim().length() > 0
				&& (1 == apppay_105.getAppr_status() || 5 == apppay_105.getAppr_status() || 6 == apppay_105.getAppr_status()))
		{
			sql += ", APPR_REMARK=" + "concat(APPR_REMARK,'\n"
					+ format.format(new Date(System.currentTimeMillis()))
					+ "->" + apppay_105.getAppr_remark() + "')";
		}

		if (apppay_105.getMARCHANT_NAME2() != null)
		{
			sql += ",MARCHANT_NAME2='" + apppay_105.getMARCHANT_NAME2() + "'";
		}
		/**********************************/
		if (apppay_105.getOUT_FEE_PRE() != null)
		{
			sql += ",OUT_FEE_PRE='" + apppay_105.getOUT_FEE_PRE() + "'";
		}
		if (apppay_105.getOUT_FEE_TOP() != null)
		{
			sql += ",OUT_FEE_TOP='" + apppay_105.getOUT_FEE_TOP() + "'";
		}
		if (apppay_105.getLC_FEE_TOP() != null)
		{
			sql += ",LC_FEE_TOP='" + apppay_105.getLC_FEE_TOP() + "'";
		}
		if (apppay_105.getLC_FEE_PRE() != null)
		{
			sql += ",LC_FEE_PRE='" + apppay_105.getLC_FEE_PRE() + "'";
		}
		/**********************************/
		
		if (apppay_105.getMcc() != null)
		{
			sql += ",mcc='" + apppay_105.getMcc() + "'";
		}
		
		if (apppay_105.getMcc18() != null)
		{
			sql += ",mcc18='" + apppay_105.getMcc18() + "'";
		}
		if (apppay_105.getLq_rule() != null)
		{
			sql += ",lq_rule='" + apppay_105.getLq_rule() + "'";
		}
		if (apppay_105.getFee_rule1() != null)
		{
			sql += ",fee_rule1='" + apppay_105.getFee_rule1() + "'";
		}
		if (apppay_105.getFee_rule2() != null)
		{
			sql += ",fee_rule2='" + apppay_105.getFee_rule2() + "'";
		}
		if (apppay_105.getMarchanttype() != null)
		{
			sql += ",marchanttype='" + apppay_105.getMarchanttype() + "'";
		}
		if (apppay_105.getFee_content() != null)
		{
			sql += ",fee_content='" + apppay_105.getFee_content() + "'";
		}
		if (apppay_105.getFee_lev() != null)
		{
			sql += ",fee_lev='" + apppay_105.getFee_lev() + "'";
		}
		if (apppay_105.getFee_chan() != null)
		{
			sql += ",fee_chan='" + apppay_105.getFee_chan() + "'";
		}

		if (apppay_105.getCredit_flag() != null)
		{
			sql += ",credit_flag='" + apppay_105.getCredit_flag() + "'";
		}

		if (apppay_105.getCredit_card_limit() != null)
		{
			sql += ",credit_card_limit='" + apppay_105.getCredit_card_limit()
					+ "'";

		}
		if (apppay_105.getCredit_m_a_limit() != null)
		{
			sql += ",credit_m_a_limit='" + apppay_105.getCredit_m_a_limit()
					+ "'";
		}
		if (apppay_105.getCredit_m_c_limit() != null)
		{
			sql += ",credit_m_c_limit='" + apppay_105.getCredit_m_c_limit()
					+ "'";
		}
		if (apppay_105.getDebit_card_limit() != null)
		{
			sql += ",debit_card_limit='" + apppay_105.getDebit_card_limit()
					+ "'";
		}
		if (apppay_105.getDebit_m_a_limit() != null)
		{
			sql += ",debit_m_a_limit='" + apppay_105.getDebit_m_a_limit() + "'";
		}
		if (apppay_105.getDebit_m_c_limit() != null)
		{
			sql += ",debit_m_c_limit='" + apppay_105.getDebit_m_c_limit() + "'";
		}

		int status = super.loadAppayStatus(TABLE, apppay_105.getApppay_id());

		// 待审和驳回审批时修改审批时间
		if (status == 0 || status == 1)
		{
			sql += " ,appr_date = to_date('" + apppay_105.getAppr_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}

		sql += ",appr_status=" + apppay_105.getAppr_status() + "";

		// 审批人员
		sql += ",appr_man=" + apppay_105.getAppr_man() + "";

		sql += ",UNIT_NO=" + apppay_105.getUNIT_NO() + "";
		sql += " where APPPAY_ID=" + apppay_105.getApppay_id() + "";
		try
		{
			super.executeUpdate(sql.toString());
			String updateTemp = "update " + ApppayTerminalDao.TABLE
					+ " set UNIT_NO=" + apppay_105.getUNIT_NO()
					+ "  where APPPAY_ID=" + apppay_105.getApppay_id();
			super.executeUpdate(updateTemp);
		} catch (Exception e)
		{
			super.rollback();
		}
	}

	@Override
	public Apppay_105 findById(int id) throws Exception
	{
		String sql = "select * from " + TABLE + " where APPPAY_ID=" + id;
		Apppay_105 info = null;
		ResultSet rs = super.execQuery(sql);
		if (rs.next())
		{
			info = this.wrapToModel(rs);
		}
		rs.close();
		release();
		return info;
	}
}
