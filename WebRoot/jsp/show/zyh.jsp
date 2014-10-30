<%@page import="com.szzt.model.KeyValueModel"%>
<%@page import="com.szzt.dao.DaoUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="../../import.jsp"%>
<%
Operman_info man=(Operman_info)session.getAttribute("man");
int operman_id =man.getOperman_id();
if(operman_id == 10111 || operman_id == 10109||operman_id== 10452){
	response.sendRedirect("zyhAdd.jsp");
	return;
}
%>
<html>
<head>
<link href="../../css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../../css/dataTable.css" media="screen" />
<link rel="stylesheet" href="../../css/formly.min.css" media="screen" />
<link rel="stylesheet" href="../../css/tabs.css" media="screen" />
<link rel="stylesheet" href="../../css/pagination.css" media="screen" />
<link rel="stylesheet" href="../../css/allinpay.css" media="screen" />

<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
<script src="../../js/formly.min.js"></script>
<script src="../../js/jquery.form.js"></script> 
<script src="../../js/jquery.pagination.js" type="text/javascript"></script>
<script src="../../js/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript">

function GetDateString(){
    var oDate = new Date();
    var month = oDate.getMonth() + 1;
    if (month <= 9)
      month = "0" + month;
    var day = oDate.getDate();
    if (day <= 9)
      day = "0" + day;
    var sDate = oDate.getYear() + "-" + month + "-" + day;
    return sDate;
}
var operman={
		operman_id:<%
						if(man.getOperman_id()>0){
							out.println(man.getOperman_id()+"");
						}else{
							out.print("10000");
						}%>,
		post_id:<%
						if(session.getAttribute("POST_ID") != null){
							out.println((Integer)session.getAttribute("POST_ID"));
						}else{
							out.print("2");
						}%>,
		oper_address:<%
						if(session.getAttribute("OPER_ADDRESS") != null){
							out.print("'"+(String)session.getAttribute("OPER_ADDRESS")+"'");
						}else{
							out.print("'4301'");
						}%>
};
function Dsy(){
	this.Items = {};
}
Dsy.prototype.add = function(id,iArray){
	this.Items[id] = iArray;
}
Dsy.prototype.Exists = function(id){
	if(typeof(this.Items[id]) == "undefined") return false;
	return true;
}

function change(v){
	var str="0_0";
	for(i=0;i<v;i++){
		str+=("_"+(document.getElementById(s[i]).selectedIndex-1));
	};
	var ss=document.getElementById(s[v]);
	with(ss){
		length = 0;
		options[0]=new Option(opt0[v],opt0[v]);
		if(v && document.getElementById(s[v-1]).selectedIndex>0 || !v){
			if(dsy.Exists(str)){
				ar = dsy.Items[str];
				for(i=0;i<ar.length;i++){
					options[length]=new Option(ar[i],ar[i]);
				}//end for
				if(v){ options[0].selected = true; }
			}
		}//end if v
		if(++v<s.length){change(v);}
	}//End with
}
var dsy = new Dsy();


dsy.add("0_0_0",["岳麓区","芙蓉区","天心区","开福区","雨花区","浏阳市","长沙县","星沙","望城县","宁乡县"]);
dsy.add("0_0_1",["永定区","武陵源区","慈利县","桑植县"]);
dsy.add("0_0_2",["武陵区","鼎城区","津市市","安乡县","汉寿县","澧县","临澧县","桃源县","石门县"]);
dsy.add("0_0_3",["赫山区","资阳区","沅江市","南县","桃江县","安化县"]);
dsy.add("0_0_4",["岳阳楼区","君山区","云溪区","汨罗市","临湘市","岳阳县","华容县","湘阴县","平江县"]);
dsy.add("0_0_5",["天元区","荷塘区","芦淞区","石峰区","醴陵市","株洲县","攸县","茶陵县","炎陵县"]);
dsy.add("0_0_6",["岳塘区","雨湖区","湘乡市","韶山市","湘潭县"]);
dsy.add("0_0_7",["雁峰区","珠晖区","石鼓区","蒸湘区","南岳区","常宁市","耒阳市","衡阳县","衡南县","衡山县","衡东县","祁东县"]);
dsy.add("0_0_8",["北湖区","苏仙区","资兴市","桂阳县","永兴县","宜章县","嘉禾县","临武县","汝城县","桂东县","安仁县"]);
dsy.add("0_0_9",["冷水滩区","零陵区","东安县","道县","宁远县","江永县","蓝山县","新田县","双牌县","祁阳县","江华瑶族自治县"]);
dsy.add("0_0_10",["双清区","大祥区","北塔区","武冈市","邵东县","邵阳县","新邵县","隆回县","洞口县","绥宁县","新宁县","城步苗族自治县"]);
dsy.add("0_0_11",["鹤城区","洪江市","沅陵县","辰溪县","溆浦县","中方县","会同县","麻阳苗族自治县","新晃侗族自治县","芷江侗族自治县","靖州苗族侗族自治县","通道侗族自治县"]);
dsy.add("0_0_12",["娄星区","冷水江市","涟源市","双峰县","新化县"]);
dsy.add("0_0_13",["吉首市","泸溪县","凤凰县","花垣县","保靖县","古丈县","永顺县","龙山县"]);
dsy.add("0_0",["长沙市","张家界市","常德市","益阳市","岳阳市","株洲市","湘潭市","衡阳市","郴州市","永州市","邵阳市","怀化市","娄底市","湘西自治州"]);

dsy.add("0",["湖南省"]);

var s=["s_city","s_county"];//三个select的name
var opt0 = ["地级市","市、县级市"];//初始值
function _init_area(){  //初始化函数
	for(i=0;i<s.length-1;i++){
	  document.getElementById(s[i]).onchange=new Function("change("+(i+1)+")");
	}
	change(0);
}
</script>		
<script type="text/javascript">
<!--
$(document).ready(function()
{
	$("#findForm").formly();
	$("#detail_custForm").formly({},function(e) {detailSubmit();});
	$("#addForm").formly();
	$('#addDiv').hide();
	$("#findForm").find('[name=unit_area]').val(operman.oper_address);
	if(operman.post_id != 10){
		$("#findForm").find('[name=unit_area]').attr("disabled","disabled");
	}
	_init_area();
});
var json;
var cur_page;
function find(cur_page){
	cur_page = cur_page || 0;
	$("#cur_page").val(cur_page+1);
	queryString ="";
	var merchantsno = $("#findForm").find('[name=merchantsno]').val();
	var trade_name = $("#findForm").find('[name=trade_name]').val();
	var unit_area = $("#findForm").find('[name=unit_area]').val();
	var input_date = $("#findForm").find('[name=input_date]').val();
	if (merchantsno != ''){
		queryString += " and merchantsno ='"+merchantsno+"'";
	}
	if (trade_name != ''){
		queryString += " and trade_name like '%"+trade_name+"%'";
	}
	if (unit_area != ''){
		queryString += " and unit_area ='"+unit_area+"'";
	}
	if (input_date != ''){
		queryString += " and to_char(input_date,'yyyy-mm-dd')='"+input_date+"'";
	}	
	$.ajax({
		type : 'POST',
		global : false,
		url : '../action/ExecuteQuery.jsp',
		data : {'where':queryString,'page_size':8,'cur_page':cur_page+1,all:1},
		dataType : 'json',
		cache : false,
		async : false,
		success: function(data){
	        this.json = data;
	        $('#Templet').nextAll().remove();
	        if (this.json.total==0){
	        	$('#Table').append('<tr><td align=center colspan=10>对不起,没有找到符合条件的记录!</td></tr>');
	        }
	        var i=0;
	        
	        for(i=(this.json.rows-1);i>=0;i--){
	        	var row = $('#Templet').clone(true);
	        	row.attr('id', this.json.resultset[i].teminal_info_serv_id);
		        row.find('#check').html('<input type=checkbox id='+this.json.resultset[i].teminal_info_serv_id+' />');
	        	for(var pro in this.json.resultset[0]) {
	        		row.find('#'+pro+'').text(this.json.resultset[i][pro]);
	        	}
		        row.find('#opera').html("<input type=button onclick=detail('"+this.json.resultset[i].teminal_info_serv_id+"') value=详细 /> <input type=button onclick=modify_merchant('"+this.json.resultset[i].teminal_info_serv_id+"') value=修改 /><input type=button onclick=cheji('"+this.json.resultset[i].teminal_info_serv_id+"') value=撤机 /><button type='button' onclick=showAttach("+this.json.resultset[i].teminal_info_serv_id+")>附件</button>");	        	
		        row.show();
		        row.insertAfter('#Templet');
	        };
	        $('#Table').mygrid();
	        $("#MyForm").resetForm(); 
	    	$('#Pagination').pagination(this.json.total, {
	    		current_page : cur_page,
	    		prev_text : '前一页',
	    		next_text : '后一页',
	    		callback : find
	    	});
	    	$('#Searchresult').text(
	    			'当前显示 ' + ((cur_page * 8) + 1) + '-'
	    					+ ((cur_page * 8) + this.json.rows) + ' 条记录,共 '
	    					+ this.json.total + ' 条记录');
    	},  
	    error: function(XmlHttpRequest, textStatus, errorThrown){  
	        alert( XmlHttpRequest);  
	    }
    }); 
	$('#findForm').resetForm();
}
function showAttach(id){
	window.open ('../insert/attachPhoto.jsp?type=107&id='+id, 'showAttach107', 'height=600, width=1000, top=40, left=100,menubar=no, scrollbars=yes, resizable=yes,location=n o, status=no'); //这句要写成一行
}
function modify_merchant(id){
	detail(id);
	$("form[id=detail_custForm] input").removeAttr("disabled");
	$("form[id=detail_custForm] select").removeAttr("disabled");
}
function detail(id){
	$.ajax({
		type : 'POST',
		global : false,
		url : '../action/ExecuteQuery.jsp',
		data : {TEMINAL_INFO_SERV_ID:id},
		dataType : 'json',
		cache : false,
		async : false,
		success : function(json) {
			var object = json.resultset;
        	for(var pro in object[0]) {
           		if(pro == 's_city'){
	       			change(0);
	       			$("#detail_custForm").find('[name='+pro+']').val(object[0][pro]);
	       			$("#detail_custForm").find('[name='+pro+']').change();
	       			continue;
	       		}       		 
           		if(pro == 'install_date'){
           			var myDate = new Date(object[0].install_comp_date);
           			var d = myDate.getFullYear() + "-"+ (myDate.getMonth() + 1) + "-"+ myDate.getDate();
           			$("#detail_custForm").find('[name=install_comp_date]').val(d);
           			continue;
           		}
           		if(pro == 'recipet_date'){
           			var myDate = new Date(object[0].recipet_date);
           			var d = myDate.getFullYear() + "-"+ (myDate.getMonth() + 1) + "-"+ myDate.getDate();
           			$("#detail_custForm").find('[name=recipet_date]').val(d);
           			continue;
           		}           		
        		$("#detail_custForm").find('[name='+pro+']').val(object[0][pro]);
        		host_seq_temp = object[0].host_seq;
        	}
	       	$("#detail_custForm").find('[name=s_county]').val(object[0].s_county);
	    	$("form[id=detail_custForm] input").attr("disabled","disabled");
	    	$("form[id=detail_custForm] select").attr("disabled","disabled");
		},
		error : function(json) {
			alert('操作失败!\nSQL: ' + id + '\n' + json.responseText);
		}
	});
}

var host_seq_temp;
var hasNo = true;
function jude(){
	var host_no = $("form[id=detail_custForm] [name=host_seq]").val();
	var teminal_product = $("form[id=detail_custForm] [name=teminal_product]").val();
	if (teminal_product != '通联'){
		return true;
	}
	if (host_no == '' && teminal_product == '通联'){
		alert('请填写主机、键盘序列号!');
		return false;
	}
	if(host_seq_temp == host_no){
		return true;
	}
	$.ajax({
		type : 'POST',
		global : false,
		async : false,
		dataType : 'text',
		url : '../action/judeHostNo.jsp',
		data : {
			'host_no' : host_no,
			'area': '<%=man.getOper_address() %>'
		},
		success : function(json) {
			var result = $.trim(json);
			if(result == 'OK'){
				hasNo = true;
				return hasNo;
			}else if(result == 1){
				alert('此主机序列号不在仓库中!请重新输入!!!!');
				hasNo = false;
				return hasNo;
			}else{
				alert('此主机序列号已经在商户['+ result +']处使用!请重新输入!!!!');
				hasNo = false;
				return hasNo;
			}
		},
		error : function(json) {
			alert(json.responseText);
			return false;
		}
	});
	return hasNo;
}
function detailSubmit(){
//	var queryString = $('#detailForm').formSerialize();
//	alert(queryString);
	if(jude()) {
		$("#detail_custForm").ajaxSubmit({
			dataType:'json',
			success: function(data){
				alert('修改成功!');
				$('#detail_custForm').resetForm();
				find();
	    	},  
		    error: function(XmlHttpRequest, textStatus, errorThrown){  
		        alert( "error");  
		    }
	    });
	}
}
function cheji(id){
	if(!confirm("确定要撤机吗？")){
		return ;
	}
	$.ajax({
		type : 'POST',
		global : false,
		url : '../action/ZyhCancelTerminal.jsp',
		data : {'id':id},
		dataType : 'json',
		cache : false,
		async : false,
		success : function(json) {
			alert('撤机成功!');
			find();
		},
		error : function(json) {
			alert('操作失败!\n ' + json.responseText);
		}
	});
	
}
function del(id){
	if (confirm('你确定要删除这条记录?')) {
		$.ajax({
			type : 'POST',
			global : false,
			url : 'jsp/Channel_infoDelete.jsp',
			data : {
				'channel_id' : id
			},
			dataType : 'json',
			cache : false,
			async : false,
			success : function(json) {
				alert('删除成功!');
				find();
			},
			error : function(json) {
				alert('操作失败!\nSQL: ' + id + '\n' + json.responseText);
			}
		});
	}
}

function add(){
	$('#addForm').resetForm();
	$('#listDiv').hide();
	$('#detailDiv').hide();
	$('#addDiv').show();
}

function addSubmit(){
	$("#addForm").ajaxSubmit({
		dataType:'json',
		success: function(data){
			alert('保存成功!');
			$('#addForm').resetForm();
			find();
			$('#addDiv').hide();
			$('#listDiv').show();
			$('#detailDiv').show();
    	},  
	    error: function(XmlHttpRequest, textStatus, errorThrown){  
	        alert( "error");  
	    }
    });
}
//-->
</script>
</head>
<body>
<h1></h1>

	
   	<div class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c">记录查询</div>
		</div>
		<div class="left02downDiv">
			<form id="findForm"   method="post">
		<table border='0px' style='font-sizd: 1.2em' >
				<tr>
					<td align='right'>商户编号:</td>
					<td><input type='text' name='merchantsno' style='width: 120px'/></td>
					<td align='right'>商户对外营业名称:</td>
					<td><input type='text' name='trade_name' style='width: 120px'/></td>
						<td align='right'>客户所在地区:</td>
					<td><select name='unit_area' style='width: 120px'/>
					<option value="">请选择</option>
					<%
						Ws_areaDao ws_areaDao = new Ws_areaDao();
						Ws_area[] ws_areas = ws_areaDao.select();
						for(int i=0;i<ws_areaDao.totalCount;i++){
							out.println("<option value='"+ws_areas[i].getAreaid()+"'>"+ws_areas[i].getCity()+"</option>");
						}
					%>
					</select>
					</td>
					<td align='right'>录入时间:</td>
					<td><input type='text' name='input_date' style='width: 120px' onClick="WdatePicker()" />
					</td>
					</tr>
					</table>
			<input type="button" onclick="find()" value="提交" /><input type="reset" value="重置" />
			<input type="hidden" id="cur_page" name="cur_page" />
			</form>
		</div>
	</div>
	
	<div id="listDiv" class="left02">
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c">记录列表 </div>
		</div>
		<div class="left02downDiv">
		<table id='Table' class='dataTable'>
			<tr>
				<th class='dataTableHeader'></th>
				<th class='dataTableHeader'>
					编号
				</th>
				<th class='dataTableHeader'>
					名称
				</th>
				<th class='dataTableHeader'>
					单位性质
				</th>	
				<th class='dataTableHeader'>
					业务类型
				</th>	
				<th class='dataTableHeader'>
					录入人员
				</th>								
				<th class='dataTableHeader'>
					录入时间
				</th>									
				<th class='dataTableHeader' >
					操作
				</th>
			</tr>
			<tr id='Templet' >
				<td id='check' ></td>
				<td id='merchantsno' ></td>
				<td id='comm_name' ></td>
				<td id='unit_attr' ></td>
				<td id='chan_name' ></td>
				<td id='sales_man' ></td>		
				<td id='input_date' ></td>			
				<td id='opera' ></td>
			</tr>	
		</table>
			<div id='Pagination' class='pagination'></div>
			<br style='clear: both;' />
			<div id='Searchresult'></div>
		</div>
	</div>

		<div id="quickadd_Div" class="left02">
  		<form id="detail_custForm" name="detail_custForm" action="../action/Teminal_info_servUpdate.jsp"  method="post">
  		<input type='hidden' name='teminal_info_serv_id' id="teminal_info_serv_id" />
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c">客户信息</div>
		</div>
		<div class="left02downDiv">
				<table border='0px' style='font-sizd: 1.2em' > 
		<tr>
			<td align='right' width="12%">商户对外营业名称:</td>
			<td colspan="3"><input type='text' name='trade_name' style='width: 99%'
				require="true" label='请输入商户对外营业名称' />
				<input type='hidden' name='sales_man' value="${sessionScope.OPERMAN_ID}"/>
				</td>
				
			<td align='right' width="12%">客户单位性质:</td>
			<td width="13%">				
				<select name='unit_attr' style='width: 110px' require="true" label='请输入客户单位性质' >
				<option value="个体工商户" selected="selected">个体工商户</option>
				<option value="企业单位">企业单位</option>
				<option value="其他">其他</option>
				</select>
			</td>
			<td align='right' width="12%">客户所在地区:</td>
			<td width="13%"><select name='unit_area' style='width: 120px' require="true" label='请输入客户所在地区'/>
				<option value="" >请选择</option>
				<%
						for(int i=0;i<ws_areaDao.totalCount;i++){
							out.println("<option value='"+ws_areas[i].getAreaid()+"'  >"+ws_areas[i].getCity()+"</option>");
						}
					%>
					</select>
			</td>	
		</tr>

		<tr>
			<td align='right'>工商营业执照编码:</td>
			<td><input type='text' name='comm_no' style='width: 120px'
				require="true" label='请输入工商营业执照编码' /></td>

			<td align='right'>工商营业执照名称:</td>
			<td><input type='text' name='comm_name' style='width: 120px'
				require="true" label='请输入工商营业执照名称' /></td>

			<td align='right'>工商营业执照地址:</td>
			<td colspan="3"><input type='text' name='comm_ad' style='width: 99%'
				require="true" label='请输入工商营业执照地址' /></td>
		</tr>
		<tr>
			<td align='right'>联系人:</td>
			<td><input type='text' name='contact_name_1'
				style='width: 120px' require="true" label='请输入联系人' /></td>

			<td align='right'>固定电话:</td>
			<td><input type='text' name='contact_tel_1' style='width: 120px'
				require="true" label='请输入客户固定电话' /></td>


			<td align='right'>移动电话:</td>
			<td><input type='text' name='contact_tel_2' style='width: 120px'
				 label='请输入客户移动电话' /></td>

			<td align='right'>单位法人:</td>
			<td><input type='text' name='contact_name_2'
				style='width: 120px' label='请输入单位法人' /></td>
		</tr>
		
		<tr>
			<td align='right' >客户单位地址:</td>
			<td colspan="3"><input type='text' name='unit_add' style='width: 99%'
				require="true" label='请输入客户单位地址' /></td>
	
			<td align='right'>备注信息:</td>
			<td colspan="3"> <input type='text' name='remark_info' style='width: 99%'
				 label='请输入备注信息' /></td>
				
		</tr>
	</table>
		</div>

		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c">商户信息</div>
		</div>
		<div class="left02downDiv">
				<table border='0px' style='font-sizd: 1.2em' >
		<tr>
			<td align='right' width="12%">商户名:</td>
			<td colspan="3"><input type='text' name='merchant_name' style='width: 99%'
				 maxlength="20" />  <FONT SIZE="" COLOR="#FF0000">(商户名长度不能超过20个汉字)</FONT></td>
		</tr>
		<tr>				
			<td align='right' width="12%">账户银行:</td>
			<td width="13%"><select name='account_bank' style='width: 120px' label='请选择账户银行' >
					<option value="">请选择</option>
					<%
						DaoUtils utils=new DaoUtils();
						for(KeyValueModel model:utils.bankInfo()){
							out.println("<option value='"+model.getKey()+"' >"+model.getValue()+"</option>");
						}
					 %>
				</select>
			</td>
			<td align='right' width="12%">开户行支行:</td>
			<td  colspan="5"><input type='text' name='account_bank_brach' style='width: 99%'
				require="true" label='请输入开户行支行' /></td>
	</tr><tr>

			<td align='right' width="12%">账户户名:</td>
			<td width="13%"><input type='text' name='account_name' style='width: 120px'
				require="true" label='请输入账户户名' /></td>
			<td align='right' width="12%"> 账户帐号:</td>
			<td colspan="3" ><input type='text' name='account_no' style='width: 99%'
				require="true" label='请输入账户帐号' /></td>
	</tr>
			<tr>
			<td align='right' width="12%">渠道类型:</td>
				<td width="13%">
					<select name='chan_type' id="chan_type" style='width: 110px' require="true" label='请输入渠道类型' >
					<option value="" selected>请选择</option>
					<option value="自主拓展">自主拓展</option>
					<option value='农村信用社' >农村信用社</option>
					<option value='华融湘江银行' >华融湘江银行</option>
					<option value='长沙银行' >长沙银行</option>
					<option value='东莞银行' >东莞银行</option>
					<option value='渤海银行' >渤海银行</option>
					<option value='兴业' >兴业</option>
					<option value='招商银行' >招商银行</option>
					<option value='广发银行' >广发银行</option>
					<option value='民生银行' >民生银行</option>
					<option value='华夏银行' >华夏银行</option>
					<option value='光大' >光大</option>
					<option value='中信' >中信</option>
					<option value='交行' >交行</option>
					<option value='建行' >建行</option>
					<option value='农行' >农行</option>
					<option value='工行' >工行</option>
					<option value='邮储' >邮储</option>
					<option value='北京银行' >北京银行</option>
					<option value='沪农商' >沪农商</option>
					<option value='浦发银行' >浦发银行</option>
					<option value='东亚银行' >东亚银行</option>
					<option value="渠道">渠道</option>
					</select>
			</td>					
			<td align='right'>渠道名称:</td>
				<td colspan="3"><input type='text' name='chan_name'  id="chan_name" style='width: 99%'
					label='请输入渠道名称' /></td>			
	</tr>
	<tr>
			<td align='right'>签约扣率:</td>
			<td><input type='text' name='ratededuction' style='width: 120px'
				require="true" label='请输入签约扣率' /></td>
			<td align='right'>商户编号:</td>
			<td><input type='text' maxlength="15" name='merchantsno' style='width: 120px'
				require="true"  label='请输入商户编号' /><div id="has"></div></td>
			<td align='right'>MCC:</td>
			<td><input type='text' name='mcc' style='width: 120px'
				require="true"  label='请输入mcc' /></td>
			<td align='right'>MCC18域:</td>
			<td><input type='text' name='mcc18' style='width: 120px'
				require="true"  label='请输入mcc18' /></td>	
	</tr>
	<tr>			
			<td align='right'>业务类型:</td>
			<td>
				<select name='marchanttype' style='width: 120px'  label='请输入开通业务' />
					<option value="专业化服务（间联）" >专业化服务（间联）</option>
					<option value="专业化服务（直联）">专业化服务（直联）</option>
				</select>
			</td>
			<td align='right'>开通业务:</td>
			<td>
				<select name='merchant_busi' style='width: 120px'  label='请输入开通业务' />
					<option value="普通收单" selected="selected">普通收单</option>
				</select>
			</td>					
			
			<td align='right'>拓展人员:</td>
			<td><input type='text' name='service_man' style='width: 120px'
				require="true"  label='请输入拓展人员' /></td>	
			<td align='right' width="12%">商户所在地区:</td>
			<td >
				<select name='unit_area' style='width: 120px' require="true" label='请输入商户所在地区'/>
					<%
					for(int i=(ws_areaDao.totalCount-1);i>=0;i--){
						out.println("<option value='"+ws_areas[i].getAreaid()+"'>"+ws_areas[i].getCity()+"</option>");
					}
					%>
					</select>
			</td>		 				
		</tr>
	</table>
		</div>
		
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02top_c">添加终端</div>
		</div>
		<div class="left02downDiv">
				<table border='0px' style='font-sizd: 1.2em' >
		<tr>
			<td align='right' width="12%">客户装机联系人:</td>
			<td width="13%"><input type='text' name='installed_man' style='width: 120px'
				require="true" label='请输入客户装机联系人' /></td>

			<td align='right' width="12%">客户装机联系电话:</td>
			<td width="13%"><input type='text' name='installed_tel' style='width: 120px'
				require="true" label='请输入客户装机联系电话' /></td>

		</tr>
		<tr>
			<td align='right' width="12%">客户装机地址:</td>
			<td colspan="5">
			    <select id="s_city" name="s_city" ></select>&nbsp;&nbsp;
    			<select id="s_county" name="s_county" ></select>
    			<input type='text' name='installed_add' style='width: 320px'	require="true" label='请输入客户装机地址' />
    		</td>
		</tr>		
		<tr>
			<td align='right' width="12%">机具产权:</td>
			<td width="13%">
				<select name='teminal_product' style='width: 110px' require="true" label='请输入机具产权' >
					<option value="通联" selected>通联</option>
					<option value="邮储银行">邮储银行</option>
					<option value="工商银行">工商银行</option>
					<option value="建设银行">建设银行</option>
					<option value="上海分公司" >上海分公司</option>
					<option value="交通银行">交通银行</option>
					<option value="农业银行">农业银行</option>
					<option value="其他分公司">其他分公司</option>
				</select>
			</td>

			<td align='right' width="12%">机具类型:</td>
			<td width="13%">
				<select name='equi_type' style='width: 110px' require="true" label='请输入机具类型' >
				<option value="普通固定" selected>普通固定</option>
				<option value="移动POS">移动POS</option>
				<option value="分体机">分体机</option>
				<option value="网络POS">网络POS</option>
				</select>
			</td>

			<td align='right' width="12%">机具绑定电话号码:</td>
			<td width="13%"><input type='text' name='equi_tel_no'
				style='width: 120px' require="true" label='请输入机具绑定电话号码' /></td>
				<td align='right'>终端编号:</td>
			<td><input type='text' maxlength="8" name='teminalno'  require="true"  style='width: 120px'
				 label='请输入8位终端编号' /></td>
	 	</tr>
		<tr id='fenpeiDiv'>
			<td align='right'>机具调试人:</td>
				<td><input type='text' name='debug_man' style='width: 120px'
				 label='请输入机具安装人' /></td>				
			<td align='right'>机具安装人:</td>
				<td><input type='text' name='inst_man' style='width: 120px'
				 label='请输入机具安装人' /></td>							
			<td align='right'>机具维护人:</td>
				<td><input type='text' name='safe_man' style='width: 120px'
				 label='请输入机具维护人' /></td>
			<td align='right'>装机终止日期:</td>
			<td><input type='text' name='install_date' style='width: 120px'
				 label='请输入装机终止日期' onClick="WdatePicker()" /></td>				
		</tr>
		<tr id='tiaoshiDiv'>
			<td align='right'>主机序列号:</td>
			<td><input type='text' name='host_seq' style='width: 120px'
				 label='请输入主机序列号' /></td>
			<td align='right'>键盘序列号:</td>
			<td><input type='text' name='key_seq' style='width: 120px'
				 label='请输入键盘序列号' /></td>
		</tr>	 	
	<tr>	
		<td align='right'>通讯费:</td>
		<td><input type='text' name='comm_fee' style='width: 120px'
		 label='请输入通讯费'/></td>	 	
		 <td align='right'>通讯费收取周期:</td>
		<td><select name='comm_fee_time' style='width: 110px'  label='请输入通讯费收取周期' >
		<option value="0">请选择</option>
		<option value="1">日</option>
		<option value="2">周</option>
		<option value="3">月</option>
		<option value="4">季</option>
		<option value="5">年</option>
		</select></td>	  
		<td align='right'>服务费:</td>
		<td><input type='text' name='serv_fee' style='width: 120px'
		 label='请输入服务费' /></td>	 	
		<td align='right'>服务费收取周期:</td>
		<td><select name='serv_fee_time' style='width: 110px'  label='请输入服务费收取周期' >
		<option value="0">请选择</option>
		<option value="1">日</option>
		<option value="2">周</option>
		<option value="3">月</option>
		<option value="4">季</option>
		<option value="5">年</option>
		</select></td>	  		 
		
	</tr>		
	<tr id='guidangDiv4'>
			<td align='right'>押金数量:</td>
			<td><input type='text' name='secu_depo'
				style='width: 120px'  label='请输入押金数量' /></td>				 
			<td align='right'>押金记账联编码:</td>
			<td><input type='text' name='acco_no' style='width: 120px'
				 label='请输入押金记账联编码' /></td>	
			<td align='right'>押金收取时间:</td>
			<td><input type='text' name='recipet_date' style='width: 120px'
			 label='请输入收取时间' onClick="WdatePicker()" /></td>				 
	</tr>				
	 	<tr>
	<td align='right'>备注:</td>
	<td colspan="7">
	<TEXTAREA name='demo' style='width: 99%' ROWS="5" COLS="10"  label='请输入备注'></TEXTAREA>
	</td>
	<td align='right'></td>
	<td align='right'></td>
	<td align='right'></td>
	<td align='right'></td>
	<td align='right'></td>
	<td align='right'></td>
	</tr>

		</table>
		</div>
		<div class="left02topDiv">
			<div class="left02top_right"></div>
			<div class="left02top_left"></div>
			<div class="left02downDiv" align="center"><input name="submit" type="button" value="保存" />
			<input type="reset" value="重置" /></div>
		</div>
		</form>
	</div>
	
</body>
</html>

