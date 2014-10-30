<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
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
		String appId = request.getParameter("appId");//业务ID、
		String type = request.getParameter("type");//业务类型
		PhotoDao dao = new PhotoDao();
		PhotoUtils p = new PhotoUtils();
		p.delPhotos(session, id, type, appId);
		dao.delete(Integer.parseInt(id));
		dao.release();
		response.sendRedirect("../insert/attachPhoto.jsp?type=" + type
				+ "&id=" + appId);
	} catch (Exception e)
	{
		Log.getLogger().error("导入上传文件异常", e);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>

