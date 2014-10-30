package com.szzt.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.AbstractDao;
import com.dodou.inferface.AppayStatus;
import com.dodou.table.Apppay101_Info;
import com.dodou.table.Apppay103_Info;
import com.szzt.exception.DeleteException;
import com.szzt.exception.ForbidUpdateException;

public class Apppay103_InfoDao extends AbstractDao<Apppay103_Info>
{
	public static final String TABLE = "APPPAY_103";

	public Apppay103_InfoDao()
	{
	}

	public Apppay103_InfoDao(String where, String table)
	{
		super(where, table);
	}

	@Override
	public Apppay103_Info[] select(String sql) throws Exception
	{
		if (null == sql)
		{
			return this.select();
		}
		Apppay103_Info[] infos = new Apppay103_Info[this.getPageSize()];
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
			Apppay103_Info info = wrapToModel(rs);
			// ---------------
			infos[j++] = info;
		}

		super.debug("查询出Apppay103_Info信息总数为：" + this.getTotalCount());
		rs.close();

		return infos;
	}

	private Apppay103_Info wrapToModel(ResultSet rs) throws SQLException
	{
		Apppay103_Info info = new Apppay103_Info();
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
		info.setCONTRACT_FEE(rs.getString("CONTRACT_FEE"));
		info.setEC_ID(rs.getString("EC_ID"));
		info.setEC_NAME(rs.getString("EC_NAME"));
		info.setE_ID(rs.getInt("E_ID"));
		info.setTERM_ID1(rs.getString("TERM_ID1"));
		info.setTERM_ID2(rs.getString("TERM_ID2"));
		info.setAPPR_MAN(rs.getString("APPR_MAN"));
		info.setAPPR_STATUS(rs.getInt("APPR_STATUS"));
		info.setAPPR_DATE(rs.getDate("APPR_DATE"));
		info.setAPPR_REMARK(rs.getString("APPR_REMARK"));
		info.setSTATUS(rs.getInt("STATUS"));
		info.setINPUT_DATE(rs.getDate("INPUT_DATE"));
		info.setCHANGE_DATE(rs.getDate("CHANGE_DATE"));
		// ---------新增字段
		info.setCOUNT_DESIRE(rs.getInt("COUNT_DESIRE"));
		info.setIS_DEFAULT(rs.getInt("IS_DEFAULT"));
		info.setTER_MONTH_MIN(rs.getString("TER_MONTH_MIN"));
		info.setBASE(rs.getString("BASE"));
		info.setTOP(rs.getString("TOP"));
		info.setCHARGE_CYCLE(rs.getInt("CHARGE_CYCLE"));
		info.setUP_COMMERCIAL(rs.getString("UP_COMMERCIAL"));
		info.setINCOME_BELONG(rs.getString("INCOME_BELONG"));
		info.setREAL_OPERATE_RANGE(rs.getString("REAL_OPERATE_RANGE"));
		info.setNOT_NORM_DESC(rs.getString("NOT_NORM_DESC"));
		info.setBUSS_TYPE_SMALL(rs.getString("BUSS_TYPE_SMALL"));
		info.setOPERATE_LIMIT(rs.getInt("OPERATE_LIMIT"));
		info.setREGISTER_CAPITAL(rs.getInt("REGISTER_CAPITAL"));
		info.setOPERATE_AREA(rs.getInt("OPERATE_AREA"));
		info.setSTAFFS(rs.getInt("STAFFS"));
		info.setMARKET_COMMPANY(rs.getInt("MARKET_COMMPANY"));
		info.setINNER_MANAGE(rs.getInt("INNER_MANAGE"));
		info.setINSPACE(rs.getInt("INSPACE"));
		info.setBUS_RELATION(rs.getInt("BUS_RELATION"));
		info.setAUTH_ARGENT(rs.getInt("AUTH_ARGENT"));
		info.setBUSS_TYPE_LARGE(rs.getInt("BUSS_TYPE_LARGE"));
		info.setACCOUNT_BANK_NAME(rs.getString("ACCOUNT_BANK_NAME"));
		info.setREMARK_INFO(rs.getString("REMARK_INFO"));
		return info;
	}

	@Override
	public Apppay103_Info[] select(Apppay103_Info data) throws Exception
	{
		return null;
	}

	@Override
	public int insert(Apppay103_Info appay) throws Exception
	{
		String sql = "insert into APPPAY_103 ";
		String fields = "APPPAY_ID";
		String values = "APPPAY_ID_ID.nextval";

		fields += ",COMMERCIAL_ID";
		values += "," + appay.getCOMMERCIAL_ID() + "";

		if (appay.getAPPTYPE() != null)
		{
			fields += ",APPTYPE";
			values += "," + appay.getAPPTYPE() + "";
		}
		if (null != appay.getREMARK_INFO()
				&& !"".equals(appay.getREMARK_INFO()))
		{
			fields += ",REMARK_INFO";
			values += "," + appay.getREMARK_INFO() + "";
		}
		
		
		fields += ",ACCOUNT_TYPE";
		values += "," + appay.getACCOUNT_TYPE() + "";

		if (appay.getACCOUNT_NO() != null)
		{
			fields += ",ACCOUNT_NO";
			values += "," + appay.getACCOUNT_NO() + "";
		}
		if (appay.getACCOUNT_BANK() != null)
		{
			fields += ",ACCOUNT_BANK";
			values += "," + appay.getACCOUNT_BANK() + "";
		}
		if (appay.getACCOUNT_BANK_NAME() != null)
		{
			fields += ",ACCOUNT_BANK_NAME";
			values += "," + appay.getACCOUNT_BANK_NAME() + "";
		}

		if (appay.getACCOUNT_BANK_ID() != null)
		{
			fields += ",ACCOUNT_BANK_ID";
			values += "," + appay.getACCOUNT_BANK_ID() + "";
		}
		if (appay.getACCOUNT_PROVINCE() != null)
		{
			fields += ",ACCOUNT_PROVINCE";
			values += "," + appay.getACCOUNT_PROVINCE() + "";
		}
		if (appay.getACCOUNT_CITY() != null)
		{
			fields += ",ACCOUNT_CITY";
			values += "," + appay.getACCOUNT_CITY() + "";
		}
		if (appay.getACCOUNT_NAME() != null)
		{
			fields += ",ACCOUNT_NAME";
			values += "," + appay.getACCOUNT_NAME() + "";
		}
		fields += ",CONTRACT_FEE";
		values += "," + appay.getCONTRACT_FEE() + "";

		if (appay.getEC_ID() != null)
		{
			fields += ",EC_ID";
			values += "," + appay.getEC_ID() + "";
		}

		fields += ",E_ID";
		values += "," + appay.getE_ID() + "";

		if (appay.getEC_NAME() != null)
		{
			fields += ",EC_NAME";
			values += "," + appay.getEC_NAME() + "";
		}

		if (appay.getTERM_ID1() != null)
		{
			fields += ",TERM_ID1";
			values += "," + appay.getTERM_ID1() + "";
		}

		System.out.println("term_id1:" + appay.getTERM_ID1());

		fields += ",TERM_ID2";
		values += "," + appay.getTERM_ID2() + "";

		// if (appay.getAPPR_MAN() != null)
		// {
		// fields += ",APPR_MAN";
		// values += "," + appay.getAPPR_MAN() + "";
		// }

		fields += ",APPR_STATUS";
		values += "," + appay.getAPPR_STATUS() + "";

		fields += ",STATUS";
		values += "," + appay.getSTATUS() + "";

		if (appay.getAPPR_REMARK() != null)
		{
			fields += ",APPR_REMARK";
			values += "," + appay.getAPPR_REMARK() + "";
		}
		fields += ",BASE";
		values += "," + appay.getBASE() + "";

		fields += ",TOP";
		values += "," + appay.getTOP() + "";

		// -------新增字段----------------
		if (appay.getTER_MONTH_MIN() != null)
		{
			fields += ",TER_MONTH_MIN";
			values += "," + appay.getTER_MONTH_MIN() + "";
		}
		fields += ",COUNT_DESIRE";
		values += "," + appay.getCOUNT_DESIRE();
		fields += ",IS_DEFAULT";
		values += "," + appay.getIS_DEFAULT();
		fields += ",CHARGE_CYCLE";
		values += "," + appay.getCHARGE_CYCLE();
		// ------新增-----------

		if (appay.getUP_COMMERCIAL() != null)
		{
			fields += ",UP_COMMERCIAL";
			values += "," + appay.getUP_COMMERCIAL();
		}
		if (appay.getINCOME_BELONG() != null)
		{
			fields += ",INCOME_BELONG";
			values += "," + appay.getINCOME_BELONG();
		}
		if (appay.getREAL_OPERATE_RANGE() != null)
		{
			fields += ",REAL_OPERATE_RANGE";
			values += "," + appay.getREAL_OPERATE_RANGE();
		}
		if (appay.getNOT_NORM_DESC() != null)
		{
			fields += ",NOT_NORM_DESC";
			values += "," + appay.getNOT_NORM_DESC();
		}
		if (appay.getBUSS_TYPE_SMALL() != null)
		{
			fields += ",BUSS_TYPE_SMALL";
			values += "," + appay.getBUSS_TYPE_SMALL();
		}

		// 经营年限
		fields += ",OPERATE_LIMIT";
		values += "," + appay.getOPERATE_LIMIT();
		// 注册资本
		fields += ",REGISTER_CAPITAL";
		values += "," + appay.getREGISTER_CAPITAL();
		// 经营场所
		fields += ",OPERATE_AREA";
		values += "," + appay.getOPERATE_AREA();
		// 公司人数
		fields += ",STAFFS";
		values += "," + appay.getSTAFFS();
		// 上市公司
		fields += ",MARKET_COMMPANY";
		values += "," + appay.getMARKET_COMMPANY();
		// 内部管理
		fields += ",INNER_MANAGE";
		values += "," + appay.getINNER_MANAGE();
		// 现场考察
		fields += ",INSPACE";
		values += "," + appay.getINSPACE();
		// 业务关系
		fields += ",BUS_RELATION";
		values += "," + appay.getBUS_RELATION();
		// 授权协议
		fields += ",AUTH_ARGENT";
		values += "," + appay.getAUTH_ARGENT();
		// 大类行业
		fields += ",BUSS_TYPE_LARGE";
		values += "," + appay.getBUSS_TYPE_LARGE();

		// ------------------
//		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		// 日期
		// fields += ",APPR_DATE";
		// values += ",to_date('" + format.format(appay.getAPPR_DATE())
		// + "','yyyy-MM-dd')";

//		fields += ",INPUT_DATE";
//		values += ",to_date('" + format.format(appay.getINPUT_DATE())
//				+ "','yyyy-MM-dd')";
//		fields += ",CHANGE_DATE";
//		values += ",to_date('" + format.format(appay.getCHANGE_DATE())
//				+ "','yyyy-MM-dd')";

		sql += "(" + fields + ") values (" + values + ")";
		System.out.println(sql);
		DatabaseAccess dba = super.executeUpdate(sql);
		// int id = super.loadCurrentId(dba, TABLE, "APPPAY_ID");
		int id = super.loadAppCurrId(dba, TABLE, "APPPAY_ID",
				appay.getCOMMERCIAL_ID());
		return id;
	}

	@Override
	public void update(Apppay103_Info data) throws Exception
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
			Apppay103_Info info = this.findById(data.getAPPPAY_ID());
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
			sql.append("CONTRACT_FEE=").append(data.getCONTRACT_FEE())
					.append(",");
			logService.appendDirty(info.getCONTRACT_FEE(),
					data.getCONTRACT_FEE(), "扣率");

			// 业务状态改为 修改待审批状态
			sql.append("APPR_STATUS=").append(AppayStatus.APPAY_UPDATE)
					.append(",");
			sql.append("CHANGE_DATE=").append("sysdate").append(",");

			sql.append("ACCOUNT_NAME=").append(data.getACCOUNT_NAME())
					.append(",");
			logService.appendDirty(info.getACCOUNT_NAME(),
					data.getACCOUNT_NAME(), "账户户名");

			sql.append("ACCOUNT_BANK_NAME=")
					.append(data.getACCOUNT_BANK_NAME()).append(",");

			logService.appendDirty(info.getACCOUNT_BANK_NAME(),
					data.getACCOUNT_BANK_NAME(), "账户支行名称");

			// 第一次测试后修改
			sql.append("ACCOUNT_TYPE=").append(data.getACCOUNT_TYPE())
					.append(",");

			logService.appendAccountType(info.getACCOUNT_TYPE(),
					data.getACCOUNT_TYPE());

			sql.append("ACCOUNT_BANK=").append(data.getACCOUNT_BANK())
					.append(",");
			logService.appendDirty(info.getACCOUNT_BANK(),
					data.getACCOUNT_BANK(), "账户银行");

			sql.append("BASE=").append(data.getBASE()).append(",");
			logService.appendDirty(info.getBASE(), data.getBASE(), "保底");

			sql.append("TOP=").append(data.getTOP()).append(",");
			logService.appendDirty(info.getTOP(), data.getTOP(), "封顶");

			sql.append("CHARGE_CYCLE=").append(data.getCHARGE_CYCLE())
					.append(",");
			logService.appendChargeCycle(info.getCHARGE_CYCLE(),
					data.getCHARGE_CYCLE());

			// 市
			sql.append("ACCOUNT_CITY=").append(data.getACCOUNT_CITY())
					.append(",");
			logService.appendCity(info.getACCOUNT_CITY(),
					data.getACCOUNT_CITY());

			sql.append("ACCOUNT_PROVINCE=").append(data.getACCOUNT_PROVINCE());
			sql.append(" where APPPAY_ID=").append(data.getAPPPAY_ID());

			super.executeUpdate(logService.insertLog(TABLE, super.getWho(),
					data.getAPPPAY_ID(), 103));
			super.executeUpdate(sql.toString());
			return;
		}

		// 账户类型
		sql.append("ACCOUNT_TYPE=" + data.getACCOUNT_TYPE()).append(",");
		sql.append("CHANGE_DATE=").append("sysdate").append(",");
		// 账户账号
		sql.append("ACCOUNT_NO=").append(data.getACCOUNT_NO()).append(",");
		// 账户银行
		sql.append("ACCOUNT_BANK=").append(data.getACCOUNT_BANK()).append(",");
		sql.append("ACCOUNT_BANK_NAME=").append(data.getACCOUNT_BANK_NAME())
				.append(",");
		// 账户支行号
		sql.append("ACCOUNT_BANK_ID=").append(data.getACCOUNT_BANK_ID())
				.append(",");
		// 拓展渠道人员
		sql.append("EC_NAME=").append(data.getEC_NAME()).append(",");
		sql.append("ACCOUNT_PROVINCE=").append(data.getACCOUNT_PROVINCE())
				.append(",");
		sql.append("ACCOUNT_CITY=").append(data.getACCOUNT_CITY()).append(",");
		sql.append("ACCOUNT_NAME=").append(data.getACCOUNT_NAME()).append(",");
		// 签约回扣率
		sql.append("CONTRACT_FEE=").append(data.getCONTRACT_FEE()).append(",");
		// ------------新增
		sql.append("TER_MONTH_MIN=").append(data.getTER_MONTH_MIN())
				.append(",");
		sql.append("E_ID=").append(data.getE_ID()).append(",");
		sql.append("COUNT_DESIRE=").append(data.getCOUNT_DESIRE()).append(",");
		sql.append("IS_DEFAULT=").append(data.getIS_DEFAULT()).append(",");
		sql.append("BASE=").append(data.getBASE()).append(",");
		sql.append("TOP=").append(data.getTOP()).append(",");

		if (null != data.getREMARK_INFO())
		{
			sql.append("REMARK_INFO=").append(data.getREMARK_INFO())
					.append(",");
		}
		
		sql.append("CHARGE_CYCLE=").append(data.getCHARGE_CYCLE()).append(",");
		if (data.getUP_COMMERCIAL() != null)
		{
			sql.append("UP_COMMERCIAL=").append(data.getUP_COMMERCIAL())
					.append(",");
		}
		if (data.getINCOME_BELONG() != null)
		{
			sql.append("INCOME_BELONG=").append(data.getINCOME_BELONG())
					.append(",");
		}
		if (data.getREAL_OPERATE_RANGE() != null)
		{
			sql.append("REAL_OPERATE_RANGE=")
					.append(data.getREAL_OPERATE_RANGE()).append(",");
		}
		if (data.getNOT_NORM_DESC() != null)
		{
			sql.append("NOT_NORM_DESC=").append(data.getNOT_NORM_DESC())
					.append(",");
		}
		if (data.getBUSS_TYPE_SMALL() != null)
		{
			sql.append("BUSS_TYPE_SMALL=").append(data.getBUSS_TYPE_SMALL())
					.append(",");
		}
		// 经营年限
		sql.append("OPERATE_LIMIT=").append(data.getOPERATE_LIMIT())
				.append(",");
		// 注册资本
		sql.append("REGISTER_CAPITAL=").append(data.getREGISTER_CAPITAL())
				.append(",");
		// 经营场所
		sql.append("OPERATE_AREA=").append(data.getOPERATE_AREA()).append(",");
		// 公司人数
		sql.append("STAFFS=").append(data.getSTAFFS()).append(",");
		// 上市公司
		sql.append("MARKET_COMMPANY=").append(data.getMARKET_COMMPANY())
				.append(",");
		// 内部管理
		sql.append("INNER_MANAGE=").append(data.getINNER_MANAGE()).append(",");
		// 现场考察
		sql.append("INSPACE=").append(data.getINSPACE()).append(",");
		// 业务关系
		sql.append("BUS_RELATION=").append(data.getBUS_RELATION()).append(",");
		// 授权协议
		sql.append("AUTH_ARGENT=").append(data.getAUTH_ARGENT()).append(",");
		// 大类行业
		sql.append("BUSS_TYPE_LARGE=").append(data.getBUSS_TYPE_LARGE())
				.append(",");
		// -----------结束新增字段
		sql.append("EC_ID=").append(data.getEC_ID());
		sql.append(" where APPPAY_ID=").append(data.getAPPPAY_ID());
		super.executeUpdate(sql.toString());
		super.debug("Apppay103--update-->" + sql.toString());
	}

	@Override
	public void delete(int id) throws Exception
	{
		if (super.loadAppayStatus(TABLE, id) < 2)
		{
			String delTemp = "delete from TERM_APP_TABLE where APPPAY_ID=" + id;
			String delApp01 = "delete from APPPAY_103 where APPPAY_ID=" + id;
			DatabaseAccess dba = null;
			super.deletoAppPhoto(id);
			try
			{
				dba = super.executeUpdate(delApp01);
				int temp = dba.executeUpdate(delTemp);
				super.debug("------->Apppay103删除<---------");
				super.debug("删除中间表个数--》" + temp);
				super.debug("------->Apppay103删除成功<---------");
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
		Apppay103_Info[] old = this.select("select * from " + TABLE
				+ " where APPPAY_ID=" + infoId);
		if (null != old[0])
		{
			int now = old[0].getAPPR_STATUS() + 1;
			return status == now;
		}
		return false;
	}

	@Override
	public void operate(Apppay103_Info info) throws Exception
	{
		StringBuffer sql = new StringBuffer();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		sql.append("update ").append(TABLE).append(" set ");
		sql.append(" APPR_MAN=").append(info.getAPPR_MAN()).append(",");
		sql.append("APPR_STATUS=").append(info.getAPPR_STATUS()).append(",");
		sql.append(" APPR_DATE=").append(
				"to_date('"
						+ this.formatDate(new Date(System.currentTimeMillis()))
						+ "','yyyy-MM-dd')");
		if (null != info.getAPPR_REMARK()
				&& info.getAPPR_REMARK().trim().length() > 0
				&& info.getAPPR_STATUS() == 1)
		{
			sql.append(",");
			sql.append(" APPR_REMARK=")
					.append("concat(APPR_REMARK,'\n"
							+ format.format(new Date(System.currentTimeMillis()))
							+ " :" + info.getAPPR_REMARK().substring(1) + ")");
		}
		sql.append(" where APPPAY_ID=").append(info.getAPPPAY_ID());
		this.executeUpdate(sql.toString());
		// // 使用bind绑定信息
		// super.initUpdate(TABLE);
		// super.wrapUpdateSql("TERM_ID1", info.getTERM_ID1());
		// super.wrapUpdateSql("TERM_ID2", info.getTERM_ID2());
		// super.wrapUpdateSql("APPR_MAN", info.getAPPR_MAN());
		// super.wrapUpdateSql("STATUS", info.getSTATUS());
		// super.wrapUpdateSql("APPR_REMARK", info.getAPPR_REMARK());
		// super.wrapUpdateSql("APPR_STATUS", info.getAPPR_STATUS());
		// super.wrapUpdateSql(
		// "APPR_DATE",
		// "to_date('"
		// + super.formatDate(new Date(System.currentTimeMillis()))
		// + "','yyyy-MM-dd')");
		// super.update("APPPAY_ID=" + info.getAPPPAY_ID());
	}

	@Override
	public Apppay103_Info findById(int id) throws Exception
	{
		String sql = "select * from " + TABLE + " where APPPAY_ID=" + id;
		ResultSet rs = super.execQuery(sql);
		Apppay103_Info info = null;
		if (rs.next())
		{
			info = this.wrapToModel(rs);
		}
		rs.close();
		this.release();
		return info;
	}

}
