package com.szzt.dao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.AbstractDao;
import com.dodou.inferface.AppayStatus;
import com.dodou.table.TerminalAppTemp;

/**
 * 终端业务信息插入数据表
 * 
 * @author 陈孟琳
 * 
 */
public class ApppayTerminalDao extends AbstractDao<TerminalAppTemp>
{
	public static final String TABLE = "TERM_APP_TABLE";

	/**
	 * 绑定终端与业务信息
	 * <p>
	 * 1:首先将所有终端的信息解绑
	 * </p>
	 * 2：进行二次绑定
	 * 
	 * @param commercialId
	 * @param terminalId
	 * @param appayIds
	 * @throws Exception
	 */
	public void bind(int commercialId, int terminalId, String[] appayIds)
			throws Exception
	{

		if (null != appayIds)
		{
			String delete = "delete from " + TABLE + " where TEMINAL_INFO_ID="
					+ terminalId + " and COMMERCIAL_ID=" + commercialId;
			super.executeUpdate(delete);

			for (int i = 0; i < appayIds.length; i++)
			{
				if (null == appayIds[i] || appayIds[i].trim().length() < 0)
				{
					continue;
				}
				System.out.println("绑定业务》》》》》》》》》《《《《《《《《《《" + appayIds[i]);
				String appType = "101";
				if (appayIds[i].startsWith("-"))
				{
					appType = "101";
				} else if (appayIds[i].startsWith("2"))
				{
					appType = "103";
				} else if (appayIds[i].startsWith("5"))
				{
					appType = "105";
				} else if (appayIds[i].startsWith("6"))
        			{
        				appType = "102";
        			}
				appayIds[i] = appayIds[i].substring(1);

				StringBuffer sql = new StringBuffer();

				sql.append("insert into ").append(TABLE)
						.append("(COMMERCIAL_ID,").append("TEMINAL_INFO_ID,")
						.append("APPTYPE,").append("APP_NAME,")
						.append("TERM_ID1,").append("TERM_ID2,")
						.append("MENU_VER,").append("APPDATA_NAME,")
						.append("STATUS,").append("APPPAY_ID)");
				sql.append(" values(").append(commercialId).append(",")
						.append(terminalId).append(",").append(appType)
						.append(",'appName',").append("' ',").append("' ',")
						.append("' ',").append("' ',").append(0).append(",")
						.append(appayIds[i]).append(")");

				super.executeUpdate(sql.toString());
				int status = super.loadAppayStatus("APPPAY_" + appType,
						Integer.parseInt(appayIds[i]));
				// 如果业务状态不为新增状态则改为新增终端待审批
				if (status >= AppayStatus.ALLOW)
				{
					// 设置业务的状态
					super.updateAppayStatus("APPPAY_" + appType,
							AppayStatus.NEW_TER, appayIds[i]);
				}

			}
		}
	}

	public ApppayTerminalDao()
	{
	}

	public ApppayTerminalDao(String where, String table)
	{
		super(where, table);
	}

	/**
	 * 终端业务信息录入DAO
	 * 
	 * @param request
	 * @param appayType
	 * @return
	 * @throws Exception
	 */
	public int insert(HttpServletRequest request, String appayType, int appid)
			throws Exception
	{
		HttpSession session = request.getSession();

		String sql = "insert into TERM_APP_TABLE ";
		String fields = "";
		String values = "";

		// 业务ID
		fields += "APPPAY_ID,";
		values += appid + ",";

		// 客户ID
		fields += "COMMERCIAL_ID";
		values += session.getAttribute("COMMERCIAL_ID");
		// 终端ID
		fields += ",TEMINAL_INFO_ID";
		values += "," + ((int) Math.random() * 1000);
		// 业务类型
		fields += ",APPTYPE";
		values += ",'" + appayType + "'";
		// 终端信息1
		fields += ",TERM_ID1";
		values += ",'" + "--" + "'";
		// 菜单版本号
		fields += ",MENU_VER";
		values += ",'" + "--" + "'";
		// 业务信息表名
		fields += ",APPDATA_NAME";
		values += ",'" + "--" + "'";
		// 开通状态
		fields += ",STATUS";
		values += "," + 1 + "";
		if (appayType.equals("101"))
		{
			// 开通状态
			fields += ",APP_NAME";
			values += ",'实名支付'";
		} else if (appayType.equals("102"))
		{
			// 开通状态
			fields += ",APP_NAME";
			values += ",'收付宝'";
		}

		sql += "(" + fields + ") values (" + values + ")";
		System.out.println(sql);
		DatabaseAccess dba = super.executeUpdate(sql);
		dba.release();
		return -1;
	}

	@Override
	public void delete(int id) throws Exception
	{

	}

	@Override
	public TerminalAppTemp[] select(TerminalAppTemp data) throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(TerminalAppTemp data) throws Exception
	{
		return 0;
	}

	@Override
	public void update(TerminalAppTemp data) throws Exception
	{

	}

	@Override
	public TerminalAppTemp[] select(String sql) throws Exception
	{
		return null;
	}

	@Override
	public void operate(TerminalAppTemp info) throws Exception
	{
		StringBuffer sql = new StringBuffer();
		sql.append("update ").append(TABLE).append(" set ");
		if (null != info.getTERM_ID1())
			sql.append(" TERM_ID1=").append(info.getTERM_ID1()).append(",");

		if (null != info.getTERM_ID2())
			sql.append(" TERM_ID2=").append(info.getTERM_ID2()).append(",");

		if (null != info.getTERM_ID3())
			sql.append(" TERM_ID3=").append(info.getTERM_ID3()).append(",");

		if (null != info.getTERM_ID4())
			sql.append(" TERM_ID4=").append(info.getTERM_ID4()).append(",");
		if (null != info.getMENU_VER())
			sql.append(" MENU_VER='").append(info.getMENU_VER()).append("',");

		sql.append("status=1 ");

		sql.append(" where APPPAY_ID=").append(info.getAPPPAY_ID())
				.append(" and ").append(" TEMINAL_INFO_ID=")
				.append(info.getTEMINAL_INFO_ID())
				.append(" and commercial_id=" + info.getCOMMERCIAL_ID());
		System.out.println("sql:" + sql.toString());
		super.executeUpdate(sql.toString());
	}

	@Override
	public TerminalAppTemp findById(int id) throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}
}
