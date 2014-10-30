(function($){
	$.fn.HideDialog = function(){
		if($("#diawindow").length>0) {
			$("#diawindow").remove();
		}
		if($("#markdiag").length>0) {
			$("#markdiag").remove();
		}	
	};
	$.fn.ShowDialog = function(options) {
		var opts={
			Width:"300",
			Height:"300",
			Title:"title",
			Intopacity:"0.2",
			ContentFlag:"0",
			skin:"blue",
			FrameURL:"",
			FrameScroll:"auto",
			Contents:""
		};
		var ie6	= ($.browser.msie && $.browser.version < 7);
		var $window	= $(window);
		var opts = $.extend(opts,options);
		opts.ContentFlag = opts.FrameURL != "" ? 0 : opts.ContentFlag != "" ? 1 : 2;
		if(!$("#diawindow").length>0) {
			var maktemp='<div id="markdiag" style="display:block;background:#666;width:100%; height:'+(ie6?$window.scrollTop()+$window.height():$window.height())+'px; position:'+(ie6?'absolute':'fixed')+'; top:0px; left:0px; z-index:80;"></div>';
			var tempstr = '<div class="jdiag_showdiv" id="diawindow"><div class="jdiag_top"><div class="jdiag_topright"></div><div class="jdiag_topmiddle" id="topmiddle"> <span style="color:#FFF; font-weight:bold; line-height:26px; font-size:12px;float:left">&nbsp;'+opts.Title+'</span><span style="float:right" id="diagclose" class="jdiag_close1"></span></div><div class="jdiag_topleft"></div></div><div class="jdiag_clear"></div><div class="jdiag_middle"><div class="jdiag_middleleft" id="middleleft"></div><div class="jdiag_middlemiddle"  id="middlemiddle"><div class="jdiag_content" id="middlecontent"><iframe src="'+opts.FrameURL+'" style="height:100%; width:100%;" scrolling="' + opts.FrameScroll + '" frameborder="0"></iframe></div></div><div class="jdiag_middleright" id="middleright"></div></div><div class="jdiag_clear"></div><div class="jdiag_end"><div class="jdiag_endleft"></div><div class="jdiag_endmiddle" id="endmiddle"></div><div class="jdiag_endright"></div></div><div class="jdiag_clear"></div></div>';
			if(opts.ContentFlag==1) {
				tempstr ='<div class="jdiag_showdiv" id="diawindow"><div class="jdiag_top"><div class="jdiag_topright"></div><div class="jdiag_topmiddle" id="topmiddle"> <span style="color:#FFF; font-weight:bold; line-height:26px; font-size:12px;float:left;">&nbsp;'+opts.Title+'</span><span style="float:right" id="diagclose" class="jdiag_close1"></span></div><div class="jdiag_topleft"></div></div><div class="jdiag_clear"></div><div class="jdiag_middle"><div class="jdiag_middleleft" id="middleleft"></div><div class="jdiag_middlemiddle" id="middlemiddle"><div class="jdiag_content" id="middlecontent">'+opts.Contents+'</div></div><div class="jdiag_middleright" id="middleright"></div></div><div class="jdiag_clear"></div><div class="jdiag_end"><div class="jdiag_endleft"></div><div class="jdiag_endmiddle" id="endmiddle"></div><div class="jdiag_endright"></div></div><div class="jdiag_clear"></div></div>';
			}
			$("body").append(maktemp);
			$("body").append(tempstr);									  
		}
		else {
			$("#markdiag").show();
			$("#markdiag").show();
		}
		var css={opacity: opts.Intopacity}
		$("#markdiag").css(css);
		var w,h,de;
		de = document.documentElement;
		w = self.innerWidth || (de&&de.clientWidth) || document.body.clientWidth;
		var diagleft = (w+eval(top.document.body.scrollLeft))/2-(opts.Width/2);	
		$("#diawindow").css({"top" : (ie6)? $window.scrollTop()+$window.height()/2-opts.Height/2-100 : (opts.top?opts.top:'20%'),"left":diagleft,"width":opts.Width,"height":opts.Height,position:ie6?'absolute':'fixed'});
		$("#topmiddle").css({"width":opts.Width-20});
		$("#middlemiddle").css({"width":opts.Width-8,"height":opts.Height-34});
		$("#middleleft").css({"height":opts.Height-34});
		$("#middleright").css({"height":opts.Height-34});
		$("#middlecontent").css({"height":opts.Height-44});								
		$("#endmiddle").css({"width":opts.Width-20});
		$("#diagclose")
			.mousemove(function(){
				$(this).removeClass('jdiag_close1').addClass('jdiag_close2');
			})
			.mouseout(function(){
				$(this).removeClass('jdiag_close2').addClass('jdiag_close1');
			})
			.mousedown(function(){
				$("#diawindow").attr("move", "no");
			})
			.click(function(){
				$.fn.HideDialog();					   
			});
    };
    
    $.promptByUrl = function(url,options){
    	var loading_message = "<div style='margin:auto;text-align: center;' id='prompt_loading_div'><img src='"+webPath+"/images/loading2.gif'/></div>";
    	$.prompt(loading_message,options);
    	$.post(url,{},function(data){
    		try{
    			var datajson = eval("("+data+")");
    			if(datajson.code=='1'){
    				alert(datajson.message);
    			}else{
    				$("#prompt_loading_div").replaceWith(data);
    			}
    		}catch(e){
    			$("#prompt_loading_div").replaceWith(data);
    		}
    	});
    };
    
    $.prompt = function(message, options) {
		options = $.extend({},$.prompt.defaults,options);
		$.prompt.currentPrefix = options.prefix;

		var ie6		= ($.browser.msie && $.browser.version < 7);
		var $body	= $(document.body);
		var $window	= $(window);
		
		options.classes = $.trim(options.classes);
		if(options.classes != '')
			options.classes = ' '+ options.classes;
			
		//build the box and fade
		var msgbox = '<div class="'+ options.prefix +'box'+ options.classes +'" id="'+ options.prefix +'box">';
		if(options.useiframe && (($('object, applet').length > 0) || ie6)) {
			msgbox += '<iframe src="javascript:false;" style="display:block;position:absolute;z-index:-1;" class="'+ options.prefix +'fade" id="'+ options.prefix +'fade"></iframe>';
		} else {
			if(ie6) {
				$('select').css('visibility','hidden');
			}
			msgbox +='<div class="'+ options.prefix +'fade" id="'+ options.prefix +'fade"></div>';
		}
		msgbox += '<div class="'+ options.prefix +'" id="'+ options.prefix +'"><div class="'+ options.prefix +'container"><div class="';
		msgbox += options.prefix +'close">X</div><div id="'+ options.prefix +'states"></div>';
		msgbox += '</div></div></div>';

		var $jqib	= $(msgbox).appendTo($body);
		var $jqi	= $jqib.children('#'+ options.prefix);
		var $jqif	= $jqib.children('#'+ options.prefix +'fade');

		//if a string was passed, convert to a single state
		if(message.constructor == String){
			message = {
				state0: {
					html: message,
				 	buttons: options.buttons,
				 	focus: options.focus,
				 	submit: options.submit
			 	}
		 	};
		}

		//build the states
		var states = "";

		$.each(message,function(statename,stateobj){
			stateobj = $.extend({},$.prompt.defaults.state,stateobj);
			message[statename] = stateobj;

			states += '<div id="'+ options.prefix +'_state_'+ statename +'" class="'+ options.prefix + '_state" style="display:none;"><div class="'+ options.prefix +'message">' + stateobj.html +'</div><div class="'+ options.prefix +'buttons">';
			$.each(stateobj.buttons, function(k, v){
				if(typeof v == 'object')
					states += '<button name="' + options.prefix + '_' + statename + '_button' + v.title.replace(/[^a-z0-9]+/gi,'') + '" id="' + options.prefix + '_' + statename + '_button' + v.title.replace(/[^a-z0-9]+/gi,'') + '" value="' + v.value + '">' + v.title + '</button>';
				else states += '<button name="' + options.prefix + '_' + statename + '_button' + k + '" id="' + options.prefix +	'_' + statename + '_button' + k + '" value="' + v + '">' + k + '</button>';
			});
			states += '</div></div>';
		});

		//insert the states...
		$jqi.find('#'+ options.prefix +'states').html(states).children('.'+ options.prefix +'_state:first').css('display','block');
		$jqi.find('.'+ options.prefix +'buttons:empty').css('display','none');
		
		//Events
		$.each(message,function(statename,stateobj){
			var $state = $jqi.find('#'+ options.prefix +'_state_'+ statename);

			$state.children('.'+ options.prefix +'buttons').children('button').click(function(){
				var msg = $state.children('.'+ options.prefix +'message');
				var clicked = stateobj.buttons[$(this).text()];
				if(clicked == undefined){
					for(var i in stateobj.buttons)
						if(stateobj.buttons[i].title == $(this).text())
							clicked = stateobj.buttons[i].value;
				}
				
				if(typeof clicked == 'object')
					clicked = clicked.value;
				var forminputs = {};

				//collect all form element values from all states
				$.each($jqi.find('#'+ options.prefix +'states :input').serializeArray(),function(i,obj){
					if (forminputs[obj.name] === undefined) {
						forminputs[obj.name] = obj.value;
					} else if (typeof forminputs[obj.name] == Array || typeof forminputs[obj.name] == 'object') {
						forminputs[obj.name].push(obj.value);
					} else {
						forminputs[obj.name] = [forminputs[obj.name],obj.value];	
					} 
				});

				var close = stateobj.submit(clicked,msg,forminputs);
				if(close === undefined || close) {
					removePrompt(true,clicked,msg,forminputs);
				}
			});
			$state.find('.'+ options.prefix +'buttons button:eq('+ stateobj.focus +')').addClass(options.prefix +'defaultbutton');

		});

		var fadeClicked = function(){
			if(options.persistent){
				var offset = (options.top.toString().indexOf('%') >= 0? ($window.height()*(parseInt(options.top,10)/100)) : parseInt(options.top,10)),
					top = parseInt($jqi.css('top').replace('px',''),10) - offset;

				//$window.scrollTop(top);
				$('html,body').animate({ scrollTop: top }, 'fast', function(){
					var i = 0;
					$jqib.addClass(options.prefix +'warning');
					var intervalid = setInterval(function(){
						$jqib.toggleClass(options.prefix +'warning');
						if(i++ > 1){
							clearInterval(intervalid);
							$jqib.removeClass(options.prefix +'warning');
						}
					}, 100);
				});
			}
			else {
				removePrompt();
			}
		};
		
		var keyPressEventHandler = function(e){
			var key = (window.event) ? event.keyCode : e.keyCode; // MSIE or Firefox?
			
			//escape key closes
			if(key==27) {
				fadeClicked();	
			}
			
			//constrain tabs
			if (key == 9){
				var $inputels = $(':input:enabled:visible',$jqib);
				var fwd = !e.shiftKey && e.target == $inputels[$inputels.length-1];
				var back = e.shiftKey && e.target == $inputels[0];
				if (fwd || back) {
				setTimeout(function(){ 
					if (!$inputels)
						return;
					var el = $inputels[back===true ? $inputels.length-1 : 0];

					if (el)
						el.focus();						
				},10);
				return false;
				}
			}
		};
		
		var positionPrompt = function(){
			var bodyHeight = $body.outerHeight(true),
				windowHeight = $window.height(),
				documentHeight = $(document).height(),
				height = bodyHeight > windowHeight ? bodyHeight : windowHeight,
				top = parseInt($window.scrollTop(),10) + (options.top.toString().indexOf('%') >= 0? (windowHeight*(parseInt(options.top,10)/100)) : parseInt(options.top,10));
			height = height > documentHeight? height : documentHeight;
			
			$jqib.css({
				position: "fixed",
				height: "100%",
				width: "100%",
				top: 0,
				left: 0,
				right: 0,
				bottom: 0
			});
			$jqif.css({
				position: "fixed",
				height: "100%",
				width: "100%",
				top: 0,
				left: 0,
				right: 0,
				bottom: 0
			});
			$jqi.css({
				position: "absolute",
				top: options.top,
				left: "50%",
				border:"2px solid #aaa",
				marginLeft: (($jqi.outerWidth()/2)*-1)
			});
		};

		var stylePrompt = function(){
			$jqif.css({
				zIndex: options.zIndex,
				display: "none",
				opacity: options.opacity
			});
			$jqi.css({
				zIndex: options.zIndex+1,
				display: "none",
				width:options.width
			});
			$jqib.css({
				zIndex: options.zIndex
			});
		};

		var removePrompt = function(callCallback, clicked, msg, formvals){
			$jqi.remove();
			$window.unbind('resize',positionPrompt);
			$jqif.fadeOut(options.overlayspeed,function(){
				$jqif.unbind('click',fadeClicked);
				$jqif.remove();
				if(callCallback) {
					options.callback(clicked,msg,formvals);
				}
				$jqib.unbind('keypress',keyPressEventHandler);
				$jqib.remove();
				if(ie6 && !options.useiframe) {
					$('select').css('visibility','visible');
				}
			});
		};

		stylePrompt();
		positionPrompt();
		$jqif.click(fadeClicked);
		$window.resize(positionPrompt);
		$jqib.bind("keydown keypress",keyPressEventHandler);
		$jqi.find('.'+ options.prefix +'close').click(removePrompt);

		//Show it
		$jqif.fadeIn(options.overlayspeed);
		$jqi[options.show](options.promptspeed,options.loaded);
		$jqi.find('#'+ options.prefix +'states .'+ options.prefix +'_state:first .'+ options.prefix +'defaultbutton').focus();
		
		if(options.timeout > 0)
			setTimeout($.prompt.close,options.timeout);

		return $jqib;
	};
	
	$.prompt.defaults = {
		prefix:'jqi',

		classes: '',
		buttons: {
			Ok: true
		},
	 	loaded: function(){

	 	},
	  	submit: function(){
	  		return true;
		},
	 	callback: function(){



	 	},
		opacity: 0.2,
	 	zIndex: 999,
	  	overlayspeed: 'fast',
	   	promptspeed: 'fast',
   		show: 'show',
	   	focus: 0,
	   	useiframe: false,
	 	top: '15%',
	  	persistent: true,
	  	timeout: 0,
	  	width:400,
	  	state: {
			html: '',
		 	buttons: {
		 		Ok: true
		 	},
		  	focus: 0,
		   	submit: function(){
		   		return true;
		   }
	  	}
	};
	
	$.prompt.currentPrefix = $.prompt.defaults.prefix;

	$.prompt.setDefaults = function(o) {
		$.prompt.defaults = $.extend({}, $.prompt.defaults, o);
	};
	
	$.prompt.setStateDefaults = function(o) {
		$.prompt.defaults.state = $.extend({}, $.prompt.defaults.state, o);
	};
	
	$.prompt.getStateContent = function(state) {
		return $('#'+ $.prompt.currentPrefix +'_state_'+ state);
	};
	
	$.prompt.getCurrentState = function() {
		return $('.'+ $.prompt.currentPrefix +'_state:visible');
	};
	
	$.prompt.getCurrentStateName = function() {
		var stateid = $.prompt.getCurrentState().attr('id');
		
		return stateid.replace($.prompt.currentPrefix +'_state_','');
	};
	
	$.prompt.goToState = function(state, callback) {
		$('.'+ $.prompt.currentPrefix +'_state').slideUp('slow');
		$('#'+ $.prompt.currentPrefix +'_state_'+ state).slideDown('slow',function(){
			$(this).find('.'+ $.prompt.currentPrefix +'defaultbutton').focus();
			if (typeof callback == 'function')
				callback();
		});
	};
	
	$.prompt.nextState = function(callback) {
		var $next = $('.'+ $.prompt.currentPrefix +'_state:visible').next();

		$('.'+ $.prompt.currentPrefix +'_state').slideUp('slow');
		
		$next.slideDown('slow',function(){
			$next.find('.'+ $.prompt.currentPrefix +'defaultbutton').focus();
			if (typeof callback == 'function')
				callback();
		});
	};
	
	$.prompt.prevState = function(callback) {
		var $next = $('.'+ $.prompt.currentPrefix +'_state:visible').prev();

		$('.'+ $.prompt.currentPrefix +'_state').slideUp('slow');
		
		$next.slideDown('slow',function(){
			$next.find('.'+ $.prompt.currentPrefix +'defaultbutton').focus();
			if (typeof callback == 'function')
				callback();
		});
	};
	
	$.prompt.close = function() {
		$('#'+ $.prompt.currentPrefix +'box').fadeOut('fast',function(){
        		$(this).remove();
		});
	};
	
	$.fn.extend({ 
		prompt: function(options){
			if(options == undefined) 
				options = {};
			if(options.withDataAndEvents == undefined)
				options.withDataAndEvents = false;
			
			$.prompt($(this).clone(options.withDataAndEvents).html(),options);
		},
		promptDropIn: function(speed, callback){ 
			var $t = $(this); 
			
			if($t.css("display") == "none"){ 
				var eltop = $t.css('top');
				$t.css({ top: $(window).scrollTop(), display: 'block' }).animate({ top: eltop },speed,'swing',callback); 
			}
		}
		
	});
})(jQuery);
