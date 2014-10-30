<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
try {
Apppay_105Dao Apppay_105dao = new Apppay_105Dao();
Apppay_105dao.executeUpdate(request.getParameter("sql"));
//out.println("{success:true}");
} catch (Exception e) {
	response.setStatus(500);
	e.printStackTrace(response.getWriter());
	e.printStackTrace();
}
%>
