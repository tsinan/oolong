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
  				   	<div id="legend" style="margin-bottom:5px">
						<a id="queryButton" class="btn btn-default btn-sm" href="#" role="button">
							<span class="glyphicon glyphicon-search"></span> 查找
						</a>&nbsp;
						<a id="batchDeleteButton" class="btn btn-default btn-sm" href="#" role="button">
							<span class="glyphicon glyphicon-remove"></span> 删除
						</a>&nbsp;
						<a id="refreshButton" class="btn btn-default btn-sm" href="#" role="button">
							<span class="glyphicon glyphicon-refresh"></span> 刷新
						</a>&nbsp;
			      	</div>
					
					<div id="queryBar" class="row" style="margin:5px auto;border: 1px solid #f1f1f1;display:none;">
						<form class="form-inline"  novalidate>
						<div class="form-group">
							<input id="queryByActiName" class="form-control input-sm" style="width:150px;"  placeholder="活动名称">
					  	</div>
					  	
					  	<button id="doQueryActivities" class="btn btn-default btn-xs">查询</button>
					  	<button id="clearQueryActivities" class="btn btn-default btn-xs">放弃查询</button>
				    	
						</form>
					</div>
					
					<div id="activityGrid"></div>
      				<!-- end of main area -->
      			</div>
      		
      			<div class="col-md-2" ></div>
      		</div>
      	</div>
	</div><!-- end of Wrap -->
  	
	<%@ include file="../include/include_bottom.jsp" %>

	<%@ include file="../include/include_deleteDialog.jsp" %>


<%@ include file="../include/include_js.jsp" %>
<script type="text/javascript" src="resources/plugin/handlebars-1.0.rc.1.js"></script>
<script type="text/javascript" src="resources/plugin/simplePagingGrid-0.6.0.0.js"></script>
<script>

// 页面加载时执行，注册表格插件
$(function(){
	
	// 分析URL，控制nav_top和nav_left
	controlNav();

	// 提取URL查询参数
	var param = location.search.split("&");
	if(param.length==1 && param[0]=="")
	{
		// 参数为空，首次进入
		var startPage = 0;		// 起始页序号
		var pageSize = 12;		// 默认每页记录数
		var sortColumn = "lastUpdateTime";		// 默认排序字段
		var sortOrder = "desc";					// 默认排序
		var query = "";						// 查询字符串		
	}
	else
	{
		// 从其他页面返回，带有排序等参数
		var paging = param[0].split("=")[1];
		
		var startPage = paging.split("|")[0];
		var pageSize = paging.split("|")[1];
		var sortColumn = paging.split("|")[2];
		var sortOrder = paging.split("|")[3];
		
		// 查询参数，以|分隔
		var query = param[1].split("=")[1];
		
		// 有查询参数时，将查询区域打开
		if(query != "")
		{
			$("#queryBar").css("display","block");
			$("#queryButton").addClass("active");
			
			// 设置查询字符串
			$("#queryByActiName").val(decodeURIComponent(decodeURIComponent(query)));
		}
	}

	// 注册表格插件
    $("#activityGrid").simplePagingGrid({
    	tableClass: "table table-striped table-bordered table-condensed",
        columnNames: ["","活动名称", "广告数量", "公司", "联系人/联系电话","操作"],
        columnKeys: ["id","activityName","advCount", "company", "linkman","operation"],
        columnWidths: ["5%","20%", "15%", "15%", "20%", "25%"],
        sortable: [false, true, true, true, true, false],
        showLoadingOverlay: false,
        initialSortColumn: sortColumn,
        sortOrder: sortOrder,
        pageNumber: startPage,
        pageSize: pageSize,
    	minimumVisibleRows: 5,
    	numberOfPageLinks: 3,
    	headerTemplates: [
			"<th><input type='checkbox' id='c_all'></th>"
		],
        cellTemplates: [
        	"<input type='checkbox' name='{{activityName}}' id='{{id}}_{{advCount}}'>",
	        "{{activityName}}",
	        "{{advCount}}",
	        "{{company}}",
	        "{{linkman}}/{{linkmanPhone}}",
	        "<a href='activities/editPage?id={{id}}&paging={{../paging}}&query={{../query}}' " +
	        			"style='margin-right:15px'>修改</a> "+
	        "<a href='#' style='margin-right:15px' "+
	        			"onclick='return openDelDialog({{id}},"+
	        			"\"{{activityName}}\",{{advCount}},\"{{company}}\","+
	        			"\"{{linkman}}\",\"{{linkmanPhone}}\");' "+
	        			">删除</a>"+
	        "<a href='advs/createPage?activityId={{id}}' style='margin-right:15px'>创建广告订单</a>"
	    ],
        dataUrl: "activities?query="+query
    });
    
    // 绑定全选按钮事件
    var selallflag=false;
	$("#c_all").click(function(){
		selallflag = !selallflag;
        $('td input').prop("checked",selallflag);
	});
	
	// 刷新列表
	$("#refreshButton").click(function(){
		$("#activityGrid").simplePagingGrid("refresh");
		return false;
	});
	
	// 删除控制脚本start
	// 注册删除关闭对话框并刷新列表
	$("#giveupDelete").click(function(){
		$("#deleteDialog").modal('hide');
		$("#activityGrid").simplePagingGrid("refresh");
		return false;
	});
	
	// 批量删除
	$("#batchDeleteButton").click(openBatchDelDialog);
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
	$("#doQueryActivities").click(function(){
		// 替换原有查询字符串
		query = encodeURIComponent(encodeURIComponent($("#queryByActiName").val()));	
		$("#activityGrid").simplePagingGrid("refresh","activities?query="+query);
		
		return false;
	});
	
	// 清空查询
	$("#clearQueryActivities").click(function(){
		// 清空查询字符串
		$("#queryByActiName").val("");
		query = "";
		$("#activityGrid").simplePagingGrid("refresh","activities?query="+query);
		
		// 关闭查询区域
		$("#queryBar").css("display","none");
		$("#queryButton").removeClass("active");
		return false;
	});
	// 查询窗口控制脚本end
});

// 打开删除对话框
function openDelDialog(id, activityName, advCount, company, linkman, linkmanPhone)
{
	if(advCount > 0)
	{
		// 显示活动名称和详细信息
		$('#deleteDialog .modal-title').text("活动 "+activityName+" 无法删除，请先删除相关广告。");
		$('#deleteDialog .modal-title').removeClass("text-warning").addClass("text-danger");
		$('#deleteDialog .modal-body p').html("<p>将要被删除的信息：</p>");
		$('#deleteDialog .modal-body ul').html("<li>广告数量："+advCount+"</li>"+
			"<li>公司："+company+"</li>"+
			"<li>联系人："+linkman+"</li>"+
			"<li>联系电话："+linkmanPhone+"</li>");
			
		//隐藏确认按钮
		$("#confirmDelete").addClass("disabled");
	}
	else
	{
		// 显示活动名称和详细信息
		$('#deleteDialog .modal-title').text("请确认是否删除活动 "+activityName+"？");
		$('#deleteDialog .modal-title').removeClass("text-danger").addClass("text-warning");
		$('#deleteDialog .modal-body ul').html("<li>广告数量："+advCount+"</li>"+
			"<li>公司："+company+"</li>"+
			"<li>联系人："+linkman+"</li>"+
			"<li>联系电话："+linkmanPhone+"</li>");
	
		// 删除可能存在的disabled样式
		$("#confirmDelete").removeClass("disabled");
	
		// 绑定confirmDelete按钮的click事件
		$("#confirmDelete").click(function(){
			sendConfirmDelete(id);
			$("#confirmDelete").unbind('click'); //解除绑定
			return false;
		});
	}
	
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
	// 获取选中的ID数组
	var batchIds = new Array();
	var batchNames = new Array();
	var batchAdvCounts = new Array();
	var index = 0;
	$('td input').each(function(){
		if(this.checked == true){
			batchIds[index] = this.id.split('_')[0];
			batchAdvCounts[index] = this.id.split('_')[1];
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
		$('#deleteDialog .modal-title').text("请确认是否删除下列活动？");
		$('#deleteDialog .modal-body p').html("<p>将要被删除的信息：</p>");
		
		var nameDisplay = "";
		for(idx in batchNames)
		{
			if(batchAdvCounts[idx] == 0)
			{
				nameDisplay = nameDisplay + "<li>"+batchNames[idx]+"</li>";
			}
			else
			{
				nameDisplay = nameDisplay + "<li>无法删除："+batchNames[idx]+"（广告订单数量："+batchAdvCounts[idx]+"）</li>";
			}
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
        url: "activities/"+ids+"?_method=delete",  
        data: null, 
        success: function(activity){
        	// 关闭对话框并刷新列表
			$('#deleteDialog').modal('hide');
			$("#activityGrid").simplePagingGrid("refresh");
        },  
        error: function(error){
        	// 提示删除错误
        	$('#deleteDialog .modal-title').text("在删除活动时发生了异常，请点击“确认”重复尝试或者点击“放弃”返回活动列表。");
        	$('#deleteDialog .modal-title').css("font-color","red");
        }
	});       
} 
</script>
</body>
</html>




