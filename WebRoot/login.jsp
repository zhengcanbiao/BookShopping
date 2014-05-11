<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/bookshopping.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/account.css" rel="stylesheet" media="screen" />
<title>登录</title>
</head>

<body>

 	<div id="home_header1" class="header">
    	<div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
            	<div class="container">
                
            	<ul class="nav">
                	<li id="logo">
                    	<a href="/BookShopping/customer/RedirectToHome.action"><img  src="/BookShopping/img/login_logo.png" /></a>
                    </li>
                   
                </ul>
                </div>
            </div>
         </div>
    </div> 
<!--     <div id="photo_left">
    	<img src="/BookShopping/img/photo_left.png" />
    </div> -->
    
    <div class="body1">
    	<div class="container row-fluid">
    	    <div id="photo_left">
    			<img src="/BookShopping/img/left.png" />
		    </div>
        	<div class="span7">
            </div>
            
            <div class="span4">
            	<form id="login_form" method="post" onSubmit="return login_submit()" 
            		<c:if test="${empty requestScope['backwardUrl'] }">action="/BookShopping/customer/RedirectToHome.action"</c:if> 
            		<c:if test="${not empty requestScope['backwardUrl'] }">action="/BookShopping/${requestScope['backwardUrl'] }"</c:if>
            		>
                	<legend>登录</legend>
                    <a id="go_login" href="/BookShopping/register.jsp">去注册</a>
                    <input name="backwardUrl" hidden="hidden" 
                    <c:if test="${not empty requestScope['backwardUrl'] }">value="${requestScope['backwardUrl'] }"</c:if>
                    <c:if test="${empty requestScope['backwardUrl'] }">value="home.jsp"</c:if> 
                    />
                    <label for="input_username">用户名<span id="username_span" class="label"></span></label>
                    <input id="input_username" name="customerName" type="text" placeholder="输入你注册时用的邮箱" />
                    
                    
                    <label for="input_password">密码<span id="password_span" class="label"></span></label>
                    <input id="input_password" name="password" type="password" />
                    
                    <input type="checkbox" name="savePassword" value="true" /><span>下次自动登录</span><a href="/BookShopping/forgetPassword.jsp" style="float:right;">忘记密码?</a>
                    
                    <input type="submit" value="登录" class="btn btn-large btn-success" style="width:264px; margin-top:10px;" />
                </form>
            </div>
        </div>
    </div>
    
    <div class="footer">
    	<div class="container row">
        </div>
    </div>
    
    <script type="application/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/check.js"></script>
    
    <script type="application/javascript">
		$(document).ready(function(e) {
            login_check();
        });
	</script>
</body>
</html>
