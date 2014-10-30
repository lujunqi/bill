package com.szzt.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.dodou.dao.Apppay_105Dao;
import com.dodou.inferface.AbstractDao;
import com.dodou.table.Apppay101_Info;
import com.szzt.model.AppayApproveModel;
import com.szzt.model.AppayComShowModel;

public class ApppayCommonDao extends AbstractDao<Apppay101_Info>
{
	private int current_size = 0;// 记录当前查询记录行数

	private StringBuilder builder = new StringBuilder();

	public String initPage(String table, String where)
	{
		if (Apppay_105Dao.TABLE.equals(table))
		{
			this.hasFeeChain = true;
		}
		builder.append("select b.* from (SELECT a.*,ROWNUM RN FROM (SELECT A.*,c.UNIT_NAME,UNIT_AREA");
		builder.append(" FROM (SELECT * FROM ").append(table).append(" dd ");
		if (null != where && !"".equals(where))
			builder.append(" where " + where);
		builder.append(") A,COMMERCIAL_INFO c");
		builder.append(" WHERE  c.commercial_id=A.commercial_id ")
				
				.append(" order by A.input_date  )a)b WHERE b.RN>=" + (this.getCurPage() - 1)
						* this.getPageSize() +" and b.RN<=").append(this.getCurPage() * this.pageSize);

		return builder.toString();
	}

	private boolean hasFeeChain;

	/**
	 * 查询所有业务
	 * 
	 * @return
	 */
	public Object[] findAll(String where, String type) throws Exception
	{
		List<Apppay101_Info> infos = new ArrayList<Apppay101_Info>();

		String table = "APPPAY_" + type;

		this.setTable(table);
		this.setWhere(where);

		ResultSet rs = super.execQuery(this.initPage(table, where));
		selectData(infos, rs, false);
		rs.close();
		return infos.toArray();
	}

	private List<AppayApproveModel> loadApproveModel(String sql,
			boolean checked, int comId) throws Exception
	{
		List<AppayApproveModel> list = new ArrayList<AppayApproveModel>();
		ResultSet result = super.execQuery(sql);
		while (result.next())
		{
			AppayApproveModel model = new AppayApproveModel();
			// a1.APPPAY_ID, a1.APPTYPE, a1.APPR_STATUS
			model.setAPPPAY_ID(result.getInt("APPPAY_ID"));
			model.setAPP_TYPE(result.getString("APPTYPE"));
			model.setAPPR_STATUS(result.getInt("APPR_STATUS"));
			model.setE_ID(result.getString("OPERMAN_NAME"));
			if (checked)
			{
				model.setAPPR_DATE(result.getString("APPR_DATE"));
				model.setTERM_ID1(result.getString("TERM_ID1"));
				model.setTERM_ID2(result.getString("TERM_ID2"));
				model.setIsBind(1);
			}

			model.setCOMMERCIAL_ID(comId);

			if ("101".equals(model.getAPP_TYPE()))
			{
				model.setMore("<a href='bussinessInsert.jsp?show=1&appayId="
						+ model.getAPPPAY_ID() + "&CommercialId=" + comId
						+ "'>详细</a>");
			} else if ("103".equals(model.getAPP_TYPE()))
			{
				model.setMore("<a href='bussinessInsert103.jsp?show=1&appayId="
						+ model.getAPPPAY_ID() + "&CommercialId=" + comId
						+ "'>详细</a>");
			} else if ("105".equals(model.getAPP_TYPE()))
			{
				model.setMore("<a href='bussinessInsert105.jsp?show=1&appayId="
						+ model.getAPPPAY_ID() + "&CommercialId=" + comId
						+ "'>详细</a>");
			}
			list.add(model);
		}
		result.close();
		super.debug("查询终端的业务信息：" + sql);
		return list;
	}

	/**
	 * 终端页面显示的业务信息
	 * 
	 * @param terminalId
	 * @param commercialId
	 * @return
	 * @throws Exception
	 */
	public Object[] findWithTerminal(int terminalId, int commercialId)
			throws Exception
	{
		StringBuffer sql = new StringBuffer();

		sql.append("select a.APPPAY_ID,a.APPTYPE,(select o.OPERMAN_NAME from OPERMAN_INFO o where  o.OPERMAN_ID=a.E_ID) as OPERMAN_NAME,to_char(a.APPR_DATE,'yyyy-MM-dd') APPR_DATE,a.APPR_STATUS,t.TERM_ID1,t.TERM_ID2 ");
		sql.append(" from APPPAY_101 a,TERM_APP_TABLE t ");
		sql.append(
				" where (t.status=1 or t.status=0) and a.APPPAY_ID in (select APPPAY_ID from TERM_APP_TABLE s where s.COMMERCIAL_ID=")
				.append(commercialId);
		sql.append(" and s.TEMINAL_INFO_ID=").append(terminalId)
				.append(" and s.APPTYPE='101')");
		sql.append(
				" and a.APPTYPE='101' and a.APPPAY_ID=t.APPPAY_ID  and a.COMMERCIAL_ID=")
				.append(commercialId).append(" and t.teminal_info_id=")
				.append(terminalId);

		// 第二个。。。。。
		sql.append(" union all  ");
		sql.append(" select a.APPPAY_ID,a.APPTYPE,(select o.OPERMAN_NAME from OPERMAN_INFO o where  o.OPERMAN_ID=a.E_ID) as OPERMAN_NAME,to_char(a.APPR_DATE,'yyyy-MM-dd') APPR_DATE,a.APPR_STATUS,t.TERM_ID1,t.TERM_ID2 ");
		sql.append(" from APPPAY_103 a,TERM_APP_TABLE t ");
		sql.append(
				" where (t.status=1 or t.status=0) and a.APPPAY_ID in (select APPPAY_ID from TERM_APP_TABLE s where s.COMMERCIAL_ID=")
				.append(commercialId);
		sql.append(" and s.TEMINAL_INFO_ID=").append(terminalId)
				.append(" and s.APPTYPE='103')");
		sql.append(
				" and a.APPTYPE='103' and a.APPPAY_ID=t.APPPAY_ID  and a.COMMERCIAL_ID=")
				.append(commercialId).append(" and t.teminal_info_id=")
				.append(terminalId);
		// 第三个。。。。。
		sql.append(" union all  ");
		sql.append(" select a.APPPAY_ID,a.APPTYPE,(select o.OPERMAN_NAME from OPERMAN_INFO o where  o.OPERMAN_ID=a.E_ID) as OPERMAN_NAME,to_char(a.APPR_DATE,'yyyy-MM-dd') APPR_DATE,a.APPR_STATUS,t.TERM_ID1,t.TERM_ID2 ");
		sql.append(" from APPPAY_102 a,TERM_APP_TABLE t ");
		sql.append(
				" where (t.status=1 or t.status=0) and a.APPPAY_ID in (select APPPAY_ID from TERM_APP_TABLE s where s.COMMERCIAL_ID=")
				.append(commercialId);
		sql.append(" and s.TEMINAL_INFO_ID=").append(terminalId)
				.append(" and s.APPTYPE='102')");
		sql.append(
				" and a.APPTYPE='102' and a.APPPAY_ID=t.APPPAY_ID  and a.COMMERCIAL_ID=")
				.append(commercialId).append(" and t.teminal_info_id=")
				.append(terminalId);		
		sql.append(" union all  ");
		// 第四个。。。。。
		sql.append(" select a.APPPAY_ID,a.APPTYPE,(select o.OPERMAN_NAME from OPERMAN_INFO o where  o.OPERMAN_ID=a.E_ID) as OPERMAN_NAME,to_char(a.APPR_DATE,'yyyy-MM-dd') APPR_DATE,a.APPR_STATUS,t.TERM_ID1,t.TERM_ID2 ");
		sql.append(" from APPPAY_105 a,TERM_APP_TABLE t ");
		sql.append(
				" where (t.status=1 or t.status=0) and a.APPPAY_ID in (select APPPAY_ID from TERM_APP_TABLE s where s.COMMERCIAL_ID=")
				.append(commercialId);
		sql.append(" and s.TEMINAL_INFO_ID=").append(terminalId)
				.append(" and s.APPTYPE='105')");
		sql.append(
				" and a.APPTYPE='105' and a.APPPAY_ID=t.APPPAY_ID  and a.COMMERCIAL_ID=")
				.append(commercialId).append(" and t.teminal_info_id=")
				.append(terminalId);

		List<AppayApproveModel> infos = new ArrayList<AppayApproveModel>();

		infos.addAll(this.loadApproveModel(sql.toString(), true, commercialId));
		// infos.addAll(this.loadApproveModel(
		// sql.toString().replace("101", "103"), true, commercialId));
		// infos.addAll(this.loadApproveModel(
		// sql.toString().replace("101", "105"), true, commercialId));

		StringBuffer notSql = new StringBuffer();
		notSql.append(
				"select a1.APPPAY_ID,  a1.APPTYPE, a1.APPR_STATUS,(select o.OPERMAN_NAME from OPERMAN_INFO o where  o.OPERMAN_ID=a1.E_ID) as OPERMAN_NAME ")
				.append("  from APPPAY_103 a1 ");
		notSql.append(" where a1.APPTYPE='103' and a1.apppay_id not in");
		notSql.append(
				"(select t.apppay_id from Term_App_Table t where  t.commercial_id = ")
				.append(commercialId)
				.append(" and t.teminal_info_id=")
				.append(terminalId)
				.append(" and (t.status=1  or t.status=0)) and a1.APPTYPE='103' and a1.commercial_id=")
				.append(commercialId);
		// ..
		notSql.append(" union all ");
		notSql.append(
				"select a1.APPPAY_ID,  a1.APPTYPE, a1.APPR_STATUS,(select o.OPERMAN_NAME from OPERMAN_INFO o where  o.OPERMAN_ID=a1.E_ID) as OPERMAN_NAME ")
				.append("  from APPPAY_101 a1 ");
		notSql.append(" where a1.APPTYPE='101'  and a1.apppay_id not in");
		notSql.append(
				"(select t.apppay_id from Term_App_Table t where  t.commercial_id = ")
				.append(commercialId)
				.append(" and t.teminal_info_id=")
				.append(terminalId)
				.append(" and (t.status=1  or t.status=0)) and a1.APPTYPE='101'  and a1.commercial_id=")
				.append(commercialId);
		// ..
		notSql.append(" union all ");
		notSql.append(
				"select a1.APPPAY_ID,  a1.APPTYPE, a1.APPR_STATUS,(select o.OPERMAN_NAME from OPERMAN_INFO o where  o.OPERMAN_ID=a1.E_ID) as OPERMAN_NAME ")
				.append("  from APPPAY_102 a1 ");
		notSql.append(" where a1.APPTYPE='102'  and a1.apppay_id not in");
		notSql.append(
				"(select t.apppay_id from Term_App_Table t where  t.commercial_id = ")
				.append(commercialId)
				.append(" and t.teminal_info_id=")
				.append(terminalId)
				.append(" and (t.status=1  or t.status=0)) and a1.APPTYPE='102'  and a1.commercial_id=")
				.append(commercialId);		
		// ...
		notSql.append(" union all ");
		notSql.append(
				"select a1.APPPAY_ID,  a1.APPTYPE, a1.APPR_STATUS,(select o.OPERMAN_NAME from OPERMAN_INFO o where  o.OPERMAN_ID=a1.E_ID) as OPERMAN_NAME ")
				.append("  from APPPAY_105 a1 ");
		notSql.append(" where a1.APPTYPE='105'  and a1.apppay_id not in");
		notSql.append(
				"(select t.apppay_id from Term_App_Table t where  t.commercial_id = ")
				.append(commercialId)
				.append(" and t.teminal_info_id=")
				.append(terminalId)
				.append(" and (t.status=1  or t.status=0)) and a1.APPTYPE='105'  and a1.commercial_id=")
				.append(commercialId);
		infos.addAll(this.loadApproveModel(notSql.toString(), false,
				commercialId));
		// infos.addAll(this.loadApproveModel(
		// notSql.toString().replace("103", "101"), false, commercialId));
		// infos.addAll(this.loadApproveModel(
		// notSql.toString().replace("103", "105"), false, commercialId));
		return infos.toArray();
	}

	public Object[] findByCommercialId(int commercialId, boolean has102)
			throws Exception
	{
		StringBuffer sql = new StringBuffer();
		sql.append("select a.APPPAY_ID,a.APPTYPE,o.OPERMAN_NAME,to_char(a.APPR_DATE,'yyyy-MM-dd') APPR_DATE,a.APPR_STATUS,t.TERM_ID1,t.TERM_ID2 ");
		sql.append(" from APPPAY_101 a,TERM_APP_TABLE t ,OPERMAN_INFO o");
		sql.append(" where a.COMMERCIAL_ID=")
				.append(commercialId)
				.append(" and a.APPPAY_ID=t.APPPAY_ID and t.APPTYPE='101' and  o.OPERMAN_ID=a.E_ID and t.status!=3");

		// ---s
		sql.append(" union all ");
		sql.append("select a.APPPAY_ID,a.APPTYPE,o.OPERMAN_NAME,to_char(a.APPR_DATE,'yyyy-MM-dd') APPR_DATE,a.APPR_STATUS,t.TERM_ID1,t.TERM_ID2 ");
		sql.append(" from APPPAY_103 a,TERM_APP_TABLE t ,OPERMAN_INFO o");
		sql.append(" where a.COMMERCIAL_ID=")
				.append(commercialId)
				.append(" and a.APPPAY_ID=t.APPPAY_ID and  a.APPTYPE='103' and o.OPERMAN_ID=a.E_ID and t.status!=3");
		// ---
		sql.append(" union all ");
		sql.append("select a.APPPAY_ID,a.APPTYPE,o.OPERMAN_NAME,to_char(a.APPR_DATE,'yyyy-MM-dd') APPR_DATE,a.APPR_STATUS,t.TERM_ID1,t.TERM_ID2 ");
		sql.append(" from APPPAY_105 a,TERM_APP_TABLE t ,OPERMAN_INFO o");
		sql.append(" where a.COMMERCIAL_ID=")
				.append(commercialId)
				.append(" and a.APPPAY_ID=t.APPPAY_ID and  a.APPTYPE='105' and o.OPERMAN_ID=a.E_ID and t.status!=3");

		List<AppayApproveModel> infos = new ArrayList<AppayApproveModel>();

		// infos.addAll(this.loadApproveModel(
		// sql.toString().replace("101", "103"), false, commercialId));
		// infos.addAll(this.loadApproveModel(
		// sql.toString().replace("101", "105"), false, commercialId));
		if (has102)
		{
			sql.append(" union all ");
			sql.append("select a.APPPAY_ID,a.APPTYPE,o.OPERMAN_NAME,to_char(a.APPR_DATE,'yyyy-MM-dd') APPR_DATE,a.APPR_STATUS,t.TERM_ID1,t.TERM_ID2 ");
			sql.append(" from APPPAY_102 a,TERM_APP_TABLE t ,OPERMAN_INFO o");
			sql.append(" where a.COMMERCIAL_ID=")
					.append(commercialId)
					.append(" and a.APPPAY_ID=t.APPPAY_ID and o.OPERMAN_ID=a.E_ID and t.status!=3");

			// infos.addAll(this.loadApproveModel(
			// sql.toString().replace("101", "102"), false, commercialId));
		}

		infos.addAll(this.loadApproveModel(sql.toString(), false, commercialId));
		return infos.toArray();
	}

	public Object[] findByCommercialId(int commercialId) throws Exception
	{
		String sql = " select INPUT_DATE ,CHANGE_DATE,(select t.term_id1 from TERM_APP_TABLE t where rownum=1 and a.APPPAY_ID=t.APPPAY_ID and t.APPTYPE='101') as trem1,a.COMMERCIAL_ID,o.operman_name,a.APPPAY_ID,a.APPTYPE, a.APPR_STATUS,a.contract_fee,to_char(a.input_date,'yyyy-MM-dd') input_date from APPPAY_101 a,OPERMAN_INFO o where a.commercial_id="
				+ commercialId
				+ " and a.E_ID=o.operman_id  "
				+ "union all "
				+ " select INPUT_DATE ,CHANGE_DATE,' ', a.COMMERCIAL_ID,o.operman_name,a.APPPAY_ID,a.APPTYPE, a.APPR_STATUS,a.FEE_SET,to_char(a.input_date,'yyyy-MM-dd') input_date from APPPAY_102 a,OPERMAN_INFO o where a.commercial_id="
				+ commercialId
				+ " and a.E_ID=o.operman_id   "
				+ "union all "
				+ "  select INPUT_DATE ,CHANGE_DATE,(select t.term_id1 from TERM_APP_TABLE t where rownum=1 and a.APPPAY_ID=t.APPPAY_ID and t.APPTYPE='103') as trem1, a.COMMERCIAL_ID,o.operman_name,a.APPPAY_ID,a.APPTYPE, a.APPR_STATUS,a.contract_fee,to_char(a.input_date,'yyyy-MM-dd') input_date from APPPAY_103 a,OPERMAN_INFO o where a.commercial_id="
				+ commercialId
				+ " and a.E_ID=o.operman_id"
				+ " union all "
				+ "  select INPUT_DATE ,CHANGE_DATE,(select t.term_id1 from TERM_APP_TABLE t where rownum=1 and a.APPPAY_ID=t.APPPAY_ID and t.APPTYPE='105') as trem1,a.COMMERCIAL_ID,o.operman_name,a.APPPAY_ID,a.APPTYPE, a.APPR_STATUS,a.contract_fee,to_char(a.input_date,'yyyy-MM-dd') input_date from APPPAY_105 a,OPERMAN_INFO o where a.commercial_id="
				+ commercialId
				+ " and a.E_ID=o.operman_id "
				+ "union all "
				+ " select INPUT_DATE ,CHANGE_DATE,' ', a.COMMERCIAL_ID,o.operman_name,a.APPPAY_ID,a.APPTYPE, a.APPR_STATUS,a.FEE_SET,to_char(a.input_date,'yyyy-MM-dd') input_date from APPPAY_106 a,OPERMAN_INFO o where a.commercial_id="
				+ commercialId + " and a.E_ID=o.operman_id   ";

		List<AppayComShowModel> infos = new ArrayList<AppayComShowModel>();
		ResultSet set = super.execQuery(sql);
		while (set.next())
		{
			AppayComShowModel model = new AppayComShowModel();
			model.setAPPPAY_ID(set.getInt("APPPAY_ID"));
			model.setAPPR_STATUS(set.getInt("APPR_STATUS"));
			model.setAPPTYPE(set.getString("APPTYPE"));
			model.setCOMMERCIAL_ID(set.getInt("COMMERCIAL_ID"));
			model.setTrem1(set.getString("trem1"));
			if (null != set.getTimestamp("INPUT_DATE"))
			{
				model.setInput(new Date(set.getTimestamp("INPUT_DATE")
						.getTime()));
			}
			if (null != set.getTimestamp("CHANGE_DATE"))
			{
				model.setChange(new Date(set.getTimestamp("CHANGE_DATE")
						.getTime()));
			}

			if ("101".equalsIgnoreCase(model.getAPPTYPE()))
			{
				model.setAPPTYPE("实名支付");
				model.setMore("<a href='bussinessInsert.jsp?show=1&appayId="
						+ model.getAPPPAY_ID() + "&CommercialId="
						+ model.getCOMMERCIAL_ID() + "'>详细</a>");

			} else if ("102".equals(model.getAPPTYPE()))
			{
				model.setAPPTYPE("收付宝");
				model.setMore("<a href='bussinessInsert102.jsp?show=1&appayId="
						+ model.getAPPPAY_ID() + "&CommercialId="
						+ model.getCOMMERCIAL_ID() + "'>详细</a>");
			} else if ("103".equals(model.getAPPTYPE()))
			{
				model.setAPPTYPE("便捷付");
				model.setMore("<a href='bussinessInsert103.jsp?show=1&appayId="
						+ model.getAPPPAY_ID() + "&CommercialId="
						+ model.getCOMMERCIAL_ID() + "'>详细</a>");
			} else if ("105".equals(model.getAPPTYPE()))
			{
				model.setAPPTYPE("收单");
				model.setMore("<a href='bussinessInsert105.jsp?show=1&appayId="
						+ model.getAPPPAY_ID() + "&CommercialId="
						+ model.getCOMMERCIAL_ID() + "'>详细</a>");
			} else if ("106".equals(model.getAPPTYPE()))
			{
				model.setAPPTYPE("自助终端");
				model.setMore("<a href='bussinessInsert106.jsp?show=1&appayId="
						+ model.getAPPPAY_ID() + "&CommercialId="
						+ model.getCOMMERCIAL_ID() + "'>详细</a>");
			}
			model.setContract_fee(set.getString("contract_fee"));
			model.setName(set.getString("operman_name"));
			infos.add(model);
		}
		// String appay1 = "select * from APPPAY_101 where COMMERCIAL_ID="
		// + commercialId;
		// String appay2 = "select * from APPPAY_102 where COMMERCIAL_ID="
		// + commercialId;
		// String appay3 = "select * from APPPAY_103 where COMMERCIAL_ID="
		// + commercialId;
		//
		//
		// ResultSet rs = super.execQuery(appay1);
		// selectData(infos, rs, false);
		//
		// ResultSet rs2 = super.execQuery(appay2);
		// selectData(infos, rs2, false);
		//
		// ResultSet rs3 = super.execQuery(appay3);
		// selectData(infos, rs3, false);

		// rs.close();
		// rs2.close();
		// rs3.close();

		return infos.toArray();
	}

	private void selectData(List<Apppay101_Info> infos, ResultSet rs,
			boolean isBind) throws SQLException
	{
		while (rs.next())
		{
			Apppay101_Info info = new Apppay101_Info();
			info.setAPPPAY_ID(rs.getInt("APPPAY_ID"));
			info.setCOMMERCIAL_ID(rs.getInt("COMMERCIAL_ID"));
			String type = rs.getString("APPTYPE");
			boolean is105 = false;
			if (null != type)
			{
				if ("101".equalsIgnoreCase(type))
				{
					info.setAPPTYPE("实名支付");
					info.setMore("<a href='bussinessInsert.jsp?show=1&appayId="
							+ info.getAPPPAY_ID() + "&CommercialId="
							+ info.getCOMMERCIAL_ID() + "'>详细</a>");

				} else if ("102".equals(type))
				{
					info.setAPPTYPE("收付宝");
					info.setMore("<a href='bussinessInsert102.jsp?show=1&appayId="
							+ info.getAPPPAY_ID()
							+ "&CommercialId="
							+ info.getCOMMERCIAL_ID() + "'>详细</a>");
				} else if ("103".equals(type))
				{
					info.setAPPTYPE("便捷付");

					info.setMore("<a href='bussinessInsert103.jsp?show=1&appayId="
							+ info.getAPPPAY_ID()
							+ "&CommercialId="
							+ info.getCOMMERCIAL_ID() + "'>详细</a>");
				} else if ("105".equals(type))
				{
					info.setAPPTYPE("收单");
					is105 = true;
					info.setMore("<a href='bussinessInsert105.jsp?show=1&appayId="
							+ info.getAPPPAY_ID()
							+ "&CommercialId="
							+ info.getCOMMERCIAL_ID() + "'>详细</a>");
				} else if ("106".equals(type))
				{
					info.setAPPTYPE("自助终端");
					is105 = true;
					info.setMore("<a href='bussinessInsert106.jsp?show=1&appayId="
							+ info.getAPPPAY_ID()
							+ "&CommercialId="
							+ info.getCOMMERCIAL_ID() + "'>详细</a>");
				}
			}
			info.setACCOUNT_TYPE(rs.getInt("ACCOUNT_TYPE"));
			info.setACCOUNT_NO(rs.getString("ACCOUNT_NO"));
			info.setACCOUNT_BANK(rs.getString("ACCOUNT_BANK"));
			info.setACCOUNT_BANK_ID(rs.getString("ACCOUNT_BANK_ID"));
			info.setACCOUNT_PROVINCE(rs.getString("ACCOUNT_PROVINCE"));
			info.setACCOUNT_CITY(rs.getString("ACCOUNT_CITY"));
			info.setACCOUNT_NAME(rs.getString("ACCOUNT_NAME"));
			info.setUNIT_AREA(rs.getString("UNIT_AREA"));

			if (this.hasFeeChain)
			{
				info.setFee_chan(rs.getInt("fee_chan"));
			}

			if (!is105)
			{
				info.setE_ID(rs.getInt("E_ID"));
				info.setEC_NAME(rs.getString("EC_NAME"));
				info.setTERM_ID1(rs.getString("TERM_ID1"));
				info.setTERM_ID2(rs.getString("TERM_ID2"));
			}

			info.setAPPR_MAN(rs.getString("APPR_MAN"));
			info.setAPPR_STATUS(rs.getInt("APPR_STATUS"));
			info.setAPPR_DATE(rs.getDate("APPR_DATE"));
			info.setAPPR_REMARK(rs.getString("APPR_REMARK"));
			info.setSTATUS(rs.getInt("STATUS"));

			// ---------

			String input = rs.getString("INPUT_DATE");
			String change = rs.getString("CHANGE_DATE");
			try
			{
				if (null != input)
				{
					info.setINPUT_DATE(new Date(rs.getTimestamp("INPUT_DATE")
							.getTime()));
				}
				if (null != change)
				{
					info.setCHANGE_DATE(new Date(rs.getTimestamp("CHANGE_DATE")
							.getTime()));
				}
			} catch (Exception e)
			{
				e.printStackTrace();
			}

			// ...用户名称
			info.setCommercialName(rs.getString("UNIT_NAME"));
			if (isBind)
				info.setIsBind(1);
			infos.add(info);
		}
	}

	@Override
	public Apppay101_Info[] select(String sql) throws Exception
	{
		return null;
	}

	@Override
	public Apppay101_Info[] select(Apppay101_Info data) throws Exception
	{
		return null;
	}

	@Override
	public int insert(Apppay101_Info data) throws Exception
	{
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void update(Apppay101_Info data) throws Exception
	{
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(int id) throws Exception
	{
		// TODO Auto-generated method stub

	}

	@Override
	public void operate(Apppay101_Info info) throws Exception
	{
		// TODO Auto-generated method stub

	}

	public int getCurrent_size()
	{
		return current_size;
	}

	@Override
	public Apppay101_Info findById(int id) throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}

}
