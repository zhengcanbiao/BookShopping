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
<link href="/BookShopping/css/item.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/home.css" rel="stylesheet" media="screen" />
<title>首页</title>
</head>

<body>
	<%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">

        	
            <c:forEach begin="1" end="${fn:length(requestScope['booksCategoryList']) }" var="booksListIndex">
            <c:if test="${not empty requestScope['booksCategoryList'][booksListIndex-1] }">
            <div class="home-item-block">
            	<legend>${applicationScope['topCategoryList'][booksListIndex-1].categoryName }</legend>
	    	    <c:forEach begin="0" end="${(fn:length(requestScope['booksCategoryList'][booksListIndex-1])-1)/4 }" var="index">
	    	    <!-- 除以4就是4列 -->
	            	<div class="row-fluid item-list">
	            		<c:forEach begin="${(index)*4 }" end="${(index)*4+3 }" var="i" >
	            			<c:if test="${i < fn:length(requestScope['booksCategoryList'][booksListIndex-1]) }">
			            	<div class="item span3">
			            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][booksListIndex-1][i].booksId }"><img src="${requestScope['booksCategoryList'][booksListIndex-1][i].picUrl }" /></a>	
			            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][booksListIndex-1][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][booksListIndex-1][i].bookName }</p></a>
			            		<h5 class="item-price">&yen;<span>${requestScope['booksCategoryList'][booksListIndex-1][i].price/100.0 }</span></h5>
			            	</div>
			            	</c:if>
	            		</c:forEach>
	            	</div>
	           	</c:forEach>
            </div>
            </c:if>
            </c:forEach>

        </div>
        
    </div>
    
	<%@ include file="footer.jsp" %>
	
	<script type="application/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
	<script type="application/javascript" src="/BookShopping/js/global.js"></script> 
</body>
</html>
