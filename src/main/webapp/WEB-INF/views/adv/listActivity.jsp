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
    <!-- <link rel="icon" href="resources/img/favicon_16X16.ico" mce_href="resources/img/favicon_16X16.ico" type="image/x-icon">  -->
	<!-- Bootstrap -->
	<link href="resources/bootstrap-3.0.0/css/bootstrap.css" rel="stylesheet" type="text/css">
	<!-- Custom styles -->
    <link href="resources/plugin/sticky-footer-navbar.css" rel="stylesheet" type="text/css">
 
    <script type="text/javascript" src="resources/jquery-1.10.2/jquery-1.10.2.js"></script>
	<script type="text/javascript" src="resources/bootstrap-3.0.0/js/bootstrap.js"></script>
	<script type="text/javascript" src="resources/plugin/handlebars-1.0.rc.1.js"></script>
    <script type="text/javascript" src="resources/plugin/simplePagingGrid-0.6.0.0.js"></script>
	<script type="text/javascript">
	
		// 提取URL查询参数
		var param = location.search.split("&");
		var paging = param[0].split("=")[1];
		if(paging == undefined)
		{
			var startPage = 0;		// 起始页序号
			var pageSize = 12;		// 默认每页记录数
			var sortColumn = "activityName";		// 默认排序字段
			var sortOrder = "desc";					// 默认排序
		}
		// 从其他页面返回，带有排序等参数
		else
		{
			var startPage = paging.split("|")[0];
			var pageSize = paging.split("|")[1];
			var sortColumn = paging.split("|")[2];
			var sortOrder = paging.split("|")[3];
		}
		
		
		// 页面加载时执行，注册表格插件
		$(document).ready(function(){
	        $("#exampleGrid").simplePagingGrid({
	        	tableClass: "table table-striped table-bordered table-condensed",
	            columnNames: ["","活动名称", "公司", "联系人/联系电话","操作"],
	            columnKeys: ["id","activityName", "company", "linkman","operation"],
	            columnWidths: ["5%","20%", "20%", "25%", "30%"],
	            sortable: [false, true, true, true, false],
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
	            	"<input type='checkbox' name='{{activityName}}' id='{{id}}'>",
			        "{{activityName}}",
			        "{{company}}",
			        "{{linkman}}/{{linkmanPhone}}",
			        "<a href='activities/editPage?id={{id}}&paging={{../paging}}' " +
			        			"style='margin-right:15px'>修改</a> "+
			        "<a href='#' style='margin-right:15px' "+
			        			"onclick='return openDelDialog({{id}},"+
			        			"\"{{activityName}}\",\"{{company}}\","+
			        			"\"{{linkman}}\",\"{{linkmanPhone}}\");' "+
			        			">删除</a>"+
			        "<a href='#' style='margin-right:15px'>创建广告订单</a>"
			    ],
	            dataUrl: "activities"
		    });
		    
		    // 绑定全选按钮事件
		    var selallflag=false;
			$("#c_all").click(function(){
				selallflag = !selallflag;
                $('td input').prop("checked",selallflag);
			});
			
			// 注册关闭对话框并刷新列表
			$("#giveupDelete").click(function(){
				$("#deleteDialog").modal('toggle');
				$("#exampleGrid").simplePagingGrid('refresh');
				return false;
			});
			
			// 刷新列表
			$("#refreshActivities").click(function(){
				$("#exampleGrid").simplePagingGrid('refresh');
			});
			
			// 批量删除
			$("#batchDelete").click(openBatchDelDialog);
		});
		
		// 打开删除对话框
		function openDelDialog(id, activityName, company, linkman, linkmanPhone)
		{
			// 显示活动名称和详细信息
			$('#deleteDialog .modal-title').text("请确认是否删除活动 "+activityName+"？");
			$('#deleteDialog .modal-body ul').html("<li>公司："+company+"</li>"+
				"<li>联系人："+linkman+"</li>"+
				"<li>联系电话："+linkmanPhone+"</li>");

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
				$('#deleteDialog .modal-title').text("请确认是否删除下列活动？");
	
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
                url: "activities/"+ids+"?_method=delete",  
                data: null, 
                success: function(activity){
                	// 关闭对话框并刷新列表
					$('#deleteDialog').modal('toggle');
					$("#exampleGrid").simplePagingGrid('refresh');
                },  
                error: function(error){
                	// 提示删除错误
                	$('#deleteDialog .modal-title').text("在删除活动时发生了异常，请点击“确认”重复尝试或者点击“放弃”返回活动列表。");
                	$('#deleteDialog .modal-title').css("font-color","red");
                }
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
      			
      			<div class="col-md-8" style="border: 1px solid #f1f1f1;">
      				<!-- main area -->
  				   	<div id="legend" style="margin-top:5px;margin-bottom:5px">
		        		<a class="btn btn-default" href="activities/createPage" role="button">
							<span class="glyphicon glyphicon-plus"></span> 新增广告活动
						</a>&nbsp;
						<a class="btn btn-default" href="#" role="button">
							<span class="glyphicon glyphicon-search"></span> 查找
						</a>&nbsp;
						<a id="batchDelete" class="btn btn-default" href="#" role="button">
							<span class="glyphicon glyphicon-remove"></span> 删除
						</a>&nbsp;
						<a id="refreshActivities" class="btn btn-default" href="activities/listPage" role="button">
							<span class="glyphicon glyphicon-refresh"></span> 刷新
						</a>&nbsp;
			      	</div>
					
					
					<div id="exampleGrid"></div>
      				<!-- end of main area -->
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
		        	<a id="confirmDelete" href="#" class="btn btn-default" role="button">确认</a>
                	<a id="giveupDelete" href="#" class="btn btn-default" role="button">放弃</a>
		      	</div>
    		</div><!-- /.modal-content -->
  		</div><!-- /.modal-dialog -->
	</div><!-- end of Response Dialog -->
	
</body>
</html>




