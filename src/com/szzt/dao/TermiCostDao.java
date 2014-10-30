package com.szzt.dao;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.AbstractDao;
import com.dodou.table.TemiCost;
import com.dodou.table.Terminal_Info;

public class TermiCostDao extends AbstractDao<TemiCost>
{
	public static final String TABLE = "TEMICOST";

	public TermiCostDao()
	{
	}

	public TermiCostDao(String where, String table)
	{
		super(where, table);
	}

	public void operate(TemiCost info, int terminalId) throws Exception
	{
		if (null != info.getCOSTNUMBER()
				&& info.getCOSTNUMBER().trim().length() > 0)
		{
			super.initUpdate(TABLE);
			if (null != info.getCOSTNUMBER())
			{
				super.wrapUpdateSql("COSTNUMBER", info.getCOSTNUMBER());
			}
			if (null != info.getREFUNDDATE())
			{
				super.wrapUpdateSql(
						"REFUNDDATE",
						"to_date('"
								+ new SimpleDateFormat("yyyy-MM-dd")
										.format(info.getREFUNDDATE())
								+ "','yyyy-MM-dd')");
			}

			super.update(" TEMINAL_INFO_ID=" + terminalId + " and COST_TYPE="
					+ info.getCOST_TYPE());
		}

	}

	@Override
	public void operate(TemiCost info) throws Exception
	{
		super.initUpdate(TABLE);
		super.wrapUpdateSql("COSTNUMBER", info.getCOSTNUMBER());
		super.update("COSTTYPEID=" + info.getCOSTTYPEID());
	}

	// 根据终端id查询
	public TemiCost[] findById(String id) throws Exception
	{
		String sql = "select *  from " + TABLE + " where TEMINAL_INFO_ID=" + id;
		return this.select(sql);
	}

	@Override
	public TemiCost[] select(String sql) throws Exception
	{
		if (null == sql || "".equals(sql))
		{
			return this.select();
		}

		TemiCost[] infos = new TemiCost[4];

		ResultSet result = super.execQuery(sql);
		int j = 0;
		while (result.next())
		{
			TemiCost info = new TemiCost();
			info.setCOSTTYPEID(result.getInt("COSTTYPEID"));
			info.setTEMINAL_INFO_ID(result.getInt("TEMINAL_INFO_ID"));
			info.setCOST_NAME(result.getString("COST_NAME"));
			info.setCOST_TYPE(result.getInt("COST_TYPE"));
			info.setCOSTNUMBER(result.getString("COSTNUMBER"));
			info.setMONEY(result.getString("MONEY"));
			info.setCYCLE(result.getInt("CYCLE"));
			info.setSTARTDATE(result.getDate("STARTDATE"));
			info.setFINALDATE(result.getDate("FINALDATE"));
			info.setREFUNDDATE(result.getDate("REFUNDDATE"));
			info.setSTATUS(result.getInt("STATUS"));
			infos[j++] = info;
		}

		super.debug("查询出TEMICOST信息总数为：" + infos.length);
		result.close();

		return infos;
	}

	@Override
	public TemiCost[] select(TemiCost data) throws Exception
	{
		return null;
	}

	@Override
	public int insert(TemiCost data) throws Exception
	{
		String sql = "insert into " + TABLE;
		String fields = "COSTTYPEID";
		String values = "COSTTYPEID_ID.nextval";

		fields += ",TEMINAL_INFO_ID";
		values += "," + data.getTEMINAL_INFO_ID() + "";

		if (null != data.getCOST_NAME())
		{
			fields += ",COST_NAME";
			values += ",'" + data.getCOST_NAME() + "'";
		}
		// 费用类型
		fields += ",COST_TYPE";
		values += "," + data.getCOST_TYPE();

		// 费用记账账号
		if (data.getCOSTNUMBER() != null)
		{
			fields += ",COSTNUMBER";
			values += ",'" + data.getCOSTNUMBER() + "'";
		}

		if (data.getMONEY() != null)
		{
			fields += ",MONEY";
			values += ",'" + data.getMONEY() + "'";
		}
		// 收费周期
		fields += ",CYCLE";
		values += "," + data.getCYCLE();
		// 状态
		fields += ",STATUS";
		values += "," + data.getSTATUS();

		// 日期
		fields += ",STARTDATE";
		values += ",sysdate";
		// fields += ",FINALDATE";
		// values += ",to_date('" + format.format(data.getFINALDATE())
		// + "','yyyy-MM-dd')";
		// fields += ",REFUNDDATE";
		// values += ",to_date('" + format.format(data.getREFUNDDATE())
		// + "','yyyy-MM-dd')";

		sql += "(" + fields + ") values (" + values + ")";
		DatabaseAccess dba = super.executeUpdate(sql);
		int id = super.loadCurrentId(dba, "TEMICOST", "COSTTYPEID");
		return id;
	}

	@Override
	public void update(TemiCost data) throws Exception
	{
		super.initUpdate(TABLE);

		// super.wrapUpdateSql("COST_NAME", "'" + data.getCOST_NAME() + "'");
		super.wrapUpdateSql("COST_TYPE", data.getCOST_TYPE());
		if (null != data.getCOSTNUMBER())
		{
			super.wrapUpdateSql("COSTNUMBER", "'" + data.getCOSTNUMBER() + "'");
		}
		if (null != data.getMONEY())
		{
			super.wrapUpdateSql("MONEY", "'" + data.getMONEY() + "'");
		}

		super.wrapUpdateSql("CYCLE", data.getCYCLE());

		super.wrapUpdateSql("STATUS", data.getSTATUS());
		// super.wrapUpdateSql("STARTDATE",
		// "to_date('" + format.format(data.getSTARTDATE())
		// + "','yyyy-MM-dd')");
		// super.wrapUpdateSql("FINALDATE",
		// "to_date('" + format.format(data.getFINALDATE())
		// + "','yyyy-MM-dd')");
		// super.wrapUpdateSql("REFUNDDATE",
		// "to_date('" + format.format(data.getREFUNDDATE())
		// + "','yyyy-MM-dd')");
		super.update(" COSTTYPEID=" + data.getCOSTTYPEID());
	}

	@Override
	public void delete(int id) throws Exception
	{
		String del = "delete from " + TABLE + " where COSTTYPEID=" + id;
		DatabaseAccess dba = null;
		try
		{
			dba = super.executeUpdate(del);
			super.debug("-------->机具费用表删除成功<------------");
		} catch (Exception e)
		{
			if (null != dba)
				dba.rollback();
			e.printStackTrace();
		}
	}

	@Override
	public TemiCost findById(int id) throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}

}
