package com.ljq;

import java.io.StringWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

import com.prism.common.VMRequest;
import com.prism.dbutil.VMPreparedStatement;

public class MyDatabase {

	private VelocityContext vc = new VelocityContext();
	private Connection conn;
	private String sql = "";
	private String eNum = "";
	private Map<String,Object> config = new HashMap<String, Object>(); 
	public void init(String sqlKey, Connection conn) {
		this.conn = conn;
		VMPreparedStatement cmd = new VMPreparedStatement(conn);
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("sqlKey", sqlKey);
			cmd.putAll(map);
			String sql1 = "SELECT KEY, SQL, ENUM FROM RPT_CONFIG WHERE KEY = ${sqlKey<STRING>}";
			List<Map<String, Object>> list = cmd.getListColValue(sql1);
			if (!list.isEmpty()) {
				config = list.get(0);
				sql = (String) config.get("SQL");
				eNum = (String) config.get("ENUM");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public Map<String,Object> getConfig(){
		return config;
	}
	public List<String[]> getENum() {
		List<String[]> list = new ArrayList<String[]>();
		
		try {
			vc = new VelocityContext();
			MyEnum e = new MyEnum();
			vc.put("e", e);
			getResultfromContent(eNum);
			list = e.getList();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		return list;
	}

	public List<Map<String, Object>> getResultSet(Map<String, Object> map,
			int minnum, int maxnum) {
		VMPreparedStatement cmd = new VMPreparedStatement(conn);
		try {
			vc = new VelocityContext();
			VMRequest v = new VMRequest();
			if (map != null) {
				v.setReqMap(map);
			}
			vc.put("v", v);
			String sql1 = getResultfromContent(sql);
			System.out.println(sql1);
			cmd.putAll(map);
			return cmd.getListColValue(sql1, minnum, maxnum);
		} catch (SQLException e) {
			e.printStackTrace();
			return new ArrayList<Map<String, Object>>();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Map<String, Object>>();
		}
	}
	public ResultSet getResultSet(Map<String, Object> map) {
		VMPreparedStatement cmd = new VMPreparedStatement(conn);
		try {
			vc = new VelocityContext();
			VMRequest v = new VMRequest();
			if (map != null) {
				v.setReqMap(map);
			}
			vc.put("v", v);
			String sql1 = getResultfromContent(sql);
			System.out.println(sql1);
			cmd.putAll(map);
			return cmd.getResultSet(sql1);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public int getResultSetTotal(Map<String, Object> map) {
		int result = 0;
		VMPreparedStatement cmd = new VMPreparedStatement(conn);
		try {
			vc = new VelocityContext();
			VMRequest v = new VMRequest();
			v.setReqMap(map);
			vc.put("v", v);
			String sql1 = getResultfromContent(sql);
			sql1 = "SELECT COUNT(1) TOTAL FROM (" + sql1 + ")";
			cmd.putAll(map);
			List<Map<String, Object>> list = cmd.getListColValue(sql1);
			return Integer.parseInt(list.get(0).get("TOTAL") + "");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public void closeConntent() {
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private String getResultfromContent(String s) throws Exception {
		StringWriter stringwriter;
		Velocity.init();
		stringwriter = new StringWriter();
		Velocity.evaluate(vc, stringwriter, "mystring", s);
		return stringwriter.toString();
	}
}
