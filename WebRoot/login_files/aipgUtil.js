/**
 * 根据客户号获取客户名称
 */
aipgUtil.getcusname = function(cusid){
	if(cusid==null || cusid=='')
	{
		return '';
	}
	var cusText =  $.ajax({
		  type: "post",
		  async:false,
		  cache:false,
		  data:{cusid:cusid},
		  url: _getRootPath()+"/unauth/getcusname.dsr",
		  dataType: "json"
	}).responseText;
	if(cusText!=null && cusText!='')
	{
		cusText = eval('('+cusText +')');
	}
	return cusText.cusname;
};

/**
 * 根据银行代码获取银行名称
 */
aipgUtil.getbankname = function(bankcode){
	var bankText= $.ajax({
			async: false, 
			url: _getRootPath()+"/unauth/getbankname.dsr",
			data:{bankcode:bankcode}
		}).responseText;
	bankText = eval('('+bankText +')');
	return bankText.bankname;
};

/**
 * 根据产品主交易类型获取交易名称
 */
aipgUtil.getmtrxcode = function(pidmtrxcodes){
	var pmtrxcodeText= $.ajax({
			async: false, 
			url: _getRootPath()+"/unauth/getmtrxcode.dsr",
			data:{pidmtrxcodes:pidmtrxcodes}
		}).responseText;
	pmtrxcodeText = eval('('+pmtrxcodeText +')');
	return pmtrxcodeText.pmtrxcodes;
};

/**
 * 根据文件交易状态获取状态名称
 */
aipgUtil.getfilestate = function(filestate){
	var filestateText= $.ajax({
			async: false, 
			url: _getRootPath()+"/unauth/getstatename.dsr",
			data:{filestate:filestate}
		}).responseText;
	filestateText = eval('('+filestateText +')');
	return filestateText.statename;
};

/**
 * 根据支付行号获取支付行名称
 */
aipgUtil.getnetbankname = function(netbankcode){
	var bankText= $.ajax({
			async: false, 
			url: _getRootPath()+"/unauth/getnetbankname.dsr",
			data:{netbankcode:netbankcode}
		}).responseText;
	bankText = eval('('+bankText +')');
	return bankText.bankname;
};

/**
 * 导出Excel报表，传入表格的id，可以数组的形式或者单个id形式
 */
aipgUtil.exportExcel = function(tableids){
	var contents = "";
	if(typeof tableids=='object'&&typeof tableids.sort=='function'&&typeof tableids.length=='number'){
		for(var i=0;i<tableids.length;i++){
			var curTbl = $("#"+tableids[i]); 
			var curTbl_clone = curTbl.clone();
			var _obj = $("<div/>");
			_obj.append(curTbl_clone);
			contents += _obj.html();
		}
	}else{
		var curTbl = $("#"+tableids); 
		var _obj = $("<div/>");
		var curTbl_clone = curTbl.clone();
		_obj.append(curTbl_clone);
		contents = _obj.html(); 
	}
	if(contents==""){
		return;
	}
	var iframe = $("<iframe/>");
	iframe.css("display","none").attr("name","Excel_Exports_Frame");
	iframe.appendTo($("body"));
	var form = $("<form method='post'/>");
//	if($.browser.msie){
//		form.attr('target','Excel_Exports_Frame');
//	}else{
		form.attr('target','_bank');
//	}
	form.css("display","none").attr("action",_getRootPath()+"/extunauth/exportExcel.dsr");
	$("<input type='hidden'/>").attr("name","contents").val(contents).appendTo(form);
	form.appendTo($("body"));
	form.submit();
	iframe.remove();
	form.remove();
	
};

aipgUtil.obj2str = function(o){
    var r = [];
    if(typeof o =="string") return "\""+o.replace(/([\'\"\\])/g,"\\$1").replace(/(\n)/g,"\\n").replace(/(\r)/g,"\\r").replace(/(\t)/g,"\\t")+"\"";
    if(typeof o =="undefined") return "undefined";
    if(typeof o == "object"){
        if(o===null) return "null";
        else if(!o.sort){
            for(var i in o)
                r.push(i+":"+aipgUtil.obj2str(o[i]));
            r="{"+r.join()+"}";
        }else{
            for(var i =0;i<o.length;i++)
                r.push(aipgUtil.obj2str(o[i]));
            r="["+r.join()+"]";
        }
        return r;
    }
    return o.toString();
};

/**
 * 判断时间间隔 时间格式yyyy-MM-dd或yyyyMMdd
 */
aipgUtil.timeSplitLimit = function(DateOne,DateTwo,date){
	if(!DateOne){
		return false;
	}
	if(!DateTwo){
		DateTwo = JSUtil.getSysDate();
	}
	DateOne = DateOne.replace(new RegExp("-","gm"),"");
	DateTwo = DateTwo.replace(new RegExp("-","gm"),"");
	if(DateTwo.length!=8||DateOne.length!=8){
		return false;
	}
	var OneMonth = DateOne.substring(4,6); 
    var OneDay = DateOne.substring(6); 
    var OneYear = DateOne.substring(0,4); 

    var TwoMonth = DateTwo.substring(4,6); 
    var TwoDay = DateTwo.substring(6); 
    var TwoYear = DateTwo.substring(0,4); 

    var cha=((Date.parse(TwoMonth+'/'+TwoDay+'/'+TwoYear) - Date.parse(OneMonth+'/'+OneDay+'/'+OneYear))/86400000);
	if(cha>date){
		return false;
	}else{
		return true;
	}
};

aipgUtil.popupDiv = function(msg,img){ 
	var tipdiv = $("<div class='tlt_pop_div'/>").css("position","fixed").css("width","200px").css("height","40px")
								.css("top","40%").css("left","40%").css("border","2px solid #D8D8D8")
								.css("backgroundColor","#3b7daf").css("fontWeight","bolder")
								.css("paddingTop","25px").css("textAlign","center")
								.css("font-size","14px");
	if(img!=false){
		tipdiv.append($("<img/>").css("verticalAlign","middle").attr("src",_getRootPath()+"/images/loading.gif"));
	}
	tipdiv.append(msg?msg:"正在加载，请耐心等候...");		
	tipdiv.appendTo("body");
};
aipgUtil.hideDiv = function(){ 
	if($(".tlt_pop_div")[0]){
		$(".tlt_pop_div").each(function(i){$(this).fadeOut("normal",function(){$(this).remove();});});
	}
}; 

aipgUtil.setCookie = function(name,value,days){
    var Days = days==null?30:days; //此 cookie 将被保存 30 天
    var exp  = new Date();    //new Date("December 31, 9998");
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
};
aipgUtil.getCookie = function(name){
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;
};

/**
 * 调用动态令牌口令输入窗口
 */
aipgUtil.callOTPdialog = function(param){
	var contentHtml ='请输入动态口令：<input style="width:80px;" id="otp_code" onkeyup="JSUtil.limitNum(this)"/>';
	$.prompt(contentHtml,{top:"30%",submit:function(){param.callback($("#otp_code").val());}});
};

aipgUtil.dataExportTip = function(itemCount){
	var count = 0;
	try{
		count = parseInt(itemCount);
	}catch(e){
	}
	if(count>20000){
		if(!confirm('数据量超过2万条，为保证系统稳定性，只导出前2万条记录，是否确定导出?')){
			return false;
		}else{
			return true;
		}
	}else{
		return true;
	}
};

function _getRootPath(){
	var strFullPath=window.document.location.href;
/*
	var strPath=window.document.location.pathname;
	var pos=strFullPath.indexOf(strPath);
	var prePath=strFullPath.substring(0,pos);
	var postPath=strPath.substring(0,strPath.substr(1).indexOf('/')+1);
	return prePath+postPath;
*/
	return strFullPath.substring(0,strFullPath.indexOf('/'));
}

aipgUtil.tablecolsum = function(sumcls,spanid,changedom,hjflag,hjcls,hjdomid){
	var sum=0;
	$('.'+sumcls).each(function(){
		var tempval=$(this).val();
		if(tempval!=null && tempval!='')
		{
			sum=sum+parseInt(tempval);
		}
	});
	if(changedom!=null && changedom!='')
	{
		$('#'+changedom).val(sum);
	}
	
	if(hjflag!=null && hjflag=='true')
	{
		var totalsum=0;
		$('.'+hjcls).each(function(){
			var tempval=$(this).val();
			if(tempval!=null && tempval!='')
			{
				totalsum=totalsum+parseInt(tempval);
			}
		});
		$("#"+hjdomid).text(totalsum); 
	}

	//alert(sum);
	$("#"+spanid).text(sum); 
};

aipgUtil.tablecolsumForSpan = function(hjcls,hjdomid){
	var totalsum=0;
	$('.'+hjcls).each(function(){
		var tempval=$(this).val();
		if(tempval!=null && tempval!='')
		{
			totalsum=totalsum+parseInt(tempval);
		}
	});
	$("#"+hjdomid).text(totalsum); 
};


aipgUtil.tablecolDoubleSum = function(sumcls,spanid,changedom,hjflag,hjcls,hjdomid){
	var sum=0;
	
	$('.'+sumcls).each(function(){
		var tempval=$(this).val();
		if(tempval!=null && tempval!='')
		{
			sum=(parseFloat(sum)+parseFloat(tempval)).toFixed(2);
		}
	});
	if(changedom!=null && changedom!='')
	{
		$('#'+changedom).val(sum);
	}
	
	if(hjflag!=null && hjflag=='true')
	{
		var totalsum=0;
		$('.'+hjcls).each(function(){
			var tempval=$(this).val();
			if(tempval!=null && tempval!='')
			{
				totalsum=(parseFloat(totalsum)+parseFloat(tempval)).toFixed(2);
			}
		});
		$("#"+hjdomid).text(totalsum); 
	}
	
	$("#"+spanid).text(sum); 
};

aipgUtil.tablecolDoubleSumForSpan = function(hjcls,hjdomid){
	
	var totalsum=0;
	$('.'+hjcls).each(function(){
		var tempval=$(this).val();
		if(tempval!=null && tempval!='')
		{
			totalsum=(parseFloat(totalsum)+parseFloat(tempval)).toFixed(2);
		}
	});
	$("#"+hjdomid).text(totalsum); 
};


aipgUtil.moneyRes = function(sumcls,obj,initsum,insum,outsum,endsum){
	
	var spanid = sumcls+"hj";
	var changedom = "h"+sumcls;
	aipgUtil.tablecolDoubleSum(sumcls,spanid,changedom);
	
	var $tr = $(obj).parents(".datarow");
		
	var initSum = $tr.find('input:text[name="'+initsum+'"]').val();
	var inSum = $tr.find('input:text[name="'+insum+'"]').val();
	var outSum = $tr.find('input:text[name="'+outsum+'"]').val();
	
	var endSum = (parseFloat(initSum)+parseFloat(inSum)-parseFloat(outSum)).toFixed(2);
	
	$tr.find('input:hidden[name="'+endsum+'"]').val(endSum);
	$tr.find('span:[name="'+endsum+'sp"]').text(endSum);
	
	spanid = endsum+"hj";
	changedom = "h"+endsum;
	aipgUtil.tablecolDoubleSum(endsum,spanid,changedom);
	
};

aipgUtil.moneyRowsRes = function(tabid,initsum,insum,outsum,endsum){

	$("#"+tabid+" .datarow").each(function(){
		
		var initSum = $(this).find('input:text[name="'+initsum+'"]').val();
		var inSum = $(this).find('input:text[name="'+insum+'"]').val();
		var outSum = $(this).find('input:text[name="'+outsum+'"]').val();
		
		var endSum = (parseFloat(initSum)+parseFloat(inSum)-parseFloat(outSum)).toFixed(2);
		
		$(this).find('input:hidden[name="'+endsum+'"]').val(endSum);
		$(this).find('span:[name="'+endsum+'sp"]').text(endSum);
	});
};

aipgUtil.posvintreg=function(val,canempty)
{
	if(canempty==true && (val==null || val==''))
	{
		  return true;
	}
	
	var reg=/^[1-9]\d*|0$/;
	return reg.test(val);
}

aipgUtil.moneyreg=function(val,canempty)
{
	if(canempty==true && (val==null || val==''))
	{
		  return true;
	}
	
	//var reg=/^[1-9]d*.d*|0.d*[1-9]d*|0?.0+|0$/;
	var reg=/^(-)?(([1-9]\d{0,9})|0)(\.\d{1,2})?$/;
	return reg.test(val);
}

function aipgUtil(){}