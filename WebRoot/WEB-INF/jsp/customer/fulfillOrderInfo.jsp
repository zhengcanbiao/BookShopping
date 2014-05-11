<%@ page language="java" import="java.util.*, com.bookshopping.service.AddressService" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

  
<%   
  if(request.getProtocol().compareTo("HTTP/1.0")==0)   
        response.setHeader("Pragma","no-cache");   
  else   if(request.getProtocol().compareTo("HTTP/1.1")==0)   
        response.setHeader("Cache-Control","no-cache");   
  response.setDateHeader("Expires",0);   
  %>

<%
 response.setHeader("Pragma","No-cache");
 response.setHeader("Cache-Control","No-cache");
 response.setDateHeader("Expires", -1);
 response.setHeader("Cache-Control", "No-store");
 
%>
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/bookshopping.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/cart.css" rel="stylesheet" media="screen" />

<title>结算中心</title>
</head>

<body >
	<%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">
        
        	<ul class="inline bread">
              <li><a href="/BookShopping/customer/RedirectToHome.acction">首页</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li>结算中心</li>
            </ul>
        
        	<p class="bookshopping_title">填写订单详情</p>
            
            <div class="pay_address">
            	<h4>选择地址</h4>
            	<c:forEach items="${requestScope['addressList'] }" var="address">
            		<label>
            			<input type="radio" name="address" value="${address.receiverName},${address.tbProvince.provinceName},${address.tbCity.cityName},${address.tbTown.townName},${address.receiverAddress},${address.postcode},${address.phone}" <c:if test="${address.isDefault }">checked="checked"</c:if> />${address.receiverName},${address.tbProvince.provinceName},${address.tbCity.cityName},${address.tbTown.townName},${address.receiverAddress},${address.postcode},${address.phone}
            		</label>
            	</c:forEach>
                <a href="#address_modal" data-toggle="modal"><button type="button" class="btn" onClick="prepare_province_list()">使用新地址</button></a>
                
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
                    
                    <c:forEach begin="1" end="${fn:length(requestScope['booksDetailList']) }" var="index">
	                    <tr>
	                        <td>
	                            <a href="#"><img src="${requestScope['booksDetailList'][index-1].picUrl }" /></a>
	                            <div class="cart_item_name">
	                            <a href="#">${requestScope['booksDetailList'][index-1].bookName }</a>
	                            <p>作者: 
	                            <%-- <c:choose>
                        			<c:when test="${requestScope['booksDetailList'][index-1].size==0 }">S</c:when>
                        			<c:when test="${requestScope['booksDetailList'][index-1].size==1 }">M</c:when>
                        			<c:when test="${requestScope['booksDetailList'][index-1].size==2 }">L</c:when>
                        			</c:choose> --%>
                        			${requestScope['booksDetailList'][index-1].author }
                        			</p>
	                            </div>
	                        </td>
	                        <td>
	                            &yen;${requestScope['booksDetailList'][index-1].price/100.0 }
	                        </td>
	                        <td>
	                            ${requestScope['cartItemList'][index-1].booksNumber }
	                        </td>
	                        <td>
	                            &yen;${requestScope['booksDetailList'][index-1].price/100.0 * requestScope['cartItemList'][index-1].booksNumber }
	                        </td>
	                    </tr>                    	
                    </c:forEach>
                </table>
   
            	<p class="cart_total_price">总价: <span>&yen;${requestScope['totalPrice'] }</span></p>
                
                <div class="discount_block">
                    <p class="cart_discount_price">实付款: <span>&yen;${requestScope['totalPrice']*applicationScope['discountList'][requestScope['customerLevel']].discountRate/100.00 }</span></p>
                    <p class="cart_discount">积分优惠: 
                    <c:if test="${requestScope['customerLevel']==0 }">
                    	<span class="label label-warning">无</span>
                    </c:if>
                    <c:if test="${requestScope['customerLevel']!=0 }">
                    	<span class="label label-warning">${applicationScope['discountList'][requestScope['customerLevel']].discountRate }折</span>
                  	</c:if>
                  	</p>
                </div> 
            </div> 
            
            <a href="#"><button class="btn btn-large btn-primary" type="button" id="order_btn" onClick="confirm_order()" <c:if test="${empty requestScope['booksDetailList'] }">disabled="disabled"</c:if>  >确认下单</button></a>
            <a href="${applicationScope['basePath'] }/customer/PrepareCartItemList.action">返回购物车</a>

            
        </div><!-- container -->
        
        <div id="alert_tips">
        	<i class="icon-2x icon-ok"></i><span>添加到购物车成功</span>
            <button type="button" class="close" onClick="$('#alert_tips').fadeOut('fast')">×</button>
        </div>
        
        <div id="address_modal" class="modal hide fade" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                
                <form id="new_address_form" action="/BookShopping/customer/GenerateOrderInfo.action" class="form-horizontal" onSubmit="return add_new_address()">
                <p class="bookshopping_title">添加新地址</p>
                
                <div class="control-group">
                    <label for="input_receiver" class="control-label">收件人</label>
                    <div class="controls">
                        <input id="input_receiver" type="text" placeholder="" value="" /><span id="receiver_span" class="label label-important"></span>
                    </div>
                </div>
        
                <div class="control-group">
                    <label for="input_nickname" class="control-label">所在地区</label>
                    <div class="controls">
                        <select id="province_dropdown" name="provinceId" onChange="on_province_selected()">
                        	<option value="-1">请选择省份</option>
                        </select>
                        
                        <select id="city_dropdown" name="cityId" onChange="on_city_selected()">
                        	<option value="-1">请选择城市</option>
                        </select>
                        
                        <select id="town_dropdown" name="townId">
                        	<option value="-1">请选择地区</option>
                        </select>
                        <span id="area_span" class="label label-important"></span>
                    </div>
                </div>
                
                <div class="control-group">
                    <label for="input_address_detail" class="control-label">详细地址</label>
                    <div class="controls">
                        <input id="input_address_detail" type="text" placeholder="" value="" /><span id="address_detail_span" class="label label-important"></span>
                    </div>
                </div>
                
                <div class="control-group">
                    <label for="input_postcode" class="control-label">邮编</label>
                    <div class="controls">
                        <input id="input_postcode" type="text" placeholder="" value="" />
                        <span id="postcode_span" class="label label-important"></span>
                    </div>
                </div>
                
                <div class="control-group">
                    <label for="input_phone" class="control-label">手机</label>
                    <div class="controls">
                        <input id="input_phone" type="text" placeholder="" value="" />
                        <span id="phone_span" class="label label-important"></span>
                    </div>
                </div>
                
            </form>
            </div>
            <div class="modal-footer">
                <button type="submit" form="new_address_form" class="btn btn-primary">保存地址</button>
                <button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
            </div>
        </div>
        
    </div>
    
    
    <%@ include file="footer.jsp" %>

	<script type="application/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/global.js"></script>
    <script type="application/javascript" src="/BookShopping/js/check.js"></script>
    
    <script type="application/javascript">
    //window.location.href(/BookShopping/customer/GetProvinceList.action); 
    




    window.onload=function(){
    	
    	
    	
    	  if (location.href.indexOf("?xyz=")<0)
    	 {
    	 location.href=location.href+"?xyz="+Math.random();}
     }
    
 
		$(document).ready(function(e) {
		 
			
			 
			prepare_province_list();
			if ($("#province_dropdown").val() != -1) {
				on_province_selected();
			}
			
			address_check('new_address_form');
        });
		
		function on_province_selected() {
			$.ajax({
				url:"/BookShopping/customer/GetCityList.action",
				type:"GET",
				contentType:"application/json;charset=utf-8",
				dataType:"json",
				data:{provinceId: $('#province_dropdown').val()},
				success: function(result) {
					$('#city_dropdown').empty();
					$('#city_dropdown').append("<option value='-1'>请选择城市</option>");
					$('#town_dropdown').empty();
					$('#town_dropdown').append("<option value='-1'>请选择地区</option>");
					var resultJson = eval(result);
					$.each(resultJson, function(index, item) {
						$('#city_dropdown').append("<option value="+ item.cityId +">" + item.cityName + "</option>");
					});
				}
			});
		}

		function on_city_selected() {
			$.ajax({
				type: "GET",
				contentType:"application/json;charset=utf-8",
				dataType:"json",
				url:"/BookShopping/customer/GetTownList.action",
				data:{cityId: $("#city_dropdown").val()},
				success: function(result) {
					var resultJson = eval(result);
					$('#town_dropdown').empty();
					$('#town_dropdown').append("<option value='-1'>请选择地区</option>");
					$.each(resultJson, function(index, item) {
						$('#town_dropdown').append("<option value="+ item.townId +">" + item.townName + "</option>");
					});
				}
			});
		}
		
		function prepare_province_list() {
			$.ajax({
				url: "/BookShopping/customer/GetProvinceList.action",
				type: "GET",
				contentType:"application/json;charset=utf-8",
				dataType:"json",
				success: function(result) {
					var resultJson = eval(result);
					$("province_dropdown").empty();
					$.each(resultJson, function(index, item) {
						$("#province_dropdown").append("<option value=" + item.provinceId + ">" + item.provinceName + "</option>");
					});
				}
			});
		}
		
		function confirm_order() {
			
			if ($("[name='address']").val()) {
				var list= $('input:radio[name="address"]:checked').val();
				$("#order_btn").parent().attr("href", "/BookShopping/customer/AddOrder.action?receiverInfo=" + list);
			} else {
				show_tips("请选择地址信息", "warning");
			}
		}
		
		function add_new_address() {
			
			var wrong = 0;
			
			wrong = (!address_submit('new_address_form'));
			if(wrong) {
				return false;
			}
			else {
				$.ajax({
					url: "/BookShopping/customer/AddAddress.action",
					type: "POST",
					async: false,
					dataType:"json",
					data:{receiverName:$("#input_receiver").val(),
						phone:$("#input_phone").val(),
						async:false,
						provinceId:$("#province_dropdown").val(), 
						cityId:$("#city_dropdown").val(), 
						townId:$("#town_dropdown").val(), 
						receiverAddress:$("#input_address_detail").val(), 
						postcode:$("#input_postcode").val()},
					success: function(result) {
						if (result == "success") {
							wrong = 0;
						} else {
							wrong = 1;
						}
					}
				});
				return (wrong == 0);
			}
		}
	</script>

</body>
</html>
