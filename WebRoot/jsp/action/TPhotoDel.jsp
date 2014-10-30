<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.dao.TPhotoDao"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="com.szzt.dao.PhotoDao"%>
<%@page import="com.szzt.util.PhotoUtils"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		Permission per = new PositionPermessionImpl();
		if (per.hasPermission(session, Permission.OPERAT_POSITION))
		{
			response.sendRedirect("../insert/error.jsp?");
			return;
		}
		String id = request.getParameter("id");//图片ID
		String terId = request.getParameter("terminalId");//图片ID
		TPhotoDao dao = new TPhotoDao();
		PhotoUtils p = new PhotoUtils();
		p.delByTphotoId(session, id, terId);
		dao.delete(Integer.parseInt(id));
		response.sendRedirect("../insert/attachTPhoto.jsp?id=" + terId);
	} catch (Exception e)
	{
		Log.getLogger().error("导入上传文件异常", e);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>

