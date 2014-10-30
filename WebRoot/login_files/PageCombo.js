$.fn.SelectComboURL = function(url,params,value){
	var el = this;
	$.post(url,params,function(json){
		try{
			json = eval('('+json +')');
		}catch(e){
			json = {};
		}
		el.SelectCombo(json,value);
	});
};

$.fn.SelectCombo = function(datas,value){
	var el = $(this);
	for(var i=0;i<datas.length;i++){
		var data = datas[i];
		var code = data.code;
		var name = data.name==null?"":data.name.trim();
		if(!name){
			name = code;
		}
		el.append($("<option/>").val(code).text(name));
	}
	if(value!=''){
		el[0].value=value;
	}
};

$.fn.PageComboExt = function(url,params){
	var el = this;
	$.post(url,params,function(json){
		try{
			json = eval('('+json +')');
		}catch(e){
			json = {};
		}
		el.PageCombo(json);
	});
}

$.fn.PageCombo = function(datas,writeMethod){
	var el = $(this);
	var layer = null;
	var ct = null;
	var pager = null;
	var page = 1;
	var size = 8;
	var pageCount = 0;
	var selected = -1;
	var curCount = 0;
	var table = null;
	var noUpdate = false;
	var input = '';
	writeMethod = writeMethod || function(v){el.val(v.code || v || '');}
	var kill = function(){
		if (!layer) return;
		layer.slideUp('fast', function(){
			layer.remove(); layer = null;
		});
	}
	var makeLayer = function(){
		var pos = el.position();
		var combofream = $("<iframe/>").attr("scrolling","no").attr("frameborder","0")
		.css("position","absolute")
		.css("visibility","inherit")
		.css("top","0px").css("left","0px").width(400).css("height","300px").css("opacity", "0.0").css("zIndex","0"); 
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
//				.text('X')
				.click(kill)
				.appendTo(layer);
			ct = $('<div/>')
				.css('position', 'absolute')
				.css('top', 20)
				.css('left', 5)
				.width(388)
//				.css('border', '1px #eeeeff solid')
				.css('fontSize', '10px')
				.appendTo(layer);
		pager = $('<div/>')
				.css('textAlign', 'right')
				.css('position', 'absolute')
				.css('left', 5)
				.width(388)
				.height(15)
//				.css('border', '1px #eeeeff solid')
				.css('fontSize', '10px')
				.text('')
				.appendTo(layer);
		return layer;
	}
	var focusLock = false;
	el.unbind('click');
	el.click(function(){
		if (!layer && !focusLock){
			el[0].select();
			page = 1;
			focusLock = true;
			makeLayer();
			layer.insertAfter(el);
			update();
			layer.slideDown('fast');
			focusLock = false;
		}
	});
	el[0].onkeydown = function(e){
		e = e || window.event;
		if (layer)
			switch (e.keyCode){
				case 37: // Left
					if(e.ctrlKey && page > 1){ page--; update(); }
					break;
				case 39: // Right
					if(e.ctrlKey && page < pageCount){ page++; update(); }
					break;				
				case 38: // Up
					if (curCount > 0){
						if (selected == -1) selected = curCount - 1;
						else{
							$("tr:eq(" + selected + ")", table[0]).css('background', 'transparent');
							selected = (selected + curCount - 1) % curCount;
						}
						noUpdate = true;
						writeMethod({code:$("tr:eq(" + selected + ") td:eq(0)", table[0]).text(), name:$("tr:eq(" + selected + ") td:eq(1)", table[0]).text()});
						noUpdate = false;
						$("tr:eq(" + selected + ")", table[0]).css('background', '#ddddff');
					}
					break;					
				case 40: // Down
					if (curCount > 0){
						if (selected == -1) selected = 0;
						else{
							$("tr:eq(" + selected + ")", table[0]).css('background', 'transparent');
							selected = (selected + 1) % curCount;
						}
						noUpdate = true;
						writeMethod({code:$("tr:eq(" + selected + ") td:eq(0)", table[0]).text(), name:$("tr:eq(" + selected + ") td:eq(1)", table[0]).text()});
						noUpdate = false;
						$("tr:eq(" + selected + ")", table[0]).css('background', '#ddddff');
					}
					break;
				case 13:
					kill();
			}
	}
	var timer;
	var ids = [];
	var insertDatas = function(matchedDatas, start, size){
		if (!layer)
			return;
		ct.empty();
		table = $('<table/>')
				.width('100%');
		var i = start, addCount = 0;
		for (var len = matchedDatas.length; i < len && addCount < size; ++i, ++addCount){
			var tr = $('<tr/>')
						.css('fontSize', '9pt')
						.css('cursor', 'pointer')
						.mouseover(function(){
							$("tr:eq(" + selected + ")", table[0]).css('background', 'transparent');
							this.style.background = '#ddddff';
							//el.focus();
						})
						.mouseout( function(){
							$("tr:eq(" + selected + ")", table[0]).css('background', 'transparent');
							this.style.background = 'transparent';
							//el.focus();
						})
						.click(function(){
							var itemp = 0;
							for(var pNode = this.parentNode.firstChild; pNode != null && pNode != this; ++itemp, pNode = pNode.nextSibling);
							writeMethod(matchedDatas[(itemp+size*(page-1))]);
							kill();
						})
			tr.append($('<td width=30%/>').css('paddingLeft', '5px').css('height','30px').css('lineHeight','30px').html(matchedDatas[i].code.replace(input, '<b>'+input+'</b>')));
			tr.append($('<td width=70%/>').css('height','30px').css('lineHeight','30px').html(matchedDatas[i].name.replace(input, '<b>'+input+'</b>')));
			tr.appendTo(table);
		}
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
	}
	var update = function(){
		if (!layer || noUpdate)
			return;
		var matchedDatas = [];
		input = $.trim(el.val());
		for (var i = 0, len = datas.length; i < len; ++i){
			if (datas[i].code.indexOf(input) != -1 || datas[i].name.indexOf(input) != -1)
				matchedDatas.push(datas[i]);
		}
		pageCount = Math.floor((matchedDatas.length + size - 1) / size);
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
		
//		pager
//			.text('')
//			.append($('<a href="#"/>').text('<').click(function(){if(page > 1){ page--; update(); }return false;}))
//			.append($('<span/>').text(' ' + page + '/' + pageCount + ' '))
//			.append($('<a href="#"/>').text('>').click(function(){if(page < pageCount){ page++; update(); }return false;}));
		insertDatas(matchedDatas, page * size - size, size);
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
	el[0].onchange = function(){
		if (!noUpdate) {page = 1; input = $.trim(el.val());}
		update();
	}
	try{
		
		el[0].addEventListener('input', el[0].onchange, false);
	}catch (e){
		el[0].onpropertychange = el[0].onchange;
	}
}

function getRootPath(){
	var strFullPath=window.document.location.href;
	var strPath=window.document.location.pathname;
	var pos=strFullPath.indexOf(strPath);
	var prePath=strFullPath.substring(0,pos);
	var postPath=strPath.substring(0,strPath.substr(1).indexOf('/')+1);
	//alert(postPath);
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
	var start;
	if(page >= 4){
		start = page-2;
	}else{
		start = 1;
	}
	if(pageCount-page<4){
		end = pageCount;
	}else if(page<3){
		end = start+4;
	}else{
		end = page+2;
	}
	if(pageCount-page<2){
		start-=2-pageCount+page;
	}
	if(start>=4)
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