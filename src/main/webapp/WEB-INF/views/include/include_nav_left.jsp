<%@ page language="java" pageEncoding="UTF-8"%>
<!-- left nav -->
<div class="panel-group" id="accordion" style="position:fixed;width:170px">
	<div id="panelActivity" class="panel panel-default">	<!-- 广告活动 -->
    	<div class="panel-heading">
      	<h4 class="panel-title">
        	<a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          	广告活动管理
        	</a>
      	</h4>
    	</div>
	    <div id="collapseOne" class="panel-collapse collapse">
	      	<div class="panel-body" style="padding:5px">
	      	<ul class="nav nav-pills nav-stacked">
				<li id="leftNav_newActi"><a href="activities/createPage">新建广告活动</a></li>
				<li id="leftNav_viewActi"><a href="activities/listPage">查看广告活动	</a></li>
			</ul>
	      	</div>
	    </div>
	</div>
	<div id="panelAdv" class="panel panel-default">	<!-- 广告订单 -->
	    <div class="panel-heading">
	    <h4 class="panel-title">
	        <a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
	        广告订单管理
	        </a>
	    </h4>
	    </div>
    	<div id="collapseTwo" class="panel-collapse collapse">
      		<div class="panel-body" style="padding:5px">
      		<ul class="nav nav-pills nav-stacked">
				<li id="leftNav_newAdv"><a href="advs/createPage">新建广告订单</a></li>
				<li id="leftNav_viewNoAuditAdv"><a href="#">待处理广告订单<span class="badge pull-right">14</span></a></li>
				<li id="leftNav_viewAuditAdv"><a href="#">已通过广告订单</a></li>
				<li id="leftNav_viewAdv"><a href="advs/listPage">查看广告订单</a></li>
			</ul>
      		</div>
    	</div>
  	</div>
  	
  	<div id="panelGlobal" class="panel panel-default" style="margin-top: 0px;">	<!-- 推送配置-->
    	<div class="panel-heading">
      	<h4 class="panel-title">
        	<a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
          	推送配置
        	</a>
      	</h4>
    	</div>
	    <div id="collapseThree" class="panel-collapse collapse">
	      	<div class="panel-body" style="padding:5px">
	      	<ul class="nav nav-pills nav-stacked">
	      		<li id="leftNav_configGlobal"><a href="globalConfig/editPage">推送间隔配置</a></li>
	      		<li id="leftNav_freePushWebsite"><a href="freePushUrls/listPage">免推送网站配置</a></li>
			</ul>
	      	</div>
	    </div>
	</div>
  	<div id="panelArea" class="panel panel-default">	<!-- 区域 -->
    	<div class="panel-heading">
      	<h4 class="panel-title">
        	<a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href="#collapseFour">
          	区域管理
        	</a>
      	</h4>
    	</div>
	    <div id="collapseFour" class="panel-collapse collapse">
	      	<div class="panel-body" style="padding:5px">
	      	<ul class="nav nav-pills nav-stacked">
	      		<li id="leftNav_newArea"><a href="areas/createPage">新建区域</a></li>
	      		<li id="leftNav_viewArea"><a href="areas/listPage">查看区域</a></li>
			</ul>
	      	</div>
	    </div>
	</div>
	<div id="panelWebsite" class="panel panel-default">	<!-- 关联网站 -->
    	<div class="panel-heading">
      	<h4 class="panel-title">
        	<a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
          	关联网站
        	</a>
      	</h4>
    	</div>
	    <div id="collapseFive" class="panel-collapse collapse">
	      	<div class="panel-body" style="padding:5px">
	      	<ul class="nav nav-pills nav-stacked">
	      		<li id="leftNav_newWebsite"><a href="websites/createPage">新建关联网站</a></li>
	      		<li id="leftNav_viewWebsite"><a href="websites/listPage">查看关联网站</a></li>
			</ul>
	      	</div>
	    </div>
	</div>
	<!-- TODO 查询网站地址 -->
	
	
</div>	<!-- end of left nav -->