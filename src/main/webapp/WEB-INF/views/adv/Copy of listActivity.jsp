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
					
					
					<table class="table  table-hover"  style="margin:10px auto 0 auto;">
					<thead>
						<tr>
							<th><input type="checkbox" value=""></th>
							<th>广告活动编号</th>
							<th>广告活动名称</th>
							<th>创建人</th>
							<th>公司名称</th>
							<th>创建时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="checkbox" value=""></div>
							</td>
							<td>01-201302200002</td>
							<td>通用汽车</td>
							<td>王某某</td>
							<td>杯京公司</td>
							<td>2013-02-20 12:28</td>
							<td>
								<span class="glyphicon glyphicon-floppy-open"></span> &nbsp;
								<span class="glyphicon glyphicon-floppy-remove"></span>
							</td>
						</tr>
						<tr>
							<td><input type="checkbox" value=""></td>
							<td>01-201301220011</td>
							<td>页游广告效果测试投放</td>
							<td>王某某</td>
							<td>杯京公司</td>
							<td>2013-02-20 12:28</td>
							<td>
								<span class="glyphicon glyphicon-floppy-open"></span> &nbsp;
								<span class="glyphicon glyphicon-floppy-remove"></span>
							</td>
						</tr>
						<tr>
							<td><input type="checkbox" value=""></td>
							<td>01-201301220011</td>
							<td>页游广告效果测试投放</td>
							<td>王某某</td>
							<td>杯京公司</td>
							<td>2013-02-20 12:28</td>
							<td>
								<span class="glyphicon glyphicon-floppy-open"></span> &nbsp;
								<span class="glyphicon glyphicon-floppy-remove"></span>
							</td>
						</tr>
						<tr>
							<td><input type="checkbox" value=""></td>
							<td>01-201301220011</td>
							<td>页游广告效果测试投放</td>
							<td>王某某</td>
							<td>杯京公司</td>
							<td>2013-02-20 12:28</td>
							<td>
								<span class="glyphicon glyphicon-floppy-open"></span> &nbsp;
								<span class="glyphicon glyphicon-floppy-remove"></span>
							</td>
						</tr>
						<tr>
							<td><input type="checkbox" value=""></td>
							<td>01-201301220011</td>
							<td>页游广告效果测试投放</td>
							<td>王某某</td>
							<td>杯京公司</td>
							<td>2013-02-20 12:28</td>
							<td>
								<span class="glyphicon glyphicon-floppy-open"></span> &nbsp;
								<span class="glyphicon glyphicon-floppy-remove"></span>
							</td>
						</tr>	
						<tr>
							<td><input type="checkbox" value=""></td>
							<td>01-201301220011</td>
							<td>页游广告效果测试投放</td>
							<td>王某某</td>
							<td>杯京公司</td>
							<td>2013-02-20 12:28</td>
							<td>
								<span class="glyphicon glyphicon-floppy-open"></span> &nbsp;
								<span class="glyphicon glyphicon-floppy-remove"></span>
							</td>
						</tr>					
					</tbody>
					</table>
				
					<ul class="pagination pagination-right" style="padding:0 auto;margin:10px auto;">
						<li class="disabled"><a href="#">&laquo;</a></li>
					  	<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
					  	<li><a href="#">2</a></li>
					  	<li><a href="#">3</a></li>
					  	<li><a href="#">4</a></li>
					  	<li><a href="#">5</a></li>
					  	<li><a href="#">&raquo;</a></li>
					</ul>
      				
      				
      				
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




