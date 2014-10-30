package com.szzt.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.AbstractDao;
import com.szzt.model.AssignOrderModel;

public class AssignOrderDao extends AbstractDao<AssignOrderModel>
{
	public static final String TABLE = "COMPLAINTS_INFO";

	public AssignOrderDao(String table, String where)
	{
		super(where, table);
	}

	public AssignOrderDao()
	{
	}

	public List<AssignOrderModel> loadByTerminal(String sql) throws Exception
	{
		StringBuffer buffer = new StringBuffer();
		buffer.append("select com.COMMERCIAL_ID,com.UNIT_NAME,com.UNIT_ATTR,com.CONTACT_NAME_1,com.CONTACT_TEL_1");
		buffer.append(",ter.UNIT_INSTALLED_ADD,ter.TEMINAL_INFO_ID,ter.safe_man,(select OPERMAN_NAME from OPERMAN_INFO where  OPERMAN_ID=ter.safe_man) as OPERMAN_NAME");
		buffer.append(" from TEMINAL_INFO ter,");
		buffer.append("COMMERCIAL_INFO com");
		buffer.append(" where ter.COMMERCIAL_ID=com.COMMERCIAL_ID  ");
		buffer.append(null == sql ? null : sql);
		List<AssignOrderModel> list = new ArrayList<AssignOrderModel>();
		ResultSet set = super.execQuery(buffer.toString());
		while (set.next())
		{
			AssignOrderModel model = new AssignOrderModel();
			model.setCOMMERCIAL_ID(set.getInt("COMMERCIAL_ID"));
			model.setCONTACT_NAME_1(set.getString("CONTACT_NAME_1"));
			model.setCONTACT_TEL_1(set.getString("CONTACT_TEL_1"));
			model.setTEMINAL_INFO_ID(set.getInt("TEMINAL_INFO_ID"));
			model.setUNIT_ATTR(set.getInt("UNIT_ATTR"));
			model.setUNIT_INSTALLED_ADD(set.getString("UNIT_INSTALLED_ADD"));
			model.setSAFE_MAN(set.getInt("safe_man") + "");
			model.setUNIT_NAME(set.getString("UNIT_NAME"));
			list.add(model);
		}
		set.close();
		super.release();
		return list;
	}

	@Override
	public void operate(AssignOrderModel info) throws Exception
	{

	}

	@Override
	public String initQuerySql()
	{
		StringBuilder builder = new StringBuilder();
		builder.append(
				"SELECT * FROM (SELECT A.*,o.operman_name, ROWNUM RN FROM  ")
				.append(TABLE).append(" A,operman_info o");
		builder.append(" WHERE ROWNUM<=")
				.append(this.getCurPage() * this.pageSize)
				.append(" and o.operman_id=A.Safe_Man ");
		if (null != super.getWhere() && !"".equals(super.getWhere()))
		{
			builder.append(super.getWhere());
		}
		builder.append(") allData WHERE RN>=" + (this.getCurPage() - 1)
				* this.getPageSize());
		return builder.toString();
	}

	public int size(String where) throws Exception
	{
		StringBuilder builder = new StringBuilder();
		builder.append(
				"SELECT count(*) FROM (SELECT A.*,o.operman_name, ROWNUM RN FROM  ")
				.append(TABLE).append(" A,operman_info o");
		builder.append(" WHERE o.operman_id=A.Safe_Man ) allData where 1=1 ");
		if (null != where && !"".equals(where))
		{
			builder.append(where);
		}
		ResultSet set = super.execQuery(builder.toString());
		set.next();
		int size = set.getInt(1);
		set.close();
		return size;
	}

	public AssignOrderModel findById(int id) throws Exception
	{
		StringBuilder builder = new StringBuilder();
		builder.append("SELECT A.*,o.operman_name, ROWNUM RN FROM  ")
				.append(TABLE).append(" A,operman_info o");
		builder.append(" WHERE o.operman_id=A.Safe_Man and comp_id=" + id);

		ResultSet set = super.execQuery(builder.toString());
		AssignOrderModel model = new AssignOrderModel();
		if (set.next())
		{
			model.setCOMP_ID(set.getInt("comp_id"));
			model.setCOMMERCIAL_ID(set.getInt("commercial_id"));
			model.setCOMP_TYPE(set.getString("comp_type"));
			model.setCOMP_CONT(set.getString("comp_cont"));
			model.setINPUT_MAN(set.getInt("input_man"));
			model.setSLOVE_CONT(set.getString("solve_cont"));
			model.setCOMP_STATUS(set.getString("comp_status"));
			model.setCOMP_DATE(set.getString("comp_date"));
			model.setCHANGE_DATE(set.getString("change_date"));
			model.setCONTACT_NAME_1(set.getString("connectman"));
			model.setCONTACT_TEL_1(set.getString("connecttel"));
			model.setSAFE_MAN(set.getString("operman_name"));
			model.setTEMINAL_INFO_ID(set.getInt("TEMINAL_INFO_ID"));
			model.setUNIT_NAME(set.getString("UNIT_NAME"));
		}
		set.close();
		return model;
	}

	public List<AssignOrderModel> selectByList(String where) throws Exception
	{
		String sql = this.initQuerySql();
		this.setTotalCount(this.size(where));

		ResultSet set = super.execQuery(sql + where);
		List<AssignOrderModel> list = new ArrayList<AssignOrderModel>();

		while (set.next())
		{
			AssignOrderModel model = new AssignOrderModel();
			model.setCOMP_ID(set.getInt("comp_id"));
			model.setCOMMERCIAL_ID(set.getInt("commercial_id"));
			model.setCOMP_TYPE(set.getString("comp_type"));
			model.setCOMP_CONT(set.getString("comp_cont"));
			model.setINPUT_MAN(set.getInt("input_man"));
			model.setSLOVE_CONT(set.getString("solve_cont"));
			model.setCOMP_STATUS(set.getString("comp_status"));
			model.setCOMP_DATE(set.getString("comp_date"));
			model.setCHANGE_DATE(set.getString("change_date"));
			model.setCONTACT_NAME_1(set.getString("connectman"));
			model.setCONTACT_TEL_1(set.getString("connecttel"));
			model.setSAFE_MAN(set.getString("operman_name"));
			model.setTEMINAL_INFO_ID(set.getInt("TEMINAL_INFO_ID"));
			model.setUNIT_NAME(set.getString("UNIT_NAME"));
			list.add(model);
		}
		set.close();
		return list;
	}

	@Override
	public AssignOrderModel[] select(String where) throws Exception
	{
		return null;
	}

	@Override
	public AssignOrderModel[] select(AssignOrderModel data) throws Exception
	{
		return null;
	}

	@Override
	public int insert(AssignOrderModel data) throws Exception
	{
		String sql = "insert into  " + TABLE;
		String fields = "comp_id";
		String values = "comp_id_id.nextval";

		// fields += ",change_date";
		// values += ",to_char(sysdate,'yyyy-MM-dd HH:mm:ss')";

		if (data.getCOMMERCIAL_ID() > 0)
		{
			fields += ",commercial_id";
			values += "," + data.getCOMMERCIAL_ID();
		}
		if (null != data.getCOMP_CONT())
		{
			fields += ",comp_cont";
			values += "," + data.getCOMP_CONT();
		}
		if (null != data.getCOMP_TYPE())
		{
			fields += ",COMP_TYPE";
			values += "," + data.getCOMP_TYPE();
		}
		fields += ",input_man";
		values += "," + data.getINPUT_MAN();

		fields += ",safe_man";
		values += "," + data.getSAFE_MAN();

		// if (null != data.getSLOVE_CONT())
		// {
		// fields += ",solve_cont";
		// values += "," + data.getSLOVE_CONT();
		// }
		fields += ",comp_status";
		values += ",1";

		fields += ",comp_date";
		values += ",sysdate";

		if (data.getTEMINAL_INFO_ID() > 0)
		{
			fields += ",TEMINAL_INFO_ID";
			values += "," + data.getTEMINAL_INFO_ID();
		}
		if (null != data.getUNIT_NAME())
		{
			fields += ",UNIT_NAME";
			values += "," + data.getUNIT_NAME();
		}

		if (data.getCONTACT_NAME_1() != null)
		{
			fields += ",connectman";
			values += "," + data.getCONTACT_NAME_1();
		}

		if (data.getCONTACT_TEL_1() != null)
		{
			fields += ",connecttel";
			values += "," + data.getCONTACT_TEL_1();
		}
		sql += "(" + fields + ") values (" + values + ")";
		DatabaseAccess dba = super.executeUpdate(sql);
		dba.release();
		return -1;
	}

	@Override
	public void update(AssignOrderModel data) throws Exception
	{
		if (null != data)
		{
			super.initUpdate(TABLE);
			super.wrapUpdateSql("change_date", "sysdate");
			super.wrapUpdateSql("solve_cont", data.getSLOVE_CONT());
			super.wrapUpdateSql("comp_status", 2);
			super.update(" comp_id=" + data.getCOMP_ID());
			super.release();
		}

	}

	@Override
	public void delete(int id) throws Exception
	{

	}

}
