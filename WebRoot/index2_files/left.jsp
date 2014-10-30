<%@page import="com.dodou.table.Page"%>
<%@page import="com.szzt.dao.PageDao"%>
<%@page import="com.szzt.dao.DaoUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	List<Integer> list=(List<Integer>)session.getAttribute("posts");
	PageDao dao=new PageDao();
	request.setAttribute("pages",dao.removeWithoutItems(dao.findAll(list)));
	System.out.println("菜单查询完毕。。。");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>菜单栏</title>
<link rel="stylesheet" href="http://merchant.allinpay.com/mssource/css/ms.css">
<script type="text/javascript" src="common.js"></script>
<script type="text/javascript" src="ms.js"></script>
<script src="../js/jquery-1.7.min.js" type="text/javascript"></script>
<script>
$(function(){
	$.each($("table[name]"),function(){
		var name=$(this).attr("name");
		
	});
});
function showsubmenu(sid)
{

}

function setLoginType()
{
	var loginType = top.document.getElementById("mainFrame").getAttribute("loginType");
	if(loginType == "1")
	{
	}
	else
	{
	}
}

</script>
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

.STYLE1 {
	font-size: 12px;
	color: #FFFFFF;
}

.STYLE3 {
	font-size: 12px;
	color: #033d61;
}

.menu_title SPAN {
	FONT-WEIGHT: bold;
	LEFT: 3px;
	COLOR: #ffffff;
	POSITION: relative;
	TOP: 2px
}

.menu_title2 SPAN {
	FONT-WEIGHT: bold;
	LEFT: 3px;
	COLOR: #FFCC00;
	POSITION: relative;
	TOP: 2px
}
</style>
</head>
<body onload="setLoginType()" >
<table width="165" border="0" cellpadding="0" cellspacing="0" style="overflow: auto">
	<tbody>
	<tr>
		<td height="28" background="main_40.gif">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tbody>
			<tr>
				<td width="19%">&nbsp;</td>
				<td width="81%" height="20"><span class="STYLE1">菜单栏</span></td>
			</tr>
		</tbody></table>
		</td>
	</tr>
	<c:if test="${pages!=null}">
		<c:forEach items="${pages }" var="v" varStatus="ss">
			<c:if test="${v!=null&&v.child!=null&&fn:length(v.child)>0}">
				<tr>
					<td valign="top">
					<table name="t${ss.index}" width="151" border="0" align="center" cellpadding="0" cellspacing="0">
						<tbody><tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tbody>
								<tr>
									<td height="23" background="main_47.gif" id="imgmenu1" class="menu_title" onmouseover="this.className=&#39;menu_title2&#39;;" onclick="showsubmenu(1)" onmouseout="this.className=&#39;menu_title&#39;;" style="cursor: hand">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tbody><tr>
											<td width="18%">&nbsp;</td>
											<td width="82%" class="STYLE1"><c:out value="${v.name}"></c:out> </td>
										</tr>
									</tbody></table>
									</td>
								</tr>
							<c:forEach var="vv" items="${v.child }">
								<c:if test="${vv.checked }">
								<tr>
								<td background="main_51.gif" id="submenu1">
								<div class="sec_menu">
								<table name="t${ss.index }" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tbody><tr>
										<td>
										<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
											<tbody><tr>
												<td width="16%" height="25">
												<div align="center"><img src="left.gif" width="10" height="10"></div>
												</td>
												<td width="84%" height="23">
												<table width="95%" border="0" cellspacing="0" cellpadding="0">
													<tbody><tr>
														<td height="20" style="cursor: hand" onmouseover="this.style.borderStyle=&#39;solid&#39;;this.style.borderWidth=&#39;1&#39;;borderColor=&#39;#7bc4d3&#39;; " onmouseout="this.style.borderStyle=&#39;none&#39;"><a target="operation_area" href="${vv.url }" class="whitelink"><c:out value="${vv.name }"></c:out> </a></td>
													</tr>
												</tbody></table>
												</td>
											</tr>
										
										</tbody></table>
										</td>
									</tr>
									<tr>
										<td height="5"><img src="main_52.gif" width="151" height="5"></td>
									</tr>
								</tbody></table>
								</div>
								</td>
							</tr>
								</c:if>
							</c:forEach>
						</tbody></table>
						</td>
					</tr>
				</tbody></table>
				</td>
			</tr>		
			</c:if>
		</c:forEach>
	</c:if>
	<tr>
		<td valign="top">
		<table width="151" border="0" align="center" cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tbody><tr>
						<td height="23" background="main_47.gif" id="imgmenu5" class="menu_title" onmouseover="this.className=&#39;menu_title2&#39;;" onclick="showsubmenu(5)" onmouseout="this.className=&#39;menu_title&#39;;" style="cursor: hand">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tbody><tr>
								<td width="18%">&nbsp;</td>
								<td width="82%" class="STYLE1">其他信息</td>
							</tr>
						</tbody></table>
						</td>
					</tr>
					<tr>
						<td background="main_51.gif" id="submenu5">
						<div class="sec_menu">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tbody><tr>
								<td>
								<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
									<tbody>
									<tr>
										<td width="16%" height="25">
										<div align="center"><img src="left.gif" width="10" height="10"></div>
										</td>
										<td width="84%" height="23">
										<table width="95%" border="0" cellspacing="0" cellpadding="0">
											<tbody><tr>
												<td height="20" style="cursor: hand" onmouseover="this.style.borderStyle=&#39;solid&#39;;this.style.borderWidth=&#39;1&#39;;borderColor=&#39;#7bc4d3&#39;; " onmouseout="this.style.borderStyle=&#39;none&#39;"><span class="STYLE3"><a href="../help/help.jsp" target="operation_area" class="whitelink">帮助教程</a></span></td>
											</tr>
										</tbody></table>
										</td>
									</tr>
									<tr>
										<td width="16%" height="25">
										<div align="center"><img src="left.gif" width="10" height="10"></div>
										</td>
										<td width="84%" height="23">
										<table width="95%" border="0" cellspacing="0" cellpadding="0">
											<tbody><tr>
												<td height="20" style="cursor: hand" onmouseover="this.style.borderStyle=&#39;solid&#39;;this.style.borderWidth=&#39;1&#39;;borderColor=&#39;#7bc4d3&#39;; " onmouseout="this.style.borderStyle=&#39;none&#39;"><span class="STYLE3"><a href="http://www.allinpay.com/" target="_blank" class="whitelink">公司主页</a></span></td>
											</tr>
										</tbody></table>
										</td>
									</tr>
									<tr>
										<td width="16%" height="25">
										<div align="center"><img src="left.gif" width="10" height="10"></div>
										</td>
										<td width="84%" height="23">
										<table width="95%" border="0" cellspacing="0" cellpadding="0">
											<tbody><tr>
												<td height="20" style="cursor: hand" onmouseover="this.style.borderStyle=&#39;solid&#39;;this.style.borderWidth=&#39;1&#39;;borderColor=&#39;#7bc4d3&#39;; " onmouseout="this.style.borderStyle=&#39;none&#39;"><span class="STYLE3">客服热线：0731-82802335</a></span></td>
											</tr>
										</tbody></table>
										</td>
									</tr>
									<tr>
										<td height="23" colspan="2">
										<table width="95%" border="0" cellspacing="0" cellpadding="0">
											<tbody><tr>
												<td height="5"></td>
											</tr>
										</tbody></table>
										</td>
									</tr>
								</tbody></table>
								</td>
							</tr>
							<tr>
								<td height="5"><img src="main_52.gif" width="151" height="5"></td>
							</tr>
						</tbody></table>
						</div>
						</td>
					</tr>
				</tbody></table>
				</td>
			</tr>
		</tbody></table>
		</td>
	</tr>
</tbody>

</table>


</body></html>
