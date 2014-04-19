<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/eshopping.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/cart.css" rel="stylesheet" media="screen" />

<title>下单失败</title>
</head>

<body>
    
    <%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">
        
        	<ul class="inline bread">
              <li><a href="/BookShopping/customer/RedirectToHome.action">首页</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li>下单失败</li>
            </ul>
        
        	<h4 style="color:#e74c3c;"><i class="icon-warning-sign"> </i>下单失败!</h4>
            <p style="margin-left:22px;">可能由于库存不足导致您的下单失败</p>
            
   
           
            
        </div><!-- container -->
        
    </div>
    
	<%@ include file="footer.jsp" %>


	<script type="application/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/global.js"></script>

</body>
</html>
