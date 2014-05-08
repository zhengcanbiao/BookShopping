<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>添加类别</title>
<link href="/BookShopping/css/manager.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<style>
.right_block{
	position: relative;
	width: 400px;
	margin: auto;
	padding-top: 100px;
}
#form_dingdang input{
	height: 30px;
}
#form_dingdang select{
    width: 207px;
}
body{
	background-color: #eee;
}


</style>
</head>
<body>
	<div class="admin_head">
		<p>网上书城系统-管理员后台</p>
	</div>
	<div class="admin_container">
		<div class="admin_left">
			<div class="welcome">
				<span>管理员 </span>
				<a href="/BookShopping/manager/ManagerLogout.action">退出</a>
			</div>
			<hr/>
			<ul>
				<li>
					<a href="/BookShopping/manager/Jump.action?jumpId=3">
						<i class="icon-home"></i>
						<span>回到首页</span>
					</a>				
				</li>
				<li>
					<a href="/BookShopping/manager/Jump.action?jumpId=0">
						<i class="icon-wrench"></i>
						<span>修改密码</span>
					</a>					
				</li>
				<li>
					<a href="/BookShopping/manager/PrepareCategory.action">
						<i class="icon-bookmark icon-white"></i>
						<span class="selected">商品类别管理</span>
					</a>					
				</li>
				<li>
					<a href="/BookShopping/manager/PrepareBooks.action">
						<i class="icon-book"></i>
						<span>商品管理</span>
					</a>					
				</li>
				<li>
					<a href="/BookShopping/manager/PrepareOrder.action">
						<i class="icon-shopping-cart"></i>
						<span>订单管理</span>
					</a>					
				</li>
				<li>
					<a href="/BookShopping/manager/Jump.action?jumpId=6">
						<i class="icon-eye-open"></i>
						<span>销售量统计</span>
					</a>					
				</li>				
				<li>
					<a href="/BookShopping/manager/PrepareCustomer.action">
						<i class="icon-user"></i>
						<span>会员管理</span>
					</a>					
				</li>
				<li>
					<a href="/BookShopping/manager/Jump.action?jumpId=4">
						<i class="icon-star"></i>
						<span>折扣管理</span>
					</a>					
				</li>								
			</ul>
		</div>
		<div class="admin_right">
			<div class="bg_right">
				<div class="admin_right_to_center">
					<div class="right_block">
			           	添加类别
			           	<button id="back" type="button" class="btn btn-success" style="float:right" onclick="back()">返回 </button>
			            <hr />
						<form id="form_dingdang" name="form2" method="post" action="/BookShopping/manager/AddCategory.action" enctype="multipart/form-data">
				     		<p/>类别名:&nbsp;&nbsp;
							<input name="categoryName" type="text" id="categoryname"/><font size="2" color="#FF0000" id="a"> *必填项</font>
							<br/>
				
				        <!-- 改 -->
				                                           父类别:&nbsp;&nbsp;&nbsp;<select id="first_category_dropdown" name="parentId">
				            <c:forEach items="${applicationScope['topCategoryList'] }" var="category">
				         		<option value="${category.categoryId }">&nbsp;&nbsp;&nbsp;&nbsp;${category.categoryName }&nbsp;&nbsp;&nbsp;&nbsp;</option>
				         	</c:forEach>
								  </select>
				                  <br />
				            <input type="button" class="btn btn-success" value="添加类别" onclick="verify()"/>
				            <input type="reset" class="btn btn-success" value="重置"/>
				        </form>
<!-- 				        <form name="form3" method="post" action="/BookShopping/manager/PrepareCategory.action" enctype="multipart/form-data">
							<input type="submit" class="btn btn-default" value="  返回  " style="float:left; margin-left:180px;margin-top:-45px;"/>
			            </form> -->
					</div>						           		       		
				</div>
			</div>
		</div>
	</div>
	
	
    <script src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/alert.js"></script>
    <script type="application/javascript" src="/BookShopping/js/manager.js"></script>
    <script type="text/javascript">	
        function back(){
			window.location.href="/BookShopping/manager/PrepareCategory.action";
		}
		function verify()
		{
			if($('#categoryname').val().length<=0 || $('#categoryname').val().length>15)
			{
				Alert("输入名称不符合规范，名字长度为1~15位");
				$('#categoryname').focus();
				return false;
			}
			else if($('#categoryname').val().replace(/(^\s*)|(\s*$)/g, "")=="") {
				Alert("输入名称不能全为空格");
				$('#categoryname').focus();
				return false;
			}
			else{
				var flag = false;
				$.ajax({
				url: "/BookShopping/manager/CategoryExist.action",
				type: "GET",
				async: false,
				contextType: "application/json;charset=utf-8",
				dataType: "json",
				data: {categoryName:$("#categoryname").val(), parentId:$("#first_category_dropdown").val()},
				success: function(result) {
					if (result=="success") {
						flag = true;
					} else {
						flag = false;
						Alert("该类别名在此父类别中已经存在");
					}
				}
				});
				if (flag == true) { 
					Alert("添加成功");
					setTimeout( function(){$("[name=form2]").submit();} ,2000);
					return true;
				}
				else {
					return false;
				}
			}
		}
	</script>
</body>
</html>













<%-- <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>添加类别</title>
<style>
body {
	margin:0;
	font-size:14px;
	line-height:30px;
	width:100%;
}/*默认字体大小14px; 行距20px;*/

.header {
	font-size:18px;
	font-family:"Courier New", Courier, monospace;
	background:left;
	background-color:#CCC;
}

.container {
	width:960px;
	margin:0 auto;
}/*最大宽度是960px*/

.breadcrumb {
	width:100%;
	background-color:#FFF;
}

.left_block {
	width:20%;
	float:left;
}

.right_block {
	width:77%;
	margin-left:3%;
	line-height:40px;
	float:left;
}
a{
	text-decoration:none;
}
a:hover{
	text-decoration:underline;
}
.Button
{
	background-color:#CCC;
}
</style>
</head>

<body>

	<div class="header">
    	<div class="container">
         <img src="/BookShopping/img/logo_cut_30px.png" />
        尊敬的管理员，Eshopping网上衣城  诚心感谢你的默默付出
        <form name="form1" method="post" action="/BookShopping/manager/ManagerLogout.action" enctype="multipart/form-data" onsubmit="return Confirm()">
        <input type="submit"  class="Button" value="注销" style="float:right; margin-top:-25px;"/>
        </form>
        </div><!-- 内容放在这里面 -->
    </div><!-- 头部 -->
    
    <div class="body">
    	<div class="container">
        	<div class="breadcrumb">
            管理系统首页-&gt;商品类别管理-&gt;添加类别
            <hr />
            </div><!-- 面包屑 就是当前页面所在的导航位置 -->
           
            <div class="left_block">
            <ul>
             <li><a href="/BookShopping/manager/Jump.action?jumpId=3">回到首页</a></li>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=0">修改密码</a></li>
            <li><a href="/BookShopping/manager/PrepareCategory.action">商品类别管理</a></li>
            <li><a href="/BookShopping/manager/PrepareBooks.action">商品管理</a></li>
            <li><a href="/BookShopping/manager/PrepareOrder.action">订单管理</a></li>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=6">销售量统计</a></li>
            <li><a href="/BookShopping/manager/PrepareCustomer.action">会员管理</a></li>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=4">折扣管理</a></li>
            </ul>
            </div><!-- 左边部分 -->
            
            <div class="right_block">
           	添加类别
            <hr />
			<form name="form2" method="post" action="/BookShopping/manager/AddCategory.action" enctype="multipart/form-data">
     		<p/>类别名:&nbsp;&nbsp;
			<input name="categoryName" type="text" id="categoryname"/><font size="2" color="#FF0000" id="a"> *必填项</font>
			<br/>

        <!-- 改 -->
            父类别:&nbsp;&nbsp;&nbsp;<select id="first_category_dropdown" name="parentId">
            <c:forEach items="${applicationScope['topCategoryList'] }" var="category">
         		<option value="${category.categoryId }">&nbsp;&nbsp;&nbsp;&nbsp;${category.categoryName }&nbsp;&nbsp;&nbsp;&nbsp;</option>
         	</c:forEach>
				  </select>
                  <br />
            <input type="button" value="添加类别" onclick="verify()"/>
            <input type="reset" value="重置"/>
            </form>
            <form name="form3" method="post" action="/BookShopping/manager/PrepareCategory.action" enctype="multipart/form-data">
			<input type="submit" value="  返回  " style="float:left; margin-left:180px;margin-top:-45px;"/>
            </form>
            </div><!-- 右边部分 -->  
        </div><!-- 内容放在这里面 -->
    </div><!-- 中间部分 -->
    
    <div class="footer">
    	<div class="container">
        
        </div><!-- 内容放在这里面 -->
    </div><!-- 底部 -->
    
   <script src="/BookShopping/js/jquery-1.9.1.min.js"></script>
   <script src="/BookShopping/js/alert.js"></script>
   <script type="text/javascript">
	function Confirm()
	{
		var r=confirm("是否确认注销？");
		if (r==true)
			  	{
					return true;
			 }
		else
				{
					return false;
				}
	}
	
	function verify()
	{
		if($('#categoryname').val().length<=0 || $('#categoryname').val().length>15)
		{
			Alert("输入名称不符合规范，名字长度为1~15位");
			$('#categoryname').focus();
			return false;
		}
		else if($('#categoryname').val().replace(/(^\s*)|(\s*$)/g, "")=="") {
			Alert("输入名称不能全为空格");
			$('#categoryname').focus();
			return false;
		}
		else{
			var flag = false;
			$.ajax({
			url: "/BookShopping/manager/CategoryExist.action",
			type: "GET",
			async: false,
			contextType: "application/json;charset=utf-8",
			dataType: "json",
			data: {categoryName:$("#categoryname").val(), parentId:$("#first_category_dropdown").val()},
			success: function(result) {
				if (result=="success") {
					flag = true;
				} else {
					flag = false;
					Alert("该类别名在此父类别中已经存在");
				}
			}
			});
			if (flag == true) { 
				Alert("添加成功");
				setTimeout( function(){$("[name=form2]").submit();} ,2000);
				return true;
			}
			else {
				return false;
			}
		}
	}
	</script>
</body>
</html> --%>

