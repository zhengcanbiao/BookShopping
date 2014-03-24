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
<title>忘记密码</title>
</head>

<body>
	<div class="header">
    	<div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
            	<div class="container">
                
            	<ul class="nav">
                	<li id="logo">
                    	<a href="/BookShopping/customer/RedirectToHome.action"><img src="/BookShopping/img/logo_cut_30px.png" /></a>
                    </li>
                   
                </ul>
                </div>
            </div>
         </div>
    </div>
    
    <div class="body">
    	<div class="container row-fluid">
            <div class="span6">
            	<form id="forget_password_form" action="/BookShopping/findPasswordSuccess.jsp" class="form-horizontal" onSubmit="return find_password_submit()">
                	<legend>忘记密码</legend>
                    
                    <div class="control-group">
                    	<label for="input_username" class="control-label">用户名</label>
                        <div class="controls">
                    		<input id="input_username" name="customerName" type="text" placeholder="注册时用的邮箱" /><span id="username_span" class="label" style="margin-left:10px;"></span>
                        </div>
                    </div>
                    
                    <div class="controls">
                    	<input type="submit" value="提交" class="btn btn-primary" />
                    </div>
                </form>
            </div>
            
            <div class="span5" id="find_tips">
            	<h5><i class="icon-envelope">   </i>我们将发送一封邮件到你的用户名所在的邮箱, 通过邮件你可以重置你的密码</h5>
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
        find_password_check();
    });
	</script>
</body>
</html>