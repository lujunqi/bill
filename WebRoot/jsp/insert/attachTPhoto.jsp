<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.dao.TPhotoDao"%>
<%@page import="com.szzt.dao.PhotoDao"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>

<meta http-equiv="content-script-type" content="text/javascript">
<meta http-equiv="content-style-type" content="text/css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../../css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../../css/tabs.css" media="screen" />
<link rel="stylesheet" href="../../css/dataTable.css" media="screen" />
<link rel="stylesheet" href="../../css/formly.min.css" media="screen" />
<link rel="stylesheet" href="../../css/pagination.css" media="screen" />
<link rel="stylesheet" href="../../css/thickbox.css" media="screen" />
<style type="text/css">
table.dataTable1 
{
	border-collapse: collapse;
}
table.dataTable1 th.dataTableHeader {
color: #fff;
background-color: #052d92;
padding: 2px;
border: #fff 1px solid;
text-align: center;
}

table.dataTable1 td {
	padding: 2px;
	border-style: solid;
	border-width: 1px 1px 0 1px;
	border-color: #ccc #fff #ccc #fff;
}

table.dataTable1 td a {
	padding-right: 2px;

}

table.dataTable1 tr.odd_row {
	background-color: #e4f2fb;
}

table.dataTable1 tr.even_row {
	background-color: #f8f8f8;
}

table.dataTable1 tr.odd_row:hover,
table.dataTable1 tr.even_row:hover,
table.dataTable1 tr.odd_row:hover a,
table.dataTable1 tr.even_row:hover a {
	background-color: #FFD900;
}

table.dataTable1 tr.odd_row:hover a:hover,
table.dataTable1 tr.even_row:hover a:hover {
}

table.dataTable1 th.dataTableHeader a,
table.dataTable1 th.dataTableHeader a:link,
table.dataTable1 th.dataTableHeader a:active,
table.dataTable1 th.dataTableHeader a:visited {
	color: #fff;
	display: block;
	text-decoration: none;
}

* html table.dataTable1 th.dataTableHeader a {
	width: 100%;
}

table.dataTable1 th.dataTableHeader a:hover {
	text-decoration: underline;
}

table.dataTable1 {
	border-bottom: 1px solid #fff;
}

table.dataTable1 thead td,
table.dataTable1 tfoot td.dataTableFooter {
	border: 0;
	padding: 0;
}

</style>
<link rel="stylesheet" type="text/css" href="../../css/easy_tab.css" />
<script type="text/javascript" src="../../js/jquery-1.7.min.js"></script>
<script language="javascript" type="text/javascript" src="../../js/WdatePicker.js"></script>  
<script type="text/javascript" src="../../js/thickbox-compressed.js"></script>
<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
<script type="text/javascript" src="../../js/jquery.easytabs.min.js"></script>
<script src="../../js/jquery.pagination2.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/check.js"></script>
  <style type="text/css">
  	input{
  		width:300px;
  		height:30px;
  	}
  select{
  width:100px;
  height:30px;
  margin-top: 10px;
  margin-bottom: 10px;
  }
  </style>
  <%
  	TPhotoDao pd=new TPhotoDao();
  	String sql="select * from " + TPhotoDao.TABLE+" where terminal_info_id="+request.getParameter("id")+" order by TYPE";
  	request.setAttribute("photos", pd.select(sql));
  %>
  <script type="text/javascript">
  function showAttachFile(url){
		window.open ('showImg.jsp?url='+url+'.jpg', 'showImage', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行 
	}
  function checkFile(){
	  var v=$("#photoFile").val();
	  if(null==v){
		  return;
	  }
	  if(!(/\w*.jpg$|\w*.png$|\w*.gif$|\w*.bmp$/.test(v))){
		  alert("请选择图片！");
		  window.location.reload();
	  }
  }
  	</script>
</head>

<body > 
<%Permission per=new PositionPermessionImpl(); %>
<!-- 终端列表信息 -->
	<center>
		<div class="left02downDiv" style="width: 80%">
		<div>
			<center>
			<div class="left02" >
			<div class="left02topDiv">
				<div class="left02top_right"></div>
				<div class="left02top_left"></div>
				<div class="left02top_c" style="width: 600px">
				 </div>
			</div>
				<%if(per.hasPermission(session, Permission.EXPAND_POSITION)){ %>
					<form enctype="multipart/form-data" action="../action/TPhotoUpload.jsp" method="post">
					<div>
						<center>
						</center>
					</div>
					<table>
						<tr>
							<td>附件类型：
								<input type="hidden" name="id" value="${param.id}"/>
							</td>
							<td>
								<select name="fileType" id="fileType">
									<option value="1">-------请选择-----</option>
									<option value="商户营业执照">商户营业执照</option>
									<option value="其他">其他</option>
								</select>
							</td>
							<td>上传附件:<input type="file"   style="height: 20px;width: 260px" name="photoFile" id="photoFile" onchange="checkFile()"></td>
							<td><input type="submit" value="上传" style="width: 100px;height:30px" onclick="if($('#fileType').val()==1){alert('请选择附件类型');return false;}var fileValue=($('#photoFile').val().length>0);if(!fileValue) alert('请选择文件');return fileValue;"></td>
							<td><button onclick="window.close()"  style="width: 100px;height:30px">关闭</button> </td>
						</tr>
					</table>
				</form>
				<%} %>
			</center>
		</div>
		</div>
		</div>
	
		<table style="width: 80%" border="1" class="dataTable1">
			<thead>
				<tr>
				<td>序号</td>
				<td>证件名称</td>
				<td>上传日期</td>
				<td>照片</td>
				<%if(!per.hasPermission(session, Permission.OPERAT_POSITION)){ %>
				<td>删除</td>
				<%} %>
				<td>下载</td>
			</tr>
			</thead>
		<c:forEach var="v" items="${photos }" varStatus="vv">
			<tr>
				<td><c:out value="${vv.index+1 }"></c:out> </td>
				<td><c:out value="${v.TYPE }"></c:out></td>
				<td><c:out value="${v.UP_DAY }"></c:out></td>
				<td><a href="javascript:showAttachFile('photo/terminal/${v.TERMINAL_INFO_ID }/${v.PHOTO_ID}')">查看</a></td>
				<%if(!per.hasPermission(session, Permission.OPERAT_POSITION)){ %>
					<td><a href="../action/TPhotoDel.jsp?id=${v.PHOTO_ID }&terminalId=${v.TERMINAL_INFO_ID }" onclick="if(confirm('确认删除')) return true;return false;">删除</a></td>
				<%} %>
				<td><a href="<%=basePath %>/photo/terminal/${v.TERMINAL_INFO_ID }/${v.PHOTO_ID}.jpg">下载</a></td>
			</tr>
		</c:forEach>
		</table>
		
		</center>
</body>
</html>		
