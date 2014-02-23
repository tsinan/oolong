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
      			
				<!-- main area --> 
      			<div class="col-md-8" style="border-width: 0px 1px;border-style:solid;border-color:#f1f1f1;">
				 	
				<div class="panel panel-default">
				<div class="panel-heading">免推送网站地址</div>
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
								<input id="queryByFreePushUrl" class="form-control input-sm" style="width:150px;"  placeholder="免推送网站地址">
						  	</div>
						  	
						  	<button id="doQueryFreePushUrl" class="btn btn-default btn-xs">查询</button>
						  	<button id="clearQueryFreePushUrl" class="btn btn-default btn-xs">放弃查询</button>
					    	
							</form>
						</div>
						
	        			<div id="freePushUrlGrid"></div>
					</div>
					<div class="col-sm-6">
					
						<form class="form-horizontal" novalidate>
						<fieldset>
								
						<div class="form-group ">		<!-- 链接 -->
	      					<label class="control-label col-sm-2" style="padding-left:0px;padding-right:0px">地址：</label>
	      					<div class="col-sm-9 controls">
	        					<div class="input-group">
									<span class="input-group-addon" style="padding:8px 8px;width:60px">http(s)://</span>
									<input id="url" name="url" type="text" 
											class="form-control input-sm" style="width:180px"
											max="100" data-validation-max-message="最长输入100个字符"
											required
											data-validation-required-message="请输入正确的免推送网站URL"
											data-validation-regex-regex="[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?"
	        								data-validation-regex-message="请输入正确的免推送网站URL" 
	        								data-validation-ajax-ajax="freePushUrls/checkUrlIfDup">
								</div>
								<p class="help-block">支持模糊匹配</p>
	      					</div>
	        			</div>
		        			
		    			<div class="form-group">		<!-- 按钮 -->
							<div class="col-sm-2" style="padding-left:0px;padding-right:0px"></div>
							<div class="col-sm-9">
								<button type="submit" class="btn btn-primary btn-sm" >提交</button>
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
	
	<%@ include file="../include/include_deleteDialog.jsp" %>
	
	
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
		submitSuccess: function(form,event){
			event.preventDefault();		// 停止URL参数形式的提交操作，使用ajax方式提交来替代
			sendRequest(form.serializeArray());
		}
	});
	
	// 表格函数
	var urlQuery="";

	// 注册表格插件
    $("#freePushUrlGrid").simplePagingGrid({
    	tableClass: "table table-striped table-bordered table-condensed",
        columnNames: ["", "地址","操作"],
        columnKeys: ["id", "url","operation"],
        columnWidths: ["10%", "75%","15%"],
        sortable: [false, true, false],
        showLoadingOverlay: false,
    	initialSortColumn: "url",
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
    		"<input type='checkbox' name='{{url}}' id='{{id}}'>",
	        "{{url}}",
	        "<a href='#' style='margin-right:5px' "+
	        			"onclick='return openDelDialog({{id}},\"{{url}}\");' "+
	        			">删除</a>"
	    ],
    	dataUrl: "freePushUrls?urlQuery="+urlQuery
    	
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
		$("#freePushUrlGrid").simplePagingGrid("refresh");
		return false;
	});
	
	// 删除控制脚本start
	// 注册删除关闭对话框并刷新列表
	$("#giveupDelete").click(function(){
		$("#deleteDialog").modal('hide');
		$("#freePushUrlGrid").simplePagingGrid("refresh");
		return false;
	});
	// 批量删除
	$("#batchDeleteButton").click(function(){
		return openBatchDelDialog();
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
	$("#doQueryFreePushUrl").click(function(){
		
		closeAlertBar();
				
		// 替换原有查询字符串
		urlQuery = encodeURIComponent(encodeURIComponent($("#queryByFreePushUrl").val()));	
		$("#freePushUrlGrid").simplePagingGrid("refresh","freePushUrls?urlQuery="+urlQuery);
		return false;
	});
	
	// 清空查询
	$("#clearQueryFreePushUrl").click(function(){
	
		closeAlertBar();
	
		// 清空查询字符串
		$("#queryByFreePushUrl").val("");
		urlQuery = "";
		$("#freePushUrlGrid").simplePagingGrid("refresh","freePushUrls?urlQuery="+urlQuery);
		
		// 关闭查询区域
		$("#queryBar").css("display","none");
		$("#queryButton").removeClass("active");
		return false;
	});
	// 查询窗口控制脚本end
})


function sendRequest(data)
{
	// 提交添加请求
	$.ajax({  
		type: "POST",  
        async:false,  // 同步执行，根据返回结果确定是否关闭对话框
        contentType: "application/json;charset=UTF-8",  
        dataType: "json", 
        url: "freePushUrls/",  
        data: JSON.stringify(serializeObject(data)), 
        success: function(freePushUrl){
        	// 关闭对话框并刷新列表
        	$(".alert-success").css("display","block");
        	$(".alert-success strong").html("添加成功！ 更新时间：" + formatTimeSecond(freePushUrl.lastUpdateTime));
        	$(".alert-warning").css("display","none");
        	
			$("#freePushUrlGrid").simplePagingGrid("refresh");
			
			// 清空input
			$("#url").val("");
			
			// 切换到锚点
			location.hash="anchor_top";
        },  
        error: function(error){
        	// 提示删除错误
        	$(".alert-success").css("display","none");
        	$(".alert-warning").css("display","block");
        	$(".alert-warning strong").html("添加失败！ 错误信息：" + getErrorMessage(error));
        	
			$("#freePushUrlGrid").simplePagingGrid("refresh");

			// 清空input
			$("#url").val("");
			
			// 切换到锚点
			location.hash="anchor_top";
        }
	});    
}

// 打开删除对话框
function openDelDialog(id, freePushUrl)
{
	closeAlertBar();
		
	// 显示活动名称和详细信息
	$('#deleteDialog .modal-title').text("请确认是否删除？");
	$('#deleteDialog .modal-title').addClass("text-warning");
	$('#deleteDialog .modal-body p').html("<p>将要被删除的信息：</p>");
	$('#deleteDialog .modal-body ul').html("<li>免推送网站地址："+freePushUrl+"</li>");

	// 绑定confirmDelete按钮的click事件
	$("#confirmDelete").click(function(){
		sendConfirmDelete(id);
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
function openBatchDelDialog()
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
		$('#deleteDialog .modal-title').text("请确认是否删除下列免推送网站地址？");
		$('#deleteDialog .modal-body p').html("<p>将要被删除的信息：</p>");
		
		var nameDisplay = "";
		for(idx in batchNames){
			 nameDisplay = nameDisplay + "<li>"+batchNames[idx]+"</li>";
		}
		$('#deleteDialog .modal-body ul').html(nameDisplay);
		
		// 绑定confirmDelete按钮的click事件
		$("#confirmDelete").click(function(){
			sendConfirmDelete(batchIds.join(","));
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
function sendConfirmDelete(ids)
{ 
	$.ajax({  
		type: "POST",  
        async:false,  // 同步执行，根据返回结果确定是否关闭对话框
        contentType: "application/json;charset=UTF-8",  
        dataType: "json", 
        url: "freePushUrls/"+ids+"?_method=delete",  
        data: null, 
        success: function(freePushUrl){
        	// 关闭对话框并刷新列表
			$('#deleteDialog').modal('hide');
			$("#freePushUrlGrid").simplePagingGrid("refresh");
        },  
        error: function(error){
        	// 提示删除错误
        	$('#deleteDialog .modal-title').text("在删除免推送地址时发生了异常，请点击“确认”重复尝试。");
        	$('#deleteDialog .modal-title').css("font-color","red");
        }
	});       
} 

</script>
</body>
</html>




