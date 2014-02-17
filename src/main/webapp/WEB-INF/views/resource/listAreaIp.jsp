<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="../include/include_head.jsp" %>	
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
				<div class="panel panel-default">
				<div class="panel-heading">区域IP地址段 - <strong id="areaName"></strong></div>
				<div class="panel-body">
					
					<div class="alert alert-success alert-dismissable" style="padding-top:5px;padding-bottom:5px;display:none">
					 	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					 	<strong></strong> 
					</div>
					<div class="alert alert-warning alert-dismissable" style="padding-top:5px;padding-bottom:5px;display:none">
					 	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					 	<strong></strong>
					</div>
					
					<div class="col-sm-6">
					
						<div id="legend" style="margin-bottom:5px">
							<a id="queryButton" class="btn btn-default btn-xs" style="padding: 1px 5px;" href="#" role="button">
								<span class="glyphicon glyphicon-search"></span> 查找
							</a>&nbsp;
							<a id="batchDeleteButton" class="btn btn-default btn-xs" style="padding: 1px 5px;" href="#" role="button">
								<span class="glyphicon glyphicon-remove"></span> 删除
							</a>&nbsp;
							<a id="refreshButton" class="btn btn-default btn-xs" style="padding: 1px 5px;" href="#" role="button">
								<span class="glyphicon glyphicon-refresh"></span> 刷新
							</a>&nbsp;
						</div>
						
						<div id="queryBar" class="row" style="margin:5px auto;border: 1px solid #f1f1f1;display:none;">
							<form class="form-inline"  novalidate>
							<div class="form-group" style="margin:5px;">
								<input id="queryByAreaIp" class="form-control input-sm" style="width:150px;"  placeholder="网站地址">
						  	</div>
						  	
						  	<button id="doQueryAreaIp" class="btn btn-default btn-xs">查询</button>
						  	<button id="clearQueryAreaIp" class="btn btn-default btn-xs">放弃查询</button>
					    	
							</form>
						</div>
						
	        			<div id="areaIpGrid"></div>
					
					</div>
					<div class="col-sm-6">
						
						<form class="form-horizontal" novalidate>
						<fieldset>
						
						<!-- 地址类型 -->
						<input type="hidden" name="ipType" value="ipMask">
												
						<div class="form-group ">		<!-- IP起始地址 -->
	      					<label class="control-label col-sm-3" style="padding-left:0px;padding-right:0px">起始地址：</label>
	      					<div class="col-sm-8 controls">
	        					<input id="ipStartText" name="ipStartText" type="text" 
											class="form-control input-sm" placeholder="例如：10.1.1.1" 
											required
											data-validation-required-message="请输入正确的IP地址"
											data-validation-regex-regex="((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))"
	        								data-validation-regex-message="请输入正确的IP地址" 
	        								data-validation-callback-callback="ips_callback_function">
								<p class="help-block"></p>
	      					</div>
	        			</div>
	        			       			
	        			<div class="form-group ">		<!-- 掩码长度 -->
	      					<label class="control-label col-sm-3" style="padding-left:0px;padding-right:0px">掩码长度：</label>
	      					<div class="col-sm-8 controls">
	        					<input id="maskLength" name="maskLength" type="number" 
											class="form-control input-sm" placeholder="例如：24"
											required
											data-validation-required-message="掩码长度为1-32"
											min="1" max="32" 
											data-validation-max-message="掩码长度为1-32"
											data-validation-callback-callback="ips_callback_function">
								<p class="help-block"></p>
	      					</div>
	        			</div>
		        		
						<div id="ipCheckMessage" class="form-group has-warning" style="display:none">		<!-- 冲突提示信息 -->
	      					<label class="col-sm-3"></label>
	      					<div class="col-sm-9 controls">
	        					<p class="help-block">注意：IP段地址冲突，请确认后重新填写。</p>
	      					</div>
	        			</div>
		        		
		    			<div class="form-group">		<!-- 按钮 -->
							<div class="col-sm-2" style="padding-left:0px;padding-right:0px"></div>
							<div class="col-sm-9">
								<button type="submit" class="btn btn-primary btn-sm" >提交</button>&nbsp;
        						<button id="returnToListBtn" type="button" class="btn btn-default btn-sm">返回</button>
							</div>
						</div> 
						</fieldset>
						</form>
						
					</div>

				</div> <!-- end of panel-body -->
				</div> <!-- end of panel -->
      			</div> <!-- end of main area -->
      		
      			<div class="col-md-2" ></div>
      		</div>
      	</div>
	</div><!-- end of Wrap -->
  	
  	<%@ include file="../include/include_bottom.jsp" %>
	
	<!-- Response Dialog -->
	<div class="modal fade" id="deleteDialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
		        	<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>  -->
		        	<h4 class="modal-title"></h4>
		      	</div>
      			<div class="modal-body">
        			<p>将要被删除的信息：</p>
        			<ul>
        			</ul>
                	
      			</div>
				<div class="modal-footer">
		        	<a id="confirmDelete" href="#" class="btn btn-default btn-sm" role="button">确认</a>
                	<a id="giveupDelete" href="#" class="btn btn-default btn-sm" role="button">放弃</a>
		      	</div>
    		</div><!-- /.modal-content -->
  		</div><!-- /.modal-dialog -->
	</div><!-- end of Response Dialog -->
	
<%@ include file="../include/include_js.jsp" %>
<script type="text/javascript" src="resources/plugin/jqBootstrapValidation.js"></script>
<script type="text/javascript" src="resources/plugin/handlebars-1.0.rc.1.js"></script>
<script type="text/javascript" src="resources/plugin/simplePagingGrid-0.6.0.0.js"></script>
<script>

$(function (){

	// 分析URL，控制nav_top和nav_left
	controlNav();

	// 提取URL查询参数
	var param = location.search.split("&");
	var editId = param[0].split("=")[1];
	var paging = param[1].split("=")[1];
	var query = param[2].split("=")[1];

	// 注册页面返回按钮事件
	$("#returnToListBtn").click(function(){
		window.location = "areas/listPage?paging="+paging+"&query="+query;
	});
	
	// 加载待修改的活动信息
	$.get('areas/'+editId, null, 
			function(area){
				// 加载数据到表单
				$("#areaName").text(area.areaName);
			}, 
			"json");
	
	// 注册校验器
	$("input,select,textarea").not("[type=submit]").jqBootstrapValidation({
		submitSuccess: function(form,event){
			event.preventDefault();		// 停止URL参数形式的提交操作，使用ajax方式提交来替代
			// 判断是否IP段冲突
			if($('#ipCheckMessage').css('display') == "block")
			{
				$('#ipCheckMessage').removeClass("has-warning").addClass("has-error");			
			}
			else
			{
				sendRequest(editId,form.serializeArray());
			}
		}
	});
	
	// 表格函数
	var ipQuery="";

	// 注册表格插件
    $("#areaIpGrid").simplePagingGrid({
    	tableClass: "table table-striped table-bordered table-condensed",
        columnNames: ["","IP地址段","操作"],
        columnKeys: ["id","ipStartText","operation"],
        columnWidths: ["10%","65%", "25%"],
        sortable: [false, true, false],
        showLoadingOverlay: false,
    	initialSortColumn: "ipStartText",
        sortOrder: "asc",
        pageNumber: 0,
        pageSize: 10,
    	minimumVisibleRows: 10,
    	numberOfPageLinks: 3,
    	showGotoPage: false,
    	headerTemplates: [
			"<th><input type='checkbox' id='c_all'></th>"
		],
    	cellTemplates: [
    		"<input type='checkbox' name='{{ipStartText}}/{{maskLength}}' id='{{id}}'>",
	        "{{ipStartText}}/{{maskLength}}",
	        "<a href='#' style='margin-right:5px' "+
	        			"onclick='return openDelDialog({{id}},\"{{ipStartText}}/{{maskLength}}\",{{areaId}});' "+
	        			">删除</a>"
	    ],
    	dataUrl: "areas/"+editId+"/areaIps?query="+ipQuery
    	
    });
    
    // 绑定全选按钮事件
    var selallflag=false;
	$("#c_all").click(function(){
		selallflag = !selallflag;
        $('td input').prop("checked",selallflag);
	});

	// 刷新列表
	$("#refreshButton").click(function(){
		closeAlertBar();
		$("#areaIpGrid").simplePagingGrid("refresh");
		return false;
	});
	
	// 删除控制脚本start
	// 注册删除关闭对话框并刷新列表
	$("#giveupDelete").click(function(){
		$("#deleteDialog").modal('hide');
		$("#areaIpGrid").simplePagingGrid("refresh");
		return false;
	});
	// 批量删除
	$("#batchDeleteButton").click(function(){
		return openBatchDelDialog(editId);
	});
	// 删除控制脚本end
	
	// 查询窗口控制脚本start
	// 查询窗口打开或关闭
	$("#queryButton").click(function(){
	
		if($("#queryBar").css("display") == "none")
		{
			$("#queryBar").css("display","block");
			$("#queryButton").addClass("active");
		}
		return false;
	});
	
	// 查询
	$("#doQueryAreaIp").click(function(){
		
		closeAlertBar();
				
		// 替换原有查询字符串
		// TODO 需要考虑对查询字符串编码
		ipQuery = $("#queryByAreaIp").val();	
		$("#areaIpGrid").simplePagingGrid("refresh","areas/"+editId+"/areaIps?query="+ipQuery);
		return false;
	});
	
	// 清空查询
	$("#clearQueryAreaIp").click(function(){
	
		closeAlertBar();
	
		// 清空查询字符串
		$("#queryByAreaIp").val("");
		ipQuery = "";
		$("#areaIpGrid").simplePagingGrid("refresh","areas/"+editId+"/areaIps?query="+ipQuery);
		
		// 关闭查询区域
		$("#queryBar").css("display","none");
		$("#queryButton").removeClass("active");
		return false;
	});
	// 查询窗口控制脚本end
})


function sendRequest(areaId,data)
{
	// 提交添加请求
	$.ajax({  
		type: "POST",  
        async:false,  // 同步执行，根据返回结果确定是否关闭对话框
        contentType: "application/json;charset=UTF-8",  
        dataType: "json", 
        url: "areas/"+areaId+"/areaIps/",  
        data: JSON.stringify(serializeObject(data)), 
        success: function(areaIp){
        	// 关闭对话框并刷新列表
        	$(".alert-success").css("display","block");
        	$(".alert-success strong").html("添加成功！ 更新时间：" + formatTimeSecond(areaIp.lastUpdateTime));
        	$(".alert-warning").css("display","none");
        	
			$("#areaIpGrid").simplePagingGrid("refresh");
			
			// 清空input
			$("#ipStartText").val("");
			$("#maskLength").val("");
			
			// 切换到锚点
			location.hash="anchor_top";
        },  
        error: function(error){
        	// 提示删除错误
        	$(".alert-success").css("display","none");
        	$(".alert-warning").css("display","block");
        	$(".alert-warning strong").html("添加失败！ 错误信息：" + getErrorMessage(error));
        	
			$("#areaIpGrid").simplePagingGrid("refresh");

			// 清空input
			$("#ipStartText").val("");
			$("#maskLength").val("");
			
			// 切换到锚点
			location.hash="anchor_top";
        }
	});    
}

// 打开删除对话框
function openDelDialog(id, areaIp, areaId)
{
	closeAlertBar();
		
	// 显示活动名称和详细信息
	$('#deleteDialog .modal-title').text("请确认是否删除？");
	$('#deleteDialog .modal-body ul').html("<li>区域IP地址段："+areaIp+"</li>");

	// 绑定confirmDelete按钮的click事件
	$("#confirmDelete").click(function(){
		sendConfirmDelete(areaId,id);
		$("#confirmDelete").unbind('click'); //解除绑定
		return false;
	}); 		

	// 显示对话框
	$('#deleteDialog').modal({
            		backdrop: 'static',
					keyboard: false
				});
	return false;
}

// 打开批量删除对话框
function openBatchDelDialog(areaId)
{
	closeAlertBar();
	// 获取选中的ID数组
	var batchIds = new Array();
	var batchNames = new Array();
	var index = 0;
	$('td input').each(function(){
		if(this.checked == true){
			batchIds[index] = this.id;
			batchNames[index] = this.name;
			index++;
		}
	});
	
	// 如果没有选中直接返回，不弹出对话框
	if(batchIds.length==0)
	{
		return false;
	}
	// 弹出确认窗口
	else
	{
		// 显示活动名称和详细信息
		$('#deleteDialog .modal-title').text("请确认是否删除下列区域IP地址段？");

		var nameDisplay = "";
		for(idx in batchNames){
			 nameDisplay = nameDisplay + "<li>"+batchNames[idx]+"</li>";
		}
		$('#deleteDialog .modal-body ul').html(nameDisplay);
		
		// 绑定confirmDelete按钮的click事件
		$("#confirmDelete").click(function(){
			sendConfirmDelete(areaId,batchIds.join(","));
			$("#confirmDelete").unbind('click'); //解除绑定
			return false;
		}); 
		
		// 显示对话框
		$('#deleteDialog').modal({
                		backdrop: 'static',
  						keyboard: false
					});
		return false;
	}
}

// 绑定confirmDelete按钮的click事件
function sendConfirmDelete(areaId, ids)
{ 
	$.ajax({  
		type: "POST",  
        async:false,  // 同步执行，根据返回结果确定是否关闭对话框
        contentType: "application/json;charset=UTF-8",  
        dataType: "json", 
        url: "areas/"+areaId+"/areaIps/"+ids+"?_method=delete",  
        data: null, 
        success: function(areaIp){
        	// 关闭对话框并刷新列表
			$('#deleteDialog').modal('hide');
			$("#areaIpGrid").simplePagingGrid("refresh");
        },  
        error: function(error){
        	// 提示删除错误
        	$('#deleteDialog .modal-title').text("在删除区域Ip地址段发生了异常，请点击“确认”重复尝试或者点击“放弃”返回管理区域IP地址段。");
        	$('#deleteDialog .modal-title').css("font-color","red");
        }
	});       
} 

// 校验方法
function ips_callback_function($el, value, callback) 
{
	// 清除提示信息
	$('#ipCheckMessage').hide();

	// 提取输入值
	var ip = $('#ipStartText').val();
	var maskLength = $('#maskLength').val();
	
	// 判断是否输入格式正确，若不满足IP地址规则，则不需要进行ajax校验
	var ipValid = /((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))/.test(ip);
	if( ipValid == true )
	{
		// 若mask长度非法，不进行校验
		if(maskLength >=1 && maskLength <= 32)
		{
			// 向后台请求校验
			$.ajax({  
				type: "GET",  
		        async:false,  // 同步执行，根据返回结果确定是否关闭对话框
		        contentType: "application/json;charset=UTF-8",  
		        dataType: "json", 
		        url: "areas/0/areaIps/checkIpSegmentIfDup?ip="+ip+"&maskLength="+maskLength,  
		        data: null, 
		        success: function(result){
		        	// 根据返回值判断是否通过校验
		        	if( result.valid == false)
		        	{
		        		$('#ipCheckMessage').show();
		        	}
		        },  
		        error: function(error){
		        	// 异常情况下，认为校验通过，不处理
		        }
			});       
		}
	}
	
	// 根据校验结果回调
    callback({
      value: value,
      valid: true,
      message: "IP段地址冲突，请确认后重新填写。"
    });
}

</script>
</body>
</html>




