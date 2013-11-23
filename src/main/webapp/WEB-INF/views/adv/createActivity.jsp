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
	<link href="resources/bootstrap-3.0.0/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="resources/plugin/sticky-footer-navbar.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="resources/jquery-1.10.2/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="resources/bootstrap-3.0.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="resources/plugin/jqBootstrapValidation.js"></script>
	<script type="text/javascript" src="resources/plugin/json2.js"></script>
	<script>

		$(function (){ 
	  		$("input,select,textarea").not("[type=submit]").jqBootstrapValidation({
				submitSuccess: function (form, event) {
					event.preventDefault();
     				//var data = convertArray(form.serializeArray()); 
     				//$.post("activity", data, function(d){},"json");
     				request("activity", "POST", JSON.stringify(serializeObject(form.serializeArray())));  
 				}
 			});
		})
		
		function convertArray(o){
			var v = {}; 
			for (var i in o) { 
				if (typeof (v[o[i].name]) == 'undefined') 
					v[o[i].name] = o[i].value; 
				else 
					v[o[i].name] += "," + o[i].value; 
			} 
			return v; 
		} 

		function request(url, method, param){      

	        $.ajax({  
				type: method,  
                //async:false,  
                contentType: "application/json;charset=UTF-8",  
                dataType: "json",  
                url: url,  
                data: param,   
                success: function(d){},  
                error: function(d){},  
	        });         
        }
        
        function serializeObject(a){  
            var o = {};  
            $.each(a, function() {  
                if (o[this.name] !== undefined) {  
                    if (!o[this.name].push) {  
                        o[this.name] = [o[this.name]];  
                    }  
                    o[this.name].push(this.value || '');  
                } else {  
                    o[this.name] = this.value || '';  
                }  
            });  
            return o;  
        };  
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
								<li><a href="activity/create">新建广告活动</a></li>
			                  	<li><a href="activity/list">查看广告活动</a></li>
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

					<form id="activityForm" class="form-horizontal" novalidate>
			    	<fieldset>
				      	<div id="legend" style="margin-bottom:20px">
			        		<a class="btn btn-default" href="activity/list" role="button">
								<span class="glyphicon glyphicon-list"></span> 查看广告活动
							</a>&nbsp;
				      	</div>
				      	
        				<div class="form-group ">
          					<label class="control-label col-sm-2">公司名称：</label>
							<div class="col-sm-6 controls">
					            <select name="company" class="form-control input-xlarge" data-validation-required-message="请选择公司" required>
					            	<option> </option>
					      			<option>杯京公司</option>
					      			<option>极难公司</option>
					      			<option>航舟公司</option>
					      			<option>程度公司</option>
					      		</select>
					      		<p class="help-block">必需：请在列表中选择公司</p>
          					</div>
						</div>
						
        				<div class="form-group">
							<label class="control-label col-sm-2" for="input01">广告活动名称：</label>
							<div class="col-sm-6 controls">
								<input name="activityName" type="text" placeholder="例如：页游广告投放测试" class="form-control input-xlarge" 
            								maxlength="30" required>
            					<p class="help-block">必需：30个字以内，可输入汉字、英文字符</p>
            					
          					</div>
						</div>
						<div class="form-group ">
          					<label class="control-label col-sm-2" for="input01">联系人：</label>
          					<div class="col-sm-6 ">
            					<input name="linkman" type="text" placeholder="" class="form-control input-xlarge">
    							<p class="help-block"></p>
          					</div>
        				</div>
        				<div class="form-group ">
          					<label class="control-label col-sm-2" for="input01">联系电话：</label>
          					<div class="col-sm-6">
            					<input name="linkmanPhone" type="text" placeholder="例如：0531-88888888" class="form-control input-xlarge">
            					<p class="help-block">请输入座机（带区号）或手机</p>
          					</div>
        				</div>
        				<div class="form-group">
							<label class="control-label col-sm-2">描述信息：</label>
							<div class="col-sm-6">
								<div class="textarea">
                  					<textarea name="description" type="" class="form-control" rows="3"> </textarea>
            					</div>
          					</div>
        				</div>
        				<div class="form-group">
							<div class="col-sm-2">
          					</div>
							<div class="col-sm-6">
								<button class="btn btn-primary" type="submit">提交</button>&nbsp;
								<button class="btn btn-warning" type="reset">重置</button>
							</div>
						</div>
					</fieldset>
  					</form>
      				
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




