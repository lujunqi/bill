<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String where = " 1=1 ";
		//获取指定用户
		if (session.getAttribute("COMMERCIAL_ID") != null)
		{
			int commercialId = (Integer) session
					.getAttribute("COMMERCIAL_ID");
			//String sql = dao.initQuerySql();
			where += " and COMMERCIAL_ID=" + commercialId;
		}
		if (request.getParameter("where") != null)
		{
			where += request.getParameter("where");
		}
		//终端
		//if (session.getAttribute("TEMINAL_INFO_ID") != null)
		//{
		//	int commercialId = (Integer) session
		//			.getAttribute("TEMINAL_INFO_ID");
		//String sql = dao.initQuerySql();
		//	where += " and TEMINAL_INFO_ID=" + commercialId;
		//	}

		ApppayQueryDao dao = new ApppayQueryDao(where,
				ApppayQueryDao.TABLE);

		if (request.getParameter("cur_page") != null
				&& !"".equals(request.getParameter("cur_page")))
		{
			int cur_page = Integer.valueOf(request
					.getParameter("cur_page"));
			dao.setCurPage(cur_page);
		}

		if (request.getParameter("page_size") != null
				&& !"".equals(request.getParameter("page_size")))
		{
			int page_size = Integer.valueOf(request
					.getParameter("page_size"));
			dao.setPageSize(page_size);
		}
		TerminalAppTemp[] infos = dao.select();

		JSONArray ja = new JSONArray();

		for (int i = dao.getStart(); i < dao.getEnd(); i++)
		{
			JSONObject jo = new JSONObject();
			if (infos.length < 1)
				break;
			TerminalAppTemp info = infos[i];
			if (null == info)
				break;

			jo.put("APP_NAME", info.getAPP_NAME());
			//jo.put("COMMERCIAL_ID", info.getCOMMERCIAL_ID());
			//	jo.put("TEMINAL_INFO_ID", info.getTEMINAL_INFO_ID());

			//	jo.put("APPTYPE", info.getAPPTYPE());
			//jo.put("TERM_ID1", info.getTERM_ID1());
			//jo.put("TERM_ID2", info.getTERM_ID2());
			//jo.put("MENU_VER", info.getMENU_VER());
			//jo.put("APPDATA_NAME", info.getAPPDATA_NAME());

			if (info.getSTATUS() == 0)
				jo.put("STATUS", "未开通");
			else if (info.getSTATUS() == 1)
				jo.put("STATUS", "开通");
			if ("101".equals(info.getAPPTYPE()))
			{
				jo.put("MORE",
						"<a href='bussinessInsert.jsp?show=1&appayId="
								+ info.getAPPPAY_ID() + "'>详细</a>");
			} else if ("102".equals(info.getAPPTYPE()))
			{
				jo.put("MORE",
						"<a href='bussinessInsert102.jsp?show=1&appayId="
								+ info.getAPPPAY_ID() + "'>详细</a>");
			}
			jo.put("TEMP_REQUEST_ISBIND", info.getAPPPAY_ID());
			ja.add(jo);
		}
		JSONObject jo = new JSONObject();
		jo.put("rows", dao.getRowsCount());
		jo.put("total", dao.size());
		jo.put("cur_page", dao.getCurPage());
		jo.put("total_page", dao.getPageCount());
		jo.put("resultset", ja);
		dao.release();
		out.println(jo);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>