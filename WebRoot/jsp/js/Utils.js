/**
 * 对表单的提交进行校验，如果合格则表单正常提交，否则提示错误信息
 * 
 * @param form
 */
function utils_beforeSubmit(form) {
	alert(11);
	alert("#" + form + " input");
	var allow = "";
	$("#" + form + " input").each(function(index, data) {
		alert(11);
		if (this.value == null || this.value == '') {
			allow = false;
			allow = $($(this).parent()).prev().html() + " 未填写！";
			$(this).focus();
			return false;
		}
		return true;
	});
	if ("" != allow) {
		alert(allow);
	} else {
		var form = document.getElementById(form);
		form.submit();
	}
}
/**
 * 重置表单所有信息
 * 
 * @param form
 */
function formReset(form) {
	var form = document.getElementById(form);
	form.reset();
}