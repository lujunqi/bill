<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="../../import.jsp"%>
<html>
<head>
<%
String info=request.getParameter("info");
	if(null!=info&&"del0".equals(info)){
		out.println("<script type=\"text/javascript\">alert('删除失败')</script>");
	}
	if(null!=info&&"del1".equals(info)){
		out.println("<script type=\"text/javascript\">alert('删除成功')</script>");
	}
%> 
<title>用户信息录入</title>
<meta http-equiv="content-script-type" content="text/javascript">
<meta http-equiv="content-style-type" content="text/css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../../css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../../css/pagination.css" media="screen" />
<link rel="stylesheet" href="../../css/dataTable.css" media="screen" />
<link rel="stylesheet" href="../../css/allinpay.css" />

<style type="text/css">
.mycss {
	width: 100%;
	height: auto;
	border: 1px solid #b4b4b4;
	border-top: 0;
	background: #fff;
}
</style>

<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
<script src="../../js/jquery.pagination2.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
<script src="../../js/province_city_area_select.js" type="text/javascript"></script>
<script type="text/javascript">
/**
 * 根据地区编码获取地区中文名称
 */
function getAreaNameByCode(code) {
	switch (code) {
	case '4301':return "长沙市";
	case '4302':return "株洲市";
	case '4303':return "湘潭市";
	case '4304':return "衡阳市";
	case '4305':return "邵阳市";
	case '4306':return "岳阳市";
	case '4307':return "常德市";
	case '4308':return "张家界市";
	case '4309':return "益阳市";
	case '4310':return "郴州市";
	case '4311':return "永州市";
	case '4312':return "怀化市";
	case '4325':return "娄底市";
	case '4326':return "湘西自治州";
	default:return "---";
	}
}
	function testDelete(obj,id){
		if(confirm("确认删除？")){
			obj.href="../action/CommercialDataDelete.jsp?delId="+id;
			obj.click();
		}
	}
	function compositeSqlQuery(status){
		var sql="and allData.commercial_id in(select commercial_id";
		sql+="  from Apppay_101 appp1 where appp1.appr_status"+status;
		sql+=" and appp1.commercial_id=allData.commercial_id   union all (select commercial_id ";
		sql+="   from Apppay_102 appp2  where appp2.appr_status "+status;
		sql+=" and appp2.commercial_id=allData.commercial_id  union all (select commercial_id from Apppay_103 appp3";
		sql+="  where appp3.appr_status"+status+" and appp3.commercial_id=allData.commercial_id)) ";
		sql+=" union all (select commercial_id from Apppay_105 appp5";
		sql+="  where appp5.appr_status"+status+" and appp5.commercial_id=allData.commercial_id))"
		return sql;
	}
	var cur_page = 0;
	function find(cur_page){
		$("#showMsg").html("正在查询。。。");
		$("#queryBtn").attr("disabled","disabled");
		var where=" 1=1 ";
		
		var fee_chan=$("#fee_chan").val();
		var INPUT_DATE=$("#INPUT_DATE").val();
		var TERM_ID1=$("#TERM_ID1").val();
		var UNIT_NAME=$("#UNIT_NAME").val();
		var UNIT_AREA=$("#UNIT_AREA").val();
		var commercial_status=$("#commercial_status").val();
		//录入时间
		if(INPUT_DATE!=null&&INPUT_DATE.length>0)
			where+="and to_char(INPUT_DATE,'yyyy-MM-dd')='"+INPUT_DATE+"'";
		if(TERM_ID1!=null&&TERM_ID1.length>0)
			
			if(TERM_ID1.indexOf("0") == 0){
				where+="and COMMERCIAL_ID in(select COMMERCIAL_ID from TERM_APP_TABLE where trim(TERM_ID2)= '"+TERM_ID1+"') ";
			}else{
				where+="and COMMERCIAL_ID in(select COMMERCIAL_ID from TERM_APP_TABLE where trim(TERM_ID1) = '"+TERM_ID1+"') ";
			}
		if(UNIT_NAME!=null&&UNIT_NAME.length>0)
			where+="and UNIT_NAME like '%"+UNIT_NAME+"%' ";
		if(UNIT_AREA!=null&&UNIT_AREA.length>0)
			where+="and UNIT_AREA='"+UNIT_AREA+"' ";
		if(fee_chan!=null&&fee_chan.length>0)
			where+=" and COMMERCIAL_ID in(select t.commercial_id from APPPAY_105 t where t.fee_chan="+fee_chan+" group by t.commercial_id) ";
		
		switch(parseInt(commercial_status)){
			case -1:break;
			case 1:
				where+=compositeSqlQuery("!=2");
				break;
			case 2:
				where+=compositeSqlQuery("=2");
				break;
			case 3:
				where+=compositeSqlQuery("=1");
				break;
		}	
	    $('#merDayGain_Templet').nextAll().remove();
		cur_page = cur_page || 0;
		var row = $('#merDayGain_Templet').clone(true);
		$("#cur_page").val(cur_page+1);
		var page_size = $("#page_size").val();
		$.ajax({
			url:'../action/CommercialDataQuery.jsp',
			dataType:'json',
			type:'POST',
			data:{'where':where,'cur_page':cur_page+1,'page_size':page_size},
			success: function(json){
				var object = json.resultset;
		        $('#merDayGain_Templet').nextAll().remove();
		        if (json.total==0){
		        	$('#cust_Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
		        }
		        var i=0;
		        for(i=(json.rows-1);i>=0;i--){
		        	var row = $('#merDayGain_Templet').clone(true);
		        	for(var pro in object[i]) {
		        		if(pro=="COMMERCIAL_ID")
			        	{
		        			row.find('#DELETE_ITEM').html("<a href='javascript:void(0)' onclick='testDelete(this,"+object[i][pro]+")'>删除</a>");
		        			row.find('#MORE').html("<a href='javascript:void(0)' onclick=showWindow("+object[i][pro]+")>详细</a>");
			        	}
		        		 else if(pro=='UNIT_AREA'){
		        			 row.find('#UNIT_AREA').html(getAreaNameByCode(object[i]["UNIT_AREA"]));
		        		}else
		        		{
			        		if(row.find('#'+pro+'')&&object[i][pro])
			        			row.find('#'+pro+'').html(object[i][pro]);
		        		}
		        	}
		        	//
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
		    			'当前显示 ' + ((cur_page * 20) + 1) + '-'
		    					+ ((cur_page * 20) + json.rows) + ' 条记录,共 '
		    					+ json.total + ' 条记录');
		    	$("#showMsg").html("查询完毕！");
				$("#queryBtn").removeAttr("disabled");
	    	},  
		    error: function(XmlHttpRequest, textStatus, errorThrown){  
		    	$("#showMsg").html("查询异常！");
		    	$("#queryBtn").removeAttr("disabled");
		    }
		 }); 
	}
	function getArea(number){
	}
	function showWindow(id){
		window.open ('../insert/commercialInsert.jsp?show=1&CommercialId='+id, 'newwindow', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=yes'); //这句要写成一行 

	}
</script>
<script language="javascript" type="text/javascript" src="../../js/WdatePicker.js"></script>  
</head>

<body >
		<!-- 终端列表信息 -->
	<div class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c"><span id="titleName">商户信息记录</span> </div>
			<div class="left02top_c" style="float: right">
			</div>
		</div>
	</div>
	<div class="left02downDiv">
			<form  method="post" target="iframe1" action="#" onSubmit="return Validator.Validate(this,2)">
				<td align='right'>客户状态：</td>
				<td>
					<select name="commercial_status" id="commercial_status">
						<option value="-1">---请选择---</option>
						<option value="1">审批中</option>
						<option value="2">审批通过</option>
						<option value="3">审批未通过</option>
					</select>
				</td>
				<td align='right'>录入时间：</td>
				<td>
				<input style="width: 100px" type="text" name="INPUT_DATE" id="INPUT_DATE" readonly="readonly" dataType='Require' msg='请输入统计起始日期'  onClick="WdatePicker()"/>
				</td>
				<td align='right'>商户编号:</td>
				<td>
					<input type="text" name='TERM_ID1' id="TERM_ID1" style='width: 120px'/>
				</td>
				<td align='right'>商户名称:</td>
				<td>
					<input type="text" name='UNIT_NAME' id="UNIT_NAME" style='width: 120px'/>
				</td>	
				<td align='right'>地区</td>
				<td>
					<select style="width:100px" name="UNIT_AREA"  id="UNIT_AREA">
						<option value="">---请选择----</option>
						<option value="4301">长沙市</option>
						<option value="4302">株洲市</option>
						<option value="4303">湘潭市</option>
						<option value="4304">衡阳市</option>
						<option value="4305">邵阳市</option>
						<option value="4306">岳阳市</option>
						<option value="4307">常德市</option>
						<option value="4308">张家界市</option>
						<option value="4309">益阳市</option>
						<option value="4310">郴州市</option>
						<option value="4311">永州市</option>
						<option value="4301">长沙市</option>
						<option value="4312">怀化市</option>
						<option value="4325">娄底市</option>
						<option value="4326">湘西自治州</option>
					</select>
				</td>
				 <td align='right'>交易渠道:</td>
				<td>
					<select name='fee_chan' id="fee_chan" style='width: 120px'  label='请输入交易渠道' />
						<option value="" selected="selected">---请选择---</option>
						<option value="1" >自主直联</option>
						<option value="2">自主间联</option>
						<option value="3">百日竞赛(自主间联)</option>
						<option value="4">电子渠道</option>
						<option value="5">策略营销(自主间联)</option>
						<option value="6">本地渠道</option>
					</select>
				</td>
				<td align='right'>	
				<input type="button" id="queryBtn" name="total" value="开始查询" onclick="find()"/>
				<font color=red id="showMsg"></font>
			</form>
		</div>
	
	<div class="left02downDiv">
	<form id="queryForm">
	<table id='cust_Table' class='dataTable1' width="100%">
		<tr>
			<th class='dataTableHeader'>客户单位名称</th>
			<th class='dataTableHeader'>客户所在地区</th>
			<th class='dataTableHeader'>客户单位联系人</th>
			<th class='dataTableHeader'>移动电话</th>
			<th class='dataTableHeader'>固定电话</th>
			<th class='dataTableHeader'>录入人员</th>
			<th class='dataTableHeader'>录入时间</th>
			<th class='dataTableHeader'>详细</th>
			<th class='dataTableHeader'>删除</th>
		</tr>
		<!-- 数据显示区 -->
		<tr id='merDayGain_Templet'>
			<td id="UNIT_NAME" style="width: 22%"></td>
			<td id="UNIT_AREA"></td>
			<td id="CONTACT_NAME_1"></td>
			<td id="CONTACT_TEL_1"></td>
			<td id="CONTACT_TEL_2"></td>
			<td id="input_name"></td>
			<td id="INPUT_DATE"></td>
			<td id="MORE"></td>
			<td id="DELETE_ITEM"></td>
		</tr>	
	</table>
		<div id='cust_Pagination' class='pagination'></div>
		<div id='cust_Searchresult'></div>
	</form>
	</div>
</body>
</html>		
