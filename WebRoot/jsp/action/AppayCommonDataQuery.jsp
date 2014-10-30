<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.ApppayCommonDao"%>
<%
	try
	{
		ApppayCommonDao dao = new ApppayCommonDao();
		Object[] infos = new Object[1];

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

		if (null != request.getParameter("TEMINAL_INFO_ID")
				&& request.getParameter("TEMINAL_INFO_ID").trim()
						.length() > 0)//终端页面显示
		{
			infos = dao.findWithTerminal(Integer.parseInt(request
					.getParameter("TEMINAL_INFO_ID")), Integer
					.parseInt(request.getParameter("COMMERCIAL_ID")));

		} else if (null != request.getParameter("allData"))//查询所有数据
		{
			Permission per = new PositionPermessionImpl();

			if (per.hasPermission(session, Permission.LEADER_POSITION)
					|| per.hasPermission(session,
							Permission.OPERAT_POSITION))
			{
				String appendWhere = per.initAppayWhere(
						per.loadPosts(session),
						per.loadCurrentId(session));

				String requestWhere = request.getParameter("where");
				if (null != appendWhere)
				{
					requestWhere = (requestWhere == null ? ""
							: requestWhere);
					requestWhere += appendWhere;
				}
				String type = request.getParameter("type");
				infos = dao.findAll(requestWhere, type);

				System.out.println("......" + requestWhere);

				TableJson<Apppay101_Info> json = new TableJson<Apppay101_Info>(
						"yyyy-MM-dd HH:mm:ss");
				int size = dao.size();
				json.setCur_page(dao.getCurPage());
				json.setRows(infos.length);
				json.setTotal(size);
				json.setTotal_page(dao.getPageCount());
				json.setResultset(infos);
				dao.release();
				out.println(json.toJson());
				return;
			}
		} else
		//if (null != request.getParameter("COMMERCIAL_ID"))
		{
			int commercialId = Integer.parseInt(request
					.getParameter("COMMERCIAL_ID"));

			//收付宝信息也需要查询
			if (null != request.getParameter("has102")
					|| null != request.getParameter("append"))
			{
				infos = dao.findByCommercialId(commercialId);
			} else
			{
				infos = dao.findByCommercialId(commercialId, false);
			}
		}

		TableJson<Apppay101_Info> json = new TableJson<Apppay101_Info>(
				"yyyy-MM-dd HH:mm:ss");
		json.setCur_page(dao.getCurPage());
		System.out.println("lllllllllllll:" + infos.length);
		json.setRows(infos.length);
		json.setTotal(infos.length);
		json.setTotal_page(1);
		json.setResultset(infos);
		dao.release();
		out.println(json.toJson());
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>