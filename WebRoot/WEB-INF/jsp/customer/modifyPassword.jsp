<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/eshopping.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/account.css" rel="stylesheet" media="screen" />
<title>修改密码</title>
</head>

<body>

	<%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">
        
        	<ul class="inline bread">
              <li><a href="/BookShopping/customer/RedirectToHome.action">首页</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li><a href="/BookShopping/customer/PreparePersonalHome.action">我的账户</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li class="active">修改信息</li>
            </ul>
        
        	<div class="row-fluid">
                <%@ include file="leftBar.jsp" %>
           
                <div class="span10">
                    <p class="myAccount_title">修改密码</p>
                    
                    <form id="edit_password_form" action="ModifyPassword.action" class="form-horizontal" onSubmit="return modify_password_check()">

                        <div id="edit_password">
                            <div class="control-group">
                                <label for="input_original_password" class="control-label">原始密码</label>
                                <div class="controls">
                                    <input id="input_original_password" name="oldPassword" type="password" placeholder="" /><span id="original_password_span" class="label label-important"></span>
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label for="input_new_password" class="control-label">修改密码</label>
                                <div class="controls">
                                    <input id="input_new_password" name="newPassword" type="password" placeholder="" /><span id="new_password_span" class="label label-important"></span>
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label for="input_new_password_again" class="control-label">再次确认修改密码</label>
                                <div class="controls">
                                    <input id="input_new_password_again" type="password" placeholder="" /><span id="new_password_again_span" class="label label-important"></span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="controls">
                            <input type="submit" value="保存修改" class="btn" />
                        </div>
                	</form>
                    
                </div>
            
            </div>
            
        </div>
        
    </div>
	<%@ include file="footer.jsp" %>

	<script type="application/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/account.js"></script>
    <script type="application/javascript" src="/BookShopping/js/check.js"></script>
    <script type="application/javascript" src="/BookShopping/js/global.js"></script>
    
    <script type="application/javascript">
		$(document).ready(function(e) {
        	modify_password_check();
        });

		$("#header3").css("visibility", "hidden");

	</script>
    
</body>
</html>
