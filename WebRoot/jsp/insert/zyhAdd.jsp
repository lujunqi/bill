<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.model.KeyValueModel"%>
<%@page import="com.szzt.dao.DaoUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.dodou.table.*" %>
<%@ page import="com.dodou.dao.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%
	Operman_info man=(Operman_info)session.getAttribute("man");
%>
  <head>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<link href="../../css/style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="../../css/dataTable.css" media="screen" />
	<link rel="stylesheet" href="../../css/formly.min.css" media="screen" />
	<link rel="stylesheet" href="../../css/tabs.css" media="screen" />
	<link rel="stylesheet" href="../../css/pagination.css" media="screen" />
	<link rel="stylesheet" href="../../css/uploadify.css" />
	<link rel="stylesheet" href="../../css/thickbox.css" />
	<script src="../../js/jquery-1.7.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../js/thickbox-compressed.js"></script>
	<script type="text/javascript" src="../../js/jquery.dataTable.js"></script>
	<script type="text/javascript" src="../../js/jquery.uploadify.min.js"></script>
	<script src="../../js/formly.min.js"></script>
	<script src="../../js/jquery.form.js"></script> 
	<script src="../../js/jquery.pagination.js" type="text/javascript"></script>
	<script src="../../js/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
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
	var hasFile = false;
		$(document).ready(function()
{
	$("#quickadd_Div").formly();
	$("#add_merchantForm").formly({},function(e) {add_merchantSubmit();});
	$("#add_merchantForm").find("[name=comm_ad]").keyup(function() {
		var comm_ad = $("#add_merchantForm").find("[name=comm_ad]").val();
		$("#add_merchantForm").find("[name=unit_add]").val(comm_ad);
		$("#add_merchantForm").find("[name=installed_add]").val(comm_ad);
	});
	$("#add_merchantForm").find("[name=trade_name]").keyup(function() {
		var trade_name = $("#add_merchantForm").find("[name=trade_name]").val();
		if (trade_name.length < 20){
			$("#add_merchantForm").find("[name=merchant_name]").val(trade_name);
		}
		$("#add_merchantForm").find("[name=comm_name]").val(trade_name);
	});	
	$("#add_merchantForm").find("[name=contact_name_1]").keyup(function() {
		var contact_name_1 = $("#add_merchantForm").find("[name=contact_name_1]").val();
		$("#add_merchantForm").find("[name=installed_man]").val(contact_name_1);
	});		
	$("#add_merchantForm").find("[name=contact_tel_1]").keyup(function() {
		var contact_tel_1 = $("#add_merchantForm").find("[name=contact_tel_1]").val();
		$("#add_merchantForm").find("[name=equi_tel_no]").val(contact_tel_1);
	});	
	$("#add_merchantForm").find("[name=contact_tel_2]").keyup(function() {
		var contact_tel_2 = $("#add_merchantForm").find("[name=contact_tel_2]").val();
		$("#add_merchantForm").find("[name=installed_tel]").val(contact_tel_2);
	});		
	_init_area();
});
		
		
var host_seq_temp;
var hasNo = true;
function jude(){
	var host_no = $("form[id=add_merchantForm] [name=host_seq]").val();
	var teminal_product = $("form[id=add_merchantForm] [name=teminal_product]").val();
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
			'area': '<%=man.getOper_address()%>'
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
function add_merchantSubmit(){
	if ($("#add_merchantForm").find("[name=equi_type]").val() == '移动POS' && ($("#add_merchantForm").find("[name=comm_fee]").val() == '' || $("#add_merchantForm").find("[name=secu_depo]").val() == '')){
		alert('移动pos必须填写通讯费!');
		return ;
	}
	if(isNaN($("#add_merchantForm").find("[name=secu_depo]").val())){
		alert("押金只能填写数字");
		return ;
	}
	var secu_depo = $("#add_merchantForm").find("[name=secu_depo]").val();
	var equi_type = $("#add_merchantForm").find("[name=equi_type]").val();
	var comm_fee = $("#add_merchantForm").find("[name=comm_fee]").val();
	var appr_status = 2;
	var teminal_status = 2;
	/*
	if (fee_chan == 3){
		if (equi_type == '移动POS' && secu_depo >= 1000 && comm_fee >= 20){
			appr_status = 2;
			teminal_status = 2;
		}
		if (equi_type != '移动POS' && secu_depo >= 500){
			appr_status = 2;
			teminal_status = 2;
		}
	}
	*/
	if ($("#add_merchantForm").find("[name=service_man]").val() == ''){
		alert('请选择拓展人');
		return ;
	}
	if ($("#add_merchantForm").find("[name=account_bank]").val() == ''){
		alert('请选择开户行');
		return ;
	}
	if ($("#add_merchantForm").find("[name=chan_type]").val() == ''){
		alert('请选择渠道类型');
		return ;
	}
	if ($("#add_merchantForm").find("[name=unit_area]").val() == ''){
		alert('请选择客户地区');
		return ;
	}	
	if(jude()) {
		var queryString = $('#add_merchantForm').formSerialize();
		queryString = queryString+"&sales_man=${sessionScope.man.operman_name}";
		queryString += "&appr_status="+appr_status+"&teminal_status="+teminal_status;
		$('#add_merchantForm').find('[name=submit]').hide();
		$.ajax({
			url:'../action/quickInsertzyh.jsp',
			data:queryString,
			type:'POST',
			dataType:'text',
			success:function(data){
				$('#add_merchantForm').resetForm();
				$('#add_merchantForm').find('[name=submit]').show();
				alert('保存成功!');
			},
			error:function(data){
				alert('保存失败!'+data);
				$('#add_merchantForm').find('[name=submit]').show();
			}
		}); 
		}
	}
	</script>
  </head>
  <body>
  		
  		<div id="quickadd_Div" class="left02">
  		<form id="add_merchantForm" name="quickform" action="jsp/quickInsert.jsp"  method="post">
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
				<input type='hidden' name='sales_man' value="${sessionScope.man.operman_name}"/>
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
						Ws_areaDao ws_areaDao = new Ws_areaDao();
						Ws_area[] ws_areas = ws_areaDao.select();
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
				 require="true" label='请输入客户移动电话' /></td>

			<td align='right'>单位法人:</td>
			<td><input type='text' name='contact_name_2'
				 require="true" style='width: 120px' label='请输入单位法人' /></td>
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
				 require="true"  label='请选择商户名' maxlength="20" /> </td>
		</tr>
		<tr>				
			<td align='right' width="12%">账户银行:</td>
			<td width="13%"><select name='account_bank' style='width: 120px' label='请选择账户银行' >
					<option value="">请选择</option>
					<%
						DaoUtils utils=new DaoUtils();
						for(KeyValueModel model:utils.bankInfo()){
							out.println("<option value='"+model.getValue()+"' >"+model.getValue()+"</option>");
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
					require="true" label='请输入渠道名称' /></td>			
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
					<option value="专业化服务（间联）" selected="selected">专业化服务（间联）</option>
					<option value="专业化服务（直连）">专业化服务（直连）</option>
				</select>
			</td>	
			<td align='right'>开通业务:</td>
			<td>
				<select name='merchant_busi' style='width: 120px'  label='请输入开通业务' />
					<option value="普通收单" selected="selected">普通收单</option>
				</select>
			</td>					
			
			<td align='right'>拓展人员:</td>
			<td width="13%"><input type='text' name='service_man' style='width: 120px'
				require="true" label='请输入拓展人员' /></td>			
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
				require="true" label='请输入机具安装人' /></td>				
			<td align='right'>机具安装人:</td>
				<td><input type='text' name='inst_man' style='width: 120px'
				 require="true" label='请输入机具安装人' /></td>							
			<td align='right'>机具维护人:</td>
				<td><input type='text' name='safe_man' style='width: 120px'
				require="true" label='请输入机具维护人' /></td>
			<td align='right'>装机终止日期:</td>
			<td><input type='text' name='install_comp_date' style='width: 120px'
				require="true" label='请输入装机终止日期' onClick="WdatePicker()" /></td>				
		</tr>
		<tr id='tiaoshiDiv'>
			<td align='right'>主机序列号:</td>
			<td><input type='text' name='host_seq' style='width: 120px'
				require="true" label='请输入主机序列号' /></td>
			<td align='right'>键盘序列号:</td>
			<td><input type='text' name='key_seq' style='width: 120px'
				require="true" label='请输入键盘序列号' /></td>
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
				style='width: 120px'  require="true"  label='请输入押金数量' /></td>				 
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
			<div class="left02downDiv" align="center"><input name="submit" type="button" value="保存" /><input type="reset" value="重置" /></div>
		</div>
		</form>
	</div>
	
  </body>
</html>
