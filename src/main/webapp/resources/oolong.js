// 分析URL，控制nav_top和nav_left
function controlNav()
{
	// 分析URL，控制nav_top和nav_left
	var path = location.pathname;
	
	controlAdvNav(path);
	controlResourceNav(path);
	controlAdminNav(path);
}	

function controlAdvNav(path)
{
	if((path.indexOf('/activities/listPage')>=0) || (path.indexOf('/activities/editPage')>=0))
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_adv").addClass("active");
		
		// 左侧导航panel设置
		$(".panel-group .panel").addClass("collapse");
		$("#panelActivity").removeClass("collapse");
		$("#panelAdv").removeClass("collapse");
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelActivity .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");
		$("#leftNav_viewActi").addClass("active");
		
	}
	else if(path.indexOf('/activities/createPage')>=0)
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_adv").addClass("active");
		
		// 左侧导航panel设置
		$(".panel-group .panel").addClass("collapse");
		$("#panelActivity").removeClass("collapse");
		$("#panelAdv").removeClass("collapse");
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelActivity .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");
		$("#leftNav_newActi").addClass("active");
	}
	if((path.indexOf('/advs/listPage')>=0) || (path.indexOf('/advs/editPage')>=0)
										|| (path.indexOf('/advs/approvalPage')>=0))
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_adv").addClass("active");
		
		// 左侧导航panel设置
		$(".panel-group .panel").addClass("collapse");
		$("#panelActivity").removeClass("collapse");
		$("#panelAdv").removeClass("collapse");
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelAdv .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");
		$("#leftNav_viewAdv").addClass("active");
		
	}
	else if(path.indexOf('/advs/createPage')>=0)
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_adv").addClass("active");
		
		// 左侧导航panel设置
		$(".panel-group .panel").addClass("collapse");
		$("#panelActivity").removeClass("collapse");
		$("#panelAdv").removeClass("collapse");
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelAdv .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");
		$("#leftNav_newAdv").addClass("active");
	}
}

function controlResourceNav(path)
{
	// 推送间隔配置
	if(path.indexOf('/globalConfig/editPage') >= 0)
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_resource").addClass("active");
		
		// 左侧导航panel设置
		$(".panel-group .panel").addClass("collapse");
		$("#panelGlobal").removeClass("collapse");
		$("#panelArea").removeClass("collapse");
		$("#panelWebsite").removeClass("collapse");	
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelGlobal .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");	
		$("#leftNav_configGlobal").addClass("active");
	}
	// 免推送配置
	else if(path.indexOf('/freePushUrls')>0)
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_resource").addClass("active");
		
		// 左侧导航panel设置
		$(".panel-group .panel").addClass("collapse");
		$("#panelGlobal").removeClass("collapse");
		$("#panelArea").removeClass("collapse");
		$("#panelWebsite").removeClass("collapse");	
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelGlobal .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");	
		$("#leftNav_freePushWebsite").addClass("active");
	}
	// 区域管理
	else if(path.indexOf('/areas/createPage')>=0)
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_resource").addClass("active");
		
		// 左侧导航panel设置
		$(".panel-group .panel").addClass("collapse");
		$("#panelGlobal").removeClass("collapse");
		$("#panelArea").removeClass("collapse");
		$("#panelWebsite").removeClass("collapse");	
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelArea .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");	
		$("#leftNav_newArea").addClass("active");
	}
	else if((path.indexOf('/areas/listPage')>=0) 
			|| (path.indexOf('/areas/editPage')>=0)
			|| (path.indexOf('/areas')>=0 && path.indexOf('listPage')>=0))
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_resource").addClass("active");
		
		// 左侧导航panel设置
		$(".panel-group .panel").addClass("collapse");
		$("#panelGlobal").removeClass("collapse");
		$("#panelArea").removeClass("collapse");
		$("#panelWebsite").removeClass("collapse");		
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelArea .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");	
		$("#leftNav_viewArea").addClass("active");
	}
	// 关联网站
	else if(path.indexOf('/websites/createPage')>=0)
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_resource").addClass("active");
		
		// 左侧导航panel设置
		$(".panel-group .panel").addClass("collapse");
		$("#panelGlobal").removeClass("collapse");
		$("#panelArea").removeClass("collapse");
		$("#panelWebsite").removeClass("collapse");	
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelWebsite .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");	
		$("#leftNav_newWebsite").addClass("active");
	}
	else if((path.indexOf('/websites/listPage')>=0) 
			|| (path.indexOf('/websites/editPage')>=0)
			|| (path.indexOf('/websites')>=0 && path.indexOf('listPage')>=0))
	{	 
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_resource").addClass("active");
		
		// 左侧导航panel设置
		$(".panel-group .panel").addClass("collapse");
		$("#panelGlobal").removeClass("collapse");
		$("#panelArea").removeClass("collapse");
		$("#panelWebsite").removeClass("collapse");		
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelWebsite .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");	
		$("#leftNav_viewWebsite").addClass("active");
	}
}

function controlAdminNav(path)
{
	// 推送间隔配置
	if(path.indexOf('/admin') >= 0)
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_admin").addClass("active");
		
		// 左侧导航panel设置
		$(".panel-group .panel").addClass("collapse");
		$("#panelAdmin").removeClass("collapse");
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelAdmin .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");	
		$("#leftNav_viewUser").addClass("active");
	}
}

// 序列化form对象 
function serializeObject(a){  
    var o = {};  
    $.each(a, function() {  
        if (o[this.name] !== undefined) {  
            if (!o[this.name].push) {  
                o[this.name] = [o[this.name]];  
            }  
            o[this.name].push(this.value || '');  
        } else {  
            o[this.name] = this.value || '';  
        }  
    });  
    return o;  
}

// 关闭成功、失败提示
function closeAlertBar()
{
	$(".alert-success").css("display","none");
	$(".alert-warning").css("display","none");
}

// 提取错误信息
function getErrorMessage(error)
{
	var response = error.responseJSON;
	var errorText = response.code + " - " + response.message;
	return errorText;
}

// 格式化秒级时间
function formatTimeSecond(updateTime)
{
	var updateTime = new Date(updateTime*1000);
	
	var updateTimeText = updateTime.getFullYear() + "年";
	updateTimeText += (updateTime.getMonth()+1) +"月";
	updateTimeText += updateTime.getDate()+"日";
	updateTimeText += updateTime.getHours()+"时";
	updateTimeText += updateTime.getMinutes()+"分";
	updateTimeText += updateTime.getSeconds()+"秒";
	
	return updateTimeText;
}

// 同步Get
function syncGet(url,callback)
{
	$.ajax({
		async	:	false,
	  	url		:	url,
	  	dataType: 	"json",	  	
	  	success	: 	callback
	});
}