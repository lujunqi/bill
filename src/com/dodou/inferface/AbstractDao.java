package com.dodou.inferface;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;

import com.dodou.dao.Apppay_105Dao;
import com.dodou.db.DatabaseAccess;
import com.dodou.log.Log;
import com.dodou.util.CreatePage;
import com.szzt.dao.Apppay101_InfoDao;
import com.szzt.dao.Apppay102_InfoDao;
import com.szzt.dao.Apppay103_InfoDao;
import com.szzt.dao.Apppay106_InfoDao;
import com.szzt.dao.Terminal_InfoDao;

/**
 * dao层通用接口实现规范
 * 
 * @author 陈孟琳
 * 
 * @param <T>
 */
public abstract class AbstractDao<T> extends CreatePage
{

	protected LogService logService;
	private String who;

	public String getWho()
	{
		return who;
	}

	public void setWho(String who)
	{
		this.who = who;
	}

	private String where;
	private String table;// 表名称
	private StringBuffer update = null;

	public void setTable(String table)
	{
		this.table = table;
	}

	public void initLogService()
	{
		this.logService = new LogService();
	}

	/**
	 * 操作信息的更新
	 * 
	 * @param info
	 * @throws Exception
	 */
	public abstract void operate(T info) throws Exception;

	public AbstractDao()
	{
	}

	public void rollback() throws Exception
	{
		this.dba.rollback();
	}

	/**
	 * 
	 * @param where
	 *            条件查询的语句
	 */
	public AbstractDao(String where, String table)
	{
		this.table = table;
		this.where = where;
	}

	public String getTable()
	{
		return table;
	}

	// 数据库访问
	private DatabaseAccess dba = new DatabaseAccess();

	private Logger log = Log.getLogger();

	public T[] select() throws Exception
	{
		return this.select(this.initQuerySql());
	}

	public abstract T[] select(String sql) throws Exception;

	public abstract T[] select(T data) throws Exception;

	public abstract int insert(T data) throws Exception;

	public abstract void update(T data) throws Exception;

	public abstract void delete(int id) throws Exception;

	/**
	 * 根据id查询信息
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public abstract T findById(int id) throws Exception;

	/**
	 * 格式化日期yyyy-MM-dd
	 * 
	 * @param target
	 * @return
	 */
	public final String formatDate(Date target)
	{
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(target);
	}

	public int size() throws Exception
	{
		String sql = "select count(*) from " + table + " allData"
				+ (where == null ? "" : " where " + where);
		log.info("size：总数sql--》" + sql);
		ResultSet rs = dba.executeQuery(sql);
		rs.next();
		return rs.getInt(1);
	}

	public ResultSet execQuery(String sql) throws Exception
	{
		this.debug("execQuery--->" + sql);
		return this.dba.executeQuery(sql);
	}

	/**
	 * 初始化更新语句
	 * 
	 * @param table
	 */
	public final void initUpdate(String table)
	{
		this.update = new StringBuffer();
		update.append("update ").append(table).append(" set ");
	}

	/**
	 * 更新插入语句
	 */
	public void wrapUpdateSql(String column, Object value)
	{
		update.append(column).append("=").append(value).append(",");
	}

	/**
	 * 更新数据
	 */
	public void update(String id) throws Exception
	{
		int lastIndex = update.lastIndexOf(",");
		update.replace(lastIndex, lastIndex + 1, "").append(" where ")
				.append(id);
		this.executeUpdate(update.toString());
		debug("更新sql语句为-->" + update.toString());
	}

	public boolean noApproved(String table, int id) throws Exception
	{
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) from ")
				.append(table)
				.append(" where APPR_STATUS>1 and APPPAY_ID in(select APPPAY_ID from ")
				.append("TERM_APP_TABLE ").append(" where TEMINAL_INFO_ID=")
				.append(id).append(")");
		ResultSet set = this.execQuery(sql.toString());
		set.next();
		return set.getInt(1) == 0;
	}

	/**
	 * 初始化分页查询语句
	 * 
	 * @param table
	 * @return
	 */
	public String initQuerySql()
	{
		StringBuilder builder = new StringBuilder();
		builder.append(
				"SELECT * FROM (SELECT A.*, ROWNUM RN FROM (SELECT * FROM ")
				.append(table).append(") A");
		builder.append(" WHERE ROWNUM<=")
				.append(this.getCurPage() * this.pageSize)
				.append(")")
				.append("  allData WHERE RN>=" + (this.getCurPage() - 1)
						* this.getPageSize());
		if (null != where && !"".equals(where))
			builder.append(" and " + where);
		log.debug("分页查询的语句为：" + builder.toString());
		return builder.toString();
	}

	/**
	 * 获取业务所处的状态
	 * 
	 * @param appTable
	 * @param appID
	 * @return
	 */
	public int loadAppayStatus(String appTable, int appId) throws Exception
	{
		StringBuffer sql = new StringBuffer();
		sql.append("select APPR_STATUS from ").append(appTable)
				.append(" where APPPAY_ID=").append(appId);
		ResultSet result = this.execQuery(sql.toString());
		if (result.next())
		{
			return result.getInt("APPR_STATUS");
		}
		return -1;
	}

	/**
	 * 修改业务的状态信息
	 * 
	 * @param appTable
	 *            业务表
	 * @param status
	 *            要修改的状态
	 */
	public void updateAppayStatus(String appTable, int status, String id)
			throws Exception
	{
		StringBuffer sql = new StringBuffer();
		sql.append("update ").append(appTable).append(" set ");
		// if (status == AppayStatus.APPAY_UPDATE)
		// {
		sql.append("CHANGE_DATE=").append("sysdate").append(",");
		// }
		sql.append(" APPR_STATUS=").append(status)
				.append(" where APPPAY_ID=" + id);
		this.debug("<<<<<<<更新业务状态>>>>>>>>>" + sql.toString());
		this.executeUpdate(sql.toString());
	}

	/**
	 * 记录日志信息
	 * 
	 * @param msg
	 */
	public final void debug(String msg)
	{
		this.log.debug(msg);
	}

	public DatabaseAccess executeUpdate(String sql) throws Exception
	{
		Log.getLogger().debug(
				this.getClass().getName() + " [自定义],SQL:[" + sql + "]");
		dba.executeUpdate(sql);
		return dba;
	}

	/**
	 * 获取插入数据的ID
	 * 
	 * @param dba
	 * @param table
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int loadCurrentId(DatabaseAccess dba, String table, String id)
			throws Exception
	{
		String sql = "select max(" + id + ") from " + table;
		ResultSet result = dba.executeQuery(sql);
		int ids = -1;
		if (result.next())
		{
			BigDecimal big = result.getBigDecimal(1);
			ids = big.intValue();
		}
		return ids;
	}

	/**
	 * 获取业务表的ID，防止并发
	 * 
	 * @param dba
	 * @param table
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int loadAppCurrId(DatabaseAccess dba, String table, String id,
			int commercialId) throws Exception
	{
		String sql = "select max(" + id + ") from " + table
				+ " where COMMERCIAL_ID=" + commercialId;
		ResultSet result = dba.executeQuery(sql);
		int ids = -1;
		if (result.next())
		{
			BigDecimal big = result.getBigDecimal(1);
			ids = big.intValue();
		}
		return ids;
	}

	/**
	 * 根据终端的id获取到用户的id
	 * 
	 * @param id
	 * @return
	 */
	public int loadCommercialIdByTerm(int id) throws Exception
	{
		StringBuffer sql = new StringBuffer();
		sql.append("select COMMERCIAL_ID from ").append(Terminal_InfoDao.TABLE)
				.append(" where TEMINAL_INFO_ID=").append(id);
		ResultSet result = dba.executeQuery(sql.toString());
		if (result.next())
		{
			BigDecimal big = result.getBigDecimal(1);
			return big.intValue();
		}
		return -1;
	}

	/**
	 * 根据业务id获取到对应客户的id
	 * 
	 * @param id
	 * @param type
	 *            业务的类型 101 102 103
	 * @return
	 */
	public int loadCommercialIdByAppayId(int id, int type) throws Exception
	{
		StringBuffer sql = new StringBuffer();
		sql.append("select COMMERCIAL_ID from ");
		switch (type)
		{
		case 101:
			sql.append(Apppay101_InfoDao.TABLE);
			break;
		case 102:
			sql.append(Apppay102_InfoDao.TABLE);
			break;
		case 103:
			sql.append(Apppay103_InfoDao.TABLE);
			break;
		case 105:
			sql.append(Apppay_105Dao.TABLE);
			break;
		case 106:
			sql.append(Apppay106_InfoDao.TABLE);
			break;
		default:
			return -1;
		}
		sql.append(" where APPPAY_ID=").append(id);
		ResultSet result = dba.executeQuery(sql.toString());
		if (result.next())
		{
			BigDecimal big = result.getBigDecimal(1);
			return big.intValue();
		}
		return -1;
	}

	public final void deletoAppPhoto(int id) throws Exception
	{
		String photo = "delete from PHOTO where APPPAY_ID=" + id;
		this.executeUpdate(photo);
	}

	/**
	 * 释放链接
	 * 
	 * @throws Exception
	 */
	public final void release() throws Exception
	{
		this.dba.release();
	}

	public String getWhere()
	{
		return where;
	}

	public void setWhere(String where)
	{
		this.where = where;
	}

}
