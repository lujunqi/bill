package com.szzt.dao;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.AbstractDao;
import com.dodou.inferface.TerminalWorkFlow;
import com.dodou.table.Terminal_Info;
import com.szzt.exception.ForbidUpdateException;
import com.szzt.exception.OutOfStoreException;
import com.szzt.exception.SerialExistsException;

public class Terminal_InfoDao extends AbstractDao<Terminal_Info> implements
		TerminalWorkFlow {
	public Terminal_InfoDao() {
	}

	/**
	 * 根据终端ID获取客户id
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int loadCommercialIdByTerId(int id) throws Exception {
		String sql = "select COMMERCIAL_ID from TEMINAL_INFO where TEMINAL_INFO_ID="
				+ id;
		ResultSet result = super.execQuery(sql);
		if (result.next()) {
			BigDecimal big = result.getBigDecimal(1);
			return big.intValue();
		}
		return -1;
	}

	public Terminal_InfoDao(String where, String table) {
		super(where, table);
	}

	public static final String TABLE = "TEMINAL_INFO";

	@Override
	public String initQuerySql() {

		StringBuffer builder = new StringBuffer();
		builder.append(
				"SELECT * FROM (SELECT A.*, ROWNUM RN FROM (SELECT * FROM ")
				.append(super.getTable()).append(" allData");

		if (null != super.getWhere() && !"".equals(super.getWhere()))
			builder.append(" where " + super.getWhere());
		// " and teminal_status!=" + ZHENG_GAI
		builder.append(" order by TEMINAL_INFO_ID desc) A");
		builder.append(" WHERE ROWNUM<=")
				.append(this.getCurPage() * this.pageSize)
				.append(")")
				.append("   WHERE RN>=" + (this.getCurPage() - 1)
						* this.getPageSize());

		super.debug("分页查询的语句为：" + builder.toString());
		return builder.toString();
	}

	public List<Terminal_Info> selectList() throws Exception {
		String sql = this.initQuerySql();
		List<Terminal_Info> list = new ArrayList<Terminal_Info>();
		ResultSet rs = super.execQuery(sql);
		while (rs.next()) {
			Terminal_Info info = this.wrapToModel(rs);
			list.add(info);
		}
		rs.close();
		super.release();
		return list;
	}

	@Override
	public Terminal_Info[] select() throws Exception {
		return this.select(this.initQuerySql());
	}

	@Override
	public Terminal_Info[] select(String sql) throws Exception {
		if (null == sql || "".equals(sql)) {
			return this.select();
		}

		Terminal_Info[] infos = new Terminal_Info[getPageSize()];

		ResultSet result = super.execQuery(sql);
		result.last();
		this.setTotalCount(result.getRow());
		result.first();
		int j = 0;
		for (int i = this.getStart(); i < this.getEnd(); i++) {
			if (this.getTotalCount() == 0)
				break;
			result.absolute(i + 1);
			Terminal_Info info = wrapToModel(result);
			infos[j++] = info;
		}

		super.debug("查询出Terminal_info信息总数为：" + this.getTotalCount());
		result.close();

		return infos;
	}

	private Terminal_Info wrapToModel(ResultSet result) throws SQLException {
		Terminal_Info info = new Terminal_Info();
		info.setTEMINAL_INFO_ID(result.getInt("TEMINAL_INFO_ID"));
		info.setCOMMERCIAL_ID(result.getInt("COMMERCIAL_ID"));
		info.setUNIT_INSTALLED_MAN(result.getString("UNIT_INSTALLED_MAN"));
		info.setUNIT_INSTALLED_TEL(result.getString("UNIT_INSTALLED_TEL"));
		info.setUNIT_INSTALLED_CITY(result.getString("UNIT_INSTALLED_CITY"));
		info.setUNIT_INSTALLED_STREET(result.getString("UNIT_INSTALLED_STREET"));
		info.setUNIT_INSTALLED_NAME(result.getString("UNIT_INSTALLED_NAME"));
		info.setUNIT_INSTALLED_ADD(result.getString("UNIT_INSTALLED_ADD"));
		info.setTEMINAL_PRODUCT(result.getInt("TEMINAL_PRODUCT"));
		info.setEQUI_TYPE(result.getInt("EQUI_TYPE"));
		info.setSERIAL1(result.getString("SERIAL1"));
		info.setSERIAL2(result.getString("SERIAL2"));
		info.setCOSTTYPEID(result.getInt("COSTTYPEID"));
		info.setDEBUG_MAN(result.getInt("DEBUG_MAN"));
		info.setINST_MAN(result.getInt("INST_MAN"));
		info.setSAFE_MAN(result.getInt("SAFE_MAN"));
		info.setIS_HURRY(result.getInt("IS_HURRY"));
		info.setINSTALL_DATE(result.getDate("INSTALL_DATE"));
		info.setINSTALL_END_DATE(result.getDate("INSTALL_END_DATE"));
		info.setWITHDRAWAL_DATE(result.getDate("WITHDRAWAL_DATE"));
		info.setARCHIVE_DATE(result.getDate("ARCHIVE_DATE"));
		info.setINSTALLED_STATUS(result.getInt("INSTALLED_STATUS"));
		info.setAPPROVAL_DATE(result.getDate("APPROVAL_DATE"));
		info.setTEMINAL_STATUS(result.getInt("TEMINAL_STATUS"));
		info.setCOMM_TYPE(result.getInt("COMM_TYPE"));
		info.setIS_BIND(result.getInt("IS_BIND"));
		info.setCOMM(result.getString("COMM"));
		if (null != result.getTimestamp("INPUT_DATE")) {
			info.setINPUT_DATE(new Date(result.getTimestamp("INPUT_DATE")
					.getTime()));
		}
		if (null != result.getTimestamp("CHANGE_DATE")) {
			info.setCHANGE_DATE(new Date(result.getTimestamp("CHANGE_DATE")
					.getTime()));
		}

		info.setREMARK_INFO(result.getString("REMARK_INFO"));
		info.setIS_OVERLAY(result.getInt("IS_OVERLAY"));
		info.setCANCEL_TIME(result.getDate("CANCEL_TIME"));
		// info.setEC_NAME(result.getString("EC_NAME"));
		info.setE_ID(result.getInt("E_ID"));
		return info;
	}

	@Override
	public Terminal_Info[] select(Terminal_Info data) throws Exception {
		return null;
	}

	@Override
	public int insert(Terminal_Info terminal) throws Exception {
		int teminal_info_id = teminal_info_id();
		String sql = "insert into TEMINAL_INFO ";
		String fields = "TEMINAL_INFO_ID";
		String values = ""+teminal_info_id;

		// EC_NAME拓展人
		// if (terminal.getEC_NAME() != null)
		// {
		// fields += ",EC_NAME";
		// values += ",'" + terminal.getEC_NAME() + "'";
		// }
		fields += ",E_ID";
		values += "," + terminal.getE_ID();
		// 客户装机联系人
		if (terminal.getUNIT_INSTALLED_MAN() != null) {
			fields += ",UNIT_INSTALLED_MAN";
			values += ",'" + terminal.getUNIT_INSTALLED_MAN() + "'";
		}
		//菜单版本
		fields += ",Term_version";
		values += ",'" + terminal.getTerm_version() + "'";

		// 客户装机联系电话:
		if (null != terminal.getUNIT_INSTALLED_TEL()) {
			fields += ",UNIT_INSTALLED_TEL";
			values += ",'" + terminal.getUNIT_INSTALLED_TEL() + "'";
		}
		// 装机城市:
		if (terminal.getUNIT_INSTALLED_CITY() != null) {
			fields += ",UNIT_INSTALLED_CITY";
			values += ",'" + terminal.getUNIT_INSTALLED_CITY() + "'";
		}
		// 装机乡镇（或街道）:
		if (terminal.getUNIT_INSTALLED_STREET() != null) {
			fields += ",UNIT_INSTALLED_STREET";
			values += ",'" + terminal.getUNIT_INSTALLED_STREET() + "'";
		}

		// 客户装机地址
		if (terminal.getUNIT_INSTALLED_ADD() != null) {
			fields += ",UNIT_INSTALLED_ADD";
			values += ",'" + terminal.getUNIT_INSTALLED_ADD() + "'";
		}
		// 备注信息
		if (terminal.getREMARK_INFO() != null) {
			fields += ",REMARK_INFO";
			values += ",'" + terminal.getREMARK_INFO() + "'";
		}

		// SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		// 日期

		// fields += ",INSTALL_DATE";
		// values += ",to_date('" + format.format(terminal.getINSTALL_DATE())
		// + "','yyyy-MM-dd')";

		fields += ",INPUT_DATE";
		values += ",sysdate";

		fields += ",CHANGE_DATE";
		values += ",sysdate";

		// 机具产权:
		fields += ",TEMINAL_PRODUCT";
		values += "," + terminal.getTEMINAL_PRODUCT() + "";

		// 机具类型
		fields += ",EQUI_TYPE";
		values += "," + terminal.getEQUI_TYPE() + "";

		// 叠加便民
		fields += ",IS_OVERLAY";
		values += "," + terminal.getIS_OVERLAY() + "";

		// 加急标志位:
		fields += ",IS_HURRY";
		values += "," + terminal.getIS_HURRY() + "";

		// 终端通讯方式
		fields += ",COMM_TYPE";
		values += "," + terminal.getCOMM_TYPE() + "";

		// 通讯方式是否绑定
		fields += ",IS_BIND";
		values += "," + terminal.getIS_BIND() + "";
		// ------附加的信息----------
		fields += ",COMMERCIAL_ID";
		values += "," + terminal.getCOMMERCIAL_ID() + "";
		fields += ",UNIT_INSTALLED_NAME";
		values += ",'" + terminal.getUNIT_INSTALLED_NAME() + "'";
		fields += ",SERIAL1";
		values += ",' '";
		// fields += ",INSTALLED_STATUS";
		// values += "," + terminal.getINSTALLED_STATUS();
		fields += ",TEMINAL_STATUS";
		values += "," + INPUT_OK;
		// 通讯方式描述:
		if (terminal.getCOMM() != null
				&& terminal.getCOMM().trim().length() > 0) {
			fields += ",COMM";
			values += ",'" + terminal.getCOMM() + "'";
		}
		sql += "(" + fields + ") values (" + values + ")";
		
		DatabaseAccess dba = super.executeUpdate(sql);
		int id = teminal_info_id;
		return id;
	}
	private int teminal_info_id() throws Exception
	{
		String sql = "select TEMINAL_INFO_ID.nextval from dual";
		ResultSet set = super.execQuery(sql);
		int id = -1;
		if (set.next())
		{
			id = set.getInt(1);
		}
		set.close();
		return id;
	}
	/**
	 * 判断终端绑定的业务没有已经审批的
	 * 
	 * @param id
	 */
	private int terStatus(int id) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select TEMINAL_STATUS from ").append(TABLE)
				.append(" where TEMINAL_INFO_ID=").append(id);
		ResultSet result = super.execQuery(sql.toString());
		result.next();
		return result.getInt(1);
	}

	@Override
	public void update(Terminal_Info terminal) throws Exception {
		// 终端状态
		int status = this.terStatus(terminal.getTEMINAL_INFO_ID());
		// 只有最新状态才可以修改
		if (status > 1) {
			throw new ForbidUpdateException();
		}
		// 使用bindrequest绑定数据
		super.initUpdate(TABLE);
		// 装机联系人
		super.wrapUpdateSql("UNIT_INSTALLED_MAN",
				terminal.getUNIT_INSTALLED_MAN());
		super.wrapUpdateSql("UNIT_INSTALLED_TEL",
				terminal.getUNIT_INSTALLED_TEL());
		super.wrapUpdateSql("UNIT_INSTALLED_CITY",
				terminal.getUNIT_INSTALLED_CITY());
		super.wrapUpdateSql("UNIT_INSTALLED_STREET",
				terminal.getUNIT_INSTALLED_STREET());
		super.wrapUpdateSql("UNIT_INSTALLED_ADD",
				terminal.getUNIT_INSTALLED_ADD());
		super.wrapUpdateSql("CHANGE_DATE", "sysdate");
		super.wrapUpdateSql("TEMINAL_PRODUCT", terminal.getTEMINAL_PRODUCT());
		super.wrapUpdateSql("EQUI_TYPE", terminal.getEQUI_TYPE());
		super.wrapUpdateSql("IS_HURRY", terminal.getIS_HURRY());
		super.wrapUpdateSql("COMM_TYPE", terminal.getCOMM_TYPE());
		super.wrapUpdateSql("IS_BIND", terminal.getIS_BIND());
		super.wrapUpdateSql("IS_OVERLAY", terminal.getIS_OVERLAY());
		super.wrapUpdateSql("COMM", terminal.getCOMM());
		super.wrapUpdateSql("E_ID", terminal.getE_ID());

		super.update("TEMINAL_INFO_ID=" + terminal.getTEMINAL_INFO_ID());
	}

	/**
	 * 删除权限判断
	 * 
	 * @param terminalId
	 * @return
	 * @throws Exception
	 */
	private boolean checkStatus(int terminalId) throws Exception {
		// 判断状态
		Terminal_Info[] old = this.select("select * from " + TABLE
				+ " where TEMINAL_INFO_ID=" + terminalId);
		if (null != old[0]) {
			int now = old[0].getTEMINAL_STATUS();
			return now < DEBUG_Ok;
		}
		System.out.println("已经审批 了 禁止删除=-==");
		// 判断是否有中间表
		ResultSet set = super
				.execQuery("select * from TERM_APP_TABLE where TEMINAL_INFO_ID="
						+ terminalId);
		boolean next = set.next();
		set.close();
		System.out.println("是否有绑定业务---" + next);
		return !next;
	}

	@Override
	public void delete(int id) throws Exception {
		if (this.terStatus(id) == 1) {
			// 删除终端
			// 删除中间表
			String delTer = "delete from " + TABLE + " where TEMINAL_INFO_ID="
					+ id;
			String delTemp = "delete from TERM_APP_TABLE where TEMINAL_INFO_ID="
					+ id;
			String cost = "delete from TEMICOST where TEMINAL_INFO_ID=" + id;
			String photo = "delete from " + TPhotoDao.TABLE
					+ " where terminal_info_id=" + id;
			DatabaseAccess dba = null;
			try {
				dba = super.executeUpdate(delTer);
				int temp = dba.executeUpdate(delTemp);
				int costItems = dba.executeUpdate(cost);
				int photos = dba.executeUpdate(photo);
				// 删除图片表
				super.debug("-------->删除终端<------------");
				super.debug("删除中间表个数:" + temp);
				super.debug("删除费用表个数:" + costItems);
				super.debug("删除图片表的个数:" + photos);
				super.debug("-------->删除终端成功<------------");
			} catch (Exception e) {
				if (null != dba)
					dba.rollback();
				e.printStackTrace();
			}
		}

	}

	@Override
	public void operate(Terminal_Info info) throws Exception {
		// 全部审批完全之前才可以审批
		if (this.terStatus(info.getTEMINAL_INFO_ID()) >= 3) {
			return;
		}
		// 分别查询三张表
		String sql = "select count(*) from TERM_APP_TABLE where TEMINAL_INFO_ID="
				+ info.getTEMINAL_INFO_ID()
				+ "and apptype='103' and APPPAY_ID in (select APPPAY_ID from APPPAY_103 where APPR_STATUS!=2)";

		// String sql2 = sql.replace("APPPAY_103", "APPPAY_102");
		String sql3 = sql.replace("103", "101");
		String sql5 = sql.replace("103", "105");

		super.initUpdate(TABLE);

		if (this.checkIsOperate(sql) && this.checkIsOperate(sql3)
				&& this.checkIsOperate(sql5)) {
			// select
			// substr(concat('00000000',a.nextval),length(concat('00000000',a.currval))-7,8)
			// from dual;
			// 审批完成
			// 是否为通联机具,非通联机具则直接归档
			Terminal_Info ti = this.findById(info.getTEMINAL_INFO_ID());
			if (ti.getTEMINAL_PRODUCT() == 0) {
				super.wrapUpdateSql("TEMINAL_STATUS", 3);
			} else {
				super.wrapUpdateSql("TEMINAL_STATUS", 13);
				super.wrapUpdateSql("INSTALLED_STATUS", 4);
				super.wrapUpdateSql(
						"ARCHIVE_DATE",
						"to_date('"
								+ super.formatDate(new Date(System
										.currentTimeMillis()))
								+ "','yyyy-MM-dd')");
			}

			super.wrapUpdateSql(
					"APPROVAL_DATE",
					"to_date('"
							+ super.formatDate(new Date(System
									.currentTimeMillis())) + "','yyyy-MM-dd')");
			// 叠加便民
			Terminal_Info[] ters = this.select("select * from " + TABLE
					+ " where TEMINAL_INFO_ID=" + info.getTEMINAL_INFO_ID()
					+ " and IS_OVERLAY=1 ");

			super.debug("------------------是否查询到便民--------------"
					+ (ters.length != 0));

			if (null != ters && ters[0] != null) {
				Terminal_Info t = ters[0];
				Apppay104_InfoDao dao104 = new Apppay104_InfoDao();
				dao104.insert(t);
			}
			// 启用中间表

		} else {
			super.wrapUpdateSql("TEMINAL_STATUS", OPERATE_Ok);
		}

		super.update("TEMINAL_INFO_ID=" + info.getTEMINAL_INFO_ID());

		super.debug("审批终端状态！" + info.getTEMINAL_STATUS());
	}

	/**
	 * 
	 * @param sql
	 * @return true所有业务审批通过，false 还有业务审批未通过
	 * @throws Exception
	 */
	private boolean checkIsOperate(String sql) throws Exception {
		ResultSet set = super.execQuery(sql);
		if (set.next()) {
			return (set.getBigDecimal(1).intValue() == 0);
		}
		return false;
	}

	public boolean waitingTerminal(Terminal_Info terminal) throws Exception {
		return false;

	}

	public boolean cancelTerminal(Terminal_Info info) throws Exception {
		// if (this.checkStatus(info.getTEMINAL_INFO_ID(), CANCEL_OK))
		// {
		if (this.terStatus(info.getTEMINAL_INFO_ID()) == FILE_Ok) {
			try {
				super.initUpdate(TABLE);
				super.wrapUpdateSql("TEMINAL_STATUS", CANCEL_OK);
				super.wrapUpdateSql("CANCEL_TIME", "sysdate");
				super.update("TEMINAL_INFO_ID=" + info.getTEMINAL_INFO_ID());
				this.modifyTemp(info.getTEMINAL_INFO_ID(), 2);
			} catch (Exception e) {
				super.rollback();
			} finally {
				super.release();
			}
			super.debug("------------------撤机成功-----------------------");
			return true;
		}
		// }
		return false;
	}

	public boolean fileTerminal(Terminal_Info info) throws Exception {
		try {
			// 使用bind绑定信息
			super.initUpdate(TABLE);

			// super.wrapUpdateSql("SAFE_MAN", info.getSAFE_MAN());
			// super.wrapUpdateSql("INST_MAN", info.getINST_MAN());
			// super.wrapUpdateSql("DEBUG_MAN", info.getDEBUG_MAN());
			if (null != info.getINSTALL_END_DATE()) {
				super.wrapUpdateSql(
						"INSTALL_END_DATE",
						"to_date('"
								+ super.formatDate(info.getINSTALL_END_DATE())
								+ "','yyyy-MM-dd')");
			}

			// 延迟装机不归档
			if (info.getINSTALLED_STATUS() != 2) {
				super.wrapUpdateSql("TEMINAL_STATUS", FILE_Ok);
				// super.wrapUpdateSql("TEMINAL_STATUS", FILE_Ok);
			}

			super.wrapUpdateSql("INSTALLED_STATUS", info.getINSTALLED_STATUS());

			if (null != info.getINSTALL_DATE()) {
				super.wrapUpdateSql("INSTALL_DATE",
						"to_date('" + super.formatDate(info.getINSTALL_DATE())
								+ "','yyyy-MM-dd')");
			}

			super.wrapUpdateSql("ARCHIVE_DATE", "sysdate");

			super.update("TEMINAL_INFO_ID=" + info.getTEMINAL_INFO_ID());

			// 未装机，取消装机，停用中间表
			if (info.getINSTALLED_STATUS() != 4) {
				this.modifyTemp(info.getTEMINAL_INFO_ID(), 2);
			} else
			// 装机成功启用中间表
			{
				this.modifyTemp(info.getTEMINAL_INFO_ID(), 1);
			}

		} catch (Exception e) {
			super.rollback();
		} finally {
			super.release();
		}
		super.debug("------------------归档成功-----------------------");
		return true;
		// }
		// return false;
	}

	/**
	 * 确定主机序列号唯一
	 * 
	 * @param info
	 */
	public void checkSerialSigleton(Terminal_Info info) throws Exception {
		if (null == info || info.getSERIAL1() == null) {
			return;
		}
		if (info.getTEMINAL_PRODUCT() != 0) {
			return;
		}

		// 1:先判断是否在库中
		String inStore = "select count(*) from TEMINAL_INFO_KEY k,TEMINAL_INFO t where upper(k.HOST_NO)=upper("
				+ info.getSERIAL1().trim()
				+ ") and k.AREA=t.UNIT_INSTALLED_CITY";

		ResultSet rs = super.execQuery(inStore);

		if (!rs.next() || rs.getInt(1) < 1) {
			rs.close();
			throw new OutOfStoreException();
		} else {
			rs.close();
		}
		// 在仓库中，则要判断是否重复
		String use = "select *  from "
				+ TABLE
				+ " where TEMINAL_STATUS=4 or TEMINAL_STATUS=5 or (TEMINAL_STATUS=13 and INSTALLED_STATUS=4)";

		String sql = "select count(*) from (" + use
				+ ") where  upper(SERIAL1)=upper(" + info.getSERIAL1() + ")";

		ResultSet set = super.execQuery(sql);

		if (set.next()) {
			if (set.getInt(1) != 0) {
				set.close();
				throw new SerialExistsException("");
			}
		} else
			set.close();

		String use2 = "select t.teminal_status from TEMINAL_INFO_SERV t where (t.teminal_status!=6 or t.teminal_status is null ) and  upper(host_seq)=upper("
				+ info.getSERIAL1() + ")";

		String sql2 = "select count(*) from (" + use2 + ")";

		ResultSet set2 = super.execQuery(sql2);

		if (set2.next()) {
			if (set2.getInt(1) != 0) {
				set2.close();
				throw new SerialExistsException("");
			}
		} else
			set2.close();
		super.debug("判断主机序列号：" + inStore + "\n 是否在使用:" + use);
	}

	public boolean debugTerminal(Terminal_Info info) throws Exception {

		// 确定调试主机序列号唯一
		this.checkSerialSigleton(info);
		// 使用bind绑定信息
		super.initUpdate(TABLE);
		super.wrapUpdateSql("TEMINAL_STATUS", Terminal_InfoDao.DEBUG_Ok);
		if (null != info.getSERIAL2())
			super.wrapUpdateSql("SERIAL2", info.getSERIAL2());
		super.wrapUpdateSql("SERIAL1", info.getSERIAL1());
		super.wrapUpdateSql("DEBUG_MAN", info.getDEBUG_MAN());
		super.update("TEMINAL_INFO_ID=" + info.getTEMINAL_INFO_ID());
		super.release();
		super.debug("------------------调试成功-----------------------");
		return true;
	}

	public boolean assign(Terminal_Info info) throws Exception {
		// if (this.checkStatus(info.getTEMINAL_INFO_ID(), DEBUG_Ok))
		// {
		// 使用bind绑定信息
		super.initUpdate(TABLE);
		// 审批瑞
		// super.wrapUpdateSql("INSTALL_END_DATE",
		// "to_date('" + super.formatDate(info.getINSTALL_END_DATE())
		// + "','yyyy-MM-dd')");
		super.wrapUpdateSql("TEMINAL_STATUS", ASSIGN_Ok);
		super.wrapUpdateSql("SAFE_MAN", info.getSAFE_MAN());
		super.wrapUpdateSql("INST_MAN", info.getINST_MAN());
		// super.wrapUpdateSql("DEBUG_MAN", info.getDEBUG_MAN());

		super.update("TEMINAL_INFO_ID=" + info.getTEMINAL_INFO_ID());
		super.release();
		super.debug("------------------分配成功-----------------------");
		return true;

	}

	public void notDebug(int id, int oid) throws Exception {
		// 使用bind绑定信息
		try {
			super.initUpdate(TABLE);
			super.wrapUpdateSql("TEMINAL_STATUS", FILE_Ok);
			super.wrapUpdateSql("INSTALLED_STATUS", 5);
			super.wrapUpdateSql("DEBUG_MAN", oid);
			super.update("TEMINAL_INFO_ID=" + id);
			this.modifyTemp(id, 2);

		} catch (Exception e) {
			super.rollback();
		} finally {
			super.release();
		}

		super.debug("------------------》未调试《-----------------------");
	}

	/**
	 * 设置中间表的状态
	 */
	private void modifyTemp(int id, int status) throws Exception {
		// 修改中间表为停用状态
		String temp = "update " + ApppayTerminalDao.TABLE + " set STATUS="
				+ status + " where TEMINAL_INFO_ID=" + id;
		super.executeUpdate(temp);
	}

	public void waitingFile(int id) throws Exception {
		// 待归档。。。
		super.initUpdate(TABLE);
		super.wrapUpdateSql("TEMINAL_STATUS", Terminal_InfoDao.DEBUG_Ok);
		super.update("TEMINAL_INFO_ID=" + id);
		super.release();
		super.debug("------------------》转换成待归档《-----------------------");
	}

	public void waitingDebug(int id) throws Exception {
		try {
			super.initUpdate(TABLE);
			super.wrapUpdateSql("TEMINAL_STATUS", 3);
			super.wrapUpdateSql("INSTALLED_STATUS", -1);
			super.update("TEMINAL_INFO_ID=" + id);
			this.modifyTemp(id, 1);
		} catch (Exception e) {
			super.rollback();
		} finally {
			super.release();
		}
		super.debug("------------------》转换成待调试《-----------------------");
	}

	@Override
	public Terminal_Info findById(int id) throws Exception {
		String sql = "select * from " + TABLE + " where TEMINAL_INFO_ID=" + id;
		ResultSet rs = execQuery(sql);
		Terminal_Info info = null;
		if (rs.next()) {
			info = this.wrapToModel(rs);
		}
		rs.close();
		release();
		return info;
	}

}
