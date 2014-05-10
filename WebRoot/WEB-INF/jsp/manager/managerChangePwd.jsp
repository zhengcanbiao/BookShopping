
 
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>修改密码</title>
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/manager.css" rel="stylesheet" media="screen" />
<style>
#form_pwd{
	position: relative;
	width: 300px;
	margin: auto;
	padding-top: 150px;
}
#form_pwd input {
	width: 300px;
	height: 30px;
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
						<i class="icon-wrench icon-white"></i>
						<span class="selected">修改密码</span>
					</a>					
				</li>
				<li>
					<a href="/BookShopping/manager/PrepareCategory.action">
						<i class="icon-bookmark"></i>
						<span>商品类别管理</span>
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
	                <form id="form_pwd" name="form2" class="form-horizontal" role="form" action="/BookShopping/manager/ManagerChangePsw.action" method="post" enctype="multipart/form-data" >
	                	<label>输入旧密码</label>
	                	<input id="oldPwd" name="old_password" type="password"/>
	                	<label>输入新密码</label>
	                	<input id="newPwd" name="new_password" type="password" />
	                	<label>再次输入新密码</label>
	                	<input id="renewPwd" name="new_password" type="password" />
	                	
	                	<input type="button" value="确认" class="btn btn-large btn-success" style="width:300px; height:40px; margin-top:10px;" onclick="verify()" />
	                </form>
		            
		            
			
				</div>
			</div>
		</div>
	</div>
	
	
    <script src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/alert.js"></script>
    <script type="application/javascript" src="/BookShopping/js/manager.js"></script>
    <script type="text/javascript">
    function verify()
	{
		 if ($('#newPwd').val()=="" || $('#renewPwd').val()=="" || $('#oldPwd').val()==""){
			 Alert("输入框不能为空");
			return false;
		}
		else if ($('#oldPwd').val() == $('#newPwd').val()){
			Alert("新旧密码相同，请重新输入");
			$('#newPwd').focus();
			return false;
		}
		else if ($('#newPwd').val() != $('#renewPwd').val()){
			Alert("两次输入的新密码不相同，请重新输入");
			$('#newPwd').focus();
			return false;
		}
		else if ($('#newPwd').val().length<6 || $('#newPwd').val().length>16){
			Alert("输入的密码长度为6到16位，请重新输入");
			return false;
		}	
		 else{
			var flag = false;
			$.ajax({
			url: "/BookShopping/manager/AdminPwdConfirm.action",
			type: "GET",
			async: false,
			contextType: "application/json;charset=utf-8",
			dataType: "json",
			data: {password:$("#oldPwd").val()},
			success: function(result) {
				if (result=="success") {
					flag = true;
				} else if (result=="timeout"){
					Alert("您过长时间未登陆，请重新登陆");
					window.location.href="/BookShopping/managerLogin.jsp";
				} else {
					Alert("旧密码错误");
				}
			}
			});
			if (flag == true) {
				Alert("修改成功");
				setTimeout( function(){$("[name=form2]").submit();} ,2000);
				return true;
			} else {
				return false;
			}
		}
	}
	</script>
</body>
</html>
 
 