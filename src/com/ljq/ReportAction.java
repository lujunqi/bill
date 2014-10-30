package com.ljq;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.dodou.db.DatabaseAccess;
import com.dodou.table.Operman_info;
import com.prism.common.JsonUtil;

public class ReportAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings({ "unchecked", "deprecation" })
	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		MyDatabase cmd = new MyDatabase();
		HttpSession session = req.getSession();
		if( session.getAttribute("man")==null){
			res.setStatus(401);
			return;
		}
		
		
		try {
//			Context cxt = new InitialContext();
//		    DataSource ds = (DataSource)cxt.lookup("java:/comp/env/jdbc/TestDB");
//		    Connection conn = ds.getConnection();
//		    System.out.println(conn.isClosed());
		    
		    
			req.setCharacterEncoding("UTF-8");
			res.setContentType("text/html;charset=UTF-8");
			DatabaseAccess dba = new DatabaseAccess();
			
			String key = getAction(req);
			cmd.init(key, dba.getConnection());
			Map<String, Object> reqMap = new HashMap<String, Object>();
			Enumeration<String> en = req.getParameterNames();
			while (en.hasMoreElements()) {
				String name = en.nextElement();
				if (!isNull(req.getParameter(name))) {
					reqMap.put(name, req.getParameter(name));
				}
			}
			
			Operman_info man = (Operman_info) session.getAttribute("man");
			reqMap.put("session_Oper_address", man.getOper_address());
			
			if ("EXCEL".equals(reqMap.get("ACTION_TYPE"))) {
				res.setContentType("application/vnd.ms-excel");
				res.setHeader("Content-Disposition","attachment;filename="+key+".xls");
				String keys = req.getParameter("keys");
				JSONArray jsonArray = JSONArray.fromObject(keys);
				Object[] os = jsonArray.toArray();

				List<Map<String, Object>> list = cmd
						.getResultSet(reqMap, 0, -1);
				System.out.println(reqMap);
				HSSFWorkbook wb = new HSSFWorkbook();
				HSSFSheet s = wb.createSheet();
				wb.setSheetName(0, "sheet1");

				// 头文件
				HSSFRow row = s.createRow(0);
				List<String[]> commercialTitle = cmd.getENum();
				for (int i = 0; i < os.length; i++) {
					HSSFCell cell = row.createCell((short) i);
					cell.setCellValue(commercialTitle.get(Integer
							.parseInt(os[i] + ""))[0]);
				}

				for (int i = 0; i < list.size(); i++) {
					Map<String, Object> m = list.get(i);
					HSSFRow row1 = s.createRow(i + 1);
					for (int j = 0; j < os.length; j++) {
						String key1 = commercialTitle.get(Integer
								.parseInt(os[j] + ""))[1];
						Object value1 = m.get(key1);
						HSSFCell cell = row1.createCell((short) j);
						cell.setCellValue(setNull(value1));
					}
				}

				wb.write(res.getOutputStream());
			} else if ("JSONLIST".equals(reqMap.get("ACTION_TYPE"))) {
				List<Map<String, Object>> list = cmd
						.getResultSet(reqMap, 0, -1);
				JsonUtil ju = new JsonUtil();
				String json = ju.toJson(list);
				res.getWriter().println(json);
			} else {
				int cur_page = Integer.parseInt(reqMap.get("cur_page") + "");
				int page_size = Integer.parseInt(reqMap.get("page_size") + "");
				int minmun = (cur_page - 1) * page_size;
				int maxmun = (cur_page) * page_size;
				List<Map<String, Object>> list = cmd.getResultSet(reqMap,
						minmun, maxmun);

				int total = cmd.getResultSetTotal(reqMap);
				Map<String, Object> jsonMap = new HashMap<String, Object>();
				jsonMap.put("resultset", list);
				jsonMap.put("total", total);
				jsonMap.put("cur_page", cur_page);
				jsonMap.put("rows", page_size);
				jsonMap.put("total_page", Math.ceil(total / page_size));

				JsonUtil ju = new JsonUtil();
				String json = ju.toJson(jsonMap);
				res.getWriter().println(json);

			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(500);
			e.printStackTrace(res.getWriter());
		}
		cmd.closeConntent();
	}

	private String getAction(HttpServletRequest req) {
		try {
			String relativeuri = req.getRequestURI().replaceFirst(
					req.getContextPath(), "");

			relativeuri = "/" + relativeuri.replaceAll("/", "");
			int len = relativeuri.length();
			StringBuffer sb = new StringBuffer(relativeuri);
			return sb.substring(1, len - 3);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	private boolean isNull(String param) {
		if (param == null) {
			return true;
		} else if ("".equals(param)) {
			return true;
		} else {
			return false;
		}
	}

	private String setNull(Object param) {
		if (param == null) {
			return " ";
		} else if ("".equals(param)) {
			return " ";
		} else {
			return param+"";
		}
	}

}
