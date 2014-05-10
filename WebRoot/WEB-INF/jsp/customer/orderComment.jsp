<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/bookshopping.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/cart.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/account.css" rel="stylesheet" media="screen" />

<title>评价</title>
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
              <li><a href="/BookShopping/customer/PrepareOrderInfoList.action">我的订单</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li>评价</li>
            </ul>
        
        	<p class="bookshopping_title">评价</p>
        	
        	<c:forEach items="${requestScope['booksDetailList'] }" var="orderDetail">
	            <div class="comment_block row-fluid" id="comment_div_${orderDetail.orderDetailId }">
	            	<div class="comment_item span6">
	                    <a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${orderDetail.tbBooks.booksId }"><img src="${orderDetail.tbBooks.picUrl }" /></a>
	                    <div class="text_block">
	                        <a href="${applicationScope['basePath'] }/customer/PrepareBooksDetail.action?booksId=${orderDetail.tbBooks.booksId }">${orderDetail.tbBooks.bookName }</a>
	                        <br>
	                        <span>作者:
	                        <%-- <c:choose>
		                        <c:when test="${orderDetail.tbBooks.size==0 }">S</c:when>
		                        <c:when test="${orderDetail.tbBooks.size==1 }">M</c:when>
		                        <c:when test="${orderDetail.tbBooks.size==2 }">L</c:when>
	                        </c:choose> --%>
	                        ${orderDetail.tbBooks.author} 
	                        </span>
	                        <span>&yen;${orderDetail.tbBooks.price/100.0 }</span>
	                    </div>
	                </div>
	                
	                <textarea id="comment_content_${orderDetail.orderDetailId }" rows="5" class="span6" placeholder="默认评价为好评！"></textarea>
	            </div>
        	</c:forEach>
            
            <button type="button" class="btn btn-large btn-primary btn_comment" onClick="add_comment('${requestScope.booksDetailList[0].tbOrder.orderId}')">添加评价</button> 
            
            
            
        </div><!-- container -->
        
        
        
    </div>
   
	<%@ include file="footer.jsp" %>

	<script type="application/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/global.js"></script>
    
    <script type="application/javascript">
    
    	function add_comment(order_id) {
    		var data = "";
    		data += "{orderId:\"" + order_id + "\"}";
    		$("[class='comment_block row-fluid']").each(function (index, item) {
    			var order_detail_id = get_num_in_str(item.id);
    			var comment_content_id = "#comment_content_" + order_detail_id;
    			if ($(comment_content_id).val().replace(/(^\s*)|(\s*$)/g, "") == "")
    				$(comment_content_id).val("好评！！！");
    			data += ",{orderDetailId:" + order_detail_id + ", commentContent:\"" + $(comment_content_id).val() + "\"}"; 
    		});
			data = "[" + data + "]";
    		$.ajax({
    			url:"/BookShopping/customer/AddComment.action",
    			type:"POST",
    			async:false,
    			dataType:"json",
    			data:{commentsJson: data},
    			success: function(result) {
    				window.location.href="/BookShopping/customer/PrepareOrderInfoList.action?orderId=" + order_id;
    			}
    		});
    	}
    </script>

</body>
</html>

