<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/bookshopping.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/account.css" rel="stylesheet" media="screen" />
<title>收藏夹</title>
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
              <li class="active">收藏夹</li>
            </ul>
        
        	<div class="row-fluid">
        		<%@ include file="leftBar.jsp" %>
           
                <div class="span10">
                    <p class="myAccount_title">收藏夹</p>
                    
                    <div class="row-fluid">
                    
		               <c:if test="${empty requestScope['favoriteList'] }">
		                    <tr>
		                	<td colspan="5">
		                    	收藏夹为空!
		                    </td>
		                	</tr>
		                </c:if>
                    
                    	<c:if test="${not empty requestScope['favoriteList'] }">
                    	
                    	<c:forEach begin="1" end="${fn:length(requestScope['favoriteList']) }" var="index">
                    		<div class="favorite_item" id="favorite_item_${requestScope['favoriteList'][index-1].favoriteId }">
                            <a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['favoriteList'][index-1].tbBooks.booksId }"><img src="${requestScope['picUrls'][index-1] }" /></a>
                            <div class="favorite_item_text">
                                <a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['favoriteList'][index-1].tbBooks.booksId }"><p class="favorite_item_name">${requestScope['favoriteList'][index-1].tbBooks.bookName }</p></a>
                                <h5 class="favorite_item_price">&yen;${requestScope['favoriteList'][index-1].tbBooks.price / 100.0 }</h5>
                                <a href="#" class="favorite_item_delete" onClick="delete_favorite('${requestScope['favoriteList'][index-1].favoriteId}')">删除</a>
                            </div>
                        </div>
                    	</c:forEach>
                    	</c:if>
                        
                    </div>
                    
                </div>
            
            </div>
            
        </div>
        
        <div id="alert_tips">
        	<i class="icon-2x icon-ok"></i><span>添加到购物车成功</span>
            <button type="button" class="close" onClick="$('#alert_tips').fadeOut('fast')">×</button>
        </div>
        
    </div>
    
    <%@ include file="footer.jsp" %>
    
    <script type="application/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/account.js"></script>
	<script type="application/javascript" src="/BookShopping/js/global.js"></script>
</body>
</html>
