<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="../include/include_head.jsp" %>	
</head>
<body>
	<!-- Wrap all page content here -->
    <div id="wrap" >
		<%@ include file="../include/include_nav_top.jsp" %>

      	<!-- Begin page content -->
      	<div class="container">
  		<div class="row">
			<div class="col-md-2" >
				<%@ include file="../include/include_nav_left.jsp" %>
  			</div>
  			
  			<!-- main area -->
  			<div class="col-md-8" style="border-width: 0px 1px;border-style:solid;border-color:#f1f1f1;">
				
		      	<div class="panel panel-default">
					<div class="panel-heading">推送间隔配置</div>
					<div class="panel-body">
					<form class="form-horizontal" novalidate>
		    		<fieldset>
						<div class="alert alert-success alert-dismissable" style="padding-top:5px;padding-bottom:5px;display:none">
						 	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						 	<strong></strong>
						</div>
						
						<div class="alert alert-warning alert-dismissable" style="padding-top:5px;padding-bottom:5px;display:none">
						 	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						 	<strong></strong>
						</div>
						
						<div class="form-group">		<!-- 推送间隔 -->
							<label class="control-label col-sm-3"  >最短间隔时间：</label>
							<div class="col-sm-6 controls ">
								<input id="pushInterval" name="pushInterval" type="number"  
		    						min="1" max="60" class="form-control input-sm"> 
		    					<p class="help-block">单位：分钟</p>
		  					</div>
						</div>
						
						<div class="form-group">		<!-- 每天推送次数 -->
							<label class="control-label col-sm-3">推送次数上限（每天）：</label>
							<div class="col-sm-6 controls">
								<input id="pushTimesPerDay" name="pushTimesPerDay" type="number"   
		    						min="1" max="1440" class="form-control input-sm" >
		    					
		    					<input id="noLimitPushTimes" name="noLimitPushTimes" type="checkbox" 
		    						onclick="return switchPushTime();" value="true" > 
		    					<font style="font-size:12px;margin-left:5px">不限制</font>
		    					
		  					</div>
						</div>
						<div class="form-group">		<!-- 按钮 -->
							<div class="col-sm-3">
		  					</div>
							<div class="col-sm-6">
								<button class="btn btn-primary" type="submit">保存为新配置</button>&nbsp;
								<button class="btn btn-warning" type="button" 
										id="resetToDefaultButton">恢复默认配置</button>
							</div>
						</div>
					</fieldset>
					</form>				
					</div><!-- end of panel-body -->
				</div><!-- end of panel -->
				
  			</div><!-- end of main area -->
  		
  			<div class="col-md-2" ></div>
  		</div>
  	</div>
	</div><!-- end of Wrap -->
  	
  	<%@ include file="../include/include_bottom.jsp" %>
		
<%@ include file="../include/include_js.jsp" %>
<script type="text/javascript" src="resources/plugin/jqBootstrapValidation.js"></script>
<script type="text/javascript" src="resources/plugin/handlebars-1.0.rc.1.js"></script>
<script type="text/javascript" src="resources/plugin/simplePagingGrid-0.6.0.0.js"></script>
<script>

$(function (){ 
	// 分析URL，控制nav_top和nav_left
	controlNav();
	
	// 查询当前配置
	var globalConfigId = 1;
	$.get('globalConfig/'+globalConfigId, 
			null, 
			function(globalConfig){
				// 加载数据到表单
				globalConfigId = globalConfig.id;
				$("#pushInterval").val(globalConfig.pushInterval);
				$("#pushTimesPerDay").val(globalConfig.pushTimesPerDay);
				
				if(globalConfig.noLimitPushTimes == true)
				{
					$("#noLimitPushTimes").attr('checked',true);
					$('#pushTimesPerDay').attr("disabled",true);
					
					$("#pushTimesPerDay").val(1440);
				}
				
			}, 
			"json");

	// 注册校验器
	$("input,select,textarea").not("[type=submit]").jqBootstrapValidation({
		submitSuccess: function (form, event) {
			event.preventDefault();		// 停止URL参数形式的提交操作，使用ajax方式提交来替代
			sendRequest(globalConfigId,JSON.stringify(serializeObject(form.serializeArray())));  
		}
	});
	
	// 绑定回退默认配置按钮
	$("#resetToDefaultButton").click(function(){
	
		closeAlertBar();
		
		// 获取默认配置
		var defaultGlobalConfig;
		$.ajax({  
			type : "get",  
          	url :  "globalConfig/0",  
          	dataType: "json",
          	data : null,  
          	async : false,  
          	success : function(globalConfig){  
            	defaultGlobalConfig = globalConfig;
          	}

		});
		
		// 提交修改
		sendRequest(globalConfigId, JSON.stringify(defaultGlobalConfig));
		return false;
	});
})
	
// 向服务端提交请求
function sendRequest(globalConfigId,data){      

    $.ajax({  
		type: "POST",  
        async:false,  
        contentType: "application/json;charset=UTF-8",  
        dataType: "json",  
        url: "globalConfig/"+globalConfigId+"?_method=PUT",  
        data: data,   
        success: function(globalConfig){
        	// 关闭对话框并刷新列表
        	$(".alert-success").css("display","block");
        	$(".alert-success strong").html("修改成功！ 更新时间：" + formatTimeSecond(globalConfig.lastUpdateTime));
        	$(".alert-warning").css("display","none");
        	
        	// 应答结果写入表单
        	$("#pushInterval").val(globalConfig.pushInterval);
			$("#pushTimesPerDay").val(globalConfig.pushTimesPerDay);
			
			if(globalConfig.noLimitPushTimes == true)
			{
				$("#noLimitPushTimes").attr('checked',true);
				$('#pushTimesPerDay').attr("disabled",true);
					
				$("#pushTimesPerDay").val(1440);
			}
        },  
        error: function(error){
        	// 提示删除错误
        	$(".alert-success").css("display","none");
        	$(".alert-warning").css("display","block");
        	$(".alert-warning strong").html("修改失败！ 错误信息：" + getErrorMessage(error));
        	
        },  
    });         
}

// 切换“不限制次数”
function switchPushTime()
{
	var mode = $('#pushTimesPerDay').attr("disabled");
	if(mode == undefined || mode == false)
	{
		$('#pushTimesPerDay').attr("disabled",true);
		$('#pushTimesPerDay').val(1440);
	}
	else
	{
		$('#pushTimesPerDay').attr("disabled",false);
		$('#pushTimesPerDay').val(1);
	}
	return true;
}

</script>
</body>
</html>




