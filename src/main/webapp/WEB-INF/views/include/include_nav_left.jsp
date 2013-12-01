<%@ page language="java" pageEncoding="UTF-8"%>
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
				<li id="leftNav_newActi"><a href="activities/createPage">新建广告活动</a></li>
				<li id="leftNav_viewActi"><a href="activities/listPage">查看广告活动	</a></li>
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
				<li id="leftNav_newAdv"><a href="advs/createPage">新建广告订单</a></li>
				<li id="leftNav_viewNoAuditAdv"><a href="#">待处理广告订单<span class="badge pull-right">14</span></a></li>
				<li id="leftNav_viewAuditAdv"><a href="#">已通过广告订单</a></li>
				<li id="leftNav_viewAdv"><a href="#">查看广告订单</a></li>
			</ul>
      		</div>
    	</div>
  	</div> 
</div>	<!-- end of left nav -->