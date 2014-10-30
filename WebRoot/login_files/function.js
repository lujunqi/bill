
/**
 * 功能说明：页面查询  (异步查询)
 * @param url            查询请求url
 * @param searchFormId   查询框form 的ID
 * @param ignorePage     是否忽略分页栏参数(true,false)
 * @return
 */
function _after(){};
function queryAjaxFun(url,searchFormId,ignorePage,afterhaddle)
{
	var params = 'queryFlag=true';
	var searchParam = getFormData(searchFormId);
	if(searchParam!=null && searchParam!='')
	{
		params+='&'+searchParam;
	}
	//aipgUtil.popupDiv();
	  $.ajax({
          type:"POST",
          url:url,
          cache: false,
          data:params,//形如"queryString=value"格式数据
          dateType:'text',
          success:function(data){//查询操作成功时返回数据
		  	 aipgUtil.hideDiv();
		      var reg=/^\{code:1,message:\'[\s\S]*\'\}$/;
		      if(reg.test(data))
		      {
			   	  var json=eval('('+data+')');
		    	  if(json.code==0)
		    	  {
		    		  $('#content').html(data);
		    	  }else{
		    		  alert(json.message);   
		    	  }
		      }else{
		    	  var begin=data.indexOf('<body>');
		    	  var end=data.indexOf('</body>');
		    	  if(begin>=0 && end>begin)
		    	  {
		    		  data=data.substring(begin+6,end);
			    	  $('#content').html(data);
		    	  }else{
		    		  alert('返回数据无法解析');
		    	  }
		      }
		      try{
		    	  fillPageParam();
		      }
		      catch(e){
		      }
		      try{
		    	  if(afterhaddle){
		    		  _after = afterhaddle;
		    		  _after();
		    	  }
		      }catch(e){}
          },
          error: function(data)
          {   
        	  aipgUtil.hideDiv();
              alert('服务器返回错误');   
          }
      }); 
}

function fillPageParam(){
	var pageparamdiv = $("#page_param_div");
	var pageCount = pageparamdiv.find("input[id='pageCount']");
	if(pageCount[0]){
		$("#pageparam_pageCount")[0].value=pageCount.val();
		$("#pageparam_pageCount_span").html(pageCount.val());
	}
	var itemCount = pageparamdiv.find("input[id='itemCount']");
	if(itemCount[0]){
		$("#pageparam_itemCount_span").html(itemCount.val());
	}
	var pageSize = pageparamdiv.find("input[id='pageSize']");
	if(pageSize[0]){
		$("#pageparam_pageSize")[0].value=pageSize.val();
	}
	var pageIndex = pageparamdiv.find("input[id='pageIndex']");
	if(pageIndex[0]){
		$("#pageparam_pageIndex")[0].value=pageIndex.val();
	}
}

/**
 * 功能说明：删除列表某行记录
 * @param url  删除请求url
 * @param param   传递参数
 * @param searchForm  查询框form ID
 * @param confTips   删除前提示信息，如果为null或''则不弹出提示窗口
 * @param successTips  删除成功后提示信息,为null或''时则删除成功，不会有提示
 * @return
 */
function deleteAjaxFun(url,param,refreshUrl,searchForm,confTips,successTips)
{
	if(confTips!=null && confTips!='')
	{
		if(!confirm(confTips)){
			return;
		}
	}
   
	$.post(url,param,function(data){
		try{
			data = eval('('+data+')');
			if(data.code=='1'){
				alert(data.message);
			}else{
				if(refreshUrl!=null)
				{
					queryAjaxFun(refreshUrl,searchForm,false);
				}
				if(successTips!=null && successTips!='')
				{
					alert(successTips);
				}
			}
		}catch(e){
			alert("删除失败");
		}
	});
}

/*
 * 获取form里面的参数，并对其进行封装后台可处理的格式
 * return :是一个id:1|name:mo格式字符串
 */
function queryFormData(formId)
{
	var queryString = $('#'+formId).formSerialize(); 
       var params='';
       var arr=queryString.split('&');
       for(var i=0,len=arr.length;i<len;++i)
       {
	       var sub_arr=arr[i].split('=');
	       if(sub_arr[1]!=null && sub_arr[1]!='')
	       {
	          params += sub_arr[0]+":"+sub_arr[1]+"|";
	       }
       }
       if(params!='' && params.length>1)
       {
    	   params=params.substring(0,params.length-1); 
       }
    return params;
}

function getSelectedValue(selectId){
	var obj = document.getElementById(selectId);
	var index = obj.selectedIndex;
	var value = obj.options[index].value;
	return value;
}
/*
 * 获取form里面的参数，并对其进行封装后台可处理的格式
 * return :是一个id=1&name=mo格式字符串
 */
function getFormData(formId)
{
	return $('#'+formId).formSerialize(); 
}
