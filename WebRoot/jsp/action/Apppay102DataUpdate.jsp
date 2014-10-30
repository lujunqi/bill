<%@page import="com.szzt.util.BindRequest"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@ page import="com.szzt.dao.*"%>
<%
	try
	{
		if (null != request.getParameter("APPPAY_ID"))
		{
			BindRequest bind = new BindRequest();
			Apppay102_Info info = bind.toModel(request,
					Apppay102_Info.class);
/*
			String base = info.getFEE_SET().replace("%", "")
					.replace("-", "").replace("'", "");

			if ("'2'".equals(info.getFEE_TYPE())
					&& request.getParameter("FEE_SET_TOP") != null)
			{
				info.setFEE_SET("'" + request.getParameter("FEE_SET")
						+ "%'");
			} else if ("'3'".equals(info.getFEE_TYPE()))
			{
				info.setFEE_SET("'" + base + "%-"
						+ request.getParameter("FEE_SET_TOP") + "'");
			} else
			{
				info.setFEE_SET(base);
			}
*/			
			Apppay102_InfoDao dao = new Apppay102_InfoDao();

			Operman_info man = (Operman_info) session
					.getAttribute("man");
			dao.setWho(man.getOperman_name());
			dao.update(info);
			out.print(info.getAPPPAY_ID());
			//response.sendRedirect("../insert/commercialInsert.jsp?info=11&show=1&CommercialId="
			//	+ session.getAttribute("COMMERCIAL_ID"));
		}
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		//response.sendRedirect("../insert/commercialInsert.jsp?info=10&show=1&CommercialId="
		//		+ session.getAttribute("COMMERCIAL_ID"));
	}
%>