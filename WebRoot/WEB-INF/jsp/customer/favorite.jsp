<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/EShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/eshopping.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/account.css" rel="stylesheet" media="screen" />
<title>收藏夹</title>
</head>

<body>
	<%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">
        
        	<ul class="inline bread">
              <li><a href="/EShopping/customer/RedirectToHome.action">首页</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li><a href="/EShopping/customer/PreparePersonalHome.action">我的账户</a></li>
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
                            <a href="/EShopping/customer/PrepareClothesDetail.action?clothesId=${requestScope['favoriteList'][index-1].tbClothes.clothesId }"><img src="${requestScope['picUrls'][index-1] }" /></a>
                            <div class="favorite_item_text">
                                <a href="/EShopping/customer/PrepareClothesDetail.action?clothesId=${requestScope['favoriteList'][index-1].tbClothes.clothesId }"><p class="favorite_item_name">${requestScope['favoriteList'][index-1].tbClothes.clothesName }</p></a>
                                <h5 class="favorite_item_price">&yen;${requestScope['favoriteList'][index-1].tbClothes.price / 100.0 }</h5>
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
    
    <script type="application/javascript" src="/EShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/EShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/EShopping/js/account.js"></script>
	<script type="application/javascript" src="/EShopping/js/global.js"></script>
</body>
</html>
