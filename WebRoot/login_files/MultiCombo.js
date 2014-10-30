(function($){
	$.fn.multiComboExt = function(url,params,opt){
		var el = this;
		$.post(url,params,function(json){
			try{
				json = eval('('+json +')');
			}catch(e){
				json = {};
			}
			el.multiCombo(json,opt);
		});
	}
	$.fn.multiCombo = function(datas, opt) {
		var ie6	= ($.browser.msie && $.browser.version < 7);
		var $window	= $(window);
		opt = opt || {};
		opt.emptyText = opt.emptyText==undefined? '(无)' :opt.emptyText;
		opt.emptyValue = opt.emptyValue==undefined?'(none)':opt.emptyValue;
		opt.allText = opt.allText==undefined?'(全部)':opt.allText;
		opt.allValue = opt.allValue==undefined?'':opt.allValue;
		var pid = this[0].id || this[0].name;
//		var el = this;
		var elVal = this;
		var el = elVal.clone(true);
		elVal.css('display','none');
		this.id = pid + '_comboShowText';
		if (!elVal.val()) elVal.val('');
//		var elVal = $('<input type="hidden"/>')
//						.attr('name', el.attr('name'))
//						.attr('id', pid)
//						.val(el.val())
//						.insertAfter(el);
		
		el.insertBefore(this);
		el.attr('name', el.attr('name') + '_comboShowText');
		var maxCount = 0;
		for (var i = 0, len = datas.length; i < len; ++i){
			if(datas[i].name.length>maxCount){
				maxCount = datas[i].name.length;
			}
		}
		var update = function(){
			if (elVal.val() == opt.allValue){
				el.val(opt.allText);
			} else {
				var v = elVal.val();
				if (v == opt.emptyValue)
					el.val(opt.emptyText);
				else {
					var c = 0, lastMatch = -1;
					v = ',' + v + ',';
					for (var i = 0, len = datas.length; i < len; ++i){
						if (v.indexOf(',' + datas[i].code + ',') != -1){
							++c;
							lastMatch = i;
						}
					}
					if (c == 0){
						elVal.val(opt.allValue);
						el.val(opt.allText);
					} else if (c == 1) {
						el.val(datas[lastMatch].name);
					} else if (c == datas.length) {
						elVal.val(opt.allValue);
						el.val(opt.allText)
					} else {
						el.val('(已选中' + c + '项)');
					}
				}
			}
		}
		update();
		var offsetparent = $(el).offsetParent();
		var combofream = $("<iframe/>").attr("src","javascript:false")
										.css("position","absolute")
										.css("visibility","inherit")
										.css("top","0px").css("left","0px").css("width","100px").css("height","200px").css("zIndex","-1"); 
		var comboSelectorCt = $("<div/>")
								.width(Math.max((maxCount+2)*13,(opt.width || this.width())))
								.height(opt.height || 300)
								.css('position', 'absolute')
								.css('background', '#DDEEF6')
								.css('display', 'none')
								.css('zIndex', '3000')
								.append(combofream)
								.appendTo(offsetparent);
		var selectAllChk = "";
		if(opt.selectAllChk!=false){
			selectAllChk = $('<input type="checkbox"/>')
							.attr('title', '全选/全不选')
							.attr('checked', !elVal.val())
							.click(function(){
								$('input[type=checkbox]', comboSelector).attr("checked", this.checked);
								if (this.checked){
									el.val(opt.allText);
									elVal.val(opt.allValue);
								} else {
									el.val(opt.emptyText);
									elVal.val(opt.emptyValue);
								}
							});
		}
		
		var titleBar = $('<div/>')
			.height(15)
			.css('padding', '3px')
			.css('fontSize', '12px')
			.css('fontWeight', 'bold')
			.css('color', '#ffffff')
			.css('background', '#3571C4')
			.css('height','20px')
			.css('lineHeight','20px')
			.append('&nbsp;')
			.append(selectAllChk)
			.append('&nbsp;' + (opt.title || '请选择'))
			.appendTo(comboSelectorCt);
		var comboSelector = $("<div/>")
			.width(comboSelectorCt.width())
			.height((opt.height || 300) - 21)
			.css('margin', '0px')
			.css('background', '#DDEEF6')
			.css('border', '1px #ddddff solid')
			.css('overflow', 'auto')
			.css('zIndex', '3000')
			.appendTo(comboSelectorCt);	
		var colCount = datas.length;
		var opCol = 0
		el.attr('readonly', 'true');
		var curVal = elVal.val() + '';
		$(datas).each(function(i, v){
			var id = 'comboSelector_' + pid + '_check_' + i;
			var chkbox = $('<input id="' + id + '" type="checkbox"/>')		
				.css('marginLeft', '5px')
				.attr('val', v.code)
				.click(function(){
					val = '';
					var c = 0;
					var text;
					var chkBoxes = $('input[type=checkbox]', comboSelector);
					chkBoxes.each(function(i, v){
						if (v.checked){
							val += ',' + $(v).attr('val');
							text = datas[i].name;
							++c;
						}
					});
					elVal.val(val.substring(1));
					if (c == 0){
						el.val(opt.emptyText);
						elVal.val(opt.emptyValue);
					}
					else if (c == 1)
						el.val(text);
					else if (c == chkBoxes.length){
						elVal.val(opt.allValue);
						el.val(opt.allText);
					} else
						el.val('(已选中' + c + '项)');
				})
				.appendTo(comboSelector);
			chkbox[0].checked = (curVal == opt.allValue) || (',' + elVal.val() + ',').indexOf(',' + v.code + ',') != -1;
			var labelText = v.name || v.code || v || '--';
			$('<label/>')
				.attr('for', id)
				.css('marginLeft', '5px')
				.css('cursor', 'pointer')
				.text(labelText)
				.appendTo(comboSelector);
			$('<br/>')
				.appendTo(comboSelector);
		});
		
		var	offset = $(el).position();
		
		$(el).click(function(e){
			var mask = $('<div class="docMask"/>')
							.css("width", "100%")
							.css("height", (ie6)? $window.scrollTop()+$window.height():"100%")
							.css("left", "0px")
							.css("top", "0px")
							.css("position", (ie6)?"absolute":"fixed")
							.css("background", "#000000")
							.css("opacity", "0.0")
							.css("zIndex", "1000")
							.click(function(){
								mask.fadeOut(function(){mask.remove()});
								shadow.fadeOut(function(){shadow.remove()});
								comboSelectorCt.fadeOut();
							})
							.appendTo(offsetparent)
							.fadeIn();
			var shadow = $('<div/>')
							.width(comboSelectorCt.width())
							.height(comboSelectorCt.height())
							.css('left', offset.left + 10)
							.css('top', offset.top + 10 + el.height())
							.css("position", "absolute")
							.css("background", "#000000")
							.css("opacity", "0.0")
							.css("zIndex", "1100")	
							.appendTo(offsetparent)
							.fadeIn();
			var curVal = elVal.val() + '';
			if(selectAllChk)
				selectAllChk[0].checked = curVal == opt.allValue;
			$('input[type=checkbox]', comboSelector).each(function(i, v){
				v.checked = (curVal == opt.allValue) || (',' + curVal + ',').indexOf(',' + datas[i].code + ',') != -1;
			});
			comboSelectorCt
				.css('left', offset.left)
				.css('top', offset.top + el.height())
				.fadeIn();
			titleBar.width(comboSelectorCt.width()-4);
			comboSelector.width(comboSelectorCt.width());
		});	
		$.fn.multiCombo.combos.items.push(
			{el: el, elVal: elVal, opt: opt}
		);
	}
	$.fn.multiCombo.combos = {
		items: [],
		resetAll: function(){
			for (var i = 0; i < this.items.length; ++i){
				var it = this.items[i];
				if(it.opt.defaultval=='empty'){
					it.el.val(it.opt.emptyText);
					it.elVal.val(it.opt.emptyValue);
				}else{
					it.el.val(it.opt.allText);
					it.elVal.val(it.opt.allValue);
				}
			}
		}
	}
})(jQuery);