<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.dao.PhotoDao"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

<link href="../../css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../../css/tabs.css" media="screen" />
<link rel="stylesheet" href="../../css/formly.min.css" media="screen" />
<link rel="stylesheet" href="../../css/pagination.css" media="screen" />
<link rel="stylesheet" href="../../css/thickbox.css" media="screen" />
<title>Plupload - Custom example</title>

<!-- production -->
<script type="text/javascript" src="../../js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../../js/plupload.full.min.js"></script>
<%
	String apppay_type = request.getParameter("type");
  	PhotoDao pd=new PhotoDao();
  	String sql="select * from " + PhotoDao.TABLE+" where APPPAY_ID="+request.getParameter("id")+" and apppay_type="+apppay_type+"  order by PHOTO_ID "; 
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
	  if(!(/\w*.jpg$|\w*.png$|\w*.gif$|\w*.bmp$/.test(v.toLowerCase()))){
		  alert("请选择图片！");
		  window.location.reload();
	  }
  }
  	</script>
  	 <style type="text/css">
  	input{
  		width:300px;
  		height:30px;
  	}
  .button{
  width:100px;
  height:30px;
  margin-top: 10px;
  margin-bottom: 10px;
  }
  </style>
</head>
<body >
	<center>
	<div id="filelist"></div>
	<br />
	<div id="container">
		<center>
			提示：必须上传 "商户营业执照","税务登记证明","企业法人身份证","考察照片","商户信息调查表","商户协议" 才能提交审批！
			</center>
		<label>附件类型:</label> <select name="fileType" id="fileType" >
			<option value="1">-------请选择-----</option>
			<option value="商户营业执照">商户营业执照</option>
			<option value="税务登记证明">税务登记证明</option>
			<option value="企业法人身份证">企业法人身份证</option>
			<option value="考察照片">考察照片</option>
			<option value="商户信息调查表">商户信息调查表</option>
			<option value="商户协议">商户协议</option>
			<option value="组织代码证">组织代码证</option>
			<option value="新增终端审批表">新增终端审批表</option>
			<option value="商户信息变更表">商户信息变更表</option>
			<option value="押金减免单">   押金减免单</option>  
			<option value="风险承诺函">   风险承诺函</option>  
			<option value="代理协议">     代理协议  </option>  
			<option value="账号授权书">   账号授权书  </option>
			<option value="商户特批单">   商户特批单  </option>
			<option value="门面租赁协议"> 门面租赁协议</option>
			<option value="账号复印件">   账号复印件  </option>

			<option value="其他">其他</option>
		</select>
		<button class="button" id="pickfiles">选择文件</button>&nbsp;&nbsp;
		<button class="button" id="uploadfiles">批量上传</button>&nbsp;&nbsp;
		<button class="button"  onclick="window.location.reload()">刷新</button>&nbsp;&nbsp;
		<button class="button" onclick="window.close()">关闭窗口</button>
		<table style="width: 600px" id="uploadTable" border="1">
			<tr>
				<td>文件类型</td>
				<td>文件名称</td>
				<td>操作</td>
				<td>上传进度</td> 
			</tr>
		</table>
	</div>
<div ><h2>已上传</h2></div>
	</center>
	<!-- 终端列表信息 -->
	<%Permission per=new PositionPermessionImpl(); %>
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
				<%if (!per.hasPermission(session, Permission.OPERAT_POSITION)){ %>
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
				<td><a href="javascript:showAttachFile('photo/${v.URL }/${v.PHOTO_ID}')">查看</a></td>
				<%if (!per.hasPermission(session, Permission.OPERAT_POSITION)){ %>
				<td><a href="../action/photoDel.jsp?id=${v.PHOTO_ID }&type=${v.APPPAY_TYPE}&appId=${v.APPPAY_ID}" onclick="if(confirm('确认删除')) return true;return false;">删除</a></td>
				<%} %>
				<td><a href="<%=basePath %>/photo/${v.URL }/${v.PHOTO_ID}.jpg">下载</a></td>
			</tr>
		</c:forEach>
		</table>
		
		</center>

	<script type="text/javascript">
		var map={};
		// Custom example logic
		var uploader = new plupload.Uploader({
					runtimes : 'html5,flash,silverlight,html4',
					browse_button : 'pickfiles', // you can pass in id...
					container : document.getElementById('container'), // ... or DOM Element itself
					url : '../action/photoUpload.jsp',
					flash_swf_url : '../../js/Moxie.swf',
					silverlight_xap_url : '../../js/Moxie.xap',
					filters : {
						max_file_size : '200kb',
						mime_types : [ {
							title : "图片类型",
							extensions : "jpg,gif,png"
						} ]
					},
					init : {
						PostInit : function() {
							document.getElementById('uploadfiles').onclick = function() {
								uploader.start();
								return false;
							};
						},
						BeforeUpload:function(up,file){
							uploader.setOption("multipart_params",{"apptype":${param.type},"id":${param.id},"fileType":map[file.id]});
						},
						FileUploaded:function(up,file){
							$("#"+file.id+"btn").parent().html("上传完毕");
							$("#"+file.id+"btn").remove();
						},
						FilesAdded : function(up, files) {
							if($("#fileType").val()==1){
								alert("请选择附件类型！");
								plupload.each(files,function(file) {
									uploader.removeFile(file.id);
								});
								return false;
							}
							plupload.each(files,function(file) {
								map[file.id]=$("#fileType").val();
								$("#uploadTable").append("<tr id='"+file.id+"tr'><td>"+$("#fileType").val()+"</td><td>"+file.name+"</td><td><button type='button' id='"+file.id+"btn' onclick=del('"+file.id+"')>删除</button> </td><td id='"+file.id+"_progress'></td></tr>");
							});
						},
						UploadProgress : function(up, file) {
							$("#"+file.id+"_progress").html('<span>'+ file.percent + "%</span>");
						},
						Error : function(up, err) {
							alert("此文件上传失败！");
						}
					}
				});
		uploader.init();
		function del(id){
			uploader.removeFile(id);
			$("#"+id+"tr").remove();
			map[id]="";
		}
	</script>
</body>
</html>
