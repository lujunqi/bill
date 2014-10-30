<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.dodou.inferface.TerminalWorkFlow"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.dao.*"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	ApppayTerminalDao dao = new ApppayTerminalDao();
	Terminal_InfoDao tdao = new Terminal_InfoDao();
	try
	{
		//终端ID，业务ID
		TerminalAppTemp temp = new BindRequest().toModel(request,
				TerminalAppTemp.class);
		if (null == request.getParameter("is105"))
		{
			temp.setTERM_ID3(temp.getTERM_ID1());
			temp.setTERM_ID4(temp.getTERM_ID2());
		}
		if (request.getParameter("APP_TYPE").equals("102"))
		{
			temp.setTERM_ID3(request.getParameter("TERM_ID3"));
			temp.setTERM_ID4(request.getParameter("TERM_ID4"));
		}else
		{
			if (null == temp.getTERM_ID3())
			{
				temp.setTERM_ID3("' '");
			}
			if (null == temp.getTERM_ID4())
			{
				temp.setTERM_ID4("' '");
			}
		}
		//其中中间表
		dao.operate(temp);
		//修改业务信息
		Terminal_Info info = new Terminal_Info();
		info.setTEMINAL_INFO_ID(temp.getTEMINAL_INFO_ID());
		info.setCOMMERCIAL_ID(temp.getCOMMERCIAL_ID());

		tdao.operate(info);

		out.println(11);
		dao.release();
		tdao.release();
	} catch (Exception e)
	{
		try
		{
			dao.rollback();
			tdao.rollback();
			dao.release();
			tdao.release();
		} catch (Exception c)
		{
		}
		e.printStackTrace();
		out.println(-1);
	}
%>