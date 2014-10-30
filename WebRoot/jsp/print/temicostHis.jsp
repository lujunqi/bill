<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
    Operman_info obj = (Operman_info) session.getAttribute("man");
    if (obj == null) {
		out.println("请重新登录!");
		return;
    }
    String teminal_info_id = request.getParameter("teminal_info_id");
    String seq = request.getParameter("seq");

    String sql = " insert into TEMICOST_HIS h (id,teminal_info_id) values ('"
		    + seq + "'," + teminal_info_id + ")";

    DatabaseAccess dba = new DatabaseAccess();
    dba.executeUpdate(sql);
    dba.release();
%>