$.fn.multiComboURL = function(url,opt){
//	var el = $(this);
	opt = opt || {};
	opt.emptyText = opt.emptyText==undefined? '(无)' :opt.emptyText;
	opt.emptyValue = opt.emptyValue==undefined?'(none)':opt.emptyValue;
	opt.allText = opt.allText==undefined?'(全部)':opt.allText;
	opt.allValue = opt.allValue==undefined?'':opt.allValue;
	var pid = this[0].id || this[0].name;
	var elVal = this;
	var el = elVal.clone(true);
	elVal.css('display','none');
	this.id = pid + '_comboShowText';
	if (!elVal.val()) elVal.val('');
	el.insertBefore(this);
	el.attr('name', el.attr('name') + '_comboShowText');
	var layer = null;
	var ct = null;
	var pager = null;
	var page = 1;
	var size = 8;
	var pageCount = 0;
	var itemCount = 0;
	var selected = -1;
	var curCount = 0;
	var table = null;
	var noUpdate = false;
	var input = '';
	el.attr('readonly', 'true');
	var updateMulti = function(){
		if (elVal.val() == opt.allValue){
			el.val(opt.allText);
		} else {
			var v = elVal.val();
			if (v == opt.emptyValue)
				el.val(opt.emptyText);
			else {
				if(v.split(",").length==1){
					el.val(v);
				}else{
					el.val('(已选中' + v.split(",").length + '项)');
				}
			}
		}
	}
	updateMulti();
	var kill = function(){
		if (!layer) return;
		layer.slideUp('fast', function(){
			layer.remove(); layer = null;
		});
	}
	var fuzzyInput = $('<input type="text"/>').css('fontSize','12px').width(180).height(16);
	var checkboxGlobal;
	var makeLayer = function(){
		var pos = el.position();
		checkboxGlobal = $('<input type="checkbox"/>').click(function(){$('input[type=checkbox]', table).attr("checked", this.checked).each(function(ii,vv){updateValues(vv.value,vv.checked)});});
		var combofream = $("<iframe/>").attr("scrolling","no").attr("frameborder","0")
		.css("position","absolute")
		.css("visibility","inherit")
		.css("top","0px").css("left","0px").css("zIndex","-1").height(size * 30+el.height()+44).width(401); 
		layer = $('<div/>')
				.css('position', 'absolute')
				.css('background', '#ffffff')
				.css('border', '1px #ddddff solid')
				.css('left', pos.left)
				.css('top', pos.top + el.height() + 5)
				.height(size * 30)
				.width(400)
				.append(combofream)
				.hide();
		var checkCtrl = $('<div/>')
				.css('cursor', 'pointer')
				.css('position', 'absolute')
				.css('fontSize', '12px')
				.css('top', 3)
				.css('left', 10)
				.width(16)
				.height(16)
				.append(checkboxGlobal)
				.appendTo(layer);
		$('<div/>').css('position', 'absolute')
			.css('fontSize', '12px')
			.css('top', 2)
			.css('left', 50)
			.width(250)
			.height(16)
			.append(fuzzyInput)
			.appendTo(layer);
		$('<div/>').css('position', 'absolute')
			.css('fontSize', '12px')
			.css('cursor', 'pointer')
			.attr('title','清除所有选择')
			.css('top', 2)
			.css('left', 280)
			.width(18)
			.height(16)
			.append($("<img/>").attr("src",getRootPath()+"/images/clearbtn.png"))
			.click(function(){elVal.val("");$('input[type=checkbox]', table).attr("checked", false);el.val(opt.allText);fuzzyInput.change();})
			.appendTo(layer);
		var header = $('<div/>')
				.css('fontSize', '9px')
				.css('cursor', 'pointer')
				.css('textAlign', 'center')
				.css('position', 'absolute')
				.css('background','url('+getRootPath()+'/images/web_icon_009.gif)')
				.css('top', 2)
				.css('left', 375)
				.width(16)
				.height(16)
				.click(kill)
				.appendTo(layer);
			ct = $('<div/>')
				.css('position', 'absolute')
				.css('top', 20)
				.css('left', 5)
				.width(388)
				.css('fontSize', '10px')
				.appendTo(layer);
		pager = $('<div/>')
				.css('textAlign', 'right')
				.css('position', 'absolute')
				.css('left', 5)
				.width(388)
				.height(15)
				.css('fontSize', '10px')
				.text('')
				.appendTo(layer);
		return layer;
	}
	var focusLock = false;
	el.click(function(){
		if (!layer && !focusLock){
//			el[0].select();
			//fuzzyInput.change();
			el.css('backgroundImage','url('+getRootPath()+'/images/rotatingglobe.gif)');
			el.css('backgroundRepeat','no-repeat');
			el.css('backgroundPosition','right');
			page = 1;
			focusLock = true;
			makeLayer();
			layer.insertAfter(el);
			update();
//			layer.slideDown('fast');
			focusLock = false;
		}
	});
	var timer;
	var ids = [];
	var getClickTrFun = function(checkbox){
		return function(){
			checkbox[0].checked = !checkbox[0].checked;
			updateValues(checkbox[0].value,checkbox[0].checked);
		}
	}
	
	var updateValues = function(val,checked){
		var vs = new Array();
		vs = elVal.val().split(',');
		if(checked){
			if(elVal.val().indexOf(val)!=-1){
				return;
			}
			vs.push(val);
		}else{
			for(var ki = 0;ki<vs.length;ki++){
				if(vs[ki]==val){
					vs.splice(ki, 1);
					break;
				}
			}
		}
		var valstr = vs.join(",");
		if(valstr.indexOf(",")==0){
			valstr = valstr.substring(1);
		}
		elVal.val(valstr);
		updateMulti();
	}
	var insertDatas = function(matchedDatas, start, size){
		if (!layer)
			return;
		ct.empty();
		table = $('<table/>')
				.width('100%');
		var i = start, addCount = 0;
		var allcheck = true;
		for (var len = matchedDatas.length; i < len && addCount < size; ++i, ++addCount){
			var checkbox = $('<input type="checkbox"/>').val(matchedDatas[i].code).css('margin-top','5px')
							.click(function(){
								updateValues(this.value,this.checked);
							});
			checkbox[0].checked = elVal.val().indexOf(checkbox.val())!=-1;
			if(!checkbox[0].checked){
				allcheck = false;
			}
			var clickTr = getClickTrFun(checkbox);
			var tr = $('<tr/>')
						.css('fontSize', '9pt')
						.css('cursor', 'pointer')
						.mouseover(function(){
							$("tr:eq(" + selected + ")", table[0]).css('background', 'transparent');
							this.style.background = '#ddddff';
							fuzzyInput.focus();
						})
						.mouseout( function(){
							$("tr:eq(" + selected + ")", table[0]).css('background', 'transparent');
							this.style.background = 'transparent';
							fuzzyInput.focus();
						});
			tr.append($('<td width=5%/>').css('paddingLeft', '5px').css('height','30px').css('lineHeight','30px').append(checkbox));
			tr.append($('<td width=30%/>').css('paddingLeft', '2px').css('height','30px').css('lineHeight','30px').css('text-align','left').html(matchedDatas[i].code.replace(input, '<b>'+input+'</b>')).click(clickTr));
			tr.append($('<td width=65%/>').css('height','30px').css('lineHeight','30px').css('text-align','left').html(matchedDatas[i].name.replace(input, '<b>&nbsp'+input+'</b>')).click(clickTr));
			tr.appendTo(table);
		}
		checkboxGlobal[0].checked = allcheck;
			
		curCount = addCount;
		for (; addCount < size; ++addCount){
			$('<tr/>').append($('<td colspan=2/>').html('&nbsp;')).appendTo(table);
		}
		table.appendTo(ct);
		var theight = table.height() || (size * 30);
		var pheight = pager.height() || 15;
		ct.height(theight);
		pager.css('top', 30 + theight);
		layer.height(theight + pheight + 40);
		if(layer.css("display")=='none'){
			layer.slideDown('fast');
			el.css('backgroundImage','url()');
		}
		fuzzyInput.focus();
	}
	
	var updateJson = function(matchedDatas){
		selected = -1;
		var numbers = getShowNumber(page,pageCount);
		var tmp = $('<span/>').css('font-size','12px').append($('<img/>').css('width','16px').css('height','16px').css('verticalAlign','middle')
				.attr('src',getRootPath()+'/images/web_icon_002.gif')
				.css('cursor', 'pointer').click(function(){if(page > 1){ page--; update(); }return false;})
				);
		for(var i = 0,len = numbers.length;i<len;i++){
			if(i==1){
				if(numbers[i]!=numbers[i-1]+1){
					tmp.append('...');
				}
			}
			if(i==len-1&&i!=0){
				if(numbers[i]!=numbers[i-1]+1){
					tmp.append('...');
				}
			}
			var pageNum = numbers[i];
			var updatePageFun = updatePage(pageNum);
			var tmp0 = $('<a href="#"/>').text(pageNum).css('text-decoration','none').css('margin-right','5px').css('color','#666666')
				.click(updatePageFun);
			if(page == pageNum){
				tmp0.css('text-decoration','underline').css('font-weight','bolder');
			}
			tmp.append(tmp0);
		}
		tmp.append($('<img/>').css('width','16px').css('height','16px').css('verticalAlign','middle')
				.attr('src',getRootPath()+'/images/web_icon_003.gif')
				.css('cursor', 'pointer').click(function(){if(page < pageCount){ page++; update(); }return false;})
				);
		
		pager
		.text('')
		.append(tmp);
		
		insertDatas(matchedDatas, 0, size);
	}
	
	var update = function(){
		if (!layer || noUpdate)
			return;
		var matchedDatas = [];
		var param = {pageIndex:page,pageSize:size,cus:input};
		$.post(url,param, function(json){
			try{
				var jsonTemp = eval('('+json +')');
				json = jsonTemp[0];
			}catch(e){
				json = {"result":{},"pageCount":0,"itemCount":0};
			}
			pageCount = json.pageCount;
			itemCount = json.itemCount;
			matchedDatas = json.result;
			updateJson(matchedDatas);
		});
		
	}
	var updatePage = function(pageTemp){
		return function(){
			if(pageTemp==page)
				return;
			if(pageTemp<1){
				pageTemp = 1;
			}
			if(pageTemp>pageCount){
				pageTemp = pageCount;
			}
			page = pageTemp;
			update();
		}
	}
	fuzzyInput.keyup(function(){
		var tmp_input = $.trim(el.val());
		if(tmp_input!=input){
			input = tmp_input;
			inputDelay();
		}
	});
	var inputFlag = 0;
	var inputDelay = function(){
		inputFlag++;
		setTimeout(function(){
			inputFlag--;
			if(inputFlag==0){
				if (!noUpdate) {page = 1; input = $.trim(fuzzyInput.val())||$.trim(elVal.val());}
				update();
			}
			},300);
	}
//	try{
//		fuzzyInput[0].addEventListener('input', inputDelay, false);
//	}catch (e){
//		fuzzyInput[0].onpropertychange = inputDelay;
//	}
}

function getRootPath(){
	var strFullPath=window.document.location.href;
	var strPath=window.document.location.pathname;
	var pos=strFullPath.indexOf(strPath);
	var prePath=strFullPath.substring(0,pos);
	var postPath=strPath.substring(0,strPath.substr(1).indexOf('/')+1);
	return postPath;
}

function getShowNumber(page,pageCount){
	var showNum = 5;
	var numbers = [];
	if(pageCount<=showNum+2){
		for(var i = 1;i<=pageCount;i++){
			numbers.push(i);
		}
		return numbers;
	}
	var start = page;
	if(pageCount-page<4){
		start = pageCount-showNum+1;
	}
	var end = start+showNum-1;
	if(start>4)
		numbers.push(1);
	for(var j = start;j<=end;j++){
		numbers.push(j);
	}
	if(pageCount-end==2){
		numbers.push(pageCount-1);
		numbers.push(pageCount);
	}else if(pageCount!=end){
		numbers.push(pageCount);
	}
	return numbers;
}