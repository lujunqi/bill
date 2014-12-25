package com.szzt.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.dodou.db.DatabaseAccess;
import com.dodou.util.CreatePage;
import com.szzt.model.TerminalTempModel;

public class TerminalAndTempDao extends CreatePage {
	public static final int STOP = 2;// 停用
	public static final int NORMAL = 1;// 启用
	public static final int ZHENG_GAI = 3;// 整改

	public List<TerminalTempModel> loadMessageByApp(int appId, String type)
			throws Exception {
		String sql = "select * from(select rownum rn,t.UNIT_INSTALLED_MAN a,t.UNIT_INSTALLED_TEL b,t.UNIT_INSTALLED_CITY c,t.UNIT_INSTALLED_STREET d,t.TEMINAL_STATUS e,"
				+ "temp.TERM_ID1 f,temp.TERM_ID2 g,t.TEMINAL_INFO_ID h,t.UNIT_INSTALLED_ADD i,TERM_ID3 j,TERM_ID4  k,t.term_version l,t.INPUT_DATE,t.EQUI_TYPE from TERM_APP_TABLE temp,TEMINAL_INFO t"
				+ " where t.TEMINAL_INFO_ID=temp.TEMINAL_INFO_ID and temp.apptype="
				+ type
				+ " and temp.APPPAY_ID="
				+ appId
				+ " and rownum<="
				+ (this.getCurPage() * 20)
				+ " order by t.TEMINAL_INFO_ID desc) where rn>"
				+ ((this.getCurPage() - 1) * 20);
		DatabaseAccess dba = new DatabaseAccess();
		ResultSet set = dba.executeQuery(sql);
		List<TerminalTempModel> model = new ArrayList<TerminalTempModel>();
		while (set.next()) {
			TerminalTempModel m = new TerminalTempModel();
			m.setUNIT_INSTALLED_MAN(set.getString("a"));
			m.setUNIT_INSTALLED_TEL(set.getString("b"));
			m.setUNIT_INSTALLED_CITY(set.getString("c"));
			m.setUNIT_INSTALLED_STREET(set.getString("d"));
			m.setTEMINAL_STATUS(set.getInt("e"));
			m.setTERM_ID1(set.getString("f"));
			m.setTERM_ID2(set.getString("g"));
			m.setTEMINAL_INFO_ID(set.getInt("h"));
			m.setUNIT_INSTALLED_ADD(set.getString("i"));
			m.setTERM_ID3(set.getString("j"));
			m.setTERM_ID4(set.getString("k"));
			m.setTerm_version(set.getInt("l"));
			if (null != set.getTimestamp("INPUT_DATE"))
				m.setINPUT_DATE(new Date(set.getTimestamp("INPUT_DATE")
						.getTime()));
			m.setEQUI_TYPE(set.getInt("EQUI_TYPE"));
			model.add(m);
		}
		System.out.println("查询终端的sql：" + sql);

		String count = "select count(*) from(select rownum rn,t.UNIT_INSTALLED_MAN a,t.UNIT_INSTALLED_TEL b,t.UNIT_INSTALLED_CITY c,t.UNIT_INSTALLED_STREET d,t.TEMINAL_STATUS e,"
				+ "temp.TERM_ID1 f,temp.TERM_ID2 g,t.TEMINAL_INFO_ID h,t.UNIT_INSTALLED_ADD i,TERM_ID3 j,TERM_ID4  k from TERM_APP_TABLE temp,TEMINAL_INFO t"
				+ " where t.TEMINAL_INFO_ID=temp.TEMINAL_INFO_ID and temp.apptype="
				+ type
				+ " and temp.APPPAY_ID="
				+ appId
				+ " order by t.TEMINAL_INFO_ID desc) ";
		set = dba.executeQuery(count);
		if (set.next()) {
			this.setTotalCount(set.getInt(1));
		}
		set.close();
		dba.release();
		return model;
	}

	public List<TerminalTempModel> loadMessageByApp(int appId) throws Exception {
		String sql = "select * from(select rownum rn,t.UNIT_INSTALLED_MAN a,t.UNIT_INSTALLED_TEL b,t.UNIT_INSTALLED_CITY c,t.UNIT_INSTALLED_STREET d,t.TEMINAL_STATUS e,"
				+ "temp.TERM_ID1 f,temp.TERM_ID2 g,t.TEMINAL_INFO_ID h,t.UNIT_INSTALLED_ADD i,TERM_ID3 j,TERM_ID4  k,t.INPUT_DATE,t.EQUI_TYPE from TERM_APP_TABLE temp,TEMINAL_INFO t"
				+ " where t.TEMINAL_INFO_ID=temp.TEMINAL_INFO_ID and temp.APPPAY_ID="
				+ appId
				+ " and rownum<="
				+ (this.getCurPage() * 20)
				+ " order by t.TEMINAL_INFO_ID desc) where rn>"
				+ ((this.getCurPage() - 1) * 20);
		DatabaseAccess dba = new DatabaseAccess();
		ResultSet set = dba.executeQuery(sql);
		List<TerminalTempModel> model = new ArrayList<TerminalTempModel>();
		while (set.next()) {
			TerminalTempModel m = new TerminalTempModel();
			m.setUNIT_INSTALLED_MAN(set.getString("a"));
			m.setUNIT_INSTALLED_TEL(set.getString("b"));
			m.setUNIT_INSTALLED_CITY(set.getString("c"));
			m.setUNIT_INSTALLED_STREET(set.getString("d"));
			m.setTEMINAL_STATUS(set.getInt("e"));
			m.setTERM_ID1(set.getString("f"));
			m.setTERM_ID2(set.getString("g"));
			m.setTEMINAL_INFO_ID(set.getInt("h"));
			m.setUNIT_INSTALLED_ADD(set.getString("i"));
			m.setTERM_ID3(set.getString("j"));
			m.setTERM_ID4(set.getString("k"));
			if (null != set.getTimestamp("INPUT_DATE"))
				m.setINPUT_DATE(new Date(set.getTimestamp("INPUT_DATE")
						.getTime()));
			m.setEQUI_TYPE(set.getInt("EQUI_TYPE"));
			model.add(m);
		}
		System.out.println("查询终端的sql：" + sql);

		String count = "select count(*) from(select rownum rn,t.UNIT_INSTALLED_MAN a,t.UNIT_INSTALLED_TEL b,t.UNIT_INSTALLED_CITY c,t.UNIT_INSTALLED_STREET d,t.TEMINAL_STATUS e,"
				+ "temp.TERM_ID1 f,temp.TERM_ID2 g,t.TEMINAL_INFO_ID h,t.UNIT_INSTALLED_ADD i,TERM_ID3 j,TERM_ID4  k from TERM_APP_TABLE temp,TEMINAL_INFO t"
				+ " where t.TEMINAL_INFO_ID=temp.TEMINAL_INFO_ID and temp.APPPAY_ID="
				+ appId + " order by t.TEMINAL_INFO_ID desc) ";
		set = dba.executeQuery(count);
		if (set.next()) {
			this.setTotalCount(set.getInt(1));
		}
		set.close();
		dba.release();
		return model;
	}
}
