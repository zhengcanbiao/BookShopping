
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
<link href="/BookShopping/css/item.css" rel="stylesheet" media="screen" />
<title>商品详情</title>
</head>

<body>

	<%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">
        
        	<ul class="inline bread">
              <li><a href="${applicationScope['basePath'] }/customer/RedirectToHome.action">首页</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li><a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?categoryId=${requestScope['currentBooks'].tbCategory.categoryId }&pageNow=1">${requestScope['currentBooks'].tbCategory.categoryName }</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li class="active">商品详情</li>
            </ul>

        	<div class="row-fluid">
            	<div class="span5" >
                	<img src="${requestScope['currentBooks'].picUrl }"/>
                </div>
             
                
                <div class="span7">
                	<div class="item_intro">
                        <h3 class="item_name_indetail">${requestScope['currentBooks'].bookName }</h3>
                        <p class="item_price_indetail">&yen;${requestScope['currentBooks'].price/100.0 }</p>
                        <p class="item_discount_indetail">积分优惠: <span class="label label-warning">
                        	<c:if test="${requestScope['customerLevel']==0 }">无</c:if>
                        	<c:if test="${requestScope['customerLevel']!=0 }">${applicationScope['discountList'][requestScope['customerLevel']].discountRate/10.0}折</c:if></span></p>
                        <p class="item_intro_indetail">${requestScope['currentBooks'].booksDescription }</p>
                        <p class="item_author_indetail">作者: <span>${requestScope['currentBooks'].author }</span></p>
                        <p class="item_publisher_indetail">出版社: <span>${requestScope['currentBooks'].publisher }</span></p>
                        <p class="item_publicationDate_indetail">出版时间: <span>${requestScope['currentBooks'].publicationDate }</span></p>
                        
                    </div>
                    
                    <hr style="width:400px;">
                    
                    <div class="item_operation">
                    	<c:if test="${requestScope['currentBooks'].valid==true }">
                    	<%-- <p>选择尺码</p>
                        <ul class="inline" id="size_list">
                        	<c:forEach items="${requestScope['clothesDetailList'] }" var="clothesDetail">
                        	<li><label <c:if test="${clothesDetail.remainder<=0}">class="disabled"</c:if>>
                        		<input <c:if test="${clothesDetail.remainder<=0}">disabled="disabled"</c:if> id="clothesDetail${clothesDetail.clothesDetailId }" value="${clothesDetail.size }" onClick="on_clothes_size_selected('${clothesDetail.remainder}')" type="radio" name="size"/>
                        		<c:choose>
                        			<c:when test="${clothesDetail.size==0 }">S</c:when>
                        			<c:when test="${clothesDetail.size==1 }">M</c:when>
                        			<c:when test="${clothesDetail.size==2 }">L</c:when>
                        		</c:choose>
                        	</label></li>
                            </c:forEach>
                        </ul> --%>
                        
                        <label for="input_count"<c:if test="${currentBooks.remainder<=0}">class="disabled"</c:if>>数量</label>
                        <input <c:if test="${currentBooks.remainder<=0}">disabled="disabled"</c:if>id="input_count" type="text" value="1" style="width:30px; margin-left:5px; float:left;" />
                        
                        <p id="remainder" >剩余<span>${requestScope['currentBooks'].remainder}</span>件</p>
                        
                        <div class="btn_block"><button onClick="add_to_cart()" class="btn btn-large btn-primary">加入购物车</button>
                        <button onClick="add_to_favorite('${requestScope.currentBooks.booksId}')" class="btn btn-large"  <c:if test="${empty sessionScope['currentCustomerName'] }">disabled="disabled"</c:if> >点击收藏</button></div>
                        </c:if>
                        <c:if test="${requestScope['currentBooks'].valid==false }">
                        	<p style="font-size:24px;">该商品已下架</p>
                        </c:if>
                    </div>
                </div>
            </div><!-- row-fluid -->
            
            <c:if test="${not empty requestScope['currentBooks'].tbComments }">
            <div class="row-fluid">
            	<div class="span7 offset5 comment_block">
                    <legend>商品评价</legend>
                    <c:forEach items="${requestScope['currentBooks'].tbComments  }" var="comment">
	                    <div class="comment">
	                    	<p class="comment_content">${comment.commentContent }</p>
	                        <p class="comment_time"><i class="icon-time"> </i> ${comment.commentTime }</p>
	                        <p class="comment_user">${comment.tbCustomer.customerName }</p>
	                    </div>
                    </c:forEach>
                </div>
            </div>
            </c:if>
            
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
		$(document).ready(function () {    
			$("input:radio").click(function(){
				$("input:radio").parent("label").removeClass("checked");
				$("input:radio:checked").parent("label").addClass("checked");
			});
			on_num_change();
			
		});
		
		function on_num_change() {
			$("#input_count").keyup(function(e) {
				if ( $("#input_count").val() > parseInt($("#remainder span").text()) ) {
					$("#input_count").val($("#remainder span").text());
				}
				
				if ( isNaN($("#input_count").val()) || $("#input_count").val() === '0' || e.keyCode == 190){
					$("#input_count").val();
				}
			});
		}
		
		function add_to_cart() {
			if (!$("input:radio:checked").val()) {
				show_tips("请选择尺码","warning");
			} else if ($("#input_count").val() === '') {
				show_tips("请输入数量","warning");
			} else {
				var clothes_detail_id = get_num_in_str($("input:radio:checked").attr("id"));
				$.ajax({
					url: "/BookShopping/customer/AddToShoppingCart.action",
					type:"GET",
					contentType:"application/json;charset=utf-8",
					dataType:"json",
					data:{clothesDetailId: clothes_detail_id, clothesNumber: $('#input_count').val()},
					success: function(result) {
						if (result == "success") {
							show_tips("添加到购物车成功", "ok");
						} else if (result = "fail") {
							show_tips("库存不足", "ok");
						}
					}
				});
			}
		}
		
		function add_to_favorite(id) {
			$.ajax({
				url:"/BookShopping/customer/AddFavorite.action",
				type:"GET",
				contentType:"application/json;charset=utf-8",
				dataType:"json",
				data:{clothesId: id},
				success: function(result) {
					if (result == "success") {
						show_tips("添加收藏成功", "ok");
					} else if (result === "exist") {
						show_tips("收藏夹已存在", "warning");
					} else if (result == "full") {
						show_tips("收藏夹已满", "warning");
					}
				}
			});
		}
		
		/* function on_clothes_size_selected(i) {
			$("#remainder").removeAttr("hidden");
			$("#remainder span").text(i);
			$("#input_count").removeAttr("disabled");
		} */
	</script>
</body>
</html>
