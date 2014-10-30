function getNoCachedUrl(url) {
	if (url.indexOf('?')>0) {
		url  = url + "&date=" + new Date();
	} else {
		url  = url + "?date=" + new Date();
	}
	return url;
}
function getMenu(url) {
	url = getNoCachedUrl(url);
	request(url, showMenuResult, null, "GET", false);
}

function getOperationPage(url) {
	url = getNoCachedUrl(url);
	request(url, showOperationPageResult, null, "GET", false);
}

function showMenuResult(value) {
	$("#menu_area").html(value);
	loadScripts(value);
}

function showOperationPageResult(value) {
	$("#operation_area").html(value);
	loadScripts(value);
}

function changePassword() {
	var url = ctx + "/merchant/modify-password/confirm.do";
	formSubmit(url, showOperationPageResult, "changePwdForm");
}

function areaSubmitForm(url, formName) {
    var url = ctx + url;
    formSubmit(url, showOperationPageResult, formName);
}