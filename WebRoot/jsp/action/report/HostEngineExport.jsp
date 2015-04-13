<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.export.HostEngineExport"%>
<%@page import="com.szzt.dao.AssignOrderDao"%>
<%@page import="com.szzt.export.AssignOrderExport"%>
<%@page import="com.dodou.inferface.Export"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@ include file="../../../import.jsp"%>
<%
	Export export = new HostEngineExport();
	Permission per = new PositionPermessionImpl();
	String where = null;
	//领导岗可选地区
	if (per.hasPermission(session, Permission.LEADER_POSITION))
	{
		where = request.getParameter("area");
	} else
	//没有领导岗只能查询本地区
	{
		Operman_info man = (Operman_info) session.getAttribute("man");
		where = man.getOper_address();
	}

	if (null != where && where.trim().length() > 0)
	{
		where = " where t.area='" + where + "'";
	}
	String sql = "select t.host_no as 主机序列号,        (select ar.city from ws_area ar where ar.areaid = t.area) as 地区,        case          when ( case                 when (   (exists (select i.serial1                         from teminal_info i                        where Upper(i.serial1) = Upper(t.host_no)) )                         or                        (exists (select ii.host_seq                         from teminal_info_serv ii                        where Upper(ii.host_seq) = Upper(t.host_no)) )                        )  then                  2                 else                  1               end ) = 1 then           '仓库中'          else           '商户处'        end as 状态,        ter.archive_date as 归档时间,        (select c.comm_name from commercial_info c where c.commercial_id=ter.commercial_id) as 客户名称,        (select temp.term_id1 from term_app_table temp where ter.teminal_info_id=temp.teminal_info_id and temp.apptype='105') as 商户编号,        (select temp.term_id2 from term_app_table temp where ter.teminal_info_id=temp.teminal_info_id and temp.apptype='105') as 终端编号,        ts.comm_name as 专业化客户名称,ts.merchantsno as 专业化商户编号,ts.teminalno as 专业化终端编号 ,TO_CHAR(IN_TIME,'YYYY-MM-DD hh24') 入库时间,DECODE(TER.INSTALLED_STATUS,0,'取消装机', 2,'延迟装机' ,4,'装机成功',5, '未调试',-1,'待调试过') 终端状态        from TEMINAL_INFO_KEY t         left join teminal_info ter on         Upper(ter.serial1) = Upper(t.host_no)         and (ter.installed_status = 4 and ter.teminal_status = 13)        left join teminal_info_serv ts on         Upper(ts.host_seq) = Upper(t.host_no)         and (ter.teminal_status <> 6 or ter.teminal_status is null) ";
	export.setSql(sql+where);
	//export.initSql(where);
	export.setFileName("zhuji" + session.getId().substring(20));
	String result = export.export(application.getRealPath("/report"));
	export.exportLog(session);
	System.out.println("=========================");
	out.println("<a href='../../../report/"+export.getFileName()+".xls'>主机报表</a>");
%>


