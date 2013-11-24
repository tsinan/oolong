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
	<!-- Bootstrap -->
	<link href="resources/bootstrap-3.0.0/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<!-- Custom styles -->
    <link href="resources/plugin/sticky-footer-navbar.css" rel="stylesheet" type="text/css">
    <!-- easyui styles -->
    <link href="resources/jquery-easyui-1.3.3/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css">
    
    <script type="text/javascript" src="resources/jquery-1.10.2/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="resources/bootstrap-3.0.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="resources/plugin/handlebars-1.0.rc.1.js"></script>
    <script type="text/javascript" src="resources/plugin/simplePagingGrid-0.6.0.0.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
		        $("#exampleGrid").simplePagingGrid({
		            columnNames: ["Name", "Price ($)", "Quantity"],
		            columnKeys: ["Name", "Price", "Quantity"],
		            columnWidths: ["50%", "25%", "25%"],
		            sortable: [true, true, true],
		            initialSortColumn: "Name",
		            data: [
		                { "OrderLineID": 1, "Name": "Pineapple", "Price": 1.50, "Quantity": 4 },
						{ "OrderLineID": 2, "Name": "Strawberry", "Price": 1.10, "Quantity": 40 },
						{ "OrderLineID": 3, "Name": "Oranges", "Price": 0.20, "Quantity": 8 },
						{ "OrderLineID": 4, "Name": "Apples", "Price": 1.50, "Quantity": 5 },
						{ "OrderLineID": 5, "Name": "Raspberries", "Price": 1.50, "Quantity": 20 },
						{ "OrderLineID": 6, "Name": "Blueberries", "Price": 1.50, "Quantity": 20 },
						{ "OrderLineID": 7, "Name": "Pairs", "Price": 1.50, "Quantity": 8 },
						{ "OrderLineID": 8, "Name": "Melons", "Price": 1.50, "Quantity": 2 },
						{ "OrderLineID": 9, "Name": "Potatoes", "Price": 1.50, "Quantity": 6 },
						{ "OrderLineID": 10, "Name": "Sweet Potatoes", "Price": 1.50, "Quantity": 3 },
						{ "OrderLineID": 11, "Name": "Cabbages", "Price": 1.50, "Quantity": 1 },
						{ "OrderLineID": 12, "Name": "Lettuce", "Price": 1.50, "Quantity": 1 },
						{ "OrderLineID": 13, "Name": "Onions", "Price": 1.50, "Quantity": 25 },
						{ "OrderLineID": 14, "Name": "Carrots", "Price": 1.50, "Quantity": 30 },
						{ "OrderLineID": 15, "Name": "Broccoli", "Price": 1.50, "Quantity": 1 },
						{ "OrderLineID": 16, "Name": "Cauliflower", "Price": 1.50, "Quantity": 1 },
						{ "OrderLineID": 17, "Name": "Peas", "Price": 1.50, "Quantity": 1 },
						{ "OrderLineID": 18, "Name": "Sweetcorn", "Price": 1.50, "Quantity": 2 },
						{ "OrderLineID": 19, "Name": "Gooseberries", "Price": 1.50, "Quantity": 20 },
						{ "OrderLineID": 20, "Name": "Spring Onions", "Price": 1.50, "Quantity": 9 },
		                { "OrderLineID": 21, "Name": "Beetroot", "Price": 0.30, "Quantity": 3 },
                		{ "OrderLineID": 22, "Name": "Avocado", "Price": 2.30, "Quantity": 1 }]
		        });
		    });
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
						<li><a href="./">首页</a></li>
						<li class="dropdown">
							<a href="#adv" class="dropdown-toggle" data-toggle="dropdown">广告管理 <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="activities/create">新建广告活动</a></li>
			                  	<li><a href="activities/list">查看广告活动</a></li>
			                  	<li class="divider"></li>
			                  	<li><a href="#">新建广告订单</a></li>
								<li><a href="#">待处理广告订单</a></li>
			                  	<li><a href="#">已通过广告订单</a></li>
			                  	<li><a href="#">查看广告订单</a></li>
			                </ul>
						</li>
		              	<li class="dropdown">
		              		<a href="#user" class="dropdown-toggle" data-toggle="dropdown">用户管理 <b class="caret"></b></a>
		              		<ul class="dropdown-menu">
								<li><a href="#">公司信息</a></li>
			                  	<li><a href="#">我的信息</a></li>
			                </ul>
		              	</li>
		              	<li><a href="#report">报表管理</a></li>
		              	<li><a href="#media">媒体编码</a></li>
		            </ul>
				</div>
			</div>
		</div><!-- end of Fixed navbar -->

      	<!-- Begin page content -->
      	<div class="container">
      		<div class="row">
      			<div class="col-md-2">
      				<div class="bs-sidebar hidden-print" role="complementary">
      					<ul class="nav bs-sidenav">
							<li><a href="#overview"></a></li>
							<li><a href="#overview"></a></li>
							<li><a href="#overview"></a></li>
							<li><a href="#overview"></a></li>
							<li><a href="#overview"></a></li>
							<li><a href="#overview"></a></li>
						</ul>
      				</div>
      			</div>
      			<div class="col-md-8">
  				   	<div id="legend" style="margin-bottom:20px">
		        		<a class="btn btn-default" href="activities/create" role="button">
							<span class="glyphicon glyphicon-plus"></span> 新增广告活动
						</a>&nbsp;
						<a class="btn btn-default" href="#" role="button">
							<span class="glyphicon glyphicon-remove"></span> 删除
						</a>&nbsp;
						<a class="btn btn-default" href="activities/list" role="button">
							<span class="glyphicon glyphicon-refresh"></span> 刷新
						</a>&nbsp;
			      	</div>
					
					
					<div id="exampleGrid"></div>
      				
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

</body>
</html>




