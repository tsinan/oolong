<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@ include file="../include/include_head.jsp" %>
    <link href="resources/plugin/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">

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
									    
					<form class="form-horizontal" novalidate>
			    	<fieldset>
						
					<div class="panel panel-default">
					<div class="panel-heading">基本信息</div>
					<div class="panel-body">
        				<div class="form-group ">	<!-- 活动名称 -->
          					<label class="control-label col-sm-3">广告活动：</label>
							<div class="col-sm-6 controls">
								<!-- 
					            <div class="input-group">
				                    <input class="form-control input-sm" size="24" type="text" name="activity"  placeholder="">
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
				                </div> -->
				                <select class="form-control">
								  	<option>虚拟域一</option>
									<option>虚拟域二</option>
									<option>虚拟域三</option>
									<option>虚拟域四</option>
									<option>虚拟域五</option>
								</select>
					      		<p class="help-block"></p>
          					</div>
          					
						</div>
						<div class="form-group">	<!-- 订单名称 -->
							<label class="control-label col-sm-3">广告订单名称：</label>
							<div class="col-sm-6 controls">
								<input id="advName" name="advName" type="text" class="form-control input-sm" 
            						data-validation-regex-regex="[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}" 
        							data-validation-regex-message="支持中文字符、英文字符、数字、英文括号、中划线（-）或下划线（_），可以输入2至30个字符" 
        							data-validation-ajax-ajax="advs/checkNameIfDup">
            					<p class="help-block"></p>
            					
          					</div>
						</div>
						<div class="form-group ">	<!-- 生效时间 -->
          					<label class="control-label col-sm-3">生效日期：</label>
          					<div class="col-sm-6 controls" >
            					<div class="input-group date form_date" 
            									data-date="" data-date-format="yyyy年mm年dd日" data-link-format="yyyy-mm-dd">
				                    <input class="form-control input-sm" style="" size="24" type="text" value="" readonly>
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
				                </div>
          					</div>
        				</div>
        				<div class="form-group ">	<!-- 生效时间 -->
          					<label class="control-label col-sm-3">失效日期：</label>
          					<div class="col-sm-6 controls" >
            					<div class="input-group date form_date" 
            									data-date="" data-date-format="yyyy年mm年dd日" data-link-format="yyyy-mm-dd">
				                    <input class="form-control input-sm" style="" size="24" type="text" value="" readonly>
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
				                </div>
          					</div>
        				</div>
						<div class="form-group">	<!-- 优先级/CPM -->
          					<label class="control-label col-sm-3">需求量（CPM）：</label>
          					<div class="col-sm-2 controls">
            					<input name="pri" type="text" placeholder="" class="form-control input-sm">
    							<p class="help-block"></p>
          					</div>
          					
          					<label class="control-label col-sm-2">优先级：</label>
          					<div class="col-sm-2 controls">
            					<input name="cpm" type="text" placeholder="" class="form-control input-sm">
    							<p class="help-block"></p>
          					</div>
						</div>
					</div>
					</div>
						

					<div class="panel panel-default">
					<div class="panel-heading">广告物料</div>
					<div class="panel-body">
						<div class="form-group ">		<!-- 链接 -->
          					<label class="control-label col-sm-3">广告链接地址：</label>
          					<div class="col-sm-6 controls">
            					<div class="input-group">
									<span class="input-group-addon" style="width:65px">http://</span>
									<input type="text" class="form-control input-sm" style="width:277px"  placeholder="Username">
								</div>
    							<p class="help-block"></p>
          					</div>
          					
        				</div>
        				<div class="form-group ">		<!-- 文件 -->
          					<label class="control-label col-sm-3" >广告素材上传：</label>
          					<div class="col-sm-6 controls">
          						<input id="lefile" type="file" style="position: fixed; left: -500px;">
								<div class="input-group" style="padding-right: 0;padding-left: 0px;">
				                    <input id="fileCover" class="form-control input-sm" size="24" type="text" name="linkman"  placeholder="">
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
				                </div>
								 
								<script type="text/javascript">
								$('input[id=lefile]').change(function() {
								$('#fileCover').val($(this).val());
								});
								</script>
								
								
          					</div>
        				</div>
    				</div>
    				</div>

    				<div class="panel panel-default">
    				<div class="panel-heading">推送范围</div>
    				<div class="panel-body">
        				<div class="form-group ">		<!-- 推广方式 -->
          					<label class="control-label col-sm-3" >推广方式：</label>
          					<div class="col-sm-6 controls">
            					<div>
									<label class="radio-inline" style="margin-right:20px">
								    	<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
								    	普通
								  	</label>
								  	<label class="radio-inline" style="margin-right:20px">
								    	<input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
								    	精准
								  	</label>
								</div>
          					</div>
        				</div>
        				<div class="form-group ">		<!-- 关联网站 -->
          					<label class="control-label col-sm-3" >关联网站推送：</label>
          					<div class="col-sm-6 controls">
            					<!-- <div class="input-group" style="padding-right: 0;padding-left: 0px;">
				                    <input class="form-control input-sm" size="24" type="text" name="linkman"  placeholder="">
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
				                </div>  -->
				                <select multiple class="form-control">
								  	<option>兴趣一</option>
									<option>兴趣二</option>
									<option>兴趣三</option>
									<option>兴趣四</option>
									<option>兴趣五</option>
								</select>
    							<p class="help-block"></p>
          					</div>
        				</div>
        				<div class="form-group ">		<!-- 推送范围 -->
          					<label class="control-label col-sm-3">推送范围：</label>
          					<div class="col-sm-6 controls">
            					<div >
									<label class="radio-inline" style="margin-right:20px">
								    	<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
								    	全局
								  	</label>
								  	<label class="radio-inline" style="margin-right:20px">
								    	<input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
								    	虚拟域
								  	</label>
								</div>
          					</div>
        				</div>
        				<div class="form-group ">		<!-- 推送虚拟域 -->
          					
          					<label class="control-label col-sm-3">虚拟域：</label>
          					<div class="col-sm-6 controls">
	          					<select multiple class="form-control">
									  	<option>虚拟域一</option>
										<option>虚拟域二</option>
										<option>虚拟域三</option>
										<option>虚拟域四</option>
										<option>虚拟域五</option>
								</select>
    							<p class="help-block"></p>
          					</div>
        				</div>
        				
        				
    				</div>
    				</div>
        				
        			<div class="panel panel-default">
    				<div class="panel-heading">附加信息</div>
    				<div class="panel-body">
        				<div class="form-group">		<!-- 广告说明 -->
							<label class="control-label col-sm-3">广告说明：</label>
							<div class="col-sm-6 controls">
								<div class="textarea">
                  					<textarea name="description" type="" class="form-control" rows="3"></textarea>
            					</div>
          					</div>
        				</div>
        				
					</div>
					</div>
					
					<div class="panel panel-default" style="border-style:none">
					<div class="panel-body">
					<div class="form-group">
						<div class="col-sm-3">
						</div>
						<div class="col-sm-6">
							<button class="btn btn-primary" type="submit">提交</button>&nbsp;
							<button class="btn btn-warning" type="reset">重置</button>
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
	
	<!-- Response Dialog -->
	<div class="modal fade" id="responseDialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
		        	<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>  -->
		        	<h4 class="modal-title"></h4>
		      	</div>
      			<div class="modal-body">
        			
      			</div>
				<div class="modal-footer">
		        	
		      	</div>
    		</div><!-- /.modal-content -->
  		</div><!-- /.modal-dialog -->
	</div><!-- end of Response Dialog -->

<%@ include file="../include/include_js.jsp" %>
<script type="text/javascript" src="resources/plugin/jqBootstrapValidation.js"></script>
<script type="text/javascript" src="resources/plugin/bootstrap-filestyle.js"></script>
<script type="text/javascript" src="resources/plugin/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="resources/plugin/bootstrap-datetimepicker.zh-CN.js"></script>
<script>

$(function (){ 
	// 分析URL，控制nav_top和nav_left
	controlNav();

	// 注册校验器
	$("input,select,textarea").not("[type=submit]").jqBootstrapValidation({
		//submitError: function (form, event) {		// 测试时重名时使用
		//	event.preventDefault();		// 停止URL参数形式的提交操作，使用ajax方式提交来替代
		//	request("activities", "POST", JSON.stringify(serializeObject(form.serializeArray())));  
		//}, 
		submitSuccess: function (form, event) {
			event.preventDefault();		// 停止URL参数形式的提交操作，使用ajax方式提交来替代
			request("advs", "POST", JSON.stringify(serializeObject(form.serializeArray())));  
		}
	});
	
    $('.form_date').datetimepicker({
        language:  'zh-CN',
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
    });
})
	
// 向服务端提交请求
function request(url, method, param){      

    $.ajax({  
		type: method,  
        async:false,  
        contentType: "application/json;charset=UTF-8",  
        dataType: "json",  
        url: url,  
        data: param,   
        success: function(activity){
        	// 创建成功时，在弹出窗口中显示活动名称，并指导用户下一步操作
        	$("#responseDialog .modal-title").text("操作成功");
        	
        	var innerHtml = "<p>广告活动： "+activity.activityName+" 创建完成，请选择下一步操作：</p>";
        	innerHtml += "<ul><li><a href=\"#\">为此广告活动新建广告定单</a> （默认，当关闭对话框时选择此操作）</li>";
        	innerHtml += "<li><a href=\"activities/listPage\">查看当前广告活动列表</a></li>";
        	innerHtml += "<li><a href=\"activities/createPage\">继续创建广告活动</a></li>";
        	innerHtml += "<li><a href=\"#\" onclick=\"return createAsTemplate();\">创建新的广告活动（以当前广告活动为模板）</a></li>";
        	innerHtml += "</ul>";
        	$("#responseDialog .modal-body").html(innerHtml);
        	
        	var footerHtml = "<a href=\"activities/createPage\" class=\"btn btn-default btn-sm\" role=\"button\">关闭</a>";
        	$("#responseDialog .modal-footer").html(footerHtml);
        	
        	// 显示对话框
        	$('#responseDialog').modal({
        		backdrop: 'static',
				keyboard: false
			});
        },  
        error: function(error){
        	var response = error.responseJSON;
        	// 如果是450错误，说明是用户输入有误，需要重新显示表单并触发校验
        	if(response.code == '450')
        	{
        		// 高亮活动名称字段，提示用户修改
        		$formGroup = $("#activityName").parents(".form-group").first();
      			$formGroup.removeClass("has-success has-warning").addClass("has-error");
      			$formGroup.find(".help-block").first().text(response.message);
        	}
        	// 其他错误属于系统异常，弹出对话框，指导用户选择下一步操作
        	else
        	{
        		$("#responseDialog .modal-title").text("操作失败");
        		
        		var innerHtml = "<p>失败原因: "+response.message+" ，请选择下一步操作：</p>";
            	innerHtml += "<ul><li><a href=\"activities/createPage\">创建新的广告活动</a> （默认，当关闭对话框时选择此操作）</li>";
            	innerHtml += "<li><a href=\"activities/listPage\">查看当前广告活动列表</a></li>";
            	innerHtml += "</ul>";
            	$("#responseDialog .modal-body").html(innerHtml);
            	
            	var footerHtml = "<a href=\"activities/createPage\" class=\"btn btn-default btn-sm\" role=\"button\">关闭</a>";
            	$("#responseDialog .modal-footer").html(footerHtml);
        	
        		// 显示对话框
            	$('#responseDialog').modal({
            		backdrop: 'static',
					keyboard: false
				});
        	}
        },  
    });         
}

// 关闭对话框，保留除活动名称外的其他字段
function createAsTemplate()
{
	$("#responseDialog").modal('hide');
	$("#activityName").val('');
	$("#activityName").focus();   
	return false;
}
	
</script>
</body>
</html>




