<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
		<link href="/BookShopping/css/flat-button.css" rel="stylesheet" media="screen" />
		<link href="/BookShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
		<link href="/BookShopping/css/flexslider.css" rel="stylesheet" media="screen" />
		<link href="/BookShopping/css/eshopping.css" rel="stylesheet" media="screen" />
		<link href="/BookShopping/css/item.css" rel="stylesheet" media="screen" />
		
		<title>商品</title>
    </head>
    
    <body>
    <%@ include file="header.jsp" %>
    <div class="body">
    	
    	<div class="container">

    		
           	<c:forEach begin="1" end="${(fn:length(requestScope['booksList'])-1)/4+1 }" var="index">
            	<div class="row-fluid item-list">
            		<c:forEach begin="${(index-1)*4 }" end="${(index-1)*4+3 }" var="i" >
            			<c:if test="${i < fn:length(requestScope['booksList']) }">
		            	<div class="item span3">
		            		<a href="${applicationScope['basePath'] }/customer/PrepareClothesDetail.action?booksId=${requestScope['booksList'][i].booksId }"><img src="${requestScope['booksList'][i].tbClothesdetails[0].picUrl }" /></a>	
		            		<a href="${applicationScope['basePath'] }/customer/PrepareClothesDetail.action?booksId=${requestScope['booksList'][i].booksId }"><p class="item-name">${requestScope['booksList'][i].booksName }</p></a>
		            		<h5 class="item-price">&yen;<span>${requestScope['booksList'][i].price/100.0 }</span></h5>
		            	</div>
		            	</c:if>
            		</c:forEach>
            	</div>
           	</c:forEach>
           	
            
            <div class="pagination">
                <ul>
                	<c:if test="${pageNow!=1 }"><li><a href="${applicationScope['basePath'] }/customer/PrepareClothesInfoList.action?categoryId=${requestScope['categoryId'] }&pageNow=${pageNow-1 }">prev</a></li></c:if>
                	<c:forEach begin="1" end="${requestScope['pageCount'] }" var="index">
                		<li <c:if test="${pageNow==index }">class="active"</c:if>><a href="${applicationScope['basePath'] }/customer/PrepareClothesInfoList.action?categoryId=${requestScope['categoryId'] }&pageNow=${index }">${index }</a></li>
                	</c:forEach>
                    <c:if test="${pageNow!=pageCount }"><li><a href="${applicationScope['basePath'] }/customer/PrepareClothesInfoList.action?categoryId=${requestScope['categoryId'] }&pageNow=${pageNow+1 }">Next</a></li></c:if>
                </ul>
            </div>
                    
            
        </div>
        
    </div>
    <script type="application/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/jquery.flexslider.js"></script>
    <script type="application/javascript" src="/BookShopping/js/global.js"></script>
    
    <%@ include file="footer.jsp" %>
    </body>
</html>
