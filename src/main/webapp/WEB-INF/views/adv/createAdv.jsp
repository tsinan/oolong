<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@ include file="../include/include_head.jsp" %>
	<script type="text/javascript" src="resources/plugin/jqBootstrapValidation.js"></script>
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
	
	// 清空表单
	function resetForm()
	{	
		$("form")[0].reset();
		$("input,select,textarea").not("[type=submit]").jqBootstrapValidation("destroy");
		
		$("input,select,textarea").not("[type=submit]").jqBootstrapValidation({
			submitSuccess: function (form, event) {
				event.preventDefault();		// 停止URL参数形式的提交操作，使用ajax方式提交来替代
 				request("activities", "POST", JSON.stringify(serializeObject(form.serializeArray())));  
			}
		});
		return false;
	}
		
	</script>
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
      			
      			<div class="col-md-8" style="border: 1px solid #f1f1f1;">
					<!-- main area -->
					<div id="legend" style="margin-top:5px;margin-bottom:5px">
			        	<a class="btn btn-default btn-sm" href="advs/listPage" role="button">
							<span class="glyphicon glyphicon-list"></span> 查看广告订单
						</a>&nbsp;
						
				    </div>
				    				      	
					<form class="form-horizontal" onreset="resetForm()" novalidate>
			    	<fieldset>
        				<div class="form-group ">
          					<label class="control-label col-sm-2">广告活动：</label>
							<div class="col-sm-4 controls">
					            <select name="company" class="form-control input-sm" style="line-height:18px;padding:2px 0"
					            data-validation-required-message="请为广告活动选择公司" required>
					            	<option> </option>
					      			<option>杯京公司</option>
					      			<option>极难公司</option>
					      			<option>航舟公司</option>
					      			<option>程度公司</option>
					      		</select>
					      		<p class="help-block"></p>
          					</div>
						</div>
						
        				<div class="form-group">
							<label class="control-label col-sm-2" for="input01">广告订单名称：</label>
							<div class="col-sm-4 controls">
								<input id="activityName" name="activityName" type="text" placeholder="例如：页游广告投放测试" class="form-control input-sm" 
            						data-validation-regex-regex="[\u4e00-\u9fa5a-zA-Z0-9_-]{3,30}" 
        							data-validation-regex-message="支持中文字符、英文字符、数字、英文括号、中划线（-）或下划线（_），可以输入3至30个字符" 
        							data-validation-ajax-ajax="activities/checkNameIfDup"
        							required>
            					<p class="help-block"></p>
            					
          					</div>
          					<label class="control-label col-sm-2" for="input01">需求量（CPM）：</label>
          					<div class="col-sm-2 ">
            					<input name="linkman" type="text" placeholder="" class="form-control input-sm">
    							<p class="help-block"></p>
          					</div>
						</div>
						
        				<div class="form-group ">
          					<label class="control-label col-sm-2" for="input01">展现形式：</label>
          					<div class="col-sm-4">
            					<select name="company" class="form-control input-sm" style="line-height:18px;padding:2px 0"
            						data-validation-required-message="请为广告活动选择公司" disabled>
					            	<option>自定义</option>
					            	<!-- <option>弹窗</option>  
					      			<option>背投</option>
					      			<option>替换</option>   
					      			<option>自定义</option> -->
					      		</select>
            					<p class="help-block"></p>
          					</div>
          					
          					<label class="control-label col-sm-2">广告尺寸：</label>
							<div class="col-sm-2">
								<input name="linkman" type="text" placeholder="" class="form-control input-sm" disabled>
    							<p class="help-block"></p>
          					</div>
        				</div>
        				<div class="form-group ">
          					<label class="control-label col-sm-2" for="input01">广告链接地址：</label>
          					<div class="col-sm-4 ">
            					<input name="linkman" type="text" placeholder="" class="form-control input-sm">
    							<p class="help-block"></p>
          					</div>
        				</div>
        				<div class="form-group ">
          					<label class="control-label col-sm-2" for="input01">广告素材上传：</label>
          					<div class="col-sm-4 ">
            					<input name="linkman" type="file" placeholder="" >
    							<p class="help-block"></p>
          					</div>
        				</div>
        				<div class="form-group ">
          					<label class="control-label col-sm-2" for="input01">推广方式：</label>
          					<div class="col-sm-3 ">
            					<div >
									<label class="radio-inline">
								    	<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
								    	普通
								  	</label>
								  	<label class="radio-inline">
								    	<input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
								    	精准
								  	</label>
								</div>
          					</div>
          					<label class="control-label col-sm-2" for="input01">关联网站分类：</label>
          					<div class="col-sm-3 ">
            					<input name="linkman" type="text" placeholder="" class="form-control input-sm">
    							<p class="help-block"></p>
          					</div>
        				</div>
        				
        				<div class="form-group ">
          					<label class="control-label col-sm-2" for="input01">全局推送：</label>
          					<div class="col-sm-3 ">
            					<input name="linkman" type="text" placeholder="" class="form-control input-sm">
    							<p class="help-block"></p>
          					</div>
          					<label class="control-label col-sm-2" for="input01">虚拟域：</label>
          					<div class="col-sm-3 ">
            					<input name="linkman" type="text" placeholder="" class="form-control input-sm">
    							<p class="help-block"></p>
          					</div>
        				</div>
        				<div class="form-group ">
          					<label class="control-label col-sm-2" for="input01">免推送网站：</label>
          					<div class="col-sm-8 ">
            					<input name="linkman" type="text" placeholder="" class="form-control input-sm">
    							<p class="help-block"></p>
          					</div>
        				</div>
        				<div class="form-group ">
          					<label class="control-label col-sm-2" for="input01">有效时间：</label>
          					<div class="col-sm-8 ">
            					<input name="linkman" type="text" placeholder="" class="form-control input-sm">
    							<p class="help-block"></p>
          					</div>
        				</div>
        				<div class="form-group">
							<label class="control-label col-sm-2">广告说明：</label>
							<div class="col-sm-8">
								<div class="textarea">
                  					<textarea name="description" type="" class="form-control" rows="3"></textarea>
            					</div>
          					</div>
        				</div>
        				<div class="form-group">
							<div class="col-sm-2">
          					</div>
							<div class="col-sm-8">
								<button class="btn btn-primary" type="submit">提交</button>&nbsp;
								<button class="btn btn-warning" type="reset">重置</button>
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
	
</body>
</html>




