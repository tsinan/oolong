// 分析URL，控制nav_top和nav_left
function controlNav()
{
	// 分析URL，控制nav_top和nav_left
	var path = location.pathname;
	if((path.indexOf('/activities/listPage')>=0) || (path.indexOf('/activities/editPage')>=0))
	{
		$("#topNav_adv").addClass("active");
		$("#leftNav_viewActi").addClass("active");
		
		$("#collapseOne").addClass("in");
		$("#collapseTwo").removeClass("in");
	}
	else if(path.indexOf('/activities/createPage')>=0)
	{
		$("#topNav_adv").addClass("active");
		$("#leftNav_newActi").addClass("active");
		
		$("#collapseOne").addClass("in");
		$("#collapseTwo").removeClass("in");
	}
	else if(path.indexOf('/advs/createPage')>=0)
	{
		$("#topNav_adv").addClass("active");
		$("#leftNav_newAdv").addClass("active");
		
		$("#collapseOne").removeClass("in");
		$("#collapseTwo").addClass("in");
		
		
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