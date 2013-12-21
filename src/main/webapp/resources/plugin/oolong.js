// 分析URL，控制nav_top和nav_left
function controlNav()
{
	// 分析URL，控制nav_top和nav_left
	var path = location.pathname;
	controlAdvNav(path);
	controlResourceNav(path);
	
}	

function controlAdvNav(path)
{
	if((path.indexOf('/activities/listPage')>=0) || (path.indexOf('/activities/editPage')>=0))
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_adv").addClass("active");
		
		// 左侧导航panel设置
		$("#panelActivity").removeClass("collapse");
		$("#panelAdv").removeClass("collapse");
		$("#panelArea").addClass("collapse");
		$("#panelWebsite").addClass("collapse");
		
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
		$("#panelActivity").removeClass("collapse");
		$("#panelAdv").removeClass("collapse");
		$("#panelArea").addClass("collapse");
		$("#panelWebsite").addClass("collapse");
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelActivity .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");
		$("#leftNav_newActi").addClass("active");
	}
	else if(path.indexOf('/advs/createPage')>=0)
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_adv").addClass("active");
		
		// 左侧导航panel设置
		$("#panelActivity").removeClass("collapse");
		$("#panelAdv").removeClass("collapse");
		$("#panelArea").addClass("collapse");
		$("#panelWebsite").addClass("collapse");
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelAdv .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");
		$("#leftNav_newAdv").addClass("active");
	}
}

function controlResourceNav(path)
{
	if(path.indexOf('/websites/createPage')>=0)
	{
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_resource").addClass("active");
		
		// 左侧导航panel设置
		$("#panelActivity").addClass("collapse");
		$("#panelAdv").addClass("collapse");
		$("#panelArea").removeClass("collapse");
		$("#panelWebsite").removeClass("collapse");	
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelWebsite .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");	
		$("#leftNav_newWebsite").addClass("active");
	}
	else if((path.indexOf('/websites/listPage')>=0) 
			|| (path.indexOf('/websites/editPage')>=0)
			|| (path.indexOf('/websites')>=0 && path.indexOf('listUrl')>=0))
	{	 
		// 顶部导航设置
		$(".navbar-fixed-top .navbar-nav li").removeClass("active");
		$("#topNav_resource").addClass("active");
		
		// 左侧导航panel设置
		$("#panelActivity").addClass("collapse");
		$("#panelAdv").addClass("collapse");
		$("#panelArea").removeClass("collapse");
		$("#panelWebsite").removeClass("collapse");	
		
		$(".panel-group .panel-collapse").removeClass("in");
		$("#panelWebsite .panel-collapse").addClass("in");
		
		$(".panel-group .panel-collapse li").removeClass("active");	
		$("#leftNav_viewWebsite").addClass("active");
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