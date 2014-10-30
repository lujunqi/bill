<%@page import="com.szzt.exception.TermIdExistsException"%>
<%@page import="com.szzt.util.CommercialNoUtils"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	System.out.println("----102审批---------------"
			+ request.getParameter("type") + "==''''''");
	List<Integer> posts = (List<Integer>) session.getAttribute("posts");
	if (!posts.contains(2))
	{
		response.sendRedirect("../insert/commercialInsert.jsp?show=1&info=opera0&CommercialId="
				+ session.getAttribute("COMMERCIAL_ID"));
	}
	String appay = request.getParameter("APPPAY_ID");
	String type = request.getParameter("type");
	try
	{
		BindRequest bind = new BindRequest();
		Operman_info man = (Operman_info) session.getAttribute("man");
		Permission per = new PositionPermessionImpl();
		if ("101".equals(type) && per.hasPermission(session, 2))
		{
			Apppay101_Info info = bind.toModel(request,
					Apppay101_Info.class);
			info.setAPPPAY_ID(Integer.parseInt(appay));
			info.setAPPR_MAN(man.getOperman_id() + "");
			Apppay101_InfoDao dao = new Apppay101_InfoDao();
			dao.operate(info);

			response.sendRedirect("../insert/bussinessInsert.jsp?info=s1&show=1&appayId="
					+ appay
					+ "&CommercialId="
					+ dao.loadCommercialIdByAppayId(
							info.getAPPPAY_ID(), 101));
			dao.release();
			//response.sendRedirect("../insert/commercialInsert.jsp?show=1&info=opera1&CommercialId="
			//	+ session.getAttribute("COMMERCIAL_ID"));
		} else if ("102".equals(type) && per.hasPermission(session, 2))
		{
			System.out.println("----102审批---------------");
			String TERM_ID1 = request.getParameter("TERM_ID1");
			String COMMERCIAL_ID = request.getParameter("COMMERCIAL_ID");
			String sql = "select * from (select count(*) from TERM_APP_TABLE where trim(TERM_ID1)='"
				+ TERM_ID1
				+ "')t"
				+ ",(select count(*) from cms.GW_CUSTOMER where col1='"
				+ TERM_ID1 + "')t1,(select count(*) from APPPAY_106 where trim(TERM_ID1)='"+TERM_ID1+"' )t2,(select count(*) from APPPAY_102 where trim(TERM_ID1)='"+TERM_ID1+"' and APPPAY_ID != "+appay+")t3 ";
			DatabaseAccess dba = new DatabaseAccess();
			ResultSet set = dba.executeQuery(sql);
			if(set.next()){
				int exists = set.getInt(1);
				int apms = set.getInt(2);
				int a_106 = set.getInt(3);
				int a_102 = set.getInt(4);			    
				if (exists != 0 || apms != 0 || a_106 != 0 || a_102 != 0){
					response.sendRedirect("../insert/bussinessInsert102.jsp?show=1&info=10&&appayId="
						+ appay
						+ "&CommercialId="
						+ COMMERCIAL_ID);
					System.out.print("《《《《《《《《收付宝编号已经存在！》》》》》》");
					set.close();
					dba.release();
					//out.println(-11);
					return;
			    }
			}
			set.close();
			dba.release();
			
			
			Apppay102_Info info = bind.toModel(request,
					Apppay102_Info.class);

			info.setAPPR_MAN(man.getOperman_id() + "");
			info.setAPPPAY_ID(Integer.parseInt(appay));
			Apppay102_InfoDao dao = new Apppay102_InfoDao();
			dao.operate(info);

			response.sendRedirect("../insert/bussinessInsert102.jsp?show=1&info=s1&&appayId="
					+ appay
					+ "&CommercialId="
					+ dao.loadCommercialIdByAppayId(
							info.getAPPPAY_ID(), 102));
			dao.release();
			//	response.sendRedirect("../insert/commercialInsert.jsp?show=1&info=opera1&CommercialId="
			//+ session.getAttribute("COMMERCIAL_ID"));
		} else if ("103".equals(type) && per.hasPermission(session, 2))
		{
			System.out.println("----103审批---------------");
			Apppay103_Info info = bind.toModel(request,
					Apppay103_Info.class);
			info.setAPPR_MAN(man.getOperman_id() + "");
			info.setAPPPAY_ID(Integer.parseInt(appay));
			Apppay103_InfoDao dao = new Apppay103_InfoDao();
			dao.operate(info);
			response.sendRedirect("../insert/bussinessInsert103.jsp?info=s1&show=1&appayId="
					+ appay
					+ "&CommercialId="
					+ dao.loadCommercialIdByAppayId(
							info.getAPPPAY_ID(), 103));
			dao.release();
		} else if ("105".equals(type) && per.hasPermission(session, 2))
		{
			System.out.println("----105审批 第一次---------------");
			Apppay_105 a105 = new Apppay_105();
			a105.setAppr_man(man.getOperman_id() + "");
			a105.requestGetParameter(request);

			Apppay_105Dao dao = new Apppay_105Dao();

			int status = dao.loadAppayStatus(Apppay_105Dao.TABLE,
					a105.getApppay_id());

			//终端为新增终端待审批，且商户编号不唯一
			if (status == 0
					&& !dao.sigletonTermId(request
							.getParameter("commercialNoTemp")))
			{
				response.sendRedirect("../insert/bussinessInsert105.jsp?info=c0&show=1&appayId="
						+ a105.getApppay_id()
						+ "&CommercialId="
						+ dao.loadCommercialIdByAppayId(
								a105.getApppay_id(), 105));
			} else
			{
				CommercialNoUtils cu = new CommercialNoUtils();
				cu.store(a105.getApppay_id(),
						request.getParameter("commercialNoTemp"),
						session);
				dao.operate(a105);

				response.sendRedirect("../insert/bussinessInsert105.jsp?info=s1&show=1&appayId="
						+ a105.getApppay_id()
						+ "&CommercialId="
						+ dao.loadCommercialIdByAppayId(
								a105.getApppay_id(), 105));
			}
			dao.release();
		} else if ("106".equals(type) && per.hasPermission(session, 2))
		{
			System.out.println("----106审批---------------");

			String TERM_ID1 = request.getParameter("TERM_ID1");
			String COMMERCIAL_ID = request.getParameter("COMMERCIAL_ID");
			String sql = "select * from (select count(*) from TERM_APP_TABLE where trim(TERM_ID1)='"
				+ TERM_ID1
				+ "')t"
				+ ",(select count(*) from cms.GW_CUSTOMER where col1='"
				+ TERM_ID1 + "')t1,(select count(*) from APPPAY_106 where trim(TERM_ID1)='"+TERM_ID1+"' and APPPAY_ID != "+appay+")t2,(select count(*) from APPPAY_102 where trim(TERM_ID1)='"+TERM_ID1+"')t3 ";
			DatabaseAccess dba = new DatabaseAccess();
			ResultSet set = dba.executeQuery(sql);
			if(set.next()){
				int exists = set.getInt(1);
				int apms = set.getInt(2);
				int a_106 = set.getInt(3);
				int a_102 = set.getInt(4);			    
				if (exists != 0 || apms != 0 || a_106 != 0 || a_102 != 0){
					response.sendRedirect("../insert/bussinessInsert106.jsp?show=1&info=10&&appayId="
						+ appay
						+ "&CommercialId="
						+ COMMERCIAL_ID);
					System.out.print("《《《《《《《《自助终端编号已经存在！》》》》》》");
					set.close();
					dba.release();
					//out.println(-11);
					return;
			    }
			}
			set.close();
			dba.release();
			
			
			Apppay106_Info info = bind.toModel(request,
					Apppay106_Info.class);

			info.setAPPR_MAN(man.getOperman_id() + "");
			info.setAPPPAY_ID(Integer.parseInt(appay));
			Apppay106_InfoDao dao = new Apppay106_InfoDao();

			dao.operate(info);

			response.sendRedirect("../insert/bussinessInsert106.jsp?show=1&info=s1&&appayId="
					+ appay
					+ "&CommercialId="
					+ dao.loadCommercialIdByAppayId(
							info.getAPPPAY_ID(), 106));
			dao.release();
		}
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		response.sendRedirect("../insert/commercialInsert.jsp?show=1&info=opera0&CommercialId="
				+ session.getAttribute("COMMERCIAL_ID"));
	}
%>