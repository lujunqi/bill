var ctx;
var interval;
function getCookie(name) {
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	if(arr=document.cookie.match(reg)) 
		return unescape(arr[2]);
	else 
		return null;
}
function setCookie(name,value)
{
    var Days = 365;
    var exp  = new Date();
        exp.setTime(exp.getTime() + Days*24*60*60);
        document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

function get(url) {
	request(url, getResult, null, "GET", false);
}

function getResult(value) {
	pay(value);
}

function pay(data) {
	$("#tabs-pay").html(data);
	loadScripts(data);
}

function loadScripts(text) {
	var match = new RegExp('(?:<script.*?>)((\n|.)*?)(?:<\/script>)', 'im'); 
	var scripts  = text.match(match); 
	if(scripts && scripts.length){
		for (var i = 0; i < scripts.length; i++){ 
			if(scripts[i] && scripts[i].match(match) && scripts[i].match(match)[1]){
		    	eval(scripts[i].match(match)[1]); 
		    }
		}   
	}
}

function replaceString(src, oldStr, newStr){
   var r, re;
   re = eval("/" + oldStr + "/g");
   r = src.replace(re, newStr);
   return(r);
}

function wrapUrl(url) {
	var result = url;
	var index = url.indexOf("?");
	if (index > 0) {
		result = result + "&date=" + new Date();
	} else {
		result = result + "?date=" + new Date();
	}
	return result;
}

function wrapFormData(formId) {
	var formNode = document.forms[formId];
	if ((!formNode) || (!formNode.tagName) || (!formNode.tagName.toLowerCase() == "form")) {
		return null;
	}
	var values = [];
	var len = formNode.elements.length;
	for (var i = 0; i < len; i++) {
		var elm = formNode.elements[i];
		if (!elm || elm.tagName.toLowerCase() == "fieldset" || !formFilter(elm)) {
			continue;
		}
		var name = encode(elm.name);
		var type = elm.type.toLowerCase();
		if (type == "select-multiple") {
			for (var j = 0; j < elm.options.length; j++) {
				if (elm.options[j].selected) {
					values.push(name + "=" + encode(elm.options[j].value));
				}
			}
		} else {
			if (type=="radio" || type=="checkbox") {
				if (elm.checked) {
					values.push(name + "=" + encode(elm.value));
				}
			} else {
				values.push(name + "=" + encode(elm.value));
			}
		}
	}
	var inputs = formNode.getElementsByTagName("input");
	var len = inputs.length;
	for (var i = 0; i < len; i++) {
		var input = inputs[i];
		if (input.type.toLowerCase() == "image" && input.form == formNode && formFilter(input)) {
			var name = encode(input.name);
			values.push(name + "=" + encode(input.value));
			//values.push(name + ".x=0");
			//values.push(name + ".y=0");
		}
	}
	var str = values.join("&") + "&";
	return str;
}

function request(url, onSuccess, paras, method, isAsync) {
	$.ajax({type:method,url:url,async:isAsync,data:paras,success:function(request){onSuccess(request);},error:function(e) {}});
}

function formSubmit(url, onSuccess, formId) {
	var paras = wrapFormData(formId);
	if (paras == null) return;
	request(url, onSuccess, paras, 'POST', false);
}

function formSubmitAsync() {
	var paras = wrapFormData(formId);
	if (paras == null) return;
	request(url, onSuccess, paras, 'POST', true);
}


function encode(str, multiPart) {
	return str;
	if (typeof(str) != 'string') return null;
	var mt = multiPart || false;
	return mt == true ? encodeURI(str) : encodeURIComponent(str);
}

function decode(str, multiPart) {
	if (typeof(str) != 'string') return null;
	var mt = multiPart || false;
	return mt == true ? decodeURI(str) : decodeURIComponent(str);	
}

function formFilter(node) {
	var type = (node.type || "").toLowerCase();
	if (type=="file" || type=="submit" || type=="image" || type=="reset" || type=="button") {
		return false;
	}
	return true;
}

function closeAutoComplete(){
    var formNumber = document.forms.length;
    for(var i=0;i<formNumber;i++)
        document.forms[i].autocomplete = "off";
}
