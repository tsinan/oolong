<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>oolong</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="<%=contextPath%>/resources/img/favicon_16X16.ico" mce_href="<%=contextPath%>/resources/img/favicon_16X16.ico" type="image/x-icon">
	<!-- Bootstrap -->
	<link href="<%=contextPath%>/resources/bootstrap-3.0.0/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<!-- Custom styles -->
    <link href="<%=contextPath%>/resources/plugin/sticky-footer-navbar.css" rel="stylesheet" type="text/css">
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
						<li><a href="<%=contextPath%>/">首页</a></li>
						<li class="dropdown">
							<a href="#adv" class="dropdown-toggle" data-toggle="dropdown">广告管理 <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="<%=contextPath%>/activity/create">新建广告活动</a></li>
			                  	<li><a href="<%=contextPath%>/activity/list">查看广告活动</a></li>
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
      			<div class="col-md-10">
      				
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
<script type="text/javascript" src="<%=contextPath%>/resources/jquery-1.10.2/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/resources/bootstrap-3.0.0/js/bootstrap.min.js"></script>
</body>
</html>




