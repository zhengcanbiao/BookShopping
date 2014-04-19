<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/bookshopping.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/cart.css" rel="stylesheet" media="screen" />

<title>下单成功</title>
</head>

<body>
    
    <%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">
        
        	<ul class="inline bread">
              <li><a href="/BookShopping/customer/RedirectToHome.action">首页</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li>下单成功</li>
            </ul>
        
        	<h4 style="color:#2ECC71;"><i class="icon-ok"> </i>成功下单!</h4>
            <p style="margin-left:22px;">我们将在确认你的订单后将为你发货</p>
            
            <a href="/BookShopping/customer/PrepareOrderInfoList.action" style="margin-left:22px;">查看我的订单</a><br>
            <a href="/BookShopping/customer/RedirectToHome.action" style="margin-left:22px;">回首页</a>
   
           
            
        </div><!-- container -->
        
    </div>
    
	<%@ include file="footer.jsp" %>


	<script type="application/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/global.js"></script>

</body>
</html>
