<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

<title>订单详情</title>
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
              <li>订单详情</li>
            </ul>
        
        	<p class="bookshopping_title">订单详情</p>
            
            <div class="order_condition_block">
            	<h4 class="order_condition">订单状态: <span>
                 	<c:choose>
                     	<c:when test="${requestScope['currentOrder'].orderStatus==-1 }">交易失败</c:when>
                     	<c:when test="${requestScope['currentOrder'].orderStatus==1 }">未发货</c:when>
                     	<c:when test="${requestScope['currentOrder'].orderStatus==2 }">未确认收货</c:when>
                     	<c:when test="${requestScope['currentOrder'].orderStatus==3 }">交易成功</c:when>
                     </c:choose>
            	</span></h4>
                <p class="order_time">下单时间: <fmt:formatDate value="${requestScope['currentOrder'].orderTime }" type="both"/></p>
                <p class="order_number">订单号: <span>${requestScope['currentOrder'].orderId }</span></p>
               
                
	               	<c:choose>
	               		<c:when test="${requestScope['currentOrder'].orderStatus==-1 }">
	               			<a href="#" class="btn" onClick="return delete_order('${requestScope['currentOrder'].orderId}')">删除订单</a>
	               		</c:when>
	               		<c:when test="${requestScope['currentOrder'].orderStatus==1 }">
	               			<a class="btn" href="${applicationScope['basePath'] }/customer/CancelOrder.action?orderId=${requestScope['currentOrder'].orderId }" onClick="return cancel_order()">取消订单</a>
	               		</c:when>
	               		<c:when test="${requestScope['currentOrder'].orderStatus==2 }">
	               			<a class="btn" href="${applicationScope['basePath'] }/customer/ConfirmDelivery.action?orderId=${requestScope['currentOrder'].orderId }">确认收货</a>
	               		</c:when>
	              			<c:when test="${requestScope['currentOrder'].orderStatus==3 and requestScope['currentOrder'].isComment==false }">
	               			<a class="btn" href="${applicationScope['basePath'] }/customer/PrepareComment.action?orderId=${requestScope['currentOrder'].orderId }">评价订单</a>
	               		</c:when>
	               	</c:choose>
               
            </div>
            
            <div class="order_address">
            	<h4>收货地址</h4>
                <p>${requestScope['currentOrder'].receiverInfo }</p>
            </div>

            <div class="pay_item_list">
            <h4>商品清单</h4>
                <table class="table table-striped">
                    <tr>
                        <th class="cart_item_column">商品</th>
                        <th class="cart_price_column">单价</th>
                        <th class="cart_count_column">数量</th>
                        <th class="cart_subtotal_column">小计</th>
                    </tr>
                    
                    <c:forEach items="${requestScope['orderDetailList'] }" var="orderDetail">
	                    <tr>
	                        <td>
	                            <a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${orderDetail.tbBooks.booksId }"><img src="${orderDetail.tbBooks.picUrl }" /></a>
	                            <div class="cart_item_name">
	                            <a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${orderDetail.tbBooks.booksId }">${orderDetail.tbBooks.bookName }</a>
	                            <p>作者:
                                    <%-- <c:choose>
                                    	<c:when test="${orderDetail.tbClothesdetail.size==0 }">S</c:when>
                                    	<c:when test="${orderDetail.tbClothesdetail.size==1 }">M</c:when>
                                    	<c:when test="${orderDetail.tbClothesdetail.size==2 }">L</c:when>
                                    </c:choose>	     --%>
                                         ${orderDetail.tbBooks.author}                   
	                            </p>
	                            </div>
	                        </td>
	                        <td>
	                            &yen;${orderDetail.tbBooks.price/100.0 }
	                        </td>
	                        <td>
	                            ${orderDetail.quantity }
	                        </td>
	                        <td>
	                            &yen;${orderDetail.price/100.0 }
	                        </td>
	                    </tr>	
                    </c:forEach>
                </table>
   
            	<p class="cart_total_price">总价: <span>&yen;${requestScope['currentOrder'].totalPrice/100.0 }</span></p>
                
                <div class="discount_block">
                    <p class="cart_discount_price">实付款: <span>&yen;${requestScope['currentOrder'].finalPrice/100.0}</span></p>
                    <p class="cart_discount">积分优惠: <span class="label-warning label">
                            <c:if test="${requestScope['currentOrder'].discount==100 }">无</c:if>
                            <c:if test="${requestScope['currentOrder'].discount!=100 }">${requestScope['currentOrder'].discount/100.0 }折</c:if>
                    </span></p>
                </div> 
            </div> 
            
        </div><!-- container -->
        <div id="alert_tips">
        	<i class="icon-2x icon-ok"></i><span>添加到购物车成功</span>
            <button type="button" class="close" onClick="$('#alert_tips').fadeOut('fast')">×</button>
        </div>
        
    </div>
    
	<%@ include file="footer.jsp" %>



	<script type="application/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/global.js"></script>
    <script type="application/javascript">
    	function cancel_order() {
    		return window.confirm("确定取消订单？")
    	}
    	function delete_order(order_id) {
    		//alert(order_id);
    		if (window.confirm("确认删除订单？")) {
    			$.ajax({
    				url: "/BookShopping/customer/DeleteOrder.action",
    				type: "GET",
    				contentType: "application/json;charset=utf-8",
    				dataType: "json",
    				data: {orderId: order_id},
    				success: function(result) {
    					show_tips("删除成功", "ok");
    					//alert("删除成功")
    					var order_body_id = "#order_body" + order_id;
    					$(order_body_id).fadeOut("slow", function() {
    						$(order_body_id).remove();
    					});
    					setTimeout(function(){
    						window.location.href="/BookShopping/customer/PrepareOrderInfoList.action";
    						
    						
    					}, 500);
    				}
    			});
    		}
    	}
    	
		function comfirm_order() {
			return window.confirm("确认收货？");
		}
    </script>

</body>
</html>
