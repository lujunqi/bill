/**
 * 生成翻页导航
 * @param pageCount 总共的页数
 * @param pageSize 一页的记录数
 * @param pageIndex 当前的页数
 * @param itemCount 记录总数
 * @param validateFunc 当前form表单提交前做的检验函数 规则：检验成功返回true，否则返回false
 * @return
 */
function PageCtrl(pageCount,pageSize,pageIndex,itemCount,validateFunc,maxPageNum){
	
	var pagestatus = [];
	pagestatus.push('<input type="hidden" name="pageCount" id="pageparam_pageCount" value="'+pageCount+'" />');
	pagestatus.push('<input type="hidden" name="pageSize" id="pageparam_pageSize" value="'+pageSize+'" style="text-align: center; width:40px;height:19px;background:#fff;border:1px solid;" maxlength="4" onchange="submitSearch(this);" onkeypress="onKeyPress(this);"/>');
	pagestatus.push('<input type="button" class="page_btn" value="首页" onclick="firstPage(this);"/> ');
	pagestatus.push('<input type="button" class="page_btn" value="&lt;&lt;" onclick="prevPage(this);"/> ');
	updatePageNumList(pageIndex,pageCount,pagestatus,maxPageNum);
	pagestatus.push('<input type="button" class="page_btn" value="&gt;&gt;" onclick="nextPage(this);"/> ');
	pagestatus.push('<input type="button" class="page_btn" value="末页" onclick="lastPage(this);"/> ');
	pagestatus.push("<div class='infospan'>共<span  id='pageparam_itemCount_span'> "+itemCount+"</span> &nbsp;条记录&nbsp;</div>");
	PageCtrl.validate = validateFunc;
	document.write(pagestatus.join(""));
	try{
		document.getElementById("pageparam_pageSize").value=pageSize;
	}catch(e){}

	$(".page_btn").each(function(){
		if($(this)[0].value==pageIndex){
			$(this).addClass("chooesd");
			this.onclick=null;
		}
	});
	
	return pagestatus;
}

function MiniPageCtrl(pageCount,pageSize,pageIndex,itemCount,validateFunc){
	
	var pagestatus = [];
	pagestatus.push('<input type="hidden" name="pageCount" id="pageparam_pageCount" value="'+pageCount+'" />');
	pagestatus.push('<input type="hidden" name="pageSize" id="pageparam_pageSize" value="'+pageSize+'" style="text-align: center; width:40px;height:19px;background:#fff;border:1px solid;" maxlength="4" onchange="submitSearch(this);" onkeypress="onKeyPress(this);"/>');
	pagestatus.push('<input type="hidden" name="pageIndex" id="pageparam_pageIndex" value="'+pageIndex+'"/>');
	pagestatus.push('当前第'+pageIndex+'页&nbsp;&nbsp;');
	pagestatus.push('共'+pageCount+'页&nbsp;&nbsp;');
	pagestatus.push('<input type="button" class="normalbtnsmall" onclick="prevPage(this);" value="上一页"/>&nbsp;&nbsp;');
	pagestatus.push('<input type="button" class="normalbtnsmall" onclick="nextPage(this);" value="下一页 "/>');
	PageCtrl.validate = validateFunc;
	
	try{
		document.getElementById("pageparam_pageSize").value=pageSize;
	}catch(e){}
	
	return pagestatus;
}

function updatePageNumList(pageIndex,pageCount,pagestatus,maxPageNum){
	
	if(typeof maxPageNum=='undefined'){
		maxPageNum = 8;
	}
	var pageNum = maxPageNum;
	
	var pageNumStart;
	var pageNumEnd;
	var remainder = pageIndex%pageNum;
	var res = Math.ceil(pageIndex/pageNum);
	var pageNumStart = (res-1)*pageNum+1;

	var pageGrap = pageCount-pageNumStart+1;
	if(pageGrap>=pageNum){
		pageGrap = pageNum;
	}

	if(res<=1){
		pageNumStart = 1;
	}
	if(pageGrap<pageNum){
		pageNumEnd = pageCount;
	}else{
		pageNumEnd = pageNumStart+pageGrap-1;
	}
	
	var pageState = pageCount>pageNumEnd;
	var pageState2 = pageCount>pageNum;
	
	if(pageState){
		
		for(var i=pageNumStart;i<=pageNumEnd;i++){
			pagestatus.push('<input type="button" class="page_btn" value="'+i+'" onclick="btnClick(this);"/>');
		}
		
		pagestatus.push('&nbsp<span>...</span>&nbsp');
		pagestatus.push('<span>...</span>&nbsp');

		if(pageNumEnd!=pageCount-1){
			pagestatus.push('<input type="button" class="page_btn" value="'+(pageCount-1)+'" onclick="btnClick(this);"/>');
		}
		pagestatus.push('<input type="button" class="page_btn" value="'+(pageCount)+'" onclick="btnClick(this);"/>');
		
	}else{
		if(pageState2){
			var endLen = Math.ceil(pageNum/2);
			for(var i=1;i<=endLen;i++){
				pagestatus.push('<input type="button" class="page_btn" value="'+i+'" onclick="btnClick(this);"/>');
			}

			pagestatus.push('&nbsp<span>...</span>&nbsp');
			pagestatus.push('<span>...</span>&nbsp');
			
		}else{
			
			pagestatus.push('<input type="hidden" name="pageIndex" id="pageparam_pageIndex" value="'+pageIndex+'"/>');
		}
		
		for(var j=pageNumStart;j<=pageNumEnd;j++){
			pagestatus.push('<input type="button" class="page_btn" value="'+j+'" onclick="btnClick(this);"/>');
		}
	}
	if(pageState2){
		pagestatus.push('<input type="text" name="pageIndex" id="pageparam_pageIndex" value="'+pageIndex+'" class="page_btn_input" maxlength="7" onchange="submitSearch(this);" onkeypress="onKeyPress(this);"/>');
		pagestatus.push('<input type="button" class="page_btn" value="确定" onclick="submitSearch(this);"/> ');
	}
	
}

PageCtrl.validate = null;

function btnClick(obj){
	$("#pageparam_pageIndex").val($(obj).val());
	submitSearch(obj);
}

function newsearch(obj){
	$("#pageparam_pageIndex").val(1);
	submitSearch(obj);
}
function firstPage(obj){
	var pageIndex = parseInt($("#pageparam_pageIndex").val());
	if(pageIndex > 1){
		$("#pageparam_pageIndex").val(1);
		submitSearch(obj);
	}else{
		//alert("当前已经是第一页");
		aipgUtil.popupDiv("<font  color='#FFFFFF'>当前已经是第一页</font>",false);
		setTimeout("aipgUtil.hideDiv()",500);
	}
}
function prevPage(obj){
	var pageIndex = parseInt($("#pageparam_pageIndex").val());
	if(pageIndex > 1){
		$("#pageparam_pageIndex").val(pageIndex - 1);
		submitSearch(obj);
	}else{
		//alert("当前已经是第一页");
		aipgUtil.popupDiv("<font  color='#FFFFFF'>当前已经是第一页</font>",false);
		setTimeout("aipgUtil.hideDiv()",500);
	}
}
function nextPage(obj){
	var pageIndex = parseInt($("#pageparam_pageIndex").val());
	var pageCount = parseInt($("#pageparam_pageCount").val());
	if(pageIndex < pageCount){
		$("#pageparam_pageIndex").val(pageIndex + 1)
		submitSearch(obj);
	}else{
		//alert("当前已是最后一页");
		aipgUtil.popupDiv("<font  color='#FFFFFF'>当前已是最后一页</font>",false);
		setTimeout("aipgUtil.hideDiv()",500);
	}
}
function lastPage(obj){
	var pageIndex = parseInt($("#pageparam_pageIndex").val());
	var pageCount = parseInt($("#pageparam_pageCount").val());
	if(pageIndex < pageCount){
		$("#pageparam_pageIndex").val(pageCount)
		submitSearch(obj);
	}else{
		//alert("当前已经是最后一页");
		aipgUtil.popupDiv("<font  color='#FFFFFF'>当前已是最后一页</font>",false);
		setTimeout("aipgUtil.hideDiv()",500);
	}
}
function submitSearch(obj){
	if($("#pageparam_pageIndex")[0]){
		if(searchDataModified){
			$("#pageparam_pageIndex").val(1);
		}
	
		var pageIndex = parseInt($("#pageparam_pageIndex").val());
		if(isNaN(pageIndex) || pageIndex<=0){
			//alert("页码非法");
			aipgUtil.popupDiv("<font color='red'>页码非法</font>",false);
			setTimeout("aipgUtil.hideDiv()",500);
			$("#pageparam_pageIndex").focus();
			return;
		}
	}
	if($("#pageparam_pageSize")[0]){
		var pageSize = parseInt($("#pageparam_pageSize")[0].value);
		if(isNaN(pageSize) || pageSize<=0){
			//alert("页大小非法");
			aipgUtil.popupDiv("<font color='red'>页大小非法</font>",false);
			setTimeout("aipgUtil.hideDiv()",500);
			$("#pageparam_pageSize").focus();
			return;
		}
	}
	if(PageCtrl.validate){
		if(PageCtrl.validate()){
			var subbtn = $(obj.form).find("input[type='submit']");
			if(subbtn[0]){
				subbtn[0].click();
			}else{
				var submitbtn = $("<input type='submit'/>").css("display","none").appendTo($(obj.form));
				submitbtn.click();
			}
		}
	}else{
		var subbtn = $(obj.form).find("input[type='submit']");
		if(subbtn[0]){
			subbtn[0].click();
		}else{
			var submitbtn = $("<input type='submit'/>").css("display","none").appendTo($(obj.form));
			submitbtn.click();
		}
	}
		
}
		
var searchDataModified = false;
function onSearchDataModified(){
	searchDataModified = true;
}

function onKeyPress(obj){
	if(window.event.keyCode==13){
		submitSearch(obj);
	}
}