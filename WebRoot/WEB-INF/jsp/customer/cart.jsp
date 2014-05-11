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
<link href="/BookShopping/css/cart.css" rel="stylesheet" media="screen" />

<title>购物车</title>
</head>

<body>

	<%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">
        
        	<ul class="inline bread">
              <li><a href="${applicationScope['basePath'] }/customer/RedirectToHome.action">首页</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li><a href="/BookShopping/customer/PrepareCartItemList.action">购物车</a></li>
            </ul>
        
        	<p class="bookshopping_title">购物车中的商品</p>
            
            <table class="table table-striped">
            	<tr>
                	<th class="cart_item_column">商品</th>
                    <th class="cart_price_column">单价</th>
                    <th class="cart_count_column">数量</th>
                    <th class="cart_subtotal_column">小计</th>
                    <th class="cart_operation_column"> </th>
                </tr>
                
                <c:if test="${empty requestScope['booksList'] }">
                    <tr>
                	<td colspan="5">
                    	购物车为空!快去购物吧
                    </td>
                	</tr>
                </c:if>
                
                <c:if test="${not empty requestScope['booksList'] }">
                <c:forEach begin="1" end="${fn:length(requestScope['booksList']) }" var="index">
	                <tr id="cart_item_${requestScope['cartItemList'][index-1].cartId}">
	                	<td>
	                    	<a href="${applicationScope['basePath'] }/customer/PrepareBooksDetail.action?booksId=${requestScope['booksList'][index-1].booksId }&categoryId=${requestScope['booksList'][index-1].tbCategory.categoryId }"><img src="${requestScope['booksList'][index-1].picUrl }" /></a>
	                        <div class="cart_item_name">
	                    	<a href="${applicationScope['basePath'] }/customer/PrepareBooksDetail.action?booksId=${requestScope['booksList'][index-1].booksId }&categoryId=${requestScope['booksList'][index-1].tbCategory.categoryId }">${requestScope['booksList'][index-1].bookName }</a>
	                        <p>作者:
	                        <%-- <c:choose>
                        			<c:when test="${requestScope['booksList'][index-1].size==0 }">S</c:when>
                        			<c:when test="${requestScope['booksList'][index-1].size==1 }">M</c:when>
                        			<c:when test="${requestScope['booksList'][index-1].size==2 }">L</c:when>
                        			</c:choose> --%>
                        			${requestScope['booksList'][index-1].author}
                        			</p>
	                        </div>
	                    </td>
	                    <td>
	                    	&yen;${requestScope['priceList'][index-1] }
	                    </td>
	                    <td>
	                    	<input id="input_count_${requestScope['cartItemList'][index-1].cartId}" type="text" value="${requestScope['cartItemList'][index-1].booksNumber }" onKeyUp="on_num_change('${requestScope.cartItemList[index-1].cartId}', '${requestScope.cartItemList[index-1].tbBooks.remainder }')"/>
	                        <a hidden="hidden" id="update${requestScope['cartItemList'][index-1].cartId}" href="${applicationScope['basePath']}/ModifyCart.action?cartId=${requestScope['cartItemList'][index-1].cartId}"></a>
                            <p>剩余库存<span>${requestScope.cartItemList[index-1].tbBooks.remainder }</span>件</p>
	                    </td>
	                    <td>
	                    	&yen;${requestScope['priceList'][index-1] * requestScope['cartItemList'][index-1].booksNumber }
	                    </td>
	                    <td>
	                    	<a href="#" onClick="delete_cart('${requestScope['cartItemList'][index-1].cartId}')"><i class="icon-trash"></i></a>
	                    </td>
	                </tr>
                </c:forEach>
                </c:if>
                
            </table>
   

            <p class="cart_total_price">总价: <span>&yen;${requestScope['totalPrice'] }</span></p>
            
            <a href="${applicationScope['basePath'] }/customer/GenerateOrderInfo.action?+new Date()"><button class="btn btn-large btn-primary pay_btn" type="button" <c:if test="${empty requestScope['cartItemList'] }">disabled="disabled"</c:if> >结算</button></a>
            
            <div class="discount_block">
            	<p class="cart_discount_price">实付款: <span>&yen;${requestScope['totalPrice']*applicationScope['discountList'][requestScope['customerLevel']].discountRate/100.00 }</span></p>
            	<p class="cart_discount">积分优惠: <span class="label label-warning">
            	<c:if test="${requestScope['customerLevel']==0 }">无</c:if>
            	<c:if test="${requestScope['customerLevel']!=0}">${applicationScope['discountList'][requestScope['customerLevel']].discountRate/10.0 }折</c:if>
            	</span></p>
            </div>  
            
            <a href="${applicationScope['basePath'] }/customer/RedirectToHome.action">继续购物</a>	
            
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
    
    <script>
		function on_num_change(cartId, max_num ) {
			var input_count_id = "#input_count_" + cartId;
			
			if ($(input_count_id).val() > parseInt(max_num) ) {
				$(input_count_id).val(parseInt(max_num));
			}
			
			if (isNaN($(input_count_id).val()) || window.event.keyCode == 190 || window.event.keyCode == 32){
				$(input_count_id).val(1);
			}
			var updateId = "#update" + cartId;
			
			if ($(input_count_id).val() == '0') {
				$(updateId).text("删除"); 
			}
			else {
				$(updateId).text("更新");
			}
			
			if ($(input_count_id).val() == '') {
				show_tips("请输入数量","warning");
			}
			else {
				$(updateId).attr("href", "/BookShopping/customer/ModifyCart.action?cartId=" + cartId + "&booksNumber=" + $(input_count_id).val());
				$(updateId).removeAttr("hidden");
			}
		}
		
		function delete_cart(cart_id) {
			if (window.confirm("确认删除商品？")) {
				$.ajax({
					url: "/BookShopping/customer/DeleteCart.action",
					type: "GET",
					async:false,
					contentType:"application/json;charset=utf-8",
					dataType:"json",
					data:{cartId: cart_id},
					success: function(result) {
						var cart_item_id = "#cart_item_" + cart_id;
						$(cart_item_id).fadeOut("slow", function() {
							$(cart_item_id).remove();
						});
						show_tips("删除成功", "ok");
					}
				});
				window.location.reload();
			}
		}
	
	</script>

</body>
</html>

