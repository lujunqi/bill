package com.szzt.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.AbstractDao;
import com.dodou.inferface.AppayStatus;
import com.dodou.table.Apppay106_Info;
import com.szzt.exception.DeleteException;
import com.szzt.exception.ForbidUpdateException;

public class Apppay106_InfoDao extends AbstractDao<Apppay106_Info>
{
	public static final String TABLE = "APPPAY_106";

	public Apppay106_InfoDao()
	{
	}

	public Apppay106_InfoDao(String where, String table)
	{
		super(where, table);
	}

	@Override
	public int insert(Apppay106_Info appay) throws Exception
	{

		String sql = "insert into APPPAY_106 ";
		String fields = "APPPAY_ID";
		String values = "APPPAY_106_ID_SEQ.nextval";

		fields += ",COMMERCIAL_ID";
		values += ",'" + appay.getCOMMERCIAL_ID() + "'";

		if (null != appay.getREMARK_INFO()
				&& !"".equals(appay.getREMARK_INFO()))
		{
			fields += ",REMARK_INFO";
			values += ",'" + appay.getREMARK_INFO() + "'";
		}

		if (appay.getPSAM_NO() != null)
		{
			fields += ",PSAM_NO";
			values += ",'" + appay.getPSAM_NO() + "'";
		}

		if (appay.getAPPTYPE() != null)
		{
			fields += ",APPTYPE";
			values += ",'" + appay.getAPPTYPE() + "'";
		}
		fields += ",ACCOUNT_TYPE";
		values += ",'" + appay.getACCOUNT_TYPE() + "'";

		if (appay.getACCOUNT_NO() != null)
		{
			fields += ",ACCOUNT_NO";
			values += ",'" + appay.getACCOUNT_NO() + "'";
		}
		if (appay.getACCOUNT_BANK() != null)
		{
			fields += ",ACCOUNT_BANK";
			values += ",'" + appay.getACCOUNT_BANK() + "'";
		}

		if (appay.getACCOUNT_BANK_ID() != null)
		{
			fields += ",ACCOUNT_BANK_ID";
			values += ",'" + appay.getACCOUNT_BANK_ID() + "'";
		}
		if (appay.getACCOUNT_PROVINCE() != null)
		{
			fields += ",ACCOUNT_PROVINCE";
			values += ",'" + appay.getACCOUNT_PROVINCE() + "'";
		}
		if (appay.getACCOUNT_CITY() != null)
		{
			fields += ",ACCOUNT_CITY";
			values += ",'" + appay.getACCOUNT_CITY() + "'";
		}
		if (appay.getACCOUNT_NAME() != null)
		{
			fields += ",ACCOUNT_NAME";
			values += ",'" + appay.getACCOUNT_NAME() + "'";
		}
		if (appay.getFEE_TYPE() != null)
		{
			fields += ",FEE_TYPE";
			values += ",'" + appay.getFEE_TYPE() + "'";
		}
		if (appay.getFEE_SET() != null)
		{
			fields += ",FEE_SET";
			values += ",'" + appay.getFEE_SET() + "'";
		}
		if (appay.getBILL_INFO() != null)
		{
			fields += ",BILL_INFO";
			values += ",'" + appay.getBILL_INFO() + "'";
		}
		if (appay.getEC_ID() != null)
		{
			fields += ",EC_ID";
			values += ",'" + appay.getEC_ID() + "'";
		}
		fields += ",E_ID";
		values += ",'" + appay.getE_ID() + "'";

		if (appay.getEC_NAME() != null)
		{
			fields += ",EC_NAME";
			values += ",'" + appay.getEC_NAME() + "'";
		}

		if (appay.getUNIT_NO() != null)
		{
			fields += ",UNIT_NO";
			values += ",'" + appay.getUNIT_NO() + "'";
		}

		fields += ",TERM_ID1";
		values += ",'" + appay.getTERM_ID1() + "'";

		fields += ",TERM_ID2";
		values += ",'" + appay.getTERM_ID2() + "'";

		if (appay.getCREDIT_FLAG() != null)
		{
			fields += ",CREDIT_FLAG";
			values += ",'" + appay.getCREDIT_FLAG() + "'";
		}

		if (appay.getCREDIT_CARD_LIMIT() != null)
		{
			fields += ",CREDIT_CARD_LIMIT";
			values += ",'" + appay.getCREDIT_CARD_LIMIT() + "'";
		}

		if (appay.getCREDIT_M_A_LIMIT() != null)
		{
			fields += ",CREDIT_M_A_LIMIT";
			values += ",'" + appay.getCREDIT_M_A_LIMIT() + "'";
		}

		if (appay.getDEBIT_CARD_LIMIT() != null)
		{
			fields += ",DEBIT_CARD_LIMIT";
			values += ",'" + appay.getDEBIT_CARD_LIMIT() + "'";
		}

		if (appay.getCREDIT_M_C_LIMIT() != null)
		{
			fields += ",CREDIT_M_C_LIMIT";
			values += ",'" + appay.getCREDIT_M_C_LIMIT() + "'";
		}
		if (appay.getDEBIT_M_A_LIMIT() != null)
		{
			fields += ",DEBIT_M_A_LIMIT";
			values += ",'" + appay.getDEBIT_M_A_LIMIT() + "'";
		}

		if (appay.getDEBIT_M_C_LIMIT() != null)
		{
			fields += ",DEBIT_M_C_LIMIT";
			values += ",'" + appay.getDEBIT_M_C_LIMIT() + "'";
		}
		if (appay.getACCOUNT_BANK_NAME() != null)
		{
			fields += ",ACCOUNT_BANK_NAME";
			values += ",'" + appay.getACCOUNT_BANK_NAME() + "'";
		}

		// if (appay.getAPPR_MAN() != null)
		// {
		// fields += ",APPR_MAN";
		// values += ",'" + appay.getAPPR_MAN() + "'";
		// }

		fields += ",APPR_STATUS";
		values += "," + appay.getAPPR_STATUS() + "";

		// -------新增字段----------------
		// if (appay.getTER_MONTH_MIN() != null)
		// {
		// fields += ",TER_MONTH_MIN";
		// values += ",'" + appay.getTER_MONTH_MIN() + "'";
		// }
		// fields += ",COUNT_DESIRE";
		// values += "," + appay.getCOUNT_DESIRE();
		// fields += ",IS_DEFAULT";
		// values += "," + appay.getIS_DEFAULT();
		// fields += ",BASE";
		// values += ",'" + appay.getBASE() + "'";
		//
		// fields += ",TOP";
		// values += ",'" + appay.getTOP() + "'";
		// fields += ",CHARGE_CYCLE";
		// values += "," + appay.getCHARGE_CYCLE();

		// ------------------
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		// if (appay.getAPPR_DATE() != null)
		// {
		// fields += ",APPR_DATE";
		// values += ",to_date('" + format.format(appay.getAPPR_DATE())
		// + "','yyyy-MM-dd')";
		// }

		if (appay.getAPPR_REMARK() != null)
		{
			fields += ",APPR_REMARK";
			values += ",'" + appay.getAPPR_REMARK() + "'";
		}

		fields += ",STATUS";
		values += "," + appay.getSTATUS();

		if (appay.getINPUT_DATE() != null)
		{
			fields += ",INPUT_DATE";
			values += ",sysdate";
		}
		if (appay.getCHANGE_DATE() != null)
		{
			fields += ",CHANGE_DATE";
			values += ",sysdate";
		}
		if (appay.getTERM_TYPE() != null)
		{
			fields += ",TERM_TYPE";
			values += ",'"+appay.getTERM_TYPE()+"'";
		}
		if (appay.getSERIAL() != null)
		{
			fields += ",SERIAL";
			values += ",'"+appay.getSERIAL()+"'";
		}		
		sql += "(" + fields + ") values (" + values + ")";
		System.out.println(sql);
		DatabaseAccess dba = super.executeUpdate(sql);
		// int id = super.loadCurrentId(dba, "APPPAY_106", "APPPAY_ID");
		int id = super.loadAppCurrId(dba, "APPPAY_106", "APPPAY_ID",
				appay.getCOMMERCIAL_ID());
		return id;
	}

	@Override
	public Apppay106_Info[] select(String sql) throws Exception
	{
		if (null == sql)
		{
			return this.select();
		}
		Apppay106_Info[] infos = new Apppay106_Info[this.getPageSize()];
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
			Apppay106_Info info = wrapToModel(rs);

			// ---------新增字段
			// info.setCOUNT_DESIRE(rs.getInt("COUNT_DESIRE"));
			// info.setIS_DEFAULT(rs.getInt("IS_DEFAULT"));
			// info.setTER_MONTH_MIN(rs.getString("TER_MONTH_MIN"));
			// info.setBASE(rs.getString("BASE"));
			// info.setTOP(rs.getString("TOP"));
			// info.setCHARGE_CYCLE(rs.getInt("CHARGE_CYCLE"));

			infos[j++] = info;
		}

		super.debug("查询出Apppay106_info信息总数为：" + this.getTotalCount());
		rs.close();

		return infos;
	}

	private Apppay106_Info wrapToModel(ResultSet rs) throws SQLException
	{
		Apppay106_Info info = new Apppay106_Info();
		info.setAPPPAY_ID(rs.getInt("APPPAY_ID"));
		info.setCOMMERCIAL_ID(rs.getInt("COMMERCIAL_ID"));
		info.setAPPTYPE(rs.getString("APPTYPE"));
		info.setACCOUNT_TYPE(rs.getInt("ACCOUNT_TYPE"));
		info.setACCOUNT_NO(rs.getString("ACCOUNT_NO"));
		info.setACCOUNT_BANK(rs.getString("ACCOUNT_BANK"));
		info.setACCOUNT_BANK_ID(rs.getString("ACCOUNT_BANK_ID"));
		info.setACCOUNT_PROVINCE(rs.getString("ACCOUNT_PROVINCE"));
		info.setACCOUNT_CITY(rs.getString("ACCOUNT_CITY"));
		info.setACCOUNT_NAME(rs.getString("ACCOUNT_NAME"));
		info.setFEE_TYPE(rs.getString("FEE_TYPE"));
		info.setFEE_SET(rs.getString("FEE_SET"));
		info.setBILL_INFO(rs.getString("BILL_INFO"));
		info.setUNIT_NO(rs.getString("UNIT_NO"));
		info.setEC_ID(rs.getString("EC_ID"));
		info.setEC_NAME(rs.getString("EC_NAME"));
		info.setE_ID(rs.getInt("E_ID"));
		info.setTERM_ID1(rs.getString("TERM_ID1"));
		info.setTERM_ID2(rs.getString("TERM_ID2"));
		info.setCREDIT_FLAG(rs.getString("CREDIT_FLAG"));
		info.setCREDIT_CARD_LIMIT(rs.getString("CREDIT_CARD_LIMIT"));
		info.setCREDIT_M_A_LIMIT(rs.getString("CREDIT_M_A_LIMIT"));
		info.setCREDIT_M_C_LIMIT(rs.getString("CREDIT_M_C_LIMIT"));
		info.setDEBIT_CARD_LIMIT(rs.getString("DEBIT_CARD_LIMIT"));
		info.setDEBIT_M_A_LIMIT(rs.getString("DEBIT_M_A_LIMIT"));
		info.setDEBIT_M_C_LIMIT(rs.getString("DEBIT_M_C_LIMIT"));
		info.setAPPR_MAN(rs.getString("APPR_MAN"));
		info.setAPPR_STATUS(rs.getInt("APPR_STATUS"));
		info.setAPPR_DATE(rs.getDate("APPR_DATE"));
		info.setAPPR_REMARK(rs.getString("APPR_REMARK"));
		info.setSTATUS(rs.getInt("STATUS"));
		info.setINPUT_DATE(rs.getDate("INPUT_DATE"));
		info.setCHANGE_DATE(rs.getDate("CHANGE_DATE"));
		info.setACCOUNT_BANK_NAME(rs.getString("ACCOUNT_BANK_NAME"));
		info.setPSAM_NO(rs.getString("PSAM_NO"));
		info.setREMARK_INFO(rs.getString("REMARK_INFO"));
		info.setTERM_TYPE(rs.getString("TERM_TYPE"));
		info.setSERIAL(rs.getString("SERIAL"));
		return info;
	}

	@Override
	public Apppay106_Info[] select(Apppay106_Info data) throws Exception
	{
		return null;
	}

	@Override
	public void update(Apppay106_Info data) throws Exception
	{

		int status = super.loadAppayStatus(TABLE, data.getAPPPAY_ID());

		// 使用反射注入的对象不需要设置字符串信息
		StringBuffer sql = new StringBuffer("update ").append(TABLE).append(
				" set ");

		switch (status)
		{
		// 新增终端审批中 账号信息修改中禁止更新
		case AppayStatus.APPAY_UPDATE:
		case AppayStatus.NEW_TER:
			throw new ForbidUpdateException();
			// 新增业务 驳回业务可以修改全部
		case AppayStatus.NOT_ALLOW:
			sql.append("APPR_STATUS=").append(AppayStatus.INPUT).append(",");
			break;
		case AppayStatus.INPUT:

			break;
		// 已审批状态只能修改部分信息--- 账户、帐号、支付行号、扣率、账户所在省
		case AppayStatus.ALLOW:
			super.initLogService();
			Apppay106_Info info = this.findById(data.getAPPPAY_ID());
			// 账户账号
			sql.append("ACCOUNT_NO=").append(data.getACCOUNT_NO()).append(",");
			logService.appendDirty(info.getACCOUNT_NO(), data.getACCOUNT_NO(),
					"账户账号");

			// 账户支行号
			sql.append("ACCOUNT_BANK_ID=").append(data.getACCOUNT_BANK_ID())
					.append(",");
			logService.appendDirty(info.getACCOUNT_NO(), data.getACCOUNT_NO(),
					"账户账号");
			// 签约回扣率
			sql.append("FEE_SET=").append(data.getFEE_SET()).append(",");
			logService.appendDirty(info.getFEE_SET(), data.getFEE_SET(), "扣率");

			// 扣率类型
			sql.append("FEE_TYPE=").append(data.getFEE_TYPE()).append(",");
			logService.appendFeeType(info.getFEE_TYPE(), data.getFEE_TYPE());

			// 业务状态改为 修改待审批状态
			sql.append("APPR_STATUS=").append(AppayStatus.APPAY_UPDATE)
					.append(",");

			sql.append("CHANGE_DATE=").append("sysdate").append(",");
			// 市
			sql.append("ACCOUNT_CITY=").append(data.getACCOUNT_CITY())
					.append(",");
			logService.appendCity(info.getACCOUNT_CITY(),
					data.getACCOUNT_CITY());

			// 第一次测试后修改
			sql.append("ACCOUNT_TYPE=").append(data.getACCOUNT_TYPE())
					.append(",");
			logService.appendAccountType(info.getACCOUNT_TYPE(),
					data.getACCOUNT_TYPE());

			sql.append("ACCOUNT_NAME=").append(data.getACCOUNT_NAME())
					.append(",");
			logService.appendDirty(info.getACCOUNT_NAME(),
					data.getACCOUNT_NAME(), "账户户名");

			sql.append("ACCOUNT_BANK_NAME=")
					.append(data.getACCOUNT_BANK_NAME()).append(",");

			logService.appendDirty(info.getACCOUNT_BANK_NAME(),
					data.getACCOUNT_BANK_NAME(), "账户支行名称");

			sql.append("ACCOUNT_BANK=").append(data.getACCOUNT_BANK())
					.append(",");
			logService.appendDirty(info.getACCOUNT_BANK(),
					data.getACCOUNT_BANK(), "账户银行");

			sql.append("ACCOUNT_PROVINCE=").append(data.getACCOUNT_PROVINCE());
			sql.append(" where APPPAY_ID=").append(data.getAPPPAY_ID());
			super.executeUpdate(logService.insertLog(TABLE, super.getWho(),
					data.getAPPPAY_ID(), 106));
			super.executeUpdate(sql.toString());
			return;
		}

		// 注意 使用bindRequest绑定的字符串数据不需要添加''
		// StringBuffer sql = new StringBuffer();
		sql.append("CHANGE_DATE=sysdate").append(",");
		// 账户类型
		sql.append("ACCOUNT_TYPE=" + data.getACCOUNT_TYPE()).append(",");
		// 账户账号
		sql.append("ACCOUNT_NO=").append(data.getACCOUNT_NO()).append(",");
		// 账户银行
		sql.append("PSAM_NO=").append(data.getPSAM_NO()).append(",");

		sql.append("ACCOUNT_BANK=").append(data.getACCOUNT_BANK()).append(",");
		sql.append("ACCOUNT_BANK_NAME=").append(data.getACCOUNT_BANK_NAME())
				.append(",");
		// 账户支行号
		sql.append("ACCOUNT_BANK_ID=").append(data.getACCOUNT_BANK_ID())
				.append(",");
		// 拓展渠道人员
		sql.append("EC_NAME=").append(data.getEC_NAME()).append(",");
		// =-=
		sql.append("E_ID=").append(data.getE_ID()).append(",");
		sql.append("EC_ID=").append(data.getEC_ID()).append(",");
		sql.append("ACCOUNT_PROVINCE=").append(data.getACCOUNT_PROVINCE())
				.append(",");
		sql.append("ACCOUNT_CITY=").append(data.getACCOUNT_CITY()).append(",");
		sql.append("ACCOUNT_NAME=").append(data.getACCOUNT_NAME()).append(",");
		// 具体手续费
		sql.append("FEE_SET=").append(data.getFEE_SET()).append(",");

		if (null != data.getREMARK_INFO())
		{
			sql.append("REMARK_INFO=").append(data.getREMARK_INFO())
					.append(",");
		}
		// 扣率类型
		sql.append("FEE_TYPE=").append(data.getFEE_TYPE()).append(",");
		sql.append("BILL_INFO=").append(data.getBILL_INFO());

		// ------新增字段--------------------------------------
		// sql.append("TER_MONTH_MIN=").append(data.getTER_MONTH_MIN())
		// .append(",");
		// sql.append("COUNT_DESIRE=").append(data.getCOUNT_DESIRE()).append(",");
		// sql.append("IS_DEFAULT=").append(data.getIS_DEFAULT()).append(",");
		// sql.append("BASE=").append(data.getBASE()).append(",");
		// sql.append("TOP=").append(data.getTOP()).append(",");
		// sql.append("CHARGE_CYCLE=").append(data.getCHARGE_CYCLE());
		// -----------------------

		sql.append(" where APPPAY_ID=").append(data.getAPPPAY_ID());
		super.executeUpdate(sql.toString());
		super.debug("Apppay106--update-->" + sql.toString());

	}

	@Override
	public void delete(int id) throws Exception
	{
		if (super.loadAppayStatus(TABLE, id) < 2)
		{
			String delTemp = "delete from TERM_APP_TABLE where APPPAY_ID=" + id;
			String delApp01 = "delete from APPPAY_106 where APPPAY_ID=" + id;

			DatabaseAccess dba = null;
			try
			{
				dba = super.executeUpdate(delApp01);
				super.deletoAppPhoto(id);
				int temp = dba.executeUpdate(delTemp);
				super.debug("------->Apppay106删除<---------");
				super.debug("删除中间表个数--》" + temp);
				super.debug("------->Apppay106删除成功<---------");
			} catch (Exception e)
			{
				if (null != dba)
					dba.rollback();
				e.printStackTrace();
			}
		} else
			throw new DeleteException();
	}

	// 判断终端处于的状态
	private boolean checkStatus(int infoId, int status) throws Exception
	{
		Apppay106_Info[] old = this.select("select * from " + TABLE
				+ " where APPPAY_ID=" + infoId);
		if (null != old[0])
		{
			int now = old[0].getAPPR_STATUS() + 1;
			return status == now;
		}
		System.out.println("dfddddddddddddddddddd" + old);
		return false;
	}

	@Override
	public void operate(Apppay106_Info info) throws Exception
	{
		// 使用bind绑定信息
		super.initUpdate(TABLE);
		if (null != info.getAPPR_MAN())
			super.wrapUpdateSql("APPR_MAN", info.getAPPR_MAN());

		if (null != info.getUNIT_NO())
			super.wrapUpdateSql("UNIT_NO", info.getUNIT_NO());

		if (null != info.getTERM_ID1() && !info.getTERM_ID1().trim().equals(""))
			super.wrapUpdateSql("TERM_ID1", ""+info.getTERM_ID1()+"");

		if (null != info.getTERM_ID2() && !info.getTERM_ID2().trim().equals(""))
			super.wrapUpdateSql("TERM_ID2", ""+info.getTERM_ID2()+"");

		if (null != info.getCREDIT_FLAG())
			super.wrapUpdateSql("CREDIT_FLAG", info.getCREDIT_FLAG());

		System.out.println("flag=-------------" + info.getCREDIT_FLAG());
		if ("'1'".equals(info.getCREDIT_FLAG()))
		{
			System.out.println("flag=-------------" + info.getCREDIT_FLAG());
			if (null != info.getCREDIT_CARD_LIMIT())
			{
				super.wrapUpdateSql("CREDIT_CARD_LIMIT",
						info.getCREDIT_CARD_LIMIT());
			}
			if (null != info.getCREDIT_M_A_LIMIT())
			{
				super.wrapUpdateSql("CREDIT_M_A_LIMIT",
						info.getCREDIT_M_A_LIMIT());
			}
			if (null != info.getCREDIT_M_C_LIMIT())
				super.wrapUpdateSql("CREDIT_M_C_LIMIT",
						info.getCREDIT_M_C_LIMIT());

			if (null != info.getDEBIT_CARD_LIMIT())
				super.wrapUpdateSql("DEBIT_CARD_LIMIT",
						info.getDEBIT_CARD_LIMIT());

			if (null != info.getDEBIT_M_A_LIMIT())
				super.wrapUpdateSql("DEBIT_M_A_LIMIT",
						info.getDEBIT_M_A_LIMIT());

			if (null != info.getDEBIT_M_C_LIMIT())
				super.wrapUpdateSql("DEBIT_M_C_LIMIT",
						info.getDEBIT_M_C_LIMIT());

		} else
		{
			super.wrapUpdateSql("CREDIT_M_A_LIMIT", "''");
			super.wrapUpdateSql("CREDIT_CARD_LIMIT", "''");
			super.wrapUpdateSql("DEBIT_M_C_LIMIT", "''");
			super.wrapUpdateSql("DEBIT_M_A_LIMIT", "''");
			super.wrapUpdateSql("DEBIT_CARD_LIMIT", "''");
			super.wrapUpdateSql("CREDIT_M_C_LIMIT", "''");

		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		super.wrapUpdateSql("STATUS", info.getSTATUS());
		// super.wrapUpdateSql(
		// "APPR_REMARK",
		// "" +format.format(System.currentTimeMillis())
		// + info.getAPPR_REMARK());
		if (null != info.getAPPR_REMARK()
				&& info.getAPPR_REMARK().trim().length() > 0
				&& info.getAPPR_STATUS() == 1)
		{
			System.out.println("remarkinfo====>"
					+ info.getAPPR_REMARK().length());

			super.wrapUpdateSql(
					" APPR_REMARK",
					"concat(APPR_REMARK,'"
							+ format.format(new Date(System.currentTimeMillis()))
							+ " :" + info.getAPPR_REMARK().substring(1) + ")");
		}

		super.wrapUpdateSql("APPR_STATUS", info.getAPPR_STATUS());
		super.wrapUpdateSql(
				"APPR_DATE",
				"to_date('"
						+ super.formatDate(new Date(System.currentTimeMillis()))
						+ "','yyyy-MM-dd')");

		super.update("APPPAY_ID=" + info.getAPPPAY_ID());
	}

	@Override
	public Apppay106_Info findById(int id) throws Exception
	{
		String sql = "select * from " + TABLE + " where APPPAY_ID=" + id;
		ResultSet rs = super.execQuery(sql);
		Apppay106_Info info = null;
		if (rs.next())
		{
			info = this.wrapToModel(rs);
		}
		rs.close();
		this.release();
		return info;
	}

}
