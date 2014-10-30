<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	try
	{
		String where = " 1=1 ";
		if (request.getParameter("singleton") != null)
		{
			where = " 1=1 ";
		}
		if (request.getParameter("where") != null)
		{
			where += " and " + request.getParameter("where");
		}

		//Permission per = new PositionPermessionImpl();
		//String authSql = per.initTerminalWhere(per.loadPosts(session),
		//per.loadCurrentId(session));

		//if (null != authSql)
		//{
		//	where = (where == null ? "" : where);
		//	where += authSql;
		//}

		Terminal_InfoDao dao = new Terminal_InfoDao(where,
				Terminal_InfoDao.TABLE);

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

		List<Terminal_Info> infos = dao.selectList();
		JSONArray ja = new JSONArray();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (Terminal_Info info : infos)
		{
			JSONObject jo = new JSONObject();
			if (null == info)
				continue;

			jo.put("TEMINAL_INFO_ID", info.getTEMINAL_INFO_ID());
			jo.put("COMMERCIAL_ID", info.getCOMMERCIAL_ID());
			jo.put("UNIT_INSTALLED_MAN", info.getUNIT_INSTALLED_MAN());
			jo.put("UNIT_INSTALLED_TEL", info.getUNIT_INSTALLED_TEL());
			jo.put("UNIT_INSTALLED_CITY", info.getUNIT_INSTALLED_CITY());
			jo.put("UNIT_INSTALLED_STREET",
					info.getUNIT_INSTALLED_STREET());
			jo.put("UNIT_INSTALLED_NAME", info.getUNIT_INSTALLED_NAME());
			jo.put("UNIT_INSTALLED_ADD", info.getUNIT_INSTALLED_ADD());
			jo.put("TEMINAL_PRODUCT", info.getTEMINAL_PRODUCT());
			jo.put("EQUI_TYPE", info.getEQUI_TYPE());
			jo.put("SERIAL1", info.getSERIAL1());
			jo.put("SERIAL2", info.getSERIAL2());
			jo.put("COSTTYPEID", info.getCOSTTYPEID());
			jo.put("DEBUG_MAN", info.getDEBUG_MAN());
			jo.put("INST_MAN", info.getINST_MAN());
			jo.put("SAFE_MAN", info.getSAFE_MAN());
			jo.put("IS_HURRY", info.getIS_HURRY());
			jo.put("E_ID", info.getE_ID());
			jo.put("IS_OVERLAY", info.getIS_OVERLAY());

			if (info.getINSTALL_DATE() != null)
				jo.put("INSTALL_DATE",
						format.format(info.getINSTALL_DATE()));
			if (info.getINSTALL_END_DATE() != null)
				jo.put("INSTALL_END_DATE",
						format.format(info.getINSTALL_END_DATE()));
			if (info.getWITHDRAWAL_DATE() != null)
				jo.put("WITHDRAWAL_DATE",
						format.format(info.getWITHDRAWAL_DATE()));
			if (info.getARCHIVE_DATE() != null)
				jo.put("ARCHIVE_DATE",
						format.format(info.getARCHIVE_DATE()));
			jo.put("INSTALLED_STATUS", info.getINSTALLED_STATUS());

			if (info.getAPPROVAL_DATE() != null)
				jo.put("APPROVAL_DATE",
						format.format(info.getAPPROVAL_DATE()));
			jo.put("TEMINAL_STATUS", info.getTEMINAL_STATUS());

			jo.put("COMM_TYPE", info.getCOMM_TYPE());

			jo.put("IS_BIND", info.getIS_BIND());
			jo.put("COMM", info.getCOMM());
			if (info.getINPUT_DATE() != null)
				jo.put("INPUT_DATE",
						format.format(info.getINPUT_DATE()));
			if (info.getCHANGE_DATE() != null)
				jo.put("CHANGE_DATE",
						format.format(info.getCHANGE_DATE()));
			jo.put("REMARK_INFO", info.getREMARK_INFO());
			jo.put("MORE",
					"<a href='../insert/terminalInsert.jsp?show=1&terminalId="
							+ info.getTEMINAL_INFO_ID()
							+ "&CommercialId="
							+ info.getCOMMERCIAL_ID() + "'>详情</a>");
			ja.add(jo);
		}
		JSONObject jo = new JSONObject();
		System.out.println("?????????????????????????" + infos.size()
				+ ":" + ja.size());
		int size = dao.size();
		jo.put("rows", ja.size());
		jo.put("total", size);
		jo.put("cur_page", dao.getCurPage());
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