<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@ page import="com.szzt.dao.*"%>
<%
	Permission per = new PositionPermessionImpl();
	if (!per.hasPermission(session, Permission.EXPAND_POSITION))
	{
		response.sendRedirect("../insert/error.jsp");
		return;
	}
	try
	{
		// 1:先判断是否在库中
		if(request.getParameter("TERM_TYPE").equals("2")){
			String inStore = "select t.apppay_id from TEMINAL_INFO_KEY k left join APPPAY_106 t on upper(k.HOST_NO)=upper(t.serial) where upper(k.HOST_NO)=upper('"+request.getParameter("SERIAL").trim()+"')  ";
			DatabaseAccess dba = new DatabaseAccess();
			ResultSet rs = dba.executeQuery(inStore);
			Log.getLogger().info("先判断是否在库中?");
			if (rs.next())
			{//已入库
			    Log.getLogger().info(rs.getString(1));
			    if (rs.getString(1) != null){
					rs.close();
					dba.release();
					Log.getLogger().info("序列号重复!");
					out.print(0);
					return;
			    }
			}else{//未入库
				rs.close();
				dba.release();
				Log.getLogger().info("序列号未入库!");
				out.print(-1);
				return;
			} 
			rs.close();
			dba.release();
		}
		Apppay106_Info info = new Apppay106_Info();
		info.requestGetParameter(request);
		Apppay106_InfoDao dao = new Apppay106_InfoDao();
		
		int id = dao.insert(info);
		dao.release();
		out.print(id);
		out.flush();
		//if (id < 0)
		//	throw new Exception();
		//	ApppayTerminalDao atd = new ApppayTerminalDao();
		//	atd.insert(request, "102",id);
		//	response.sendRedirect("../insert/commercialInsert.jsp?show=1&info=1&CommercialId="
		//		+ session.getAttribute("COMMERCIAL_ID"));
	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		//response.sendRedirect("../insert/commercialInsert.jsp?show=1&info=-1&CommercialId="
		//	+ session.getAttribute("COMMERCIAL_ID"));
	}
%>