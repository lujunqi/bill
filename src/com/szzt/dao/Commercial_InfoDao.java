package com.szzt.dao;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.AbstractDao;
import com.dodou.table.Commercial_Info;
import com.szzt.exception.DeleteException;
import com.szzt.exception.DumplicateException;
import com.szzt.exception.ForbidUpdateException;
import com.szzt.util.PhotoUtils;

public class Commercial_InfoDao extends AbstractDao<Commercial_Info>
{
	private Map<Integer, String> apppayContainer = null;
	public static final String TABLE = "COMMERCIAL_INFO";
	private boolean hasName;

	public Commercial_InfoDao()
	{
	}

	public Commercial_InfoDao(String where, String table)
	{
		super(where, table);
	}

	@Override
	public String initQuerySql()
	{
		StringBuffer builder = new StringBuffer();
		builder.append(
				"SELECT * FROM (SELECT A.*, ROWNUM RN FROM (SELECT  allData.Commercial_Id,  allData.TAX_SIGN_CARD,      allData.Unit_Name,        allData.Unit_Attr,        allData.Unit_Add,        allData.Unit_Area,        allData.Comm_No,        allData.Comm_Name,        allData.Comm_Ad,        allData.Trade_Name,        allData.Contact_Name_1,        allData.Contact_Tel_1,        allData.Contact_Name_2,        allData.Contact_Tel_2,        allData.Unit_Status,        allData.Comm_Rating,        allData.Input_Date,        allData.Change_Date,        allData.Remark_Info,        allData.Com_Sim_Name,        allData.Legaler_Name,        allData.Legal_Id_Card,        allData.Unti_Code_Card,        allData.Contact_Email,        allData.Input_User_Id,        (select man.operman_name           from Operman_Info man          where man.operman_id = allData.Input_User_Id) as name FROM ")
				.append(super.getTable()).append(" allData");

		if (null != super.getWhere() && !"".equals(super.getWhere()))
			builder.append(" where " + super.getWhere()).append(") A");

		builder.append(" WHERE ROWNUM<=")
				.append(this.getCurPage() * this.pageSize)
				.append(")")
				.append("   WHERE RN>=" + (this.getCurPage() - 1)
						* this.getPageSize());
		this.hasName = true;
		super.debug("分页查询的语句:::：" + builder.toString());
		return builder.toString();
	}

	/**
	 * 判断营业执照编码唯一
	 * 
	 * @param comNo
	 * @return 0 唯一，否则不唯一
	 * @throws Exception
	 */
	public int checkSigletonComNum(String comNo) throws Exception
	{
		String sql = "select COMMERCIAL_ID from " + TABLE + " where COMM_NO='"
				+ comNo + "'";
		ResultSet set = super.execQuery(sql);
		int result = 0;
		if (set.next())
			result = set.getInt(1);
		set.close();
		return result;
	}

	public int insert(Commercial_Info commercial) throws Exception
	{
		if (this.checkSigletonComNum(commercial.getCOMM_NO().replace("'", "")) != 0)
		{
			throw new DumplicateException();
		}

		String sql = "insert into COMMERCIAL_INFO ";
		String fields = "COMMERCIAL_ID";
		String values = "COMMERCIAL_ID_SEQ.nextval";

		fields += ",UNIT_STATUS";
		values += "," + commercial.getUNIT_STATUS();
		fields += ",COMM_RATING";
		values += "," + commercial.getCOMM_RATING();
		// 录入人员。。。。
		fields += ",INPUT_USER_ID";
		values += "," + commercial.getINPUT_USER_ID();

		// 单位名称
		if (commercial.getUNIT_NAME() != null)
		{
			fields += ",UNIT_NAME";
			values += "," + commercial.getUNIT_NAME();
		}
		// 单位性质0-4
		if (commercial.getUNIT_ATTR() > 0)
		{
			fields += ",UNIT_ATTR";
			values += "," + commercial.getUNIT_ATTR();
		}
		if (commercial.getUNIT_ADD() != null)
		{
			fields += ",UNIT_ADD";
			values += "," + commercial.getUNIT_ADD();
		}
		if (commercial.getUNIT_AREA() != null)
		{
			fields += ",UNIT_AREA";
			values += "," + commercial.getUNIT_AREA();
		}

		// 工商执照编码
		if (commercial.getCOMM_NO() != null)
		{
			fields += ",COMM_NO";
			values += "," + commercial.getCOMM_NO();
		}
		// 工商执照名称
		if (commercial.getCOMM_NAME() != null)
		{
			fields += ",COMM_NAME";
			values += "," + commercial.getCOMM_NAME();
		}
		// 工商执照地址
		if (commercial.getCOMM_AD() != null)
		{
			fields += ",COMM_AD";
			values += "," + commercial.getCOMM_AD();
		}
		// 商户对外营业名称
		if (commercial.getTRADE_NAME() != null)
		{
			fields += ",TRADE_NAME";
			values += "," + commercial.getTRADE_NAME();
		}

		// 客户单位联系人_1
		if (commercial.getCONTACT_NAME_1() != null)
		{
			fields += ",CONTACT_NAME_1";
			values += "," + commercial.getCONTACT_NAME_1();
		}
		// 客户单位联系人电话_1
		if (commercial.getCONTACT_TEL_1() != null)
		{
			fields += ",CONTACT_TEL_1";
			values += "," + commercial.getCONTACT_TEL_1();
		}
		// 客户单位联系人_2
		if (commercial.getCONTACT_NAME_2() != null)
		{
			fields += ",CONTACT_NAME_2";
			values += "," + commercial.getCONTACT_TEL_2();
		}
		// 客户单位联系人电话_2
		if (commercial.getCONTACT_TEL_2() != null)
		{
			fields += ",CONTACT_TEL_2";
			values += "," + commercial.getCONTACT_TEL_2();
		}
		// 备注信息
		if (commercial.getREMARK_INFO() != null)
		{
			fields += ",REMARK_INFO";
			values += "," + commercial.getREMARK_INFO();
		}

		// 录入时间和更改时间系统自动生成
		fields += ",INPUT_DATE";
		values += ",sysdate";
		fields += ",CHANGE_DATE";
		values += ",sysdate";

		// -------------------------新增字段-----------------------------------------

		if (commercial.getCONTACT_EMAIL() != null)
		{
			fields += ",CONTACT_EMAIL";
			values += "," + commercial.getCONTACT_EMAIL();
		}

		if (null != commercial.getCOM_SIM_NAME())
		{
			// 必填的信息
			// 客户简称
			fields += ",COM_SIM_NAME";
			values += "," + commercial.getCOM_SIM_NAME();
		}

		if (null != commercial.getLEGALER_NAME())
		{ // 法人
			fields += ",LEGALER_NAME";
			values += "," + commercial.getLEGALER_NAME();
		}

		if (null != commercial.getLEGAL_ID_CARD())
		{// 法人ID
			fields += ",LEGAL_ID_CARD";
			values += "," + commercial.getLEGAL_ID_CARD();
		}

		// 组织机构代码证
		if (null != commercial.getUNTI_CODE_CARD())
		{
			fields += ",UNTI_CODE_CARD";
			values += "," + commercial.getUNTI_CODE_CARD();
		}

		if (null != commercial.getTAX_SIGN_CARD())
		{
			// 税务登记证
			fields += ",TAX_SIGN_CARD";
			values += "," + commercial.getTAX_SIGN_CARD();

		}

		sql += "(" + fields + ") values (" + values + ")";
		DatabaseAccess dba = super.executeUpdate(sql);
		int id = super.loadCurrentId(dba, "COMMERCIAL_INFO", "COMMERCIAL_ID");
		System.out.println("插入的商户ID为-->" + id);
		return id;
	}

	@Override
	public Commercial_Info[] select(String sql) throws Exception
	{
		if (null == sql)
		{
			return this.select();
		}

		Commercial_Info[] infos = new Commercial_Info[getPageSize()];

		super.debug("commericalDaoSql-->" + sql);
		ResultSet result = super.execQuery(sql);

		result.last();
		this.setTotalCount(result.getRow());
		result.first();
		int j = 0;
		for (int i = this.getStart(); i < this.getEnd(); i++)
		{
			if (this.getTotalCount() == 0)
				break;
			result.absolute(i + 1);
			Commercial_Info info = wrapToModel(result);

			infos[j++] = info;
		}

		super.debug("查询出Commercial_info信息总数为：" + this.getTotalCount());
		result.close();

		return infos;
	}

	public List<Commercial_Info> selectList(String sql) throws Exception
	{
		List<Commercial_Info> list = new ArrayList<Commercial_Info>();

		sql = this.initQuerySql();
		ResultSet result = super.execQuery(sql);

		while (result.next())
		{
			Commercial_Info info = wrapToModel(result);
			list.add(info);
		}

		result.close();

		return list;
	}

	private Commercial_Info wrapToModel(ResultSet result) throws SQLException
	{
		Commercial_Info info = new Commercial_Info();
		info.setCOMMERCIAL_ID(result.getInt("COMMERCIAL_ID"));
		info.setUNIT_NAME(result.getString("UNIT_NAME"));
		info.setUNIT_ATTR(result.getInt("UNIT_ATTR"));
		info.setUNIT_ADD(result.getString("UNIT_ADD"));
		info.setUNIT_AREA(result.getString("UNIT_AREA"));
		info.setCOMM_NO(result.getString("COMM_NO"));
		info.setCOMM_NAME(result.getString("COMM_NAME"));
		info.setCOMM_AD(result.getString("COMM_AD"));
		info.setTRADE_NAME(result.getString("TRADE_NAME"));
		info.setCONTACT_NAME_1(result.getString("CONTACT_NAME_1"));
		info.setCONTACT_TEL_1(result.getString("CONTACT_TEL_1"));
		info.setCONTACT_NAME_2(result.getString("CONTACT_NAME_2"));
		info.setCONTACT_TEL_2(result.getString("CONTACT_TEL_2"));
		info.setUNIT_STATUS(result.getInt("UNIT_STATUS"));
		info.setCOMM_RATING(result.getString("COMM_RATING"));
		try
		{
			if (this.hasName)
				info.setInput_name(result.getString("name"));
		} catch (Exception e)
		{
		}

		if (null != result.getTimestamp("INPUT_DATE"))
		{
			info.setINPUT_DATE(new Date(result.getTimestamp("INPUT_DATE")
					.getTime()));
		}
		if (null != result.getTimestamp("CHANGE_DATE"))
		{
			info.setCHANGE_DATE(new Date(result.getTimestamp("CHANGE_DATE")
					.getTime()));
		}

		info.setREMARK_INFO(result.getString("REMARK_INFO"));
		// ------------------新增字段===================
		info.setCONTACT_EMAIL(result.getString("CONTACT_EMAIL"));
		info.setCOM_SIM_NAME(result.getString("COM_SIM_NAME"));
		info.setLEGALER_NAME(result.getString("LEGALER_NAME"));
		info.setLEGAL_ID_CARD(result.getString("LEGAL_ID_CARD"));
		info.setUNTI_CODE_CARD(result.getString("UNTI_CODE_CARD"));
		info.setTAX_SIGN_CARD(result.getString("TAX_SIGN_CARD"));
		return info;
	}

	@Override
	public Commercial_Info[] select(Commercial_Info data) throws Exception
	{
		return null;
	}

	@Override
	public void update(Commercial_Info commercial) throws Exception
	{

		if (!this.checkStatus(commercial.getCOMMERCIAL_ID()))
		{
			throw new ForbidUpdateException();
		}
		StringBuffer sql = new StringBuffer("update  COMMERCIAL_INFO set ");
		// .append(" UNIT_STATUS=" + commercial.getUNIT_STATUS() + ",");

		// sql.append("COMM_RATING=").append(commercial.getCOMM_RATING())
		// .append(",");

		// 单位名称
		if (commercial.getUNIT_NAME() != null)
		{
			sql.append("UNIT_NAME=").append(commercial.getUNIT_NAME())
					.append(",");
		}
		// 单位性质0-4
		if (commercial.getUNIT_ATTR() >= 0 && commercial.getUNIT_ATTR() <= 4)
		{
			sql.append("UNIT_ATTR=").append(commercial.getUNIT_ATTR())
					.append(",");
		}
		if (commercial.getUNIT_ADD() != null)
		{
			sql.append("UNIT_ADD=").append(commercial.getUNIT_ADD())
					.append(",");
		}
		if (commercial.getUNIT_AREA() != null)
		{
			sql.append("UNIT_AREA=").append(commercial.getUNIT_AREA())
					.append(",");
		}

		// 工商执照编码
		if (commercial.getCOMM_NO() != null)
		{
			sql.append("COMM_NO=").append(commercial.getCOMM_NO()).append(",");
		}
		// 工商执照名称
		if (commercial.getCOMM_NAME() != null)
		{
			sql.append("COMM_NAME=").append(commercial.getCOMM_NAME())
					.append(",");
		}
		// 工商执照地址
		if (commercial.getCOMM_AD() != null)
		{
			sql.append("COMM_AD=").append(commercial.getCOMM_AD()).append(",");
		}
		// 商户对外营业名称
		if (commercial.getTRADE_NAME() != null)
		{
			sql.append("TRADE_NAME=").append(commercial.getTRADE_NAME())
					.append(",");
		}

		// 客户单位联系人_1
		if (commercial.getCONTACT_NAME_1() != null)
		{
			sql.append("CONTACT_NAME_1=")
					.append(commercial.getCONTACT_NAME_1()).append(",");
		}
		// 客户单位联系人电话_1
		if (commercial.getCONTACT_TEL_1() != null)
		{
			sql.append("CONTACT_TEL_1=").append(commercial.getCONTACT_TEL_1())
					.append(",");
		}
		// 客户单位联系人_2
		if (commercial.getCONTACT_NAME_2() != null)
		{
			sql.append("CONTACT_NAME_2=").append(commercial.getCONTACT_TEL_2())
					.append(",");
		}
		// 客户单位联系人电话_2
		if (commercial.getCONTACT_TEL_2() != null)
		{
			sql.append("CONTACT_TEL_2=").append(commercial.getCONTACT_TEL_2())
					.append(",");
		}
		// 备注信息
		if (commercial.getREMARK_INFO() != null)
		{
			sql.append("REMARK_INFO=").append(commercial.getREMARK_INFO())
					.append(",");
		}

		// ----------新增字段----------------------

		if (commercial.getCONTACT_EMAIL() != null)
		{
			sql.append("CONTACT_EMAIL=").append(commercial.getCONTACT_EMAIL())
					.append(",");
		} else
		{
			sql.append("CONTACT_EMAIL=").append("''").append(",");
		}

		// 必填的信息

		if (null != commercial.getCOM_SIM_NAME())
		{

			// 客户简称
			sql.append("COM_SIM_NAME=").append(commercial.getCOM_SIM_NAME())
					.append(",");
		}

		if (null != commercial.getLEGALER_NAME())
		{
			// 法人
			sql.append("LEGALER_NAME=").append(commercial.getLEGALER_NAME())
					.append(",");
		}

		if (null != commercial.getLEGAL_ID_CARD())
		{
			// 法人ID
			sql.append("LEGAL_ID_CARD=").append(commercial.getLEGAL_ID_CARD())
					.append(",");

		}
		if (null != commercial.getUNTI_CODE_CARD())
		{ // 组织机构代码证
			sql.append("UNTI_CODE_CARD=")
					.append(commercial.getUNTI_CODE_CARD()).append(",");
		}
		if (null != commercial.getTAX_SIGN_CARD())
		{ // 税务登记证
			sql.append("TAX_SIGN_CARD=").append(commercial.getTAX_SIGN_CARD())
					.append(",");
		}
		// 录入时间和更改时间系统自动生成
		SimpleDateFormat format = new SimpleDateFormat("yyy-MM-dd");
		sql.append("CHANGE_DATE=").append(
				"to_date('" + format.format(commercial.getCHANGE_DATE())
						+ "','yyyy-MM-dd')");
		sql.append(" where COMMERCIAL_ID=" + commercial.getCOMMERCIAL_ID());

		super.executeUpdate(sql.toString());
		super.debug("update commercial---》" + sql.toString());
	}

	private boolean checkStatus(int id) throws Exception
	{
		// 判断业务的状态
		// 判断终端的状态
		String ter = "select count(*) from TEMINAL_INFO where COMMERCIAL_ID="
				+ id + " and TEMINAL_STATUS!=1";
		if (this.status(ter))// 终端没有待审批的
		{
			String a1 = "select count(*) from APPPAY_103 where COMMERCIAL_ID="
					+ id + " and APPR_STATUS=2";
			if (this.status(a1)
					&& this.status(a1.replace("APPPAY_103", "APPPAY_102"))
					&& this.status(a1.replace("APPPAY_103", "APPPAY_101"))
					&& this.status(a1.replace("APPPAY_106", "APPPAY_106")))
			{
				return true;
			}
		}
		return false;
	}

	private boolean status(String sql) throws Exception
	{
		ResultSet result = super.execQuery(sql);
		if (result.next())
		{
			BigDecimal big = result.getBigDecimal(1);
			return big.intValue() == 0;
		}
		return false;
	}

	@Override
	public void delete(int id) throws Exception
	{
		if (this.checkStatus(id))
		{
			// 1 先删除客户
			// 2 删除客户的终端
			// 3 删除客户的业务appay101 appay102 appay103
			// 4 删除中间表
			String deleteCommercial = "delete from " + TABLE
					+ " where COMMERCIAL_ID=" + id;
			String deleteTerminal = "delete from TEMINAL_INFO where COMMERCIAL_ID="
					+ id;
			String deleteAppay1 = "delete from APPPAY_101 where COMMERCIAL_ID="
					+ id;
			String deleteAppay2 = "delete from APPPAY_102 where COMMERCIAL_ID="
					+ id;
			String deleteAppay3 = "delete from APPPAY_103 where COMMERCIAL_ID="
					+ id;
			String deleteAppay5 = "delete from APPPAY_105 where COMMERCIAL_ID="
					+ id;
			String deleteAppay6 = "delete from APPPAY_106 where COMMERCIAL_ID="
					+ id;
			String TERM_APP_TABLE = "delete from TERM_APP_TABLE where COMMERCIAL_ID="
					+ id;
			String cost = "delete from TEMICOST where TEMINAL_INFO_ID in (select TEMINAL_INFO_ID from TEMINAL_INFO where COMMERCIAL_ID="
					+ id + ")";

			DatabaseAccess dba = null;
			try
			{
				dba = super.executeUpdate(deleteCommercial);
				int costs = dba.executeUpdate(cost);
				int terminal = dba.executeUpdate(deleteTerminal);
				int app1 = dba.executeUpdate(deleteAppay1);
				int app2 = dba.executeUpdate(deleteAppay2);
				int app3 = dba.executeUpdate(deleteAppay3);
				int app5 = dba.executeUpdate(deleteAppay5);
				int app6 = dba.executeUpdate(deleteAppay6);
				int temp = dba.executeUpdate(TERM_APP_TABLE);
				super.debug("-------------->客户删除成功！<---------------");
				super.debug("删除终端个数：" + terminal);
				super.debug("删除apppay1个数：" + app1);
				super.debug("删除apppay2个数：" + app2);
				super.debug("删除apppay3个数：" + app3);
				super.debug("删除apppay5个数：" + app5);
				super.debug("删除apppay6个数：" + app6);
				super.debug("删除费用表个数：" + costs);
				super.debug("删除中间表个数：" + temp);
				super.debug("-------------->客户删除成功！<---------------");
			} catch (Exception e)
			{
				e.printStackTrace();
				if (null != dba)
					dba.rollback();
			}
		} else
		{
			throw new DeleteException();
		}
	}

	/**
	 * 根据客户id删除图片信息
	 * 
	 * @param session
	 * @param commercialId
	 */
	public void deletePhotos(final HttpSession session, final int commercialId)
			throws Exception
	{
		StringBuffer buffer = new StringBuffer();
		buffer.append(
				"select a.apppay_id,'105' tt  from APPPAY_105 a where COMMERCIAL_ID=")
				.append(commercialId);
		buffer.append(
				" union all select a.apppay_id,'103' tt  from APPPAY_103 a where COMMERCIAL_ID=")
				.append(commercialId);
		buffer.append(
				" union select a.apppay_id,'101' tt  from APPPAY_101 a where COMMERCIAL_ID=")
				.append(commercialId);
		ResultSet set = super.execQuery(buffer.toString());
		apppayContainer = new HashMap<Integer, String>();
		while (set.next())
		{
			// 删除图片
			// super.deletoAppPhoto(set.getInt("apppay_id"));
			apppayContainer.put(set.getInt("apppay_id"), set.getString("tt"));
		}
		set.close();
		new Thread()
		{
			public void run()
			{
				PhotoUtils utils = new PhotoUtils();
				if (apppayContainer.size() > 0)
				{
					Iterator<Integer> it = apppayContainer.keySet().iterator();
					while (it.hasNext())
					{
						int next = it.next();
						utils.delPhotoByApp(session, apppayContainer.get(next),
								next + "");
					}

				}

			}
		}.start();
	}

	@Override
	public void operate(Commercial_Info info) throws Exception
	{

	}

	@Override
	public Commercial_Info findById(int id) throws Exception
	{
		String sql = "select * from " + TABLE + " where COMMERCIAL_ID=" + id;
		ResultSet rs = super.execQuery(sql);
		Commercial_Info info = null;
		if (rs.next())
		{
			info = this.wrapToModel(rs);
		}
		rs.close();
		release();
		return info;
	}
}
