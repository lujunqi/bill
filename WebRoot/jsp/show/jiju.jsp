<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../import.jsp"%>


<html>
<head>
<meta http-equiv="content-script-type" content="text/javascript">
<meta http-equiv="content-style-type" content="text/css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../../css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../../css/dataTable.css" media="screen" />
<link rel="stylesheet" href="../../css/formly.min.css" media="screen" />
<link rel="stylesheet" href="../../css/tabs.css" media="screen" />
<link rel="stylesheet" href="../../css/pagination.css" media="screen" />
<link rel="stylesheet" href="../../css/thickbox.css" />

<link rel="stylesheet" href="../../css/allinpay.css" />
	<link rel="stylesheet" href="../../css/uploadify.css" />

<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/thickbox-compressed.js"></script>
<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
<script src="../../js/formly.min.js"></script>
<script src="../../js/jquery.form.js"></script> 
<script src="../../js/jquery.pagination2.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../js/jquery.uploadify.min.js"></script>

<script src="../../js/WdatePicker.js" type="text/javascript"></script>
<script>
var hasFile = false;
	$(document).ready(function()
{
	$('form').resetForm();
	$("#detail_custForm").formly();
	$('#add_file_nameDiv').hide();
	//find(0);
	   $('#fileInput').uploadify({
	        'uploader': '../action/keyUpload.jsp',        //上传文件的后台处理页面
	        'swf': '../../js/uploadify.swf',
	        'auto': true,
	        'multi'	 :false,
	        'cancelImg': '../../js/cancel.png',
	        'fileTypeDesc':'支持的格式:',
	        'fileTypeExts':'*.txt',
	        'fileSizeLimit':'4MB',
	        'folder': 'key',
	        'simUploadLimit': 2,                   //上传文件大小的限制
	         'onUploadComplete': function(event, queueID, fileObj, response, data) {             //上传完成后的操作
	        	alert("文件上传成功");
	        },
		    'onUploadError': function (event, queueID, fileObj) {
		        alert("文件上传失败");
		    },
		    'onSelect': function(e, queueId, fileObj)
	        {
		    	hasFile = true;
	        }
	    });
});
var host_no;
function modify(id){
	host_no = id;
	$('#add_file_name').click();
}	
	
function update(){
	var area = $('#update_unit_area').val();
	$.ajax({
		url:'../action/JiJuUpdate.jsp',
		dataType:'json',
		type:'POST',
		data:{'host':host_no,'area':area},
		success: function(json){
			if(json == 1)
				alert('调配成功!');
			$('#add_file_nameDiv').hide();
    	},  
	    error: function(XmlHttpRequest, textStatus, errorThrown){  
	        alert( "error");  
	    }
	 }); 
}
var cur_page = 0;
function find(cur_page){
    $('#merDayGain_Templet').nextAll().remove();
	cur_page = cur_page || 0;
	var row = $('#merDayGain_Templet').clone(true);
	$("#cur_page").val(cur_page+1);
	var page_size = $("#page_size").val();
	$.ajax({
		url:'../action/JiJuQuery.jsp',
		dataType:'json',
		type:'POST',
		data:{startTime:$("#startTime").val(),endTime:$("#endTime").val(),unit_area:$("#unit_area").val(),host_no:$("#host_no").val(),status:$("#statuss").val(),'cur_page':cur_page+1,'page_size':page_size},
		success: function(json){
			var object = json.resultset;
	        $('#merDayGain_Templet').nextAll().remove();
	        if (json.total==0){
	        	$('#cust_Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
	        }
	        var i=0;
	        for(i=(json.rows-1);i>=0;i--){
	        	var row = $('#merDayGain_Templet').clone(true);
	        	for(var pro in object[0]) {
	        		row.find('#'+pro+'').text(object[i][pro]);
					if(pro == 'status' && object[i][pro] == '1'){
	        			row.find('#'+pro+'').text('仓库中');
	        		}else if(pro == 'status' && object[i][pro] == '2'){
	        			row.find('#'+pro+'').text('商户库');
	        		}


	        	}
	        	row.find('#opera').append("<input type=button onclick=modify('"+object[i].host_no+"') value=调机 />");		        		        	
		        row.show();
		        row.insertAfter('#merDayGain_Templet');
	        };
	        $('#cust_Table').mygrid();
	    	$('#cust_Pagination').pagination(json.total, {
	    		current_page : cur_page,
	    		prev_text : '前一页',
	    		next_text : '后一页',
	    		callback : find
	    	});
	    	$('#cust_Searchresult').text(
	    			'当前显示 ' + ((cur_page * $('#page_size').val()) + 1) + '-'
	    					+ ((cur_page * $('#page_size').val()) + json.rows) + ' 条记录,共 '
	    					+ json.total + ' 条记录');
    	},  
	    error: function(XmlHttpRequest, textStatus, errorThrown){  
	        alert( "error");  
	    }
	 }); 
}
/**
 * return true时间选择，false 时间未选择
 */
function timeSelected(){
	   return ($('#startTime').val() != '')&&($('#endTime').val() != '');
}
function importReort(){
	$('#fileInput').uploadify('upload');
}
	function exportReport()
	{
		if(!timeSelected()){
			alert("请选择日期！");
			return;
		}
		var cust_Table = document.getElementById('cust_Table');
		if(cust_Table.rows.length <= 3)
		{
		    alert('没有要导出的数据！');
		}
		else
		{
			var startTime = document.getElementById('startTime').value;
			var endTime = document.getElementById('endTime').value;
			var tranType = document.getElementById('tranType').value;
			var unit_area = document.getElementById('unit_area').value;
			
			if(unit_area != null && unit_area != '')
			{
			}
			else
			{
				alert('只能按地区导出，请先按地区查询');
				document.getElementById('unit_area').focus();
				return;
			}
		   	location.href='merDayLogExport.jsp?startTime='+startTime+'&endTime='+endTime+"&tranType="+tranType+"&unit_area="+unit_area;
		}
	}
</script>
<style type="text/css">
#cust_Table td{
	text-align: center;
}

</style>
</head>

<body>

	<div id=detailDiv class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c" id="titleInfo">查询条件</div>
		</div>
		<div class="left02downDiv">
		<form id="detail_custForm" action="ExecuteQuery.jsp"  method="post">
		<table border='0px' style='font-sizd: 1.2em' >
		<tr>
			<td align='right' width="8%">导入时间:</td>
			<td width="30%">
				<input  readonly="readonly" style='width: 100px' id="startTime" name="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" class="Wdate" />
				至
				<input  readonly="readonly" style='width: 100px' id="endTime" name="endTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" class="Wdate" />
			</td>
	
			<td align='right' width="8%">序列号:</td>
			<td width="13%">
				<input   style='width: 100px' id="host_no" name="host_no" />
			</td>	
			<td align='right' width="12%">所在地区:</td>
			<td width="13%"><select id="unit_area" name='unit_area' style='width: 120px' />
				<option value=''>请选择</option>
				<option value='4326'  >湘西自治州</option>
				<option value='4325'  >娄底市</option>
				<option value='4312'  >怀化市</option>
				<option value='4311'  >永州市</option>
				<option value='4310'  >郴州市</option>
				<option value='4309'  >益阳市</option>
				<option value='4308'  >张家界市</option>
				<option value='4307'  >常德市</option>
				<option value='4306'  >岳阳市</option>
				<option value='4305'  >邵阳市</option>
				<option value='4304'  >衡阳市</option>
				<option value='4303'  >湘潭市</option>
				<option value='4302'  >株洲市</option>
				<option value='4301'  >长沙市</option>

					</select>
			</td>	
			<td align="right" ><input  type="button" value="查 询" onclick="find(0)"  />
			</td>
		</tr>
			<tr>
		<td align='right'>导入excel:</td>
		<td>
				<input type="file" name="fileInput" id="fileInput" />		
		</td>
		<td align='left'>
			<!-- <a href="javascript:$('#fileInput').uploadify('upload');">Upload Files</a>  -->   
			<a href="javascript:$('#fileInput').uploadify('cancel','*');">取消</a>
		</td>
		<td align='left' colspan="5">
			<FONT SIZE="2" COLOR="#FF0000">上传要求：文件格式txt，文件大小不超1M，内容包括：主机序列号、地区编号。</FONT>
		</td>
		</tr>
		</table>
			<input type="hidden" id="cur_page" name="cur_page"  value=0/>
			<input type="hidden"  id="page_size" name="page_size" value="20"/>
		</form>
		</div>
	
	<div id="listDiv" class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c"><span id="titleName">商户押金缴纳记录</span> </div>
		</div>
		<div class="left02downDiv">
		<form id="queryForm">
		<table id='cust_Table' class='dataTable1' width="100%">
			<tr>
				<th class='dataTableHeader'>地市</th>
				<th class='dataTableHeader'>主机序列号	</th>
				<th class='dataTableHeader'>状态</th>
				<th class='dataTableHeader'>导入时间</th>
				<th class='dataTableHeader'>操作</th>
			</tr>
			<tr id='merDayGain_Templet' >
				<td id='t_area' ></td>
				<td id='host_no' ></td>
				<td id='status' ></td>
				<td id="in_time"></td>
				<td id="opera"></td>
			</tr>	
		</table>
			<div id='cust_Pagination' class='pagination'></div>
			<div id='cust_Searchresult'></div>
		</div>
		</form>
	</div>


<a id='add_file_name' href='#TB_inline?height=400&width=1000&inlineId=add_file_nameDiv' class='thickbox'></a>
 	<div id="add_file_nameDiv" class="left02">
 		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c">机具调配</div>
		</div>
		<div class="left02downDiv">
		<table border='0px' style='font-sizd: 1.2em' >
		<tr>
			<td align='right'>调配地址:</td>
			<td>
				<select id="update_unit_area" name='unit_area' style='width: 120px' />
					<option value=''>请选择</option>
					<option value='4326'  >湘西自治州</option>
					<option value='4325'  >娄底市</option>
					<option value='4312'  >怀化市</option>
					<option value='4311'  >永州市</option>
					<option value='4310'  >郴州市</option>
					<option value='4309'  >益阳市</option>
					<option value='4308'  >张家界市</option>
					<option value='4307'  >常德市</option>
					<option value='4306'  >岳阳市</option>
					<option value='4305'  >邵阳市</option>
					<option value='4304'  >衡阳市</option>
					<option value='4303'  >湘潭市</option>
					<option value='4302'  >株洲市</option>
					<option value='4301'  >长沙市</option>

				</select>
				<input name="s" type="button" value="调配" onclick="update();"/>
			</td>
		</tr>
		</table>
 		</div>
	</div>	
</body>
</html>

