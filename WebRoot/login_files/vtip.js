/**
Vertigo Tip by www.vertigo-project.com
Requires jQuery
*/

$.fn.vtip = function(contentid,param) {    
    var content = $("#"+contentid).css("display","block");
    if(!content[0]){
    	return;
    }
    var closecallback = function(){};
    if(param.closecallback){
    	closecallback = param.closecallback;
    }
    var el = this;
    var pos = el.position();
    var pcontentid= "vtip_"+contentid;
    var marginLeft = param.marginLeft?param.marginLeft:0;
    var marginTop = param.marginTop?param.marginTop:0;
    var newcontent = null;
    newcontent = $("<p/>").attr("id",pcontentid).css("top", pos.top+el.height()+marginTop).css("left", pos.left+el.width()+marginLeft)
    						.css("position","absolute")
    						.css("padding","10px")
    						.css("backgroundColor","white")
    						.css("border","1px solid #a6c9e2")
    						.css("-moz-border-radius","5px")
    						.css("-webkit-border-radius","5px")
    						.css("zIndex","9999")
    						.css("display","none")
    						.append($("<img/>").attr("src",_getRootPath()+"/images/vtip_arrow.png").css("position","absolute").css("top","-10px").css("left","5px"))
    						.append(content)
    						.append("<br/>")
    						.append($("<div/>").css("textAlign","right").append($("<input type='button'/>").attr("class","button").val("知道了").click(function(){closecallback();newcontent.fadeOut("slow").remove();})));
    
    $('body').append(newcontent);
    newcontent.fadeIn("slow");
    //setTimeout(function(){newcontent.fadeOut("slow").remove();},10000);
};