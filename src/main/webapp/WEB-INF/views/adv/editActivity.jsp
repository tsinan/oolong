<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>oolong</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="<%=contextPath%>/" />
    <link rel="icon" href="resources/img/favicon_16X16.ico" mce_href="resources/img/favicon_16X16.ico" type="image/x-icon">
	<link href="resources/bootstrap-3.0.0/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="resources/plugin/sticky-footer-navbar.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="resources/jquery-1.10.2/jquery-1.10.2.js"></script>
	<script type="text/javascript" src="resources/bootstrap-3.0.0/js/bootstrap.js"></script>
	<script type="text/javascript" src="resources/plugin/jqBootstrapValidation.js"></script>
	<script type="text/javascript" src="resources/plugin/json2.js"></script>
	<script>
		// 提取URL查询参数
		var param = location.search.split("&");
		var editId = param[0].split("=")[1];
		var paging = param[1].split("=")[1];

		$(function (){ 
		
			// 设置ajax校验URL
			$("#activityName").attr("data-validation-ajax-ajax","activities/checkNameIfDup?exceptId="+editId);
		
			// 注册页面返回按钮事件
			$("#returnToListLink").click(function(){
				window.location = "activities/listPage?paging="+paging;
			});
			$("#returnToListBtn").click(function(){
				window.location = "activities/listPage?paging="+paging;
			});
		
			// 加载待修改的活动信息
			$.get('activities/'+editId, 
					null, 
					function(activity){
						// 加载数据到表单
						$("#company").val(activity.company);
						$("#activityName").val(activity.activityName);
						$("#linkman").val(activity.linkman);
						$("#linkmanPhone").val(activity.linkmanPhone);
						$("#description").val(activity.description);
					}, 
					"json");
		
			// 注册校验器
	  		$("input,select,textarea").not("[type=submit]").jqBootstrapValidation({
				submitSuccess: function (form, event) {
					event.preventDefault();		// 停止URL参数形式的提交操作，使用ajax方式提交来替代
     				sendRequest("activities/"+editId+"?_method=PUT", "POST", JSON.stringify(serializeObject(form.serializeArray())));  
 				}
 			});
		})
		
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
        };  

		// 向服务端提交请求
		function sendRequest(url, method, param){      

	        $.ajax({  
				type: method,  
                async:false,  
                contentType: "application/json;charset=UTF-8",  
                dataType: "json",  
                url: url,  
                data: param,   
                success: function(activity){
                	// 修改成功时，在弹出窗口中显示活动名称，并指导用户下一步操作
                	$("#responseDialog .modal-title").text("操作成功");
                	
                	var innerHtml = "<p>广告活动： "+activity.activityName+" 修改完成。</p>";
                	$("#responseDialog .modal-body").html(innerHtml);
                	
                	var footerHtml = "<a href=\"activities/listPage?paging="+paging+"\" "+
                						"class=\"btn btn-default\" role=\"button\">返回</a>";
                	$("#responseDialog .modal-footer").html(footerHtml);
                	
                	// 显示对话框?paging="+paging+"
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
                		
                		var innerHtml = "<p>失败原因: "+response.message+"。</p>";
	                	$("#responseDialog .modal-body").html(innerHtml);
	                	
	                	var footerHtml = "<a href=\"activities/listPage?paging="+paging+"\" "+
	                						"class=\"btn btn-default\" role=\"button\">返回</a>";
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
		
	</script>
</head>
<body>
	<!-- Wrap all page content here -->
    <div id="wrap" >
		<!-- Fixed navbar -->
      	<div class="navbar navbar-default navbar-fixed-top" role="navigation">
        	<div class="container">
          		<div class="navbar-header">
		            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
		            </button>
            		<a class="navbar-brand" href="#">Project name</a>
          		</div>
	          	<div class="collapse navbar-collapse">
		       		<ul class="nav navbar-nav">
						<li><a href="#">首页</a></li>
						<li class="active">
							<a href="activities/listPage">广告管理</a>
						</li>
						<li><a href="#resource">资源管理</a></li>
		              	<li><a href="#report">报表管理</a></li>
		              	<li><a href="#system">系统管理</a></li>
		            </ul>
				</div>
			</div>
		</div><!-- end of Fixed navbar -->

      	<!-- Begin page content -->
      	<div class="container">
      		<div class="row">
      			
				<div class="col-md-2" >
					<!-- left nav -->
					<div class="panel-group" id="accordion">
						<div class="panel panel-default">
					    	<div class="panel-heading">
					      	<h4 class="panel-title">
					        	<a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
					          	广告活动管理
					        	</a>
					      	</h4>
					    	</div>
						    <div id="collapseOne" class="panel-collapse collapse in">
						      	<div class="panel-body">
						      	<ul class="nav nav-pills nav-stacked">
									<li >
										<a href="activities/createPage">
										新建广告活动
										</a>
									</li>
									<li class="active">
										<a href="activities/listPage">
										查看广告活动
										</a>
									</li>
								</ul>
						      	</div>
						    </div>
						</div>
						<div class="panel panel-default">
						    <div class="panel-heading">
						    <h4 class="panel-title">
						        <a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
						          广告订单管理
						        </a>
						    </h4>
						    </div>
					    	<div id="collapseTwo" class="panel-collapse collapse">
					      		<div class="panel-body">
					      		<ul class="nav nav-pills nav-stacked">
									<li >
										<a href="#">
										新建广告订单
										</a>
									</li>
									<li >
										<a href="#">
										待处理广告订单
										</a>
									</li>
									<li >
										<a href="#">
										已通过广告订单
										</a>
									</li>
									<li >
										<a href="#">
										查看广告订单
										</a>
									</li>
								</ul>
					      		</div>
					    	</div>
					  	</div> 
					</div>	<!-- end of left nav -->
      			</div>
      			
      			<div class="col-md-10" style="border: 1px solid #f1f1f1;">

					<form class="form-horizontal" novalidate>
			    	<fieldset>
				      	<div id="legend" style="margin-top:5px;margin-bottom:5px">
			        		<a id="returnToListLink" class="btn btn-default" role="button">
								<span class="glyphicon glyphicon-list"></span> 查看广告活动
							</a>&nbsp;
				      	</div>
				      	
        				<div class="form-group ">
          					<label class="control-label col-sm-2">公司名称：</label>
							<div class="col-sm-6 controls">
					            <select id="company" name="company" class="form-control input-xlarge" data-validation-required-message="请为广告活动选择公司" required>
					            	<option> </option>
					      			<option>杯京公司</option>
					      			<option>极难公司</option>
					      			<option>航舟公司</option>
					      			<option>程度公司</option>
					      		</select>
					      		<p class="help-block">必需：请在列表中选择公司</p>
          					</div>
						</div>
						
        				<div class="form-group">
							<label class="control-label col-sm-2" for="input01">广告活动名称：</label>
							<div class="col-sm-6 controls">
								<input id="activityName" name="activityName" type="text" placeholder="例如：页游广告投放测试" class="form-control input-xlarge" 
            						data-validation-regex-regex="[\u4e00-\u9fa5a-zA-Z0-9_-]{3,30}" 
        							data-validation-regex-message="支持中文字符、英文字符、数字、英文括号、中划线（-）或下划线（_），可以输入3至30个字符"
        							required>
            					<p class="help-block">必需：3-30个字符，可输入中文字符、英文字符、数字或下划线（_）</p>
            					
          					</div>
						</div>
						<div class="form-group ">
          					<label class="control-label col-sm-2" for="input01">联系人：</label>
          					<div class="col-sm-6 ">
            					<input id="linkman" name="linkman" type="text" placeholder="" class="form-control input-xlarge">
    							<p class="help-block"></p>
          					</div>
        				</div>
        				<div class="form-group ">
          					<label class="control-label col-sm-2" for="input01">联系电话：</label>
          					<div class="col-sm-6">
            					<input id="linkmanPhone" name="linkmanPhone" type="text" placeholder="例如：0531-88888888" class="form-control input-xlarge">
            					<p class="help-block">请输入座机（带区号）或手机</p>
          					</div>
        				</div>
        				<div class="form-group">
							<label class="control-label col-sm-2">描述信息：</label>
							<div class="col-sm-6">
								<div class="textarea">
                  					<textarea id="description" name="description" type="" class="form-control" rows="3"></textarea>
            					</div>
          					</div>
        				</div>
        				<div class="form-group">
							<div class="col-sm-2">
          					</div>
							<div class="col-sm-6">
								<button class="btn btn-primary" type="submit">提交</button>&nbsp;
								<button id="returnToListBtn" class="btn btn-warning" type="button">返回</button>
							</div>
						</div>
					</fieldset>
  					</form>
      				
      			</div>
      		</div>
      	</div>
	</div><!-- end of Wrap -->
  	
  	<!-- footer of page -->
	<div id="footer" >
		<div class="container">
			<p class="text-muted credit">
				当前版本：1.0 &middot;
				<a href="#">关于我们</a>&middot;
				<a href="#">帮助中心</a>&middot;
				<a href="#">网站地图</a>&middot;
			</p>
		</div>
	</div><!-- end of footer -->
	
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



