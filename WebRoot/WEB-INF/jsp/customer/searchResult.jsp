<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/EShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/flexslider.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/eshopping.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/item.css" rel="stylesheet" media="screen" />

<title>搜索商品</title>
</head>

<body>

	<%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">
        	
       	<c:if test="${not empty requestScope['clothesList'] }">
            <div id="search_filter">
            	<h4>结果过滤</h4>
                <select id="order" onChange="on_sort_method_change('${requestScope['keyword'] }')">
                	<option value="0">默认排序</option>
                    <option value="1">按销量由低到高</option>
                    <option value="2">按销量由高到低</option>
                    <option value="3">价格由低到高</option>
                    <option value="4">价格由高到低</option>
                    <option value="5">按名称排序</option>
                </select>
            </div>
        	
           	<c:forEach begin="1" end="${(fn:length(requestScope['clothesList'])-1)/4+1 }" var="index">
            	<div class="row-fluid item-list">
            		<c:forEach begin="${(index-1)*4 }" end="${(index-1)*4+3 }" var="i" >
            			<c:if test="${i < fn:length(requestScope['clothesList']) }">
		            	<div class="item span3">
		            		<a href="${applicationScope['basePath'] }/customer/PrepareClothesDetail.action?clothesId=${requestScope['clothesList'][i].clothesId }&categoryId=${requestScope['clothesList'][i].tbCategory.categoryId }"><img src="${requestScope['clothesList'][i].tbClothesdetails[0].picUrl }" /></a>	
		            		<a href="${applicationScope['basePath'] }/customer/PrepareClothesDetail.action?clothesId=${requestScope['clothesList'][i].clothesId }&categoryId=${requestScope['clothesList'][i].tbCategory.categoryId }"><p class="item-name">${requestScope['clothesList'][i].clothesName }</p></a>
		            		<h5 class="item-price">&yen;<span>${requestScope['clothesList'][i].price/100.0 }</span></h5>
		            	</div>
		            	</c:if>
            		</c:forEach>
            	</div>
           	</c:forEach>
            
            <div class="pagination">
                <ul>
                	<c:if test="${pageNow!=1 }"><li><a href="${applicationScope['basePath'] }/customer/SearchClothes.action?keyword=${requestScope['keyword'] }&pageNow=${pageNow-1 }">prev</a></li></c:if>
                	<c:forEach begin="1" end="${requestScope['pageCount'] }" var="index">
                		<li <c:if test="${pageNow==index }">class="active"</c:if>><a href="${applicationScope['basePath'] }/customer/SearchClothes.action?keyword=${requestScope['keyword'] }&pageNow=${index }">${index }</a></li>
                	</c:forEach>
                    <c:if test="${pageNow!=pageCount }"><li><a href="${applicationScope['basePath'] }/customer/SearchClothes.action?keyword=${requestScope['keyword'] }&pageNow=${pageNow+1 }">Next</a></li></c:if>
                </ul>
            </div>
        </c:if>
                 

		<c:if test="${empty requestScope['clothesList'] }">
           	<div class="body">
    			<div class="container row-fluid">
            		<div class="span6">
            			<legend>搜索结果</legend>
            			<h4 style="color:#2ECC71;"><i class="icon-ok"> </i>没有找到您搜索的内容!</h4>
            		</div>
        		</div>
    		</div>	
        </c:if>
            
        </div>
        
    </div>
    

	<%@ include file="footer.jsp" %>


	<script type="application/javascript" src="/EShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/EShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/EShopping/js/jquery.flexslider.js"></script>
    <script type="application/javascript" src="/EShopping/js/global.js"></script>
    
    <script type="application/javascript">
    	$(document).ready(function (e) {
    		$("#order").val(${requestScope['orderIndex']});
    	});
    
    	function on_sort_method_change(keyword) {
    		var order_index = $("#order").val();
    		window.location.href="/EShopping/customer/SearchClothes.action?pageNow=1&orderIndex=" + order_index + "&keyword=" + keyword;
    	}
    </script>

</body>
</html>
