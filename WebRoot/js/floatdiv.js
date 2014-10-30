jQuery.fn.floatdiv=function(location){
	//ie6要隐藏纵向滚动条
	var isIE6=false;
	if($.browser.msie){
		
		$("html").css("overflow-x","auto");
		isIE6=true;
	};
	return this.each(function(){
		var loc;//层的绝对定位位置
		if(location==undefined || location.constructor == String){
			switch(location){
				case("rightbottom")://右下角
					loc={right:"0px",bottom:"0px"};
					break;
				case("leftbottom")://左下角
					loc={left:"0px",bottom:"0px"};
					break;	
				case("lefttop")://左上角
					loc={left:"0px",top:"0px"};
					break;
				case("righttop")://右上角
					loc={right:"0px",top:"0px"};
					break;
				case("middle")://居中
					var l=0;//居左
					var t=0;//居上
					var windowWidth,windowHeight;//窗口的高和宽
					//取得窗口的高和宽
					if (self.innerHeight) {
						windowWidth=self.innerWidth;
						windowHeight=self.innerHeight;
					}else if (document.documentElement&&document.documentElement.clientHeight) {
						windowWidth=document.documentElement.clientWidth;
						windowHeight=document.documentElement.clientHeight;
					} else if (document.body) {
						windowWidth=document.body.clientWidth;
						windowHeight=document.body.clientHeight;
					}
					l=windowWidth/2-$(this).width()/2;
					t=windowHeight/2-$(this).height()/2;
					loc={left:l+"px",top:t+"px"};
					break;
				default://默认为右下角
					loc={right:"0px",bottom:"0px"};
					break;
			}
		}else{
			loc=location;
		}	    
		$(this).css("z-index","9999").css(loc).css("position","fixed");
		if(isIE6){
			if(loc.right!=undefined){
				$(this).css("right","18px");
			}
			$(this).css("position","absolute");
		}
	});
};