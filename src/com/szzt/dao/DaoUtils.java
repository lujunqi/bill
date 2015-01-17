package com.szzt.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.Permission;
import com.dodou.log.Log;
import com.dodou.table.Operman_info;
import com.szzt.model.KeyValueModel;

/**
 * 获取跨表基本信息工具类
 * 
 * @author 陈孟琳
 * 
 */
public class DaoUtils
{
	private DatabaseAccess dba = new DatabaseAccess();

	public List<KeyValueModel> bankInfo() throws Exception
	{
		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		String sql = "select * from BANK_INFO";
		ResultSet result = dba.executeQuery(sql);
		while (result.next())
		{
			KeyValueModel model = new KeyValueModel();
			model.setKey(result.getString("BANK_CODE"));
			model.setValue(result.getString("BANK_NAME"));
			list.add(model);
		}
		dba.release();
		return list;
	}

	public List<KeyValueModel> marketInfo() throws Exception
	{
		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		String sql = "select * from MARKETDEPARTMENT";
		ResultSet result = dba.executeQuery(sql);
		while (result.next())
		{
			KeyValueModel model = new KeyValueModel();
			model.setKey(result.getString("DEPA_ID"));
			model.setValue(result.getString("DEPA_NAME"));
			list.add(model);
		}
		dba.release();
		return list;
	}

	/**
	 * 拓展渠道所有信息
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<KeyValueModel> channelInfo() throws Exception
	{
		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		String sql = "select * from CHANNEL_INFO";
		ResultSet result = dba.executeQuery(sql);
		while (result.next())
		{
			KeyValueModel model = new KeyValueModel();
			model.setKey(result.getString("CHANNEL_ID"));
			model.setValue(result.getString("CHANNEL_NAME"));
			list.add(model);
		}
		dba.release();
		return list;
	}

	/**
	 * 根据地区筛选
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<KeyValueModel> operateUserQuery(String area) throws Exception
	{
		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		String sql = "select OPERMAN_NAME,OPERMAN_ID from OPERMAN_INFO where OPER_ADDRESS='"
				+ area + "' and OPER_STATUS=1 order by OPERMAN_NAME desc";
		ResultSet result = dba.executeQuery(sql);
		wrapModel(list, result);
		dba.release();
		System.out.println("pppppppppp");
		return list;
	}

	/**
	 * 根据地区筛选
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<KeyValueModel> operateUser(String area) throws Exception
	{
		if ("0000".equals(area))
		{
			return this.operateUser();
		}
		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		String sql = "select OPERMAN_NAME,OPERMAN_ID from OPERMAN_INFO where OPER_ADDRESS='"
				+ area + "' and OPER_STATUS=1 order by OPERMAN_NAME desc";
		ResultSet result = dba.executeQuery(sql);
		wrapModel(list, result);
		dba.release();
		System.out.println("pppppppppp");
		return list;
	}

	/**
	 * 所有的操作人员
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<KeyValueModel> operateUser() throws Exception
	{
		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		String sql = "select OPERMAN_NAME,OPERMAN_ID from OPERMAN_INFO  order by OPERMAN_NAME desc";
		ResultSet result = dba.executeQuery(sql);
		wrapModel(list, result);
		dba.release();
		return list;
	}

	public List<KeyValueModel> operateUser(int position) throws Exception
	{
		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		String sql = "select OPERMAN_NAME,OPERMAN_ID from OPERMAN_INFO where OPERMAN_ID in(select OPERMAN_ID from USE_ROLE_INFO where POST_ID="
				+ position + ") order by OPERMAN_NAME desc";
		ResultSet result = dba.executeQuery(sql);
		wrapModel(list, result);
		System.out.println(sql);
		dba.release();
		return list;
	}

	/**
	 * 获取本地区拓展人
	 * 
	 * @param session
	 * @return
	 * @throws Exception
	 */
	public List<KeyValueModel> localExpandUser(HttpSession session, boolean all)
			throws Exception
	{
		Operman_info man = (Operman_info) session.getAttribute("man");
		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		if (man.getOper_address().equals("0000"))
		{
			return this.operateUser();
		}
		String sql = "select OPERMAN_NAME,OPERMAN_ID from OPERMAN_INFO where   OPERMAN_ID in(select OPERMAN_ID from USE_ROLE_INFO where POST_ID="
				+ Permission.EXPAND_POSITION + ")";
		if (all)
		{
			sql += " and OPER_ADDRESS=" + man.getOper_address()
					+ " order by OPERMAN_NAME desc";
		}
		System.out.println("本地区拓展人：" + sql);
		ResultSet result = dba.executeQuery(sql);
		wrapModel(list, result);
		dba.release();
		return list;
	}

	/**
	 * 拓展岗获取拓展人员
	 * <p>
	 * 除孔莹璨、黄明霞开放可选全省人员外，其他拓展人员录入时，可选拓展人必须为本地市人员
	 * </p>
	 * 
	 * @param position
	 * @return
	 * @throws Exception
	 */
	public List<KeyValueModel> expandUser(HttpSession session) throws Exception
	{
		Operman_info info = (Operman_info) session.getAttribute("man");
		// info.setOper_address("4301");==地区所在id

		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		String sql = null;
		if ("孔莹璨".equals(info.getOperman_name())
				|| "黄明霞".equals(info.getOperman_name())
				|| info.getOper_address().equals("0000"))
		{
			sql = "select OPERMAN_NAME,OPERMAN_ID from OPERMAN_INFO where  OPER_STATUS=1 and OPERMAN_ID in(select OPERMAN_ID from USE_ROLE_INFO where POST_ID="
					+ Permission.EXPAND_POSITION
					+ ") order by OPERMAN_NAME desc";
		} else
		{
			sql = "select OPERMAN_NAME,OPERMAN_ID from OPERMAN_INFO where  OPER_STATUS=1 and OPERMAN_ID in(select OPERMAN_ID from USE_ROLE_INFO where POST_ID="
					+ Permission.EXPAND_POSITION
					+ ") and OPER_ADDRESS="
					+ info.getOper_address() + " order by OPERMAN_NAME desc";
		}
		ResultSet result = dba.executeQuery(sql);
		wrapModel(list, result);
		dba.release();
		return list;
	}

	public List<KeyValueModel> qingSuanJiGou() throws Exception
	{
		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		String sql = "select * from WS_STASTIC where name='qsjg'";
		ResultSet result = dba.executeQuery(sql);
		while (result.next())
		{
			KeyValueModel model = new KeyValueModel();
			model.setKey(result.getString("VAL"));
			model.setValue(result.getString("KEY"));
			list.add(model);
		}
		result.close();
		dba.release();
		return list;
	}

	private void wrapModel(List<KeyValueModel> list, ResultSet result)
			throws SQLException
	{
		while (result.next())
		{
			KeyValueModel model = new KeyValueModel();
			model.setKey(result.getInt("OPERMAN_ID") + "");
			model.setValue(result.getString("OPERMAN_NAME"));
			list.add(model);
		}
		result.close();
	}

	public String currLocal(HttpSession session)
	{
		Operman_info man = (Operman_info) session.getAttribute("man");
		return man.getOper_address();
	}

	/**
	 * 获取本地区人员
	 * 
	 * @param session
	 * @param position
	 * @return
	 * @throws Exception
	 */
	public List<KeyValueModel> localEUser(HttpSession session, int position)
			throws Exception
	{
		Operman_info man = (Operman_info) session.getAttribute("man");
		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		String sql = "select OPERMAN_NAME,OPERMAN_ID from OPERMAN_INFO where  OPER_STATUS=1 and OPERMAN_ID in(select OPERMAN_ID from USE_ROLE_INFO where POST_ID="
				+ position
				+ ") and OPER_ADDRESS="
				+ man.getOper_address()
				+ " order by OPERMAN_NAME desc";
		ResultSet result = dba.executeQuery(sql);
		wrapModel(list, result);
		dba.release();
		return list;
	}

	/**
	 * 终端所在地的的人员
	 * 
	 * @param position
	 * @return
	 * @throws Exception
	 */
	public List<KeyValueModel> localTerminalUser(HttpSession session,
			int position, String id) throws Exception
	{
		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		String sql = "select OPERMAN_NAME,OPERMAN_ID from OPERMAN_INFO where  OPER_STATUS=1 and OPERMAN_ID in(select OPERMAN_ID from USE_ROLE_INFO where POST_ID="
				+ position
				+ ") and OPER_ADDRESS=(select unit_installed_city from TEMINAL_INFO where teminal_info_id="
				+ id + ")" + " order by OPERMAN_NAME desc";
		ResultSet result = dba.executeQuery(sql);
		Log.getLogger().debug("地区查询sql:" + sql);
		wrapModel(list, result);
		dba.release();
		return list;
	}

}
