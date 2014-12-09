function isIdCardNo(num){  
	num = num.toUpperCase(); 
	var len = num.length;
	var mobileReg15 =/^\d{15}$/;
	if(mobileReg15.test(num)){
		return true;
	}
	var mobileReg18 =/^\d{17}[\d,X]$/;
	if(mobileReg18.test(num)){
		return true;
	}
	return false;
}
function isOtherFont(val){
	
}