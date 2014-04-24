
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/bookshopping.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/account.css" rel="stylesheet" media="screen" />
<title>我的订单</title>
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
              <li>我的订单</li>
            </ul>
        
        	<div class="row-fluid">
        	
        		<%@ include file="leftBar.jsp" %>
           
                <div class="span10">
                    <p class="myAccount_title">我的订单</p>
                    
                    <table class="table">
                        <tr>
                            <th class="order_item_column">商品</th>
                            <th class="order_price_column">单价</th>
                            <th class="order_count_column">数量</th>
                            <th class="order_total_column">实付款</th>
                            <th class="order_detail_column">详情</th>
                            <th class="order_operation_column">操作</th>
                        </tr>
                        
                    <c:forEach begin="1" end="${fn:length(requestScope['orderList']) }" var="orderIndex">
                    	<c:if test="${requestScope['orderList'][orderIndex-1].valid==true }">
                        <tbody class="order" id="order_body_${requestScope['orderList'][orderIndex-1].orderId }">
                        	<tr>
                            	<td colspan="6"></td>
                            </tr><!-- a empty row use to apart each order -->
                        
                            <tr>
                                <td colspan="6" class="order_head">
                                    <ul>
                                        <li class="order_condition">订单状态: <span>
                                        <c:choose>
                                        	<c:when test="${requestScope['orderList'][orderIndex-1].orderStatus==-1 }">交易失败</c:when>
                                        	<c:when test="${requestScope['orderList'][orderIndex-1].orderStatus==1 }">未发货</c:when>
                                        	<c:when test="${requestScope['orderList'][orderIndex-1].orderStatus==2 }">未确认收货</c:when>
                                        	<c:when test="${requestScope['orderList'][orderIndex-1].orderStatus==3 }">交易成功</c:when>
                                        </c:choose>
                                        </span></li>
                                        <li class="order_time">下单时间: <span>${requestScope['orderList'][orderIndex-1].orderTime }</span></li>
                                        <li class="order_number">订单号: <span>${requestScope['orderList'][orderIndex-1].orderId }</span></li>
                                    </ul>
                                </td>
                            </tr><!-- the frist row, show the condition of this order -->
                            
                            <tr>
                                <td>
                                    <a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['orderList'][orderIndex-1].tbOrderdetails[0].tbBooks.booksId }"><img src="${requestScope['orderList'][orderIndex-1].tbOrderdetails[0].tbBooks.picUrl }" /></a>
                                    <div class="cart_item_name">
                                    <a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['orderList'][orderIndex-1].tbOrderdetails[0].tbBooks.booksId }">${requestScope['orderList'][orderIndex-1].tbOrderdetails[0].tbBooks.bookName }</a>
                                    <p>作者: 
                                    <%-- <c:choose>
                                    	<c:when test="${requestScope['orderList'][orderIndex-1].tbOrderdetails[0].size==0 }">S</c:when>
                                    	<c:when test="${requestScope['orderList'][orderIndex-1].tbOrderdetails[0].size==1 }">M</c:when>
                                    	<c:when test="${requestScope['orderList'][orderIndex-1].tbOrderdetails[0].size==2 }">L</c:when>
                                    </c:choose> --%>
                                    ${requestScope['orderList'][orderIndex-1].tbOrderdetails[0].tbBooks.author}
                                    </p>
                                    </div>
                                </td>
                                <td>
                                    &yen;${requestScope['orderList'][orderIndex-1].tbOrderdetails[0].tbBooks.price / 100.0 }
                                </td>
                                <td>
                                    ${requestScope['orderList'][orderIndex-1].tbOrderdetails[0].quantity }
                                </td>
                                <td rowspan="2">
                                    <b>&yen;${requestScope['orderList'][orderIndex-1].finalPrice/100.0 }</b>
                                </td>
                                <td rowspan="2">
                                    <p>收件人:${fn:substringBefore(requestScope['orderList'][orderIndex-1].receiverInfo, ',') }</p>
                                    <a href="${applicationScope['basePath'] }/customer/PrepareOrderDetail.action?orderId=${requestScope['orderList'][orderIndex-1].orderId }"><button type="button" class="btn btn-primary">订单详情</button></a>
                                </td>
                                <td rowspan="2">         
                                    	<c:choose>
                                    		<c:when test="${requestScope['orderList'][orderIndex-1].orderStatus==-1 }">
                                    			<a href="#" onClick="return delete_order('${request['orderList'][orderIndex-1].orderId}')">删除订单</a>
                                    		</c:when>
                                    		<c:when test="${requestScope['orderList'][orderIndex-1].orderStatus==1 }">
                                    			<a href="${applicationScope['basePath'] }/customer/CancelOrder.action?orderId=${request['orderList'][orderIndex-1].orderId }" onClick="return cancel_order()">取消订单</a>
                                    		</c:when>
                                    		<c:when test="${requestScope['orderList'][orderIndex-1].orderStatus==2 }">
                                    			<a href="${applicationScope['basePath'] }/customer/ConfirmDelivery.action?orderId=${request['orderList'][orderIndex-1].orderId }" onClick="return comfirm_order()">确认收货</a>
                                    		</c:when>
                                   			<c:when test="${requestScope['orderList'][orderIndex-1].orderStatus==3 and requestScope['orderList'][orderIndex-1].isComment==false }">
                                    			<a href="${applicationScope['basePath'] }/customer/PrepareComment.action?orderId=${request['orderList'][orderIndex-1].orderId }">评价订单</a>
                                    		</c:when>
                                    	</c:choose>
                                </td>
                            </tr><!-- the second row contain total price, recevier and the operation -->
                            
                            <c:forEach begin="2" end="${fn:length(requestScope['orderList'][orderIndex-1].tbOrderdetails) }" var="index">
                            <tr>
                                <td>
                                    <a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['orderList'][orderIndex-1].tbOrderdetails[index-1].tbBooks.booksId }"><img src="${requestScope['orderList'][orderIndex-1].tbOrderdetails[index-1].tbBooks.picUrl }" /></a>
                                    <div class="cart_item_name">
                                    <a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['orderList'][orderIndex-1].tbOrderdetails[index-1].tbBooks.booksId }">${requestScope['orderList'][orderIndex-1].tbOrderdetails[index-1].tbBooks.bookName }</a>
                                    <p>作者:
                                    <%-- <c:choose> 
                                    	<c:when test="${requestScope['orderList'][orderIndex-1].tbOrderdetails[index-1].size==0 }">S</c:when>
                                    	<c:when test="${requestScope['orderList'][orderIndex-1].tbOrderdetails[index-1].size==1 }">M</c:when>
                                    	<c:when test="${requestScope['orderList'][orderIndex-1].tbOrderdetails[index-1].size==2 }">L</c:when>
                                    </c:choose> --%>
                                    ${requestScope['orderList'][orderIndex-1].tbOrderdetails[0].tbBooks.author}
                                    
                                    </p>
                                    </div>
                                </td>
                                <td>
                                    &yen;${requestScope['orderList'][orderIndex-1].tbOrderdetails[index-1].tbBooks.price / 100.0 }
                                </td>
                                <td>
                                    ${requestScope['orderList'][orderIndex-1].tbOrderdetails[index-1].quantity }
                                </td>
                            </tr><!-- from the third row, there's only item information -->
                            </c:forEach>
                        </tbody>
                        </c:if>
                    </c:forEach>
                    </table>
                    
                    
                    
                </div>
            
            </div>
            
            <div class="pagination">
                <ul>
                	<c:if test="${pageNow!=1 }"><li><a href="${applicationScope['basePath'] }/customer/PrepareOrderInfoList.action?pageNow=${pageNow-1 }">prev</a></li></c:if>
                	<c:forEach begin="1" end="${requestScope['pageCount'] }" var="index">
                		<li <c:if test="${pageNow==index }">class="active"</c:if>><a href="${applicationScope['basePath'] }/customer/PrepareOrderInfoList.action?pageNow=${index }">${index }</a></li>
                	</c:forEach>
                    <c:if test="${pageNow!=pageCount }"><li><a href="${applicationScope['basePath'] }/customer/PrepareOrderInfoList.action?pageNow=${pageNow+1 }">Next</a></li></c:if>
                </ul>
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
    <script type="application/javascript">
    	function cancel_order() {
    		return window.confirm("确定取消订单？")
    	}
    	function delete_order(order_id) {
    		if (window.confirm("确认删除订单？")) {
    			$.ajax({
    				url: "/BookShopping/customer/DeleteOrder.action",
    				type: "GET",
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
		
		function comfirm_order() {
			return window.confirm("确认收货？");
		}
    </script>

</body>
</html>
