package com.szzt.dao;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.AbstractDao;
import com.dodou.log.Log;
import com.dodou.table.Teminal_info_visit_call;
import com.szzt.model.VisitBacklogModel;
import com.szzt.util.BindResultSetData;

public class Teminal_info_visit_callDao extends
		AbstractDao<Teminal_info_visit_call>
{
	public static final String TABLE = "TEMINAL_INFO_VISIT_CALL";

	public List<VisitBacklogModel> findAllWithSafeMan(String where,String man)
			throws Exception
	{
		StringBuilder builder = new StringBuilder();
		builder.append("SELECT allData.* FROM (select visit.*,com.UNIT_NAME, (select o.operman_name from  OPERMAN_INFO o where o.OPERMAN_ID = tem.SAFE_MAN and OPERMAN_NAME like '%"+man+"%')as operman_name,tem.UNIT_INSTALLED_NAME, ROWNUM RN FROM ");
		builder.append(Commercial_InfoDao.TABLE)
				.append(" com ,")
				.append(Terminal_InfoDao.TABLE)
				.append("  tem,")
				.append(TABLE)
				.append(" visit")
				.append(" where tem.teminal_info_id=visit.teminal_info_id and tem.commercial_id=com.commercial_id  ");
		builder.append(where == null ? "" : where);
		builder.append(" and ROWNUM<")
				.append(this.getCurPage() * this.pageSize);
		builder.append(" ) ").append(
				"  allData WHERE RN>=" + (this.getCurPage() - 1)
						* this.getPageSize());
		StringBuilder counts = new StringBuilder();
		counts.append("SELECT count(*) FROM (select visit.*,com.UNIT_NAME, (select o.operman_name from  OPERMAN_INFO o where o.OPERMAN_ID = tem.SAFE_MAN and OPERMAN_NAME like '%"+man+"%')as operman_name,tem.UNIT_INSTALLED_NAME, ROWNUM RN FROM ");
		counts.append(Commercial_InfoDao.TABLE)
				.append(" com ,")
				.append(Terminal_InfoDao.TABLE)
				.append("  tem,")
				.append(TABLE)
				.append(" visit")
				.append("  where tem.teminal_info_id=visit.teminal_info_id and tem.commercial_id=com.commercial_id  ");
		counts.append(where == null ? "" : where);
		counts.append(" ) ");

		ResultSet count = super.execQuery(counts.toString());

		count.next();
		this.setTotalCount(count.getInt(1));
		count.close();

		// StringBuffer sql = new StringBuffer();
		// sql.append("select visit.*,com.UNIT_NAME,o.OPERMAN_NAME,tem.UNIT_INSTALLED_NAME ");
		// sql.append(" from ").append(Commercial_InfoDao.TABLE).append("  com ,")
		// .append(Terminal_InfoDao.TABLE).append("  tem,").append(TABLE)
		// .append(" visit").append(",OPERMAN_INFO o");
		// sql.append(" where tem.teminal_info_id=visit.teminal_info_id and tem.commercial_id=com.commercial_id ");
		// sql.append(" and o.OPERMAN_ID=tem.SAFE_MAN");
		// sql.append(where == null ? "" : where);
		ResultSet rs = super.execQuery(builder.toString());
		List<VisitBacklogModel> list = new ArrayList<VisitBacklogModel>();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		while (rs.next())
		{
			VisitBacklogModel model = new VisitBacklogModel();
			model.setDEMO(rs.getString("demo"));
			model.setUNIT_NAME(rs.getString("UNIT_NAME"));
			model.setSAFE_MAN(rs.getString("OPERMAN_NAME"));
			model.setTEMINAL_INFO_VISIT_CALL_ID(rs
					.getInt("TEMINAL_INFO_VISIT_CALL_ID"));

			model.setVisit_date(format.format(rs.getDate("visit_date")));

			model.setHas_col1(rs.getInt("has_col1"));
			model.setHas_col2(rs.getInt("has_col2"));
			model.setHas_col3(rs.getInt("has_col3"));
			model.setHas_col4(rs.getInt("has_col4"));
			model.setHas_col5(rs.getInt("has_col5"));
			model.setHas_col6(rs.getInt("has_col6"));
			model.setHas_col7(rs.getInt("has_col7"));
			model.setHas_col8(rs.getInt("has_col8"));
			model.setHas_col9(rs.getInt("has_col9"));
			model.setHas_col10(rs.getInt("has_col10"));

			list.add(model);
		}
		rs.close();
		super.release();
		return list;

	}

	public List<VisitBacklogModel> findAll(String where) throws Exception
	{
		StringBuilder builder = new StringBuilder();
		//(select o.operman_name from  OPERMAN_INFO o where o.OPERMAN_ID = tem.SAFE_MAN)as operman_name
		builder.append("SELECT allData.* FROM (select visit.*,com.UNIT_NAME, o.operman_name ,tem.UNIT_INSTALLED_NAME, ROWNUM RN FROM ");
		builder.append(Commercial_InfoDao.TABLE)
				.append(" com ,")
				.append(Terminal_InfoDao.TABLE)
				.append("  tem,")
				.append(TABLE)
				.append(" visit ,OPERMAN_INFO o ")
				.append(" where   o.OPERMAN_ID = tem.SAFE_MAN and tem.teminal_info_id=visit.teminal_info_id and tem.commercial_id=com.commercial_id  ");
		builder.append(where == null ? "" : where);
		builder.append(" and ROWNUM<")
				.append(this.getCurPage() * this.pageSize);
		builder.append(" ) ").append(
				"  allData WHERE RN>=" + (this.getCurPage() - 1)
						* this.getPageSize());
		StringBuilder counts = new StringBuilder();
		counts.append("SELECT count(*) FROM (select visit.*,com.UNIT_NAME, o.operman_name,tem.UNIT_INSTALLED_NAME, ROWNUM RN FROM ");
		counts.append(Commercial_InfoDao.TABLE)
				.append(" com ,")
				.append(Terminal_InfoDao.TABLE)
				.append("  tem,")
				.append(TABLE)
				.append(" visit ,OPERMAN_INFO o  ")
				.append("  where o.OPERMAN_ID = tem.SAFE_MAN and tem.teminal_info_id=visit.teminal_info_id and tem.commercial_id=com.commercial_id  ");
		counts.append(where == null ? "" : where);
		counts.append(" ) ");

		ResultSet count = super.execQuery(counts.toString());

		count.next();
		this.setTotalCount(count.getInt(1));
		count.close();

		// StringBuffer sql = new StringBuffer();
		// sql.append("select visit.*,com.UNIT_NAME,o.OPERMAN_NAME,tem.UNIT_INSTALLED_NAME ");
		// sql.append(" from ").append(Commercial_InfoDao.TABLE).append("  com ,")
		// .append(Terminal_InfoDao.TABLE).append("  tem,").append(TABLE)
		// .append(" visit").append(",OPERMAN_INFO o");
		// sql.append(" where tem.teminal_info_id=visit.teminal_info_id and tem.commercial_id=com.commercial_id ");
		// sql.append(" and o.OPERMAN_ID=tem.SAFE_MAN");
		// sql.append(where == null ? "" : where);
		ResultSet rs = super.execQuery(builder.toString());
		List<VisitBacklogModel> list = new ArrayList<VisitBacklogModel>();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		while (rs.next())
		{
			VisitBacklogModel model = new VisitBacklogModel();
			model.setDEMO(rs.getString("demo"));
			model.setUNIT_NAME(rs.getString("UNIT_NAME"));
			model.setSAFE_MAN(rs.getString("OPERMAN_NAME"));
			model.setTEMINAL_INFO_VISIT_CALL_ID(rs
					.getInt("TEMINAL_INFO_VISIT_CALL_ID"));

			model.setVisit_date(format.format(rs.getDate("visit_date")));

			model.setHas_col1(rs.getInt("has_col1"));
			model.setHas_col2(rs.getInt("has_col2"));
			model.setHas_col3(rs.getInt("has_col3"));
			model.setHas_col4(rs.getInt("has_col4"));
			model.setHas_col5(rs.getInt("has_col5"));
			model.setHas_col6(rs.getInt("has_col6"));
			model.setHas_col7(rs.getInt("has_col7"));
			model.setHas_col8(rs.getInt("has_col8"));
			model.setHas_col9(rs.getInt("has_col9"));
			model.setHas_col10(rs.getInt("has_col10"));

			list.add(model);
		}
		rs.close();
		super.release();
		return list;

	}

	public List<VisitBacklogModel> search(String where, int type)
			throws Exception
	{
		System.out.println("wo shi seacrakfsdklfd cdf");
		StringBuffer sql = new StringBuffer();
		StringBuilder count = new StringBuilder();

		if (1 == type)// 回访待办
		{
			sql.append("select * from(");
			sql.append("select rownum rn, (select OPERMAN_NAME from OPERMAN_INFO o where o.operman_id=tem.safe_man ) as OPERMAN_NAME ,tem.is_hurry,com.COMMERCIAL_ID,tem.APPROVAL_DATE,tem.TEMINAL_INFO_ID,com.UNIT_NAME,");
			sql.append(" (select city from WS_AREA a where a.AREAID = com.UNIT_AREA) as UNIT_AREA ");
			sql.append(" from ").append(Commercial_InfoDao.TABLE)
					.append("  com ,").append(Terminal_InfoDao.TABLE)
					.append("  tem");
			sql.append(" where  tem.commercial_id=com.commercial_id ");
			sql.append(" and tem.TEMINAL_STATUS=13 and rownum<=").append(
					this.getCurPage() * 20);
			sql.append(where == null ? "" : where);
			sql.append(")tem where rn>=").append((this.getCurPage() - 1) * 20);

			count.append("select count(*) from(");
			count.append("select rownum rn, (select OPERMAN_NAME from OPERMAN_INFO o where o.operman_id=tem.safe_man ) as OPERMAN_NAME ,tem.is_hurry,com.COMMERCIAL_ID,tem.APPROVAL_DATE,tem.TEMINAL_INFO_ID,com.UNIT_NAME,");
			count.append(" (select city from WS_AREA a where a.AREAID = com.UNIT_AREA) as UNIT_AREA ");
			count.append(" from ").append(Commercial_InfoDao.TABLE)
					.append("  com ,").append(Terminal_InfoDao.TABLE)
					.append("  tem");
			count.append(" where  tem.commercial_id=com.commercial_id ");
			count.append(" and tem.TEMINAL_STATUS=13 ");
			count.append(where == null ? "" : where);
			count.append(")tem where 1=1 ");

		} else
		{
			sql.append("select * from(");
			sql.append("select rownum rn, (select OPERMAN_NAME from OPERMAN_INFO o where o.operman_id=tem.safe_man ) as OPERMAN_NAME ,visit.TEMINAL_INFO_VISIT_CALL_ID,tem.is_hurry,com.COMMERCIAL_ID,tem.APPROVAL_DATE,tem.TEMINAL_INFO_ID,com.UNIT_NAME,visit.demo,");
			sql.append(" (select city from WS_AREA a where a.AREAID = com.UNIT_AREA) as UNIT_AREA ");
			sql.append(" from ").append(Commercial_InfoDao.TABLE)
					.append("  com ,").append(Terminal_InfoDao.TABLE)
					.append("  tem,").append(TABLE).append(" visit");
			sql.append(" where tem.teminal_info_id=visit.teminal_info_id and tem.commercial_id=com.commercial_id ");
			sql.append(" and tem.TEMINAL_STATUS=13 ");
			sql.append(" and rownum<=").append(this.getCurPage() * 20)
					.append(" ");
			sql.append(where == null ? "" : where);
			sql.append(")tem where rn>= ").append((this.getCurPage() - 1) * 20);

			count.append("select count(*) from(");
			count.append("select rownum rn, (select OPERMAN_NAME from OPERMAN_INFO o where o.operman_id=tem.safe_man ) as OPERMAN_NAME ,visit.TEMINAL_INFO_VISIT_CALL_ID,tem.is_hurry,com.COMMERCIAL_ID,tem.APPROVAL_DATE,tem.TEMINAL_INFO_ID,com.UNIT_NAME,visit.demo,");
			count.append(" (select city from WS_AREA a where a.AREAID = com.UNIT_AREA) as UNIT_AREA ");
			count.append(" from ").append(Commercial_InfoDao.TABLE)
					.append("  com ,").append(Terminal_InfoDao.TABLE)
					.append("  tem,").append(TABLE).append(" visit");
			count.append(" where tem.teminal_info_id=visit.teminal_info_id and tem.commercial_id=com.commercial_id ");
			count.append(" and tem.TEMINAL_STATUS=13 ");
			count.append(where == null ? "" : where);
			count.append(")tem where 1=1 ");
		}

		ResultSet set = super.execQuery(sql.toString());
		List<VisitBacklogModel> list = new ArrayList<VisitBacklogModel>();
		while (set.next())
		{
			VisitBacklogModel model = new VisitBacklogModel();
			model.setCOMMERCIAL_ID(set.getInt("COMMERCIAL_ID"));
			model.setAPPROVAL_DATE(set.getDate("APPROVAL_DATE"));

			model.setTEMINAL_INFO_ID(set.getInt("TEMINAL_INFO_ID"));
			model.setUNIT_AREA(set.getString("UNIT_AREA"));
			model.setUNIT_NAME(set.getString("UNIT_NAME"));
			model.setIs_hurry(set.getInt("is_hurry"));
			model.setSAFE_MAN(set.getString("OPERMAN_NAME"));

			if (type == 2)
			{
				model.setTEMINAL_INFO_VISIT_CALL_ID(set
						.getInt("TEMINAL_INFO_VISIT_CALL_ID"));

				model.setDEMO(set.getString("demo"));
				model.setTypeUndo("电话未接通");
			}
			list.add(model);
		}
		set.close();

		ResultSet r = super.execQuery(count.toString());
		if (r.next())
			this.setTotalCount(r.getInt(1));
		r.close();

		super.release();
		return list;
	}

	public Teminal_info_visit_call[] select() throws Exception
	{
		String sql = "select * from TEMINAL_INFO_VISIT_CALL order by TEMINAL_INFO_VISIT_CALL_ID desc";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] select(String sql) throws Exception
	{
		Teminal_info_visit_call[] Teminal_info_visit_callArray = new Teminal_info_visit_call[getPageSize()];
		Log.getLogger().debug("Teminal_info_visit_call [查找],SQL:[" + sql + "]");
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
			Teminal_info_visit_call teminal_info_visit_call = new Teminal_info_visit_call();
			teminal_info_visit_call.setTeminal_info_visit_call_id(rs
					.getInt("teminal_info_visit_call_id"));
			teminal_info_visit_call.setVisit_date(rs.getString("visit_date"));
			teminal_info_visit_call.setVisit_man(rs.getInt("visit_man"));
			teminal_info_visit_call.setDemo(rs.getString("demo"));
			teminal_info_visit_call.setTeminal_info_id(rs
					.getInt("teminal_info_id"));
			teminal_info_visit_call.setMerchantsno_id(rs
					.getInt("merchantsno_id"));
			teminal_info_visit_call.setHas_col1(rs.getInt("has_col1"));
			teminal_info_visit_call.setHas_col2(rs.getInt("has_col2"));
			teminal_info_visit_call.setHas_col3(rs.getInt("has_col3"));
			teminal_info_visit_call.setHas_col4(rs.getInt("has_col4"));
			teminal_info_visit_call.setHas_col5(rs.getInt("has_col5"));
			teminal_info_visit_call.setHas_col6(rs.getInt("has_col6"));
			teminal_info_visit_call.setHas_col7(rs.getInt("has_col7"));
			teminal_info_visit_call.setHas_col8(rs.getInt("has_col8"));
			teminal_info_visit_call.setHas_col9(rs.getInt("has_col9"));
			teminal_info_visit_call.setHas_col10(rs.getInt("has_col10"));
			Teminal_info_visit_callArray[j++] = teminal_info_visit_call;
		}
		Log.getLogger().debug("查询记录总数为:" + this.getTotalCount());
		rs.close();
		dba.release();
		return Teminal_info_visit_callArray;
	}

	public Teminal_info_visit_call[] select(
			Teminal_info_visit_call teminal_info_visit_call) throws Exception
	{
		String sql = "select * from TEMINAL_INFO_VISIT_CALL where 1 = 1 ";
		if (teminal_info_visit_call.getTeminal_info_visit_call_id() != 0)
		{
			sql += " and teminal_info_visit_call_id = "
					+ teminal_info_visit_call.getTeminal_info_visit_call_id()
					+ "";
		}
		if (teminal_info_visit_call.getVisit_date() != null)
		{
			sql += " and visit_date = to_date('"
					+ teminal_info_visit_call.getVisit_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_visit_call.getVisit_man() != 0)
		{
			sql += " and visit_man = " + teminal_info_visit_call.getVisit_man()
					+ "";
		}
		if (teminal_info_visit_call.getDemo() != null)
		{
			sql += " and demo = '" + teminal_info_visit_call.getDemo() + "'";
		}
		if (teminal_info_visit_call.getTeminal_info_id() != 0)
		{
			sql += " and teminal_info_id = "
					+ teminal_info_visit_call.getTeminal_info_id() + "";
		}
		if (teminal_info_visit_call.getMerchantsno_id() != 0)
		{
			sql += " and merchantsno_id = "
					+ teminal_info_visit_call.getMerchantsno_id() + "";
		}
		if (teminal_info_visit_call.getHas_col1() != 0)
		{
			sql += " and has_col1 = " + teminal_info_visit_call.getHas_col1()
					+ "";
		}
		if (teminal_info_visit_call.getHas_col2() != 0)
		{
			sql += " and has_col2 = " + teminal_info_visit_call.getHas_col2()
					+ "";
		}
		if (teminal_info_visit_call.getHas_col3() != 0)
		{
			sql += " and has_col3 = " + teminal_info_visit_call.getHas_col3()
					+ "";
		}
		if (teminal_info_visit_call.getHas_col4() != 0)
		{
			sql += " and has_col4 = " + teminal_info_visit_call.getHas_col4()
					+ "";
		}
		if (teminal_info_visit_call.getHas_col5() != 0)
		{
			sql += " and has_col5 = " + teminal_info_visit_call.getHas_col5()
					+ "";
		}
		if (teminal_info_visit_call.getHas_col6() != 0)
		{
			sql += " and has_col6 = " + teminal_info_visit_call.getHas_col6()
					+ "";
		}
		if (teminal_info_visit_call.getHas_col7() != 0)
		{
			sql += " and has_col7 = " + teminal_info_visit_call.getHas_col7()
					+ "";
		}
		if (teminal_info_visit_call.getHas_col8() != 0)
		{
			sql += " and has_col8 = " + teminal_info_visit_call.getHas_col8()
					+ "";
		}
		if (teminal_info_visit_call.getHas_col9() != 0)
		{
			sql += " and has_col9 = " + teminal_info_visit_call.getHas_col9()
					+ "";
		}
		if (teminal_info_visit_call.getHas_col10() != 0)
		{
			sql += " and has_col10 = " + teminal_info_visit_call.getHas_col10()
					+ "";
		}
		sql += " order by TEMINAL_INFO_VISIT_CALL_ID desc";
		return this.select(sql);
	}

	public int insert(Teminal_info_visit_call teminal_info_visit_call)
			throws Exception
	{
		String sql = "insert into TEMINAL_INFO_VISIT_CALL ";
		String fields = "TEMINAL_INFO_VISIT_CALL_ID";
		String values = "TEMINAL_INFO_VISIT_CALL_ID_SEQ.nextval";
		if (teminal_info_visit_call.getVisit_date() != null)
		{
			fields += ",visit_date";
			values += ",to_date('" + teminal_info_visit_call.getVisit_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_visit_call.getVisit_man() != 0)
		{
			fields += ",visit_man";
			values += "," + teminal_info_visit_call.getVisit_man() + "";
		}
		if (teminal_info_visit_call.getDemo() != null)
		{
			fields += ",demo";
			values += ",'" + teminal_info_visit_call.getDemo() + "'";
		}
		if (teminal_info_visit_call.getTeminal_info_id() != 0)
		{
			fields += ",teminal_info_id";
			values += "," + teminal_info_visit_call.getTeminal_info_id() + "";
		}
		if (teminal_info_visit_call.getMerchantsno_id() != 0)
		{
			fields += ",merchantsno_id";
			values += "," + teminal_info_visit_call.getMerchantsno_id() + "";
		}
		if (teminal_info_visit_call.getHas_col1() != 0)
		{
			fields += ",has_col1";
			values += "," + teminal_info_visit_call.getHas_col1() + "";
		}
		if (teminal_info_visit_call.getHas_col2() != 0)
		{
			fields += ",has_col2";
			values += "," + teminal_info_visit_call.getHas_col2() + "";
		}
		if (teminal_info_visit_call.getHas_col3() != 0)
		{
			fields += ",has_col3";
			values += "," + teminal_info_visit_call.getHas_col3() + "";
		}
		if (teminal_info_visit_call.getHas_col4() != 0)
		{
			fields += ",has_col4";
			values += "," + teminal_info_visit_call.getHas_col4() + "";
		}
		if (teminal_info_visit_call.getHas_col5() != 0)
		{
			fields += ",has_col5";
			values += "," + teminal_info_visit_call.getHas_col5() + "";
		}
		if (teminal_info_visit_call.getHas_col6() != 0)
		{
			fields += ",has_col6";
			values += "," + teminal_info_visit_call.getHas_col6() + "";
		}
		if (teminal_info_visit_call.getHas_col7() != 0)
		{
			fields += ",has_col7";
			values += "," + teminal_info_visit_call.getHas_col7() + "";
		}
		if (teminal_info_visit_call.getHas_col8() != 0)
		{
			fields += ",has_col8";
			values += "," + teminal_info_visit_call.getHas_col8() + "";
		}
		if (teminal_info_visit_call.getHas_col9() != 0)
		{
			fields += ",has_col9";
			values += "," + teminal_info_visit_call.getHas_col9() + "";
		}
		if (teminal_info_visit_call.getHas_col10() != 0)
		{
			fields += ",has_col10";
			values += "," + teminal_info_visit_call.getHas_col10() + "";
		}
		sql += "(" + fields + ") values (" + values + ")";
		Log.getLogger().debug("Teminal_info_visit_call [插入],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
		return -1;
	}

	public void update(Teminal_info_visit_call teminal_info_visit_call)
			throws Exception
	{
		String sql = "update TEMINAL_INFO_VISIT_CALL set TEMINAL_INFO_VISIT_CALL_ID=TEMINAL_INFO_VISIT_CALL_ID";
		if (teminal_info_visit_call.getVisit_date() != null)
		{
			sql += ",visit_date=to_date('"
					+ teminal_info_visit_call.getVisit_date()
					+ "','yyyy-MM-dd hh24:mi:ss')";
		}
		if (teminal_info_visit_call.getVisit_man() != 0)
		{
			sql += ",visit_man=" + teminal_info_visit_call.getVisit_man() + "";
		}
		if (teminal_info_visit_call.getDemo() != null)
		{
			sql += ",demo='" + teminal_info_visit_call.getDemo() + "'";
		}
		if (teminal_info_visit_call.getTeminal_info_id() != 0)
		{
			sql += ",teminal_info_id="
					+ teminal_info_visit_call.getTeminal_info_id() + "";
		}
		if (teminal_info_visit_call.getMerchantsno_id() != 0)
		{
			sql += ",merchantsno_id="
					+ teminal_info_visit_call.getMerchantsno_id() + "";
		}
		if (teminal_info_visit_call.getHas_col1() != 0)
		{
			sql += ",has_col1=" + teminal_info_visit_call.getHas_col1() + "";
		}
		if (teminal_info_visit_call.getHas_col2() != 0)
		{
			sql += ",has_col2=" + teminal_info_visit_call.getHas_col2() + "";
		}
		if (teminal_info_visit_call.getHas_col3() != 0)
		{
			sql += ",has_col3=" + teminal_info_visit_call.getHas_col3() + "";
		}
		if (teminal_info_visit_call.getHas_col4() != 0)
		{
			sql += ",has_col4=" + teminal_info_visit_call.getHas_col4() + "";
		}
		if (teminal_info_visit_call.getHas_col5() != 0)
		{
			sql += ",has_col5=" + teminal_info_visit_call.getHas_col5() + "";
		}
		if (teminal_info_visit_call.getHas_col6() != 0)
		{
			sql += ",has_col6=" + teminal_info_visit_call.getHas_col6() + "";
		}
		if (teminal_info_visit_call.getHas_col7() != 0)
		{
			sql += ",has_col7=" + teminal_info_visit_call.getHas_col7() + "";
		}
		if (teminal_info_visit_call.getHas_col8() != 0)
		{
			sql += ",has_col8=" + teminal_info_visit_call.getHas_col8() + "";
		}
		if (teminal_info_visit_call.getHas_col9() != 0)
		{
			sql += ",has_col9=" + teminal_info_visit_call.getHas_col9() + "";
		}
		if (teminal_info_visit_call.getHas_col10() != 0)
		{
			sql += ",has_col10=" + teminal_info_visit_call.getHas_col10() + "";
		}
		sql += " where TEMINAL_INFO_VISIT_CALL_ID="
				+ teminal_info_visit_call.getTeminal_info_visit_call_id() + "";
		Log.getLogger().debug("Teminal_info_visit_call [更新],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public void delete(int id) throws Exception
	{
		String sql = "delete from TEMINAL_INFO_VISIT_CALL where TEMINAL_INFO_VISIT_CALL_ID="
				+ id;
		Log.getLogger().debug("Teminal_info_visit_call [删除],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		dba.release();
	}

	public DatabaseAccess executeUpdate(String sql) throws Exception
	{
		Log.getLogger()
				.debug("Teminal_info_visit_call [自定义],SQL:[" + sql + "]");
		DatabaseAccess dba = new DatabaseAccess();
		dba.executeUpdate(sql);
		// dba.release();
		return dba;
	}

	public Teminal_info_visit_call whereTeminal_info_visit_call_id(
			int teminal_info_visit_call_id) throws Exception
	{
		String sql = "select * from teminal_info_visit_call where teminal_info_visit_call_id="
				+ teminal_info_visit_call_id + "";
		return this.select(sql)[0];
	}

	public Teminal_info_visit_call[] whereVisit_date(String visit_date)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where visit_date='"
				+ visit_date + "'";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereVisit_man(int visit_man)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where visit_man="
				+ visit_man + "";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereDemo(String demo) throws Exception
	{
		String sql = "select * from teminal_info_visit_call where demo='"
				+ demo + "'";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereTeminal_info_id(int teminal_info_id)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where teminal_info_id="
				+ teminal_info_id + "";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereMerchantsno_id(int merchantsno_id)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where merchantsno_id="
				+ merchantsno_id + "";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereHas_col1(int has_col1)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where has_col1="
				+ has_col1 + "";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereHas_col2(int has_col2)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where has_col2="
				+ has_col2 + "";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereHas_col3(int has_col3)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where has_col3="
				+ has_col3 + "";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereHas_col4(int has_col4)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where has_col4="
				+ has_col4 + "";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereHas_col5(int has_col5)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where has_col5="
				+ has_col5 + "";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereHas_col6(int has_col6)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where has_col6="
				+ has_col6 + "";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereHas_col7(int has_col7)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where has_col7="
				+ has_col7 + "";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereHas_col8(int has_col8)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where has_col8="
				+ has_col8 + "";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereHas_col9(int has_col9)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where has_col9="
				+ has_col9 + "";
		return this.select(sql);
	}

	public Teminal_info_visit_call[] whereHas_col10(int has_col10)
			throws Exception
	{
		String sql = "select * from teminal_info_visit_call where has_col10="
				+ has_col10 + "";
		return this.select(sql);
	}

	@Override
	public void operate(Teminal_info_visit_call info) throws Exception
	{
		// TODO Auto-generated method stub

	}

	@Override
	public Teminal_info_visit_call findById(int id) throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}
}
