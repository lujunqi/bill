//扩展String类功能
String.prototype.trim=function() {return this.replace(/(^\s*)|(\s*$)/g,"");};
String.prototype.ltrim = function(){return this.replace(/(^\s*)/g, "");};
String.prototype.rtrim = function(){return this.replace(/(\s*$)/g, "");};

Array.prototype.del=function(n) {
	  if(n<0)
	    return this;
	  else{
	 	  var result = this.slice(0,n).concat(this.slice(n+1,this.length));
	 	  return result;
	  }
};

String.prototype.gblen = function() {   
  var len = 0;   
  for (var i=0; i<this.length; i++) {   
      if (this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {   
           len += 2;   
       } else {   
           len ++;   
       }   
   }   
  return len;   
};

/**
* 页面null字符转换空字符
*/
JSUtil.nullToEmpty = function (param) {
    param = param.trim();
    if(param==null||param=="null") return "";
    return param;
};

/**
* 判断输入数据是否为整数
*/
JSUtil.isInt = function (param) {
    param = param.trim();
    if(isNaN(param) || (param.indexOf(".") != -1)) return false;
    return true;
};

/**
* 判断是否为瑞年
*/
JSUtil.isLeapYear = function (year) {
    if(!isPositiveInt(year)) return false;
    var intYear = parseInt(year);
    if((intYear % 4) == 0) {
        if((intYear % 100) == 0) {
            if((intYear % 400) ==0) {
                return true;
            }
        } else {
            return true;
        }
    }
    return false;
};

/**
* 检查日期合法性:合格返回日期;反之返回false
*/
JSUtil.isDate = function (checkedStr) {
   if(!/\d{4}(\.|\/|\-)\d{1,2}(\.|\/|\-)\d{1,2}/.test(str)){
    return false;
  }
  var r = str.match(/\d{1,4}/g);
  if(r===null){return false;};
  var d= new Date(r[0], r[1]-1, r[2]);
  return (d.getFullYear()==r[0]&&(d.getMonth()+1)==r[1]&&d.getDate()==r[2]);
};

/**
* 打开新窗口
*/
JSUtil.openWindow = function (theURL,winName,width,height) {
    try {
        var top = (screen.height - height)/3;
        var left = (screen.width - width)/2;

        var newWin = window.open(theURL,winName,"width=" + width + ",height=" + height + ",top=" + top + ",left=" + left + ",scrollbars");
        newWin.focus();
    }
    catch(e) {}
};

/**
* 获取系统时间: yyyy-MM-dd
*/
JSUtil.getSysDate = function (){
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth()+1;
		if(month < 10) month = "0" + month;
    var day = date.getDate();
		if(day < 10) day = "0" + day;
    	return year + "-" + month + "-" + day;
};

/**
* 获取系统时间: yyyy-MM-dd hh:mm:ss
*/
JSUtil.getSysTime = function (){
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth()+1;
		if(month < 10) month = "0" + month;
    var day = date.getDate();
		if(day < 10) day = "0" + day;
    var hour = date.getHours();
		if(hour < 10) hour = "0" + hour;
    var minute = date.getMinutes();
		if(minute < 10) minute = "0" + minute;
	var second = date.getSeconds();
		if(second < 10) second = "0" + second;
		return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
};

/**
* 获取系统时间: yyyy-MM-dd hh:mm:ss
*/
JSUtil.getSysTimestamp = function (){
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth()+1;
		if(month < 10) month = "0" + month;
    var day = date.getDate();
		if(day < 10) day = "0" + day;
    var hour = date.getHours();
		if(hour < 10) hour = "0" + hour;
    var minute = date.getMinutes();
		if(minute < 10) minute = "0" + minute;
	var second = date.getSeconds();
		if(second < 10) second = "0" + second;
	var millis = date.getMilliseconds();
		return year + "" + month + "" + day + "" + hour + "" + minute + "" + second + "" + millis;
};

/**
* 判断是否有汉字
*/
JSUtil.hasChinese = function (param) {
	return (/[^\x00-\xff]/g.test(param));
};

/**
 * 金额校验
 * @return
 */
function NumericOnly() {
	// 数组判断	大键盘 + backspace + tab + 小键盘
	if((window.event.keyCode >= 48 && window.event.keyCode <= 57) || (window.event.keyCode == 8) || (window.event.keyCode == 9)
      || (window.event.keyCode >= 96 && window.event.keyCode <= 105) || (window.event.keyCode == 110) || (window.event.keyCode == 190)) {
		// 返回响应键盘的值
		window.event.returnValue = true;
	} else if (event.keyCode == 13) {// 回车
        event.keyCode = 9;
        event.returnValue = true;
    } else
		window.event.returnValue = false;
};

JSUtil.sortMe = function (oSel) {
	var selvalue = oSel.value;
	var ln = oSel.options.length;
	var arr = new Array(); // 这是关键部分
	var arrvalue = new Array(); 
	var arrtext = new Array( );
	//将select中的所有option的value值将保存在Array中
	for (var p = 0; p < ln; p++) {
		//如果需要对option中的文本排序，可以改为arr[p] = oSel.options[p].text;
		arr[p] = oSel.options[p].text;
		arrvalue[p] = oSel.options[p].value;
		arrtext[p] = oSel.options[p].text;
	}	

	arr.sort(); // 开始排序
	//清空Select中全部Option
	while (ln--) {
		oSel.options.remove(0) ;
	}
	oSel.add(new Option("全部",""));
	// 将排序后的数组重新添加到Select中
	for (var p = 0; p<arr.length; p++) {
		for (var j=0; j<arrtext.length; j++) {
			if (arrtext[j]==arr[p]) {
				oSel.add(new Option(arr[p], arrvalue[j]));
			}
		}    	
	}
	if (selvalue != null) {
		for (var p = 0; p<oSel.options.length; p++) {
			if (selvalue==oSel.options[p].value) {
				oSel.options[p].selected = true;
				break;
			}
		}
	}
	else {
		oSel.options[0].selected = true;
	}
};

/**
 * 获取指定域的值
 */
JSUtil.getValue = function (id) {
	var obj = document.getElementById(id);
		   if (obj && obj != null)
		   {
			   if (obj.type == "text" || obj.type == "checkbox" || obj.type == "radio" || obj.type == "select-one" || obj.type == "button")
			   {
				   return obj.value;
			   }			   
		   }
	return "";
};

/**
 * 设置域值
 */
JSUtil.setValue = function (id, value) {
	var obj = document.getElementById(id);
		   if (obj && obj != null)
		   {
			   if (obj.type == "text" || obj.type == "checkbox" || obj.type == "radio" || obj.type == "select-one" || obj.type == "button")
			   {
				   obj.value=value;
			   }
		   }
};

/**
 * 过滤下拉框
 */
JSUtil.pkListByArray = function (pkObj, filter) {
	var len = pkObj.options.length;
		  if (!filter || filter == null || filter == "")
		  {
				return pkObj;
		  }
		// 删除历史数据
	var valArr = [];
	var showArr = [];
		for (var p = 0; p < len; p++) {
		//如果需要对option中的文本排序，可以改为arr[p] = oSel.options[p].text;
			arr[p] = pkObj.options[p].text;
			var temp = pkObj.options[p].value;
				  if (filter == temp.substring(0, 1)) //一个字符过滤
				  {
						valArr[p] = temp;
						showArr[p] = pkObj.options[p].text;
				  }
		}
		return JSUtil.pkListByArray(pkObj, valArr, showArr);
};

/**
 * 自定义下拉框
 */
JSUtil.pkListByArray = function (pkObj, valueArr, showArr) {
	var len = pkObj.options.length;
	// 删除历史数据
		while(len-- > 0) {
			pkObj.options.remove(0) ;
		}
	// 按最小数据装载
	var newLen = valueArr.length >= showArr.length ?  showArr.length :  valueArr.length;
		// 装入新数据
		for (var p = 0; p < newLen; p++) {
			pkObj.add(new Option(showArr[p], valueArr[p]));// <show, value>
		}
		return pkObj;
};

/**
 * 获取选中的下拉框的描述
 */
JSUtil.getListDesc = function (pkObj) {
	var selectedDesc = "";
		  selectedDesc = pkObj.options[pkObj.selectedIndex].text;
    return selectedDesc;
};

//校验是否为正浮点数
JSUtil.isPlusFloat=function(str){
  var patrn=/^([+]?)\d*\.\d+$/;
  return patrn.test(str);
};

// 校验是否为空(先删除二边空格再验证)
JSUtil.isNull = function (str) {
	if (!str) {// catch undefined
		return true;
	}
	 if (null == str ||  "" == str.trim()) {
	  return true;
	 } else {
	  return false;
	 }
};

/**
 * 格式化小数
 */
JSUtil.formatCeil=function(d, scale) {
	var addZero = "";
	// 判断是否是数据
//	d = d.trim();
	if (isNaN(d))
	{
		return 0.00;
	}
	var s = 2;
	if (scale)
	{
		s = scale;
	}
	// 判断整数
	var reg  = /^([+]?)\d*$/;
		if(reg.test(d)) {
			for (var m = 0; m < s; m++)
			{
				addZero += "0";
			}
			return d + "." + addZero;
		}
		// 非整数
		reg=eval('/^([+]?)\d*\.\d{' + s + '}$/');
		if(!reg.test(d)) {
			var digitPos = d.indexOf('.');
			var digitLen = d.length - digitPos - 1;// 减去小数点一位
				for (var m = 0; m < s - digitLen; m++)
				{
					addZero += "0";
				}
			return d.substring(0, digitPos + s + 1) + addZero;// 小数点也占一位
		}		
};
/**
 * 校验电话号码 020-88510768
 */
JSUtil.isTelPhone=function(str){
	if (JSUtil.isNull(str)) return true;
	var regArea=/^[0][1-9]{2,3}-[0-9]{5,8}$/;
	var regNoArea=/^[1-9]{1}[0-9]{5,8}$/; 
	    return regArea.test(str) || regNoArea.test(str);
};

/**
 * 校验手机号码 13/15/18
 */
JSUtil.isMobilePhone=function(str){
	if (JSUtil.isNull(str)) return true;
	var reg=/^[1][3,5,8][0-9]{9}$/; 
	    return reg.test(str);
};

//校验电邮地址
JSUtil.isEmail = function (str) {
	if (JSUtil.isNull(str)) return true;
	var patrn = /^[\w-]+@[\w-]+(\.[\w-]+)+$/;
	 	return patrn.test(str);
};

//校验邮编
JSUtil.isZipCode = function (str) {
	if (JSUtil.isNull(str)) return true;
	var patrn = /^\d{6}$/;
		return patrn.test(str);
};

/**
 * 检查密码安全等级
 * @return 低: L 中: M 高: H   非法: null
 */
JSUtil.checkPassword=function(password){
	var pswGrade = "L";
	// 密码小于六位或全为数字时提示有误
    if(password.length < 6){
    	alert("密码小于六位!");
    	pswGrade = null;
    } else {
    	var sameNum = true;
    	var ch = password.substr(0,1);
    	for (var m = 1; m < password.length; m += 1) {
    		if (ch != password.charAt(m)) {
    			sameNum = false;
    		}
    	}
    	if(sameNum){
        	alert("密码过于简单!");
        	pswGrade = null;
        } else {
        	var p1 = (password.search(/[a-zA-Z]/) != -1) ? 1 : 0;
    	    var p2 = (password.search(/[0-9]/) != -1) ? 1 : 0;
    	    var p3 = (password.search(/[^A-Za-z0-9_]/) != -1) ? 1 : 0;
    	    var result = p1 + p2 + p3;
	    	    if(result == 1){
	    	    	pswGrade = "低";
	    	    }else if(result == 2){
	    	    	pswGrade = "中";
	    	    }else if(result == 3){
	    	    	pswGrade = "高";
	    	    }
        }
    }
    return pswGrade;
};

JSUtil.limitNum = function(obj,point)
{
  var vl=obj.value;
  var reg = /[^0-9]/g;
  var nv=vl;
  if(point){
	  nv = vl.replace(/[^0-9.]/g,'');
	  var i = vl.indexOf(".");
	  if(i!=-1){
		  var j = vl.indexOf(".",i+1);
		  if(j!=-1){
			  nv = vl.replace(/[.]/g,"");
			  nv = nv.substring(0,i)+"."+nv.substring(i);
		  }
	  }
  }else{
	  nv = vl.replace(reg,'');
  }
  if(nv!=vl) obj.value=nv;
};

//导出Excel
JSUtil.exportExcel = function(tableid) {   
	var contents = "";
	if(typeof tableid=='object'&&typeof tableid.sort=='function'&&typeof tableid.length=='number'){
		for(var i=0;i<tableid.length;i++){
			var curTbl = document.getElementById(tableid[i]); 
			contents += curTbl.outerHTML;
		}
	}else{
		var curTbl = document.getElementById(tableid); 
		contents += curTbl.outerHTML; 
	}
	try{    
		window.clipboardData.setData("Text",contents);
		var ExApp = new ActiveXObject("Excel.Application");
		var ExWBk = ExApp.workbooks.add();
		var ExWSh = ExWBk.worksheets(1);
		ExApp.DisplayAlerts = false;
		ExApp.visible = true;
		ExWSh.Paste;
	}      
	catch(e){    
		alert(e.message);
		alert("您的电脑没有安装Microsoft Excel软件！");
		return false;
	}
};

JSUtil.isview = function(id){
	var parent = null;
	if(id){
		parent = $("#"+id);
	}else{
		parent = $(document);
	}
	parent.find("font[type=del]").each(function(i,v){
		$(v).remove();
	});
	
	parent.find("a[type=del]").each(function(i,v){
		$(v).remove();
	});
	parent.find("input").each(function(i,v){
		if($(v).attr("del")=='nodel'||$(v).attr("id")=='nohidden'){
			return;
		}
		var type = $(v).attr("type");
		if(type=='checkbox'||type=='radio'){
			if (v.nextSibling){
				var vn = v.nextSibling;
				if (!$(v).attr("checked"))
					$(vn).remove();
			}
			$(v).remove();
		}else if(type=='hidden'||type=='button'||type=='submit'){
			$(v).remove();
		}else if(type=='text'){
			if (v.nextSibling){
				var vn = v.nextSibling;
				if (vn.tagName && vn.tagName.toUpperCase() == "FONT")
					$(vn).remove();
			}
			$(v).replaceWith("<span>" + $(v).val() + "</span>");
		}
	});
	parent.find("textarea").each(function(i, v){
		if (v.value){
			var text = v.value.replace("\r\n", "<br/>");
			$(v).replaceWith("<span>" + text + "</span>");
		}
	});
	parent.find("select").each(function(i, v){
		if($(v).attr("del")!='nodel')
		{
			if (v.size && parseInt(v.size) > 1){
				//列表
				var str = [];
				for (var i=0; i<v.options.length; i++) {
					str.push(v.options[i].text);
				}
				$(v).replaceWith(
						"<span> " + str.join() + "</span>");
			} else {
				//下拉框
				if(v.selectedIndex==-1){
					$(v).remove();
				}else{
					var selval=v.options[v.selectedIndex].text;
					if(selval.indexOf('请选择')<0)
					{
						$(v).replaceWith("<span> " + v.options[v.selectedIndex].text + "</span>");
					}else{
						$(v).replaceWith("<span></span>");
					}
				}
			}
		}
	});
};

JSUtil.len = function(s) {
	 var l = 0;
	 var a = s.split("");
	 for (var i=0;i<a.length;i++) {
	  if (a[i].charCodeAt(0)<299) {
	   l++;
	  } else {
	   l+=2;
	  }
	 }
	 return l;
};

JSUtil.MD5 = function(sMessage) {
	function RotateLeft(lValue, iShiftBits) { return (lValue<<iShiftBits) | (lValue>>>(32-iShiftBits)); }
	function AddUnsigned(lX,lY) {
	var lX4,lY4,lX8,lY8,lResult;
	lX8 = (lX & 0x80000000);
	lY8 = (lY & 0x80000000);
	lX4 = (lX & 0x40000000);
	lY4 = (lY & 0x40000000);
	lResult = (lX & 0x3FFFFFFF)+(lY & 0x3FFFFFFF);
	if (lX4 & lY4) return (lResult ^ 0x80000000 ^ lX8 ^ lY8);
	if (lX4 | lY4) {
	if (lResult & 0x40000000) return (lResult ^ 0xC0000000 ^ lX8 ^ lY8);
	else return (lResult ^ 0x40000000 ^ lX8 ^ lY8);
	} else return (lResult ^ lX8 ^ lY8);
	}
	function F(x,y,z) { return (x & y) | ((~x) & z); }
	function G(x,y,z) { return (x & z) | (y & (~z)); }
	function H(x,y,z) { return (x ^ y ^ z); }
	function I(x,y,z) { return (y ^ (x | (~z))); }
	function FF(a,b,c,d,x,s,ac) {
	a = AddUnsigned(a, AddUnsigned(AddUnsigned(F(b, c, d), x), ac));
	return AddUnsigned(RotateLeft(a, s), b);
	}
	function GG(a,b,c,d,x,s,ac) {
	a = AddUnsigned(a, AddUnsigned(AddUnsigned(G(b, c, d), x), ac));
	return AddUnsigned(RotateLeft(a, s), b);
	}
	function HH(a,b,c,d,x,s,ac) {
	a = AddUnsigned(a, AddUnsigned(AddUnsigned(H(b, c, d), x), ac));
	return AddUnsigned(RotateLeft(a, s), b);
	}
	function II(a,b,c,d,x,s,ac) {
	a = AddUnsigned(a, AddUnsigned(AddUnsigned(I(b, c, d), x), ac));
	return AddUnsigned(RotateLeft(a, s), b);
	}
	function ConvertToWordArray(sMessage) {
	var lWordCount;
	var lMessageLength = sMessage.length;
	var lNumberOfWords_temp1=lMessageLength + 8;
	var lNumberOfWords_temp2=(lNumberOfWords_temp1-(lNumberOfWords_temp1 % 64))/64;
	var lNumberOfWords = (lNumberOfWords_temp2+1)*16;
	var lWordArray=Array(lNumberOfWords-1);
	var lBytePosition = 0;
	var lByteCount = 0;
	while ( lByteCount < lMessageLength ) {
	lWordCount = (lByteCount-(lByteCount % 4))/4;
	lBytePosition = (lByteCount % 4)*8;
	lWordArray[lWordCount] = (lWordArray[lWordCount] | (sMessage.charCodeAt(lByteCount)<<lBytePosition));
	lByteCount++;
	}
	lWordCount = (lByteCount-(lByteCount % 4))/4;
	lBytePosition = (lByteCount % 4)*8;
	lWordArray[lWordCount] = lWordArray[lWordCount] | (0x80<<lBytePosition);
	lWordArray[lNumberOfWords-2] = lMessageLength<<3;
	lWordArray[lNumberOfWords-1] = lMessageLength>>>29;
	return lWordArray;
	}
	function WordToHex(lValue) {
	var WordToHexValue="",WordToHexValue_temp="",lByte,lCount;
	for (lCount = 0;lCount<=3;lCount++) {
	lByte = (lValue>>>(lCount*8)) & 255;
	WordToHexValue_temp = "0" + lByte.toString(16);
	WordToHexValue = WordToHexValue + WordToHexValue_temp.substr(WordToHexValue_temp.length-2,2);
	}
	return WordToHexValue;
	}
	var x=Array();
	var k,AA,BB,CC,DD,a,b,c,d;
	var S11=7, S12=12, S13=17, S14=22;
	var S21=5, S22=9 , S23=14, S24=20;
	var S31=4, S32=11, S33=16, S34=23;
	var S41=6, S42=10, S43=15, S44=21;
	// Steps 1 and 2. Append padding bits and length and convert to words
	x = ConvertToWordArray(sMessage);
	// Step 3. Initialise
	a = 0x67452301; b = 0xEFCDAB89; c = 0x98BADCFE; d = 0x10325476;
	// Step 4. Process the message in 16-word blocks
	for (k=0;k<x.length;k+=16) {
	AA=a; BB=b; CC=c; DD=d;
	a=FF(a,b,c,d,x[k+0], S11,0xD76AA478);
	d=FF(d,a,b,c,x[k+1], S12,0xE8C7B756);
	c=FF(c,d,a,b,x[k+2], S13,0x242070DB);
	b=FF(b,c,d,a,x[k+3], S14,0xC1BDCEEE);
	a=FF(a,b,c,d,x[k+4], S11,0xF57C0FAF);
	d=FF(d,a,b,c,x[k+5], S12,0x4787C62A);
	c=FF(c,d,a,b,x[k+6], S13,0xA8304613);
	b=FF(b,c,d,a,x[k+7], S14,0xFD469501);
	a=FF(a,b,c,d,x[k+8], S11,0x698098D8);
	d=FF(d,a,b,c,x[k+9], S12,0x8B44F7AF);
	c=FF(c,d,a,b,x[k+10],S13,0xFFFF5BB1);
	b=FF(b,c,d,a,x[k+11],S14,0x895CD7BE);
	a=FF(a,b,c,d,x[k+12],S11,0x6B901122);
	d=FF(d,a,b,c,x[k+13],S12,0xFD987193);
	c=FF(c,d,a,b,x[k+14],S13,0xA679438E);
	b=FF(b,c,d,a,x[k+15],S14,0x49B40821);
	a=GG(a,b,c,d,x[k+1], S21,0xF61E2562);
	d=GG(d,a,b,c,x[k+6], S22,0xC040B340);
	c=GG(c,d,a,b,x[k+11],S23,0x265E5A51);
	b=GG(b,c,d,a,x[k+0], S24,0xE9B6C7AA);
	a=GG(a,b,c,d,x[k+5], S21,0xD62F105D);
	d=GG(d,a,b,c,x[k+10],S22,0x2441453);
	c=GG(c,d,a,b,x[k+15],S23,0xD8A1E681);
	b=GG(b,c,d,a,x[k+4], S24,0xE7D3FBC8);
	a=GG(a,b,c,d,x[k+9], S21,0x21E1CDE6);
	d=GG(d,a,b,c,x[k+14],S22,0xC33707D6);
	c=GG(c,d,a,b,x[k+3], S23,0xF4D50D87);
	b=GG(b,c,d,a,x[k+8], S24,0x455A14ED);
	a=GG(a,b,c,d,x[k+13],S21,0xA9E3E905);
	d=GG(d,a,b,c,x[k+2], S22,0xFCEFA3F8);
	c=GG(c,d,a,b,x[k+7], S23,0x676F02D9);
	b=GG(b,c,d,a,x[k+12],S24,0x8D2A4C8A);
	a=HH(a,b,c,d,x[k+5], S31,0xFFFA3942);
	d=HH(d,a,b,c,x[k+8], S32,0x8771F681);
	c=HH(c,d,a,b,x[k+11],S33,0x6D9D6122);
	b=HH(b,c,d,a,x[k+14],S34,0xFDE5380C);
	a=HH(a,b,c,d,x[k+1], S31,0xA4BEEA44);
	d=HH(d,a,b,c,x[k+4], S32,0x4BDECFA9);
	c=HH(c,d,a,b,x[k+7], S33,0xF6BB4B60);
	b=HH(b,c,d,a,x[k+10],S34,0xBEBFBC70);
	a=HH(a,b,c,d,x[k+13],S31,0x289B7EC6);
	d=HH(d,a,b,c,x[k+0], S32,0xEAA127FA);
	c=HH(c,d,a,b,x[k+3], S33,0xD4EF3085);
	b=HH(b,c,d,a,x[k+6], S34,0x4881D05);
	a=HH(a,b,c,d,x[k+9], S31,0xD9D4D039);
	d=HH(d,a,b,c,x[k+12],S32,0xE6DB99E5);
	c=HH(c,d,a,b,x[k+15],S33,0x1FA27CF8);
	b=HH(b,c,d,a,x[k+2], S34,0xC4AC5665);
	a=II(a,b,c,d,x[k+0], S41,0xF4292244);
	d=II(d,a,b,c,x[k+7], S42,0x432AFF97);
	c=II(c,d,a,b,x[k+14],S43,0xAB9423A7);
	b=II(b,c,d,a,x[k+5], S44,0xFC93A039);
	a=II(a,b,c,d,x[k+12],S41,0x655B59C3);
	d=II(d,a,b,c,x[k+3], S42,0x8F0CCC92);
	c=II(c,d,a,b,x[k+10],S43,0xFFEFF47D);
	b=II(b,c,d,a,x[k+1], S44,0x85845DD1);
	a=II(a,b,c,d,x[k+8], S41,0x6FA87E4F);
	d=II(d,a,b,c,x[k+15],S42,0xFE2CE6E0);
	c=II(c,d,a,b,x[k+6], S43,0xA3014314);
	b=II(b,c,d,a,x[k+13],S44,0x4E0811A1);
	a=II(a,b,c,d,x[k+4], S41,0xF7537E82);
	d=II(d,a,b,c,x[k+11],S42,0xBD3AF235);
	c=II(c,d,a,b,x[k+2], S43,0x2AD7D2BB);
	b=II(b,c,d,a,x[k+9], S44,0xEB86D391);
	a=AddUnsigned(a,AA); b=AddUnsigned(b,BB); c=AddUnsigned(c,CC); d=AddUnsigned(d,DD);
	}
	var temp= WordToHex(a)+WordToHex(b)+WordToHex(c)+WordToHex(d);
	return temp.toLowerCase();
};

JSUtil.number_format = function(number, decimals, dec_point, thousands_sep) {
    // Formats a number with grouped thousands  
    // 
    // version: 1109.2015
    // discuss at: http://phpjs.org/functions/number_format    // +   original by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +     bugfix by: Michael White (http://getsprink.com)
    // +     bugfix by: Benjamin Lupton
    // +     bugfix by: Allan Jensen (http://www.winternet.no)    // +    revised by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
    // +     bugfix by: Howard Yeend
    // +    revised by: Luke Smith (http://lucassmith.name)
    // +     bugfix by: Diogo Resende
    // +     bugfix by: Rival    // +      input by: Kheang Hok Chin (http://www.distantia.ca/)
    // +   improved by: davook
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // +      input by: Jay Klehr
    // +   improved by: Brett Zamir (http://brett-zamir.me)    // +      input by: Amir Habibi (http://www.residence-mixte.com/)
    // +     bugfix by: Brett Zamir (http://brett-zamir.me)
    // +   improved by: Theriault
    // +      input by: Amirouche
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)    // *     example 1: number_format(1234.56);
    // *     returns 1: '1,235'
    // *     example 2: number_format(1234.56, 2, ',', ' ');
    // *     returns 2: '1 234,56'
    // *     example 3: number_format(1234.5678, 2, '.', '');    // *     returns 3: '1234.57'
    // *     example 4: number_format(67, 2, ',', '.');
    // *     returns 4: '67,00'
    // *     example 5: number_format(1000);
    // *     returns 5: '1,000'    // *     example 6: number_format(67.311, 2);
    // *     returns 6: '67.31'
    // *     example 7: number_format(1000.55, 1);
    // *     returns 7: '1,000.6'
    // *     example 8: number_format(67000, 5, ',', '.');    // *     returns 8: '67.000,00000'
    // *     example 9: number_format(0.9, 0);
    // *     returns 9: '1'
    // *    example 10: number_format('1.20', 2);
    // *    returns 10: '1.20'    // *    example 11: number_format('1.20', 4);
    // *    returns 11: '1.2000'
    // *    example 12: number_format('1.2000', 3);
    // *    returns 12: '1.200'
    // *    example 13: number_format('1 000,50', 2, '.', ' ');    // *    returns 13: '100 050.00'
    // Strip all characters but numerical ones.
    number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
    var n = !isFinite(+number) ? 0 : +number,
        prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),        sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
        dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
        s = '',
        toFixedFix = function (n, prec) {
            var k = Math.pow(10, prec);            return '' + Math.round(n * k) / k;
        };
    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3) {        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec) {
        s[1] = s[1] || '';
        s[1] += new Array(prec - s[1].length + 1).join('0');    }
    return s.join(dec);
};

//定义一个可静态调用方法的js类
function JSUtil() { };
