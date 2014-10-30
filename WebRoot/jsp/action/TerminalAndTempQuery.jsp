<%@page import="com.szzt.model.TerminalTempModel"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.dodou.table.*"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
    //终端和中间表信息查询，用于三个业务的界面信息
    try {
		String id = request.getParameter("APPPAY_ID");
		String type = request.getParameter("apptype");
		if (null != id) {
		    TerminalAndTempDao dao = new TerminalAndTempDao();
		    String cur_page = request.getParameter("cur_page");
		    if (null != cur_page) {
			dao.setCurPage(Integer.parseInt(cur_page));
		    }
		    List<TerminalTempModel> data = dao.loadMessageByApp(
			    Integer.parseInt(id), type);
		    TableJson<TerminalTempModel> json = new TableJson<TerminalTempModel>(
			    "yyyy-MM-dd HH:mm:ss");
		    json.setResultset(data.toArray());
		    json.setRows(data.size());
		    json.setTotal(dao.getTotalCount());
		    System.out.println("-------------------"
			    + dao.getTotalCount());
		    json.setRowsCount(dao.getRowsCount());
		    out.println(json.toJson());
		}
    } catch (Exception e) {
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
    }
%>