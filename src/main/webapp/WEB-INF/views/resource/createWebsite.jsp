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
      			
      			<div class="col-md-8" style="border-width: 0px 1px;border-style:solid;border-color:#f1f1f1;">
				<!-- main area -->
			      	
				<form class="form-horizontal"  novalidate>
		    	<fieldset>
		    		<div class="panel panel-default">
					<div class="panel-heading">关联网站信息</div>
					<div class="panel-body">
    				
    				<div class="alert alert-success alert-dismissable" style="padding-top:5px;padding-bottom:5px;display:none">
					 	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					 	<strong></strong> 
					</div>
					
					<div class="alert alert-warning alert-dismissable" style="padding-top:5px;padding-bottom:5px;display:none">
					 	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					 	<strong></strong>
					</div>
    				
					<div class="form-group">		<!-- 关联网站名称 -->
						<label class="control-label col-sm-3"  >关联网站名称：</label>
						<div class="col-sm-6 controls">
							<input id="websiteName" name="websiteName" type="text" placeholder="例如：新闻网站" class="form-control input-sm" 
        						required
        						data-validation-required-message="支持中文字符、英文字符、数字、英文括号、中划线（-）或下划线（_），可以输入2至30个字符"
        						data-validation-regex-regex="[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}" 
    							data-validation-regex-message="支持中文字符、英文字符、数字、英文括号、中划线（-）或下划线（_），可以输入2至30个字符" 
    							data-validation-ajax-ajax="websites/checkNameIfDup">
        					<p class="help-block">必需：2-30个字符，可输入中文字符、英文字符、数字或下划线（_）</p>
        					
      					</div>
					</div>
					
					<div class="form-group">		<!-- 描述信息 -->
						<label class="control-label col-sm-3">描述信息：</label>
						<div class="col-sm-6 controls">
							<div class="textarea">
              					<textarea id="description" name="description" type="" class="form-control" rows="3"></textarea>
        					</div>
      					</div>
    				</div>
    				<div class="form-group">		<!-- 按钮 -->
						<div class="col-sm-3">
      					</div>
						<div class="col-sm-6">
							<button class="btn btn-primary" type="submit">提交</button>
						</div>
					</div>
					</div>
					</div>
					
				</fieldset>
				</form>
  				<!-- end of area -->
      			</div>
      		
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

	// 注册校验器
	$("input,select,textarea").not("[type=submit]").jqBootstrapValidation({
		submitSuccess: function (form, event) {
			event.preventDefault();		// 停止URL参数形式的提交操作，使用ajax方式提交来替代
			sendRequest(JSON.stringify(serializeObject(form.serializeArray())));  
		}
	});
})
	
// 向服务端提交请求
function sendRequest(data){      

    $.ajax({  
		type: "POST",  
        async:false,  
        contentType: "application/json;charset=UTF-8",  
        dataType: "json",  
        url: "websites",  
        data: data,   
        success: function(website){
        	// 关闭对话框并刷新列表
        	$(".alert-success").css("display","block");
        	$(".alert-success strong").html("添加成功！ 更新时间：" + formatTimeSecond(website.lastUpdateTime));
        	$(".alert-warning").css("display","none");
        	
        	$("form")[0].reset();
        },  
        error: function(error){
        
        	// 提示删除错误
        	$(".alert-success").css("display","none");
        	$(".alert-warning").css("display","block");
        	$(".alert-warning strong").html("添加失败！ 错误信息：" + getErrorMessage(error));
        		
        	var response = error.responseJSON;
        	// 如果是450错误，说明是用户输入有误，需要重新显示表单并触发校验
        	if(response.code == '450')
        	{
        		// 高亮活动名称字段，提示用户修改
        		$formGroup = $("#websiteName").parents(".form-group").first();
      			$formGroup.removeClass("has-success has-warning").addClass("has-error");
      			$formGroup.find(".help-block").first().text(response.message);
        	}
        	// 其他错误属于系统异常，弹出对话框，指导用户选择下一步操作
        	else
        	{
        		$("form")[0].reset();
        	}
        },  
    });         
}
	
</script>
</body>
</html>




