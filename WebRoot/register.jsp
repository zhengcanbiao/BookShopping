<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/bookshopping.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/account.css" rel="stylesheet" media="screen" />
<title>注册</title>
</head>

<body>
	<div class="header">
    	<div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
            	<div class="container">
                
            	<ul class="nav">
                	<li id="logo">
                    	<a href="/BookShopping/customer/RedirectToHome.action"><img src="img/logo_cut_30px.png" /></a>
                    </li>
                   
                </ul>
                </div>
            </div>
         </div>
    </div>
    
    <div class="body">
    	<div class="container row-fluid">
        	<div class="span7">
            	
            </div>
            
            <div class="span4">
            	<form id="register_form" onSubmit="return register_submit()" action="/BookShopping/customer/Register.action">
                	<legend>注册</legend>
                    <a id="go_login" href="/BookShopping/login.jsp">去登陆</a>
                    
                    <label for="input_username">用户名<span id="username_span" class="label"></span></label>
                    <input id="input_username" name="customerName" type="text" placeholder="使用邮箱作为用户名" />
                    
                    <label for="input_nickname">昵称<span id="nickname_span" class="label"></span></label>
                    <input id="input_nickname" name="nickName" type="text" placeholder="怎么称呼你呢?" />
                    
                    <label for="input_password">密码<span id="password_span" class="label"></span></label>
                    <input id="input_password" name="password" type="password" />
                    
                    <label for="input_password_again">再次确认密码<span id="password_again_span" class="label"></span></label>
                    <input id="input_password_again" type="password" />
                    
                    <input type="submit" value="注册" class="btn btn-large btn-danger" style="width:264px; margin-top:10px;" />
                </form>
            </div>
        </div>
    </div>
    
    <div class="footer">
    	<div class="container">
        </div>
    </div>
    
    <script type="application/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/check.js"></script>
    
    <script type="application/javascript">
		$(document).ready(function(e) {
            register_check();
        });
	</script>
</body>
</html>
