<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/EShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/eshopping.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/account.css" rel="stylesheet" media="screen" />
<title>个人主页</title>
</head>

<body>
	<%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">
        
        	<ul class="inline bread">
              <li><a href="/EShopping/customer/RedirectToHome.action">首页</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li>个人主页</li>
            </ul>
        
        	<div class="row-fluid">
                <%@ include file="leftBar.jsp" %>
               
                <div class="span10 row-fluid">
                	<div class="span12">
                    	<div class="nickname_block">
                            <p class="myAccount_title" id="nickname">${sessionScope['currentNickName'] }</p><span id="rank">等级: ${requestScope['customerLevel'] }</span>
                            <span id="discount">积分折扣: <span class="label-warning label">
                            <c:if test="${requestScope['customerLevel']==0 }">无</c:if>
                            <c:if test="${requestScope['customerLevel']!=0 }">${applicationScope['discountList'][requestScope['customerLevel']].discountRate }折</c:if>
                            </span></span>
                    	</div>
                    </div>
                    
                    <div class="row-fluid">
                        <div class="span8 recent_order">
                            <h4>最近订单</h4>
                            
                            <c:if test="${empty requestScope['recentOrders'] }">
                            <div class="account_home_item">
                            	最近无订单
                            </div>
                            </c:if>
                            
                            <c:if test="${not empty requestScope['recentOrders'] }">
                            	<c:forEach items="${requestScope['recentOrders']}" var="order">
	                            	<div class="account_home_item">
	                            	<img src="${order.tbOrderdetails[0].tbClothesdetail.picUrl }" />
	                                <ul class="inline">
	                                    <li>&yen;${order.finalPrice }</li>
	                                    <li><c:choose>
					                     	<c:when test="${order.orderStatus==-1 }">交易失败</c:when>
					                     	<c:when test="${order.orderStatus==1 }">未发货</c:when>
					                     	<c:when test="${order.orderStatus==2 }">未确认收货</c:when>
					                     	<c:when test="${order.orderStatus==3 }">交易成功</c:when>
					                     </c:choose></li>
	                                    <li>                                    	
	                                    <c:choose>
                                    		<c:when test="${order.orderStatus==-1 }">
                                    			<a href="/EShopping/customer/PrepareOrderInfoList.action" class="btn" onClick="return delete_order('${requestScope['currentOrder'].orderId}')">删除订单</a>
                                    		</c:when>
                                    		<c:when test="${order.orderStatus==1 }">
                                    			<a href="${applicationScope['basePath'] }/customer/CancelOrder.action?orderId=${order.orderId }" onClick="return cancel_order()">取消订单</a>
                                    		</c:when>
                                    		<c:when test="${order.orderStatus==2 }">
                                    			<a href="${applicationScope['basePath'] }/customer/ConfirmDelivery.action?orderId=${order.orderId }">确认收货</a>
                                    		</c:when>
                                   			<c:when test="${order.orderStatus==3 and order.isComment==false }">
                                    			<a href="${applicationScope['basePath'] }/customer/PrepareComment.action?orderId=${order.orderId }">评价订单</a>
                                    		</c:when>
                                    	</c:choose>
                                    	</li>
	                                </ul>
	                            	</div>
                            	</c:forEach>
                            </c:if>
                            
                            <a href="${applicationScope['basePath'] }/customer/PrepareOrderInfoList.action">查看全部订单</a>
                        </div>
                        
                        <div class="span4 account_cart">
                            <h4>购物车</h4>
                            
                            <c:if test="${empty requestScope['cartList']} ">
                            	<div class="account_cart_item">
                            		购物车中没有商品
                            	</div>
                            </c:if>
                            
                            <c:if test="${not empty requestScope['cartList'] }">
                            	<c:forEach items="${requestScope['cartList'] }" var="cart">
	                            	<div class="account_cart_item">
	                            	<a href="/EShopping/customer/PrepareClothesDetail.action?clothesId=${cart.tbClothesdetail.tbClothes.clothesId }">
	                                    <img src="${cart.tbClothesdetail.picUrl }" />
	                                    
	                                    <div class="account_cart_item_text">
	                                        <p class="account_cart_item_name">${cart.tbClothesdetail.tbClothes.clothesName }</p>
	                                        <span class="account_cart_item_price">&yen;${cart.tbClothesdetail.tbClothes.price }</span><span class="account_cart_item_count">数量:${cart.clothesNumber }</span>
	                                    </div>
	                                </a>
	                            	</div>	
                            	</c:forEach>
                            </c:if>
                            
                            <a href="${applicationScope['basePath'] }/customer/PrepareCartItemList.action">查看全部购物车</a>
                        </div>
                    </div>
                    
                </div>
            </div>
            
        </div>
        
    </div>
    
	<%@ include file="footer.jsp" %>


	<script type="application/javascript" src="/EShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/EShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/EShopping/js/account.js"></script>
    <script type="application/javascript" src="/EShopping/js/global.js"></script>


	<script type="application/javascript">
		function cancel_order() {
			return window.confirm("确定取消订单？")
		}
		function delete_order(order_id) {
    		if (window.confirm("确认删除订单？")) {
    			$.ajax({
    				url: "/EShopping/customer/DeleteOrder.action",
    				type: "GET",
    				aysnc: false,
    				contentType: "application/json;charset=utf-8",
    				dataType: "json",
    				data: {orderId: order_id},
    				success: function(result) {
    					show_tips("删除成功", "ok");
    					var order_body_id = "#order_body" + order_id;
    					$(order_body_id).fadeOut("slow", function() {
    						$(order_body_id).remove();
    					});
    					setTimeout(function(){window.location.reload();}, 3000);
    				}
    			});
    		}
    	}
	</script>

</body>
</html>
