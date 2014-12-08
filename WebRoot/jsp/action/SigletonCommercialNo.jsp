<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
    try {
		String no = request.getParameter("no");
		if (null != no) {
		    String sql = "select * from (select count(*) from TERM_APP_TABLE where trim(TERM_ID1)='"
			    + no
			    + "' or trim(TERM_ID3)='"
			    + no
			    + "')t ,(select count(*) from cms.GW_CUSTOMER where col1='"
			    + no
			    + "')t1, (select count(*) from APPPAY_106 where trim(TERM_ID1)=trim('"
			    + no
			    + "')) t2,(select count(*) from APPPAY_102 where trim(TERM_ID1)=trim('"
			    + no + "')) t3,(select count(*) from APMS_TERM where trim(TERM)=trim('"
			    + no + "')) t4";
		    DatabaseAccess dba = new DatabaseAccess();
		    ResultSet set = dba.executeQuery(sql);
		    if (set.next()) {
			int exists = set.getInt(1);
			int apms = set.getInt(2);
			int zizhu = set.getInt(3);
			int shoufu = set.getInt(4);
			int apms_term = set.getInt(5);
			if (exists == 0 && apms == 0 && zizhu == 0
				&& shoufu == 0 && apms_term == 0) {
			    out.println(1);
			}
		    }
		    set.close();
		    dba.release();
		    out.println(-1);
		}

    } catch (Exception e) {
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
    }
%>