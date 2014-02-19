<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@ include file="../include/include_head.jsp" %>
    <link href="resources/plugin/bootstrap-datetimepicker.css" rel="stylesheet" type="text/css">
</head>
<body>
	<a name="anchor_top"></a>
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
					
						<div class="alert alert-success alert-dismissable" style="padding-top:5px;padding-bottom:5px;display:none">
						 	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						 	<strong>添加成功！</strong> 
						</div>
						
						<div class="alert alert-warning alert-dismissable" style="padding-top:5px;padding-bottom:5px;display:none">
						 	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						 	<strong>添加失败！</strong> 
						</div>
					
        				<div class="form-group ">	<!-- 活动名称 -->
          					<label class="control-label col-sm-3">广告活动：</label>
							<div class="col-sm-6 controls">
				                <select id="activityId" name="activityId" class="form-control" 
				                	min="1" data-validation-min-message="请选择广告活动">
				                	<option value='0'>---</option>
								</select>
					      		<p class="help-block"></p>
          					</div>
						</div>
						<div class="form-group">	<!-- 订单名称 -->
							<label class="control-label col-sm-3">广告订单名称：</label>
							<div class="col-sm-6 controls">
								<input id="advName" name="advName" type="text" class="form-control input-sm" 
									required
									data-validation-required-message="支持中文字符、英文字符、数字、英文括号、中划线（-）或下划线（_），可以输入2至30个字符"
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
            									data-date="" data-date-format="yyyy-mm-dd" >
				                    <input id="startDate" name="startDate" class="form-control input-sm" 
				                    	style="" size="24" type="text" value="" 
				                    	required
				                    	data-validation-required-message="请选择生效时间"
				                    	data-validation-callback-callback="date_callback_function"
				                    	readonly>
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
				                </div>
				                <p class="help-block"></p>
          					</div>
        				</div>
        				<div class="form-group ">	<!-- 失效时间 -->
          					<label class="control-label col-sm-3">失效日期：</label>
          					<div class="col-sm-6 controls" >
            					<div class="input-group date form_date" 
            									data-date="" data-date-format="yyyy-mm-dd">
				                    <input id="endDate" name="endDate" class="form-control input-sm" 
				                    	style="" size="24" type="text" value=""
				                    	required
				                    	data-validation-required-message="请选择失效时间" 
				                    	data-validation-callback-callback="date_callback_function"
				                    	readonly>
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
				                </div>
				                <p class="help-block"></p>
          					</div>
        				</div>
						<div id="dateCheckMessage" class="form-group has-warning" style="display:none"><!-- 冲突提示信息 -->
	      					<label class="col-sm-3"></label>
	      					<div class="col-sm-6 controls">
	        					<p class="help-block">生效日期晚于失效日期，请确认后重新选择。</p>
	      					</div>
	        			</div>
						<div class="form-group">	<!-- 优先级/CPM -->
          					<label class="control-label col-sm-3">需求量（CPM）：</label>
          					<div class="col-sm-2 controls">
            					<input id="cpm" name="cpm" type="number" value="1000" class="form-control input-sm"
            						required min="1" max="99999"
									data-validation-required-message="需求量（CPM）可输入范围为：1-99999"
            						data-validation-min-message="需求量（CPM）可输入范围为：1-99999"
            						data-validation-max-message="需求量（CPM）可输入范围为：1-99999">
    							<p class="help-block">[1-99999]</p>
          					</div>
          					
          					<label class="control-label col-sm-2">优先级：</label>
          					<div class="col-sm-2 controls">
            					<input id="priority" name="priority" type="number" value="5" class="form-control input-sm"
            						required min="1" max="9"
									data-validation-required-message="需求量（CPM）可输入范围为：1-99999"
            						data-validation-min-message="优先级可输入范围为：1-9"
            						data-validation-max-message="优先级可输入范围为：1-9">
    							<p class="help-block">[1-9]</p>
          					</div>
						</div>
					</div>
					</div><!-- end of 基本信息 -->
						
					<div class="panel panel-default">
					<div class="panel-heading">广告物料</div>
					<div class="panel-body">
						<div class="form-group ">		<!-- 广告物料类型 -->
          					<label class="control-label col-sm-3" >物料类型：</label>
          					<div class="col-sm-6 controls">
            					<div>
									<label class="radio-inline" style="margin-right:20px">
								    	<input type="radio" name="advType" id="advTypeUrl" value="url" checked
								    		onclick="switchAdvType('url');">
								    	外部物料
								  	</label>
								  	<label class="radio-inline" style="margin-right:20px">
								    	<input type="radio" name="advType" id="advTypeFile" value="file"
								    		onclick="switchAdvType('file');">
								    	上传文件
								  	</label>
								</div>
          					</div>
        				</div>
						<div class="form-group ">		<!-- 链接 -->
          					<label class="control-label col-sm-3">广告链接地址：</label>
          					<div class="col-sm-6 controls">
            					<div class="input-group">
									<span class="input-group-addon" style="width:65px">http://</span>
									<input id="advUrl" name="advUrl" type="text" 
										class="form-control input-sm" style="width:277px" placeholder=""
										required
										data-validation-required-message="请输入广告链接地址"
										data-validation-callback-callback="advUrl_callback_function">
								</div>
    							<p class="help-block"></p>
          					</div>
        				</div>
        				<div class="form-group ">		<!-- 文件 -->
          					<label class="control-label col-sm-3" >广告素材上传：</label>
          					<div class="col-sm-6 controls">
          						<input id="trueAdvFile" name="trueAdvFile" type="file" style="position: fixed; left: -500px;"/>
								<div class="input-group" style="padding-right: 0;padding-left: 0px;">
				                    <input id="advFileDisplay" name="advFileDisplay" size="24" type="text" 
				                    	class="form-control input-sm" placeholder="" readonly />
									<span id="advFileButton" class="input-group-addon" >
										<span class="glyphicon glyphicon-th" title="选择上传文件"></span>
									</span>
				                </div>
          					</div>
        				</div>
        				<div class="form-group ">		<!-- 文件隐藏，用于提示信息显示 -->
        					<label class="control-label col-sm-3" ></label>
          					<div class="col-sm-6 controls">
          						<input id="advFile" name="advFile" type="hidden" 
          							required
          							data-validation-required-message="请选择需要上传的广告文件"/>
          						<p class="help-block"></p>
          					</div>
        				</div>
    				</div>
    				</div><!-- end of 广告物料类型 -->

    				<div class="panel panel-default">
    				<div class="panel-heading">推送范围</div>
    				<div class="panel-body">
        				<div class="form-group ">		<!-- 推广方式 -->
          					<label class="control-label col-sm-3" >推广方式：</label>
          					<div class="col-sm-6 controls">
            					<div>
									<label class="radio-inline" style="margin-right:20px">
								    	<input type="radio" name="spreadType" id="spreadTypeNormal" value="normal" 
								    		onclick="return switchSpreadType('normal');" checked>
								    	普通
								  	</label>
								  	<label class="radio-inline" style="margin-right:20px">
								    	<input type="radio" name="spreadType" id="spreadTypeAccurate" value="accurate"
								    		onclick="return switchSpreadType('accurate');" >
								    	精准
								  	</label>
								</div>
          					</div>
        				</div>
        				<div class="form-group ">		<!-- 关联网站 -->
          					<label class="control-label col-sm-3" >关联网站推送：</label>
          					<div class="col-sm-6 controls">
				                <div class="panel panel-default">
									<div class="panel-body" id="websiteCheckboxPanel">
						 	
			    						
								 	</div>
								 	<div id="websiteCheckMessage" class="form-group has-error" style="display:none">
				      					<p class="help-block" style="margin-left:30px">请选择关联网站。</p>
				        			</div>	
								</div>
          					</div>
        				</div>        				
        				<div class="form-group ">		<!-- 推送范围 -->
          					<label class="control-label col-sm-3">推送范围：</label>
          					<div class="col-sm-6 controls">
            					<div >
									<label class="radio-inline" style="margin-right:20px">
								    	<input type="radio" name="scope" id="scopeGlobal" value="global" 
								    		onclick="return switchScope('global')" checked>
								    	全局
								  	</label>
								  	<label class="radio-inline" style="margin-right:20px">
								    	<input type="radio" name="scope" id="scopeArea" value="area"
								    		onclick="return switchScope('area')">
								    	虚拟域
								  	</label>
								</div>
          					</div>
        				</div>
        				<div class="form-group ">		<!-- 推送虚拟域 -->
          					<label class="control-label col-sm-3">虚拟域：</label>
          					<div class="col-sm-6 controls">
	          					<div class="panel panel-default">
									<div class="panel-body" id="areaCheckboxPanel">
						 	
			    						
								 	</div>
								 	<div id="areaCheckMessage" class="form-group has-error" style="display:none">
				      					<p class="help-block" style="margin-left:30px">请选择虚拟域。</p>
				        			</div>	
								</div>
          					</div>
        				</div>
    				</div>
    				</div><!-- end of 推广方式 -->
        				
        			<div class="panel panel-default">
    				<div class="panel-heading">附加信息</div>
    				<div class="panel-body">
        				<div class="form-group">		<!-- 广告说明 -->
							<label class="control-label col-sm-3">广告说明：</label>
							<div class="col-sm-6 controls">
								<div class="textarea">
                  					<textarea id="description" name="description" class="form-control" rows="3"> </textarea>
            					</div>
          					</div>
        				</div>
					</div>
					</div><!-- end of 附加信息 -->
					
					<div class="panel panel-default" style="border-style:none">
					<div class="panel-body">
						<div class="form-group">
							<div class="col-sm-3"></div>
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
	
	<!-- Warning Dialog -->
	<div class="modal fade" id="warningDialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
		        	<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>  -->
		        	<h4 class="modal-title">告警</h4>
		      	</div>
      			<div class="modal-body">
        			当前没有可用的广告活动，请点击“确认”进入添加广告活动页面。
      			</div>
				<div class="modal-footer">
		        	<a href="activities/createPage" class="btn btn-default btn-sm" role="button">确认</a>
		      	</div>
    		</div><!-- /.modal-content -->
  		</div><!-- /.modal-dialog -->
	</div><!-- end of Warning Dialog -->

<%@ include file="../include/include_js.jsp" %>
<script type="text/javascript" src="resources/plugin/jqBootstrapValidation.js"></script>
<script type="text/javascript" src="resources/plugin/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="resources/plugin/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="resources/plugin/jquery.ui.widget.js"></script>
<script type="text/javascript" src="resources/plugin/jquery.iframe-transport.js"></script>
<script type="text/javascript" src="resources/plugin/jquery.fileupload.js"></script>
		
		
<script>

$(function (){ 
	// 分析URL，控制nav_top和nav_left
	controlNav();

	// 加载活动列表
	loadActivities();
	
	// 加载关联网站,默认设置为普通推送
	loadWebsites();
	
	// 加载区域
	loadAreas();

	// 时间选择器注册
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
    
    // 文件上传控件
    $('input[id=trueAdvFile]').change(function() {
		$('#advFileDisplay').val($(this).val());
	});
	
	$('input[id=trueAdvFile]').fileupload({
	 	dataType:	"json",
	 	url:		"advs/advFiles",
		done:		function(e,data){
						alert(data.result.path);
						$('#advFile').val(data.result.path);
					}  
	});
	
	$('#advFileButton').click(function(){
		if($('input[id=advTypeFile]').get(0).checked)
		{
			$('input[id=trueAdvFile]').click();
		}
	});
    
	// 注册校验器
	$("input,select,textarea").not("[type=submit]").jqBootstrapValidation({
		//submitError: function (form, event) {		// 测试时重名时使用
		//	event.preventDefault();		// 停止URL参数形式的提交操作，使用ajax方式提交来替代
		//	request("activities", "POST", JSON.stringify(serializeObject(form.serializeArray())));  
		//}, 
		submitSuccess: function (form, event) {
			
			event.preventDefault();		// 停止URL参数形式的提交操作，使用ajax方式提交来替代
			
			var willSubmit = true;
			
			// 判断是否生效/失效日期冲突
			if($('#dateCheckMessage').css('display') == "block")
			{
				$('#dateCheckMessage').removeClass("has-warning").addClass("has-error");			
				willSubmit = false;
			}
			
			// 判断当推广方式为精准时，关联网站是否选择
			if($('input[id=spreadTypeAccurate]').get(0).checked)
			{
				var chooseWebsite = false;
				$('#websiteCheckboxPanel input').each(function(){
					
					if(this.checked)
					{
						chooseWebsite = true;
						return;
					}
				});
				if(!chooseWebsite)
				{
					$('#websiteCheckMessage').css('display','block');
					willSubmit = false;
				}
				
			}
			
			// 判断当推广范围为区域虚拟域时，区域是否选择
			if($('input[id=scopeArea]').get(0).checked)
			{
				var chooseArea = false;
				$('#areaCheckboxPanel input').each(function(){
					
					if(this.checked)
					{
						chooseArea = true;
						return;
					}
				});
				if(!chooseArea)
				{
					$('#areaCheckMessage').css('display','block');
					willSubmit = false;
				}
			}
			
			// 校验通过，提交表单
			if(willSubmit)
			{
				sendRequest(JSON.stringify(serializeObject(form.serializeArray())));
			}
		},
		filter: function () {
			var id = $(this).attr("id");
			if(id === "advUrl" && $('#advTypeFile').get(0).checked===true)
			{
				return false;
			}
			else if(id === "advFile" && $('#advTypeUrl').get(0).checked===true)
			{
				return false;
			}
			else
			{
				return true;
			}
			//var isReadonly = (element.attr("readonly")=='readonly');
    		//return !isReadonly;
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
        url: "advs",  
        data: data,   
        success: function(adv){
        	// 操作结果显示
        	$(".alert-success").css("display","block");
        	$(".alert-success strong").html("添加成功！ 更新时间：" + formatTimeSecond(adv.lastUpdateTime));
        	$(".alert-warning").css("display","none");
			
			// 清空表单
			$("form")[0].reset();
			switchAdvType("url");
			switchSpreadType("normal");
			switchScope("global");
			
			// 切换到锚点
			location.hash="anchor_top";
        },  
        error: function(error){
        	// 操作结果显示
        	$(".alert-success").css("display","none");
        	$(".alert-warning").css("display","block");
        	$(".alert-warning strong").html("添加失败！ 错误信息：" + getErrorMessage(error));
        	
        	var response = error.responseJSON;
        	// 如果是450错误，说明是用户输入有误，需要重新显示表单并触发校验
        	if(response.code == '450')
        	{
        		// 高亮广告名称字段，提示用户修改
        		$formGroup = $("#advName").parents(".form-group").first();
      			$formGroup.removeClass("has-success has-warning").addClass("has-error");
      			$formGroup.find(".help-block").first().text(response.message);
        	}
        	// 其他错误属于系统异常，弹出对话框，指导用户选择下一步操作
        	else
        	{
        		// 清空表单
				$("form")[0].reset();
				switchAdvType("url");
				switchSpreadType("normal");
				switchScope("global");
        	}
        	
        	// 切换到锚点
			location.hash="anchor_top";
        },  
    });         
}

// 加载广告活动
function loadActivities()
{
	$.get("activities?sortColumn=activityName&sortOrder=ASC", 
			null, 
			function(activites){
				// 加载数据到表单
				var array = activites.currentPage;
				if(array.length == 0)
				{
					// 弹出窗口提示用户先配置活动
					$('#warningDialog').modal({
				            		backdrop: 'static',
									keyboard: false
								});
					return;
				}
				else
				{
					for(idx in array)
					{
						var option = "<option value='"+array[idx].id+"'>"+array[idx].activityName+"</option>";
						$(option).appendTo("#activityId");
					}
					return;
				}
				
			}, 
			"json");
}

// 加载关联网站
function loadWebsites()
{
	$.get("websites?sortColumn=websiteName&sortOrder=ASC", 
			null, 
			function(websites){
				// 加载数据到表单
				var array = websites.currentPage;
				if(array.length == 0)
				{
					// 提示当前没有可用的关联网站
					var checkbox = "<label class=\"checkbox col-sm-12\"> "+
											"<input name=\"websites\" type=\"checkbox\" "+
												"value='0' disabled /> "+
									    	"尚未添加关联网站"+
									 	"</label>";
					$(checkbox).appendTo("#websiteCheckboxPanel"); 	
					return;
				}
				else
				{
					for(idx in array)
					{
						var checkbox = "<label class=\"checkbox col-sm-4\"> "+
											"<input name=\"websites\" type=\"checkbox\" "+
												"value='"+array[idx].id+"' disabled "+
												"onclick=\"return chooseWebsite(this);\" "+
          										"/> "+
									    	array[idx].websiteName+
									 	"</label>";
						$(checkbox).appendTo("#websiteCheckboxPanel");
					}
					
									
					return;
				}
				
			}, 
			"json");
}

// 加载区域
function loadAreas()
{
	$.get("areas?sortColumn=areaName&sortOrder=ASC", 
			null, 
			function(areas){
				// 加载数据到表单
				var array = areas.currentPage;
				if(array.length == 0)
				{
					// 提示当前没有可用的区域
					var checkbox = "<label class=\"checkbox col-sm-12\"> "+
											"<input name=\"areas\" type=\"checkbox\" "+
												"value='0' disabled /> "+
									    	"尚未添加虚拟域"+
									 	"</label>";
					$(checkbox).appendTo("#areaCheckboxPanel"); 	
					return;
				}
				else
				{
					for(idx in array)
					{
						var checkbox = "<label class=\"checkbox col-sm-4\"> "+
											"<input name=\"areas\" type=\"checkbox\" "+
												"value='"+array[idx].id+"' disabled "+
												"onclick=\"return chooseArea(this);\" "+
          										"/> "+
									    	array[idx].areaName+
									 	"</label>";
						$(checkbox).appendTo("#areaCheckboxPanel");
					
					}
					return;
				}
				
			}, 
			"json");
}

// 广告物料类型切换
function switchAdvType(advType)
{
	if(advType === 'url')
	{
		$("#advUrl").removeAttr("readonly");
		$("#advFileDisplay").attr("readonly","readonly");
		
		// 消除file模式中可能存在的告警
		$formGroup = $("#advFile").parents(".form-group").first();
      	$formGroup.removeClass("has-error");
      	$formGroup.find(".help-block").first().text('');
	}
	else if(advType === 'file')
	{
		$("#advUrl").attr("readonly","readonly");
		$("#advFileDisplay").removeAttr("readonly");
		
		// 消除url模式中可能存在的告警
		$formGroup = $("#advUrl").parents(".form-group").first();
      	$formGroup.removeClass("has-error");
      	$formGroup.find(".help-block").first().text('');
	}
}

// 推广类型切换
function switchSpreadType(spreadType)
{
	var option0 = $("#websiteCheckboxPanel input[value='0']").length;
	
	if(spreadType === 'normal')
	{
		// checkbox设置为disabled
		$("#websiteCheckboxPanel input").attr('disabled','disabled');
		return true;
	}
	// 选择精准推送且已配置关联网站时，允许切换
	else if(spreadType === 'accurate' && option0 !== 1)
	{
		$("#websiteCheckboxPanel input").removeAttr('disabled');
		return true;
	}
	else
	{
		// checkbox设置为disabled
		$("#websiteCheckboxPanel input").attr('disabled','disabled');
		return false;
	}
}
	
// 推广范围切换
function switchScope(scope)
{	
	var option0 = $("#areaCheckboxPanel input[value='0']").length;
	
	if(scope === 'global')
	{
		// checkbox设置为disabled
		$("#areaCheckboxPanel input").attr('disabled','disabled');
		return true;
	}
	// 选择精准推送且已配置关联网站时，允许切换
	else if(scope === 'area' && option0 !== 1)
	{
		$("#areaCheckboxPanel input").removeAttr('disabled');
		return true;
	}
	else
	{
		// checkbox设置为disabled
		$("#areaCheckboxPanel input").attr('disabled','disabled');
		return false;
	}
}

// 校验方法
function date_callback_function($el, value, callback) 
{
	// 清除提示信息
	$('#dateCheckMessage').hide();

	// 提取输入值
	var startDate = $('#startDate').val();
	var endDate = $('#endDate').val();
	
	// 判断是否输入格式正确，若生效时间未输入，则不需要进行ajax校验
	if( startDate != null && startDate.length >0 )
	{
		// 若失效时间未输入，不进行校验
		if( endDate != null && endDate.length >0 )
		{
			var start = Date.parse(startDate);
			var end = Date.parse(endDate);
			// 判断生效时间与失效时间是否有效
        	if( start > end )
        	{
        		$('#dateCheckMessage').show();
        	}
		}
	}
	
	// 根据校验结果回调
    callback({
      value: value,
      valid: true,
      message: "生效时间/失效时间冲突，请确认后重新填写。"
    });
}

// 校验方法
function advUrl_callback_function($el, value, callback) 
{
	var isValid = false;
	
	// advUrl不能为空，不能超过100字符
	if(value == null || value.length == 0 || value.length > 100)
	{
		isValid = false;
	}
	else
	{
		// 如果为URL地址，则进行正则表达式校验
		isValid = /[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?/.test(value);		
	}	
	
	// 根据校验结果回调
    callback({
      value: value,
      valid: isValid,
      message: "请输入正确的URL。"
    });
}

// 选择关联网站
function chooseWebsite(inputObj)
{
	// 当选中时，将提示信息隐藏
	if(inputObj.checked == true)
	{
		$('#websiteCheckMessage').css('display','none');
	}
}

// 选择虚拟域
function chooseArea(inputObj)
{
	// 当选中时，将提示信息隐藏
	if(inputObj.checked == true)
	{
		$('#areaCheckMessage').css('display','none');
	}
}



</script>
</body>
</html>




