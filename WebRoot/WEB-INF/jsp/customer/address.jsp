<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/EShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/eshopping.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/account.css" rel="stylesheet" media="screen" />
<title>地址簿</title>
</head>

<body>
	<%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">
        
        	<ul class="inline bread">
              <li><a href="/EShopping/customer/RedirectToHome.action">首页</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li><a href="/EShopping/customer/PreparePersonalHome.action">我的账户</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li class="active">地址簿</li>
            </ul>
        
        	<div class="row-fluid">
                <%@ include file="leftBar.jsp" %>
               
                <div class="span10">
                    <p class="myAccount_title">地址簿</p>
                    <table class="table table-striped">
                        <tr>
                            <th class="address_name">收货人</th>
                            <th class="address_area">所在地区</th>
                            <th class="address_detail">详细地址</th>
                            <th class="address_postcode">邮编</th>
                            <th class="address_phone">手机</th>
                            <th>操作</th>
                            <th class="address_default">默认</th>
                        </tr>
                        
                        <c:forEach items="${requestScope['addressList'] }" var="address">
                        	<tr class="address_row" id="address_info_${address.addressId }">
                        		<td>${address.receiverName }</td>
                        		<td>${address.tbProvince.provinceName } ${address.tbCity.cityName } ${address.tbTown.townName }</td>
                        		<td>${address.receiverAddress }</td>
                        		<td>${address.postcode }</td>
                        		<td>${address.phone }</td>
                        		<td>
                        			<a href="javascript:void()" onClick="modify_form('${address.addressId }', 
                        			'${address.receiverName }', 
                        			'${address.tbProvince.provinceId }',
                        			'${address.tbCity.cityId }',
                        			'${address.tbTown.townId }',
                                	'${address.receiverAddress }',
                                	'${address.postcode }',
                                	'${address.phone }')">修改</a>
	                                <a href="#" onClick="delete_address('${address.addressId }')">删除</a>
                           		</td>
                            	<td class="address_default">
                            		<c:if test="${address.isDefault == true }">
	                            		<a class="set_default_show" href="#" onClick="set_default_address('${address.addressId }')">
	                            			<i class="icon-ok"></i>
	                            		</a>
                            		</c:if>
                            		<c:if test="${address.isDefault == false }">
	                            		<a class="set_default" href="#" onClick="set_default_address('${address.addressId }')">
	                            			<i class="icon-ok"></i>
	                            		</a>
                            		</c:if>
                            	</td>
                        	</tr>
                        </c:forEach>
                    </table>
                    
                    
                    <form id="new_address_form" action="PrepareAddress.action" class="form-horizontal" method="post" onsubmit="return add_new_address()">
                    <p class="myAccount_title">添加新地址</p>
                    	<div class="control-group">
                            <label for="input_receiver" class="control-label">收件人</label>
                            <div class="controls">
                                <input id="input_receiver" name="receiverName" type="text" placeholder="" value="" /><span id="receiver_span" class="label label-important"></span>
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label for="input_nickname" class="control-label">所在地区</label>
                            <div class="controls">
                                <select id="province_dropdown" name="provinceId" onChange="on_province_selected()">
                                	<option value="-1">请选择省份</option>
                                	<c:forEach items="${requestScope['provinceList'] }" var="province">
                                		<option value="${province.provinceId }">${province.provinceName }</option>
                                	</c:forEach>
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
                                <input id="input_address_detail" type="text" placeholder="" name="receiverAddress" value="" /><span id="address_detail_span" class="label label-important"></span>
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label for="input_postcode" class="control-label">邮编</label>
                            <div class="controls">
                                <input name="postcode" id="input_postcode" type="text" placeholder="" value="" /><span id="postcode_span" class="label label-important"></span>
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label for="input_phone" class="control-label">手机</label>
                            <div class="controls">
                                <input id="input_phone" name="phone" type="text" placeholder="" value="" /><span id="phone_span" class="label label-important"></span>
                            </div>
                        </div>
                        
                        <div class="controls">
                            <input type="submit" value="添加" class="btn btn-primary" />
                        </div>
                    </form>
                    
                    <form id="modify_address_form" action="/EShopping/customer/ModifyAddress.action" class="form-horizontal" style="display:none;" onSubmit="return modify_address()">
                    	<p class="myAccount_title">修改地址</p>
                    	<input type="hidden" name="addressId" id="addressId" />
                    	<div class="control-group">
                            <label for="input_receiver" class="control-label">收件人</label>
                            <div class="controls">
                                <input id="input_receiver" type="text" name="receiverName" placeholder="" value="" /><span id="receiver_span" class="label label-important"></span>
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label for="input_nickname" class="control-label">所在地区</label>
                            <div class="controls">
                                <select id="province_dropdown" name="provinceId" onChange="on_modify_province_selected()">
                                	<option value="-1">请选择省份</option>
                                	<c:forEach items="${requestScope['provinceList'] }" var="province">
                                		<option value="${province.provinceId }">${province.provinceName }</option>
                                	</c:forEach>
                                </select>
                                
                                <select id="city_dropdown" name="cityId" onChange="on_modify_city_selected()">
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
                                <input id="input_address_detail" name="receiverAddress" type="text" placeholder="" value="" /><span id="address_detail_span" class="label label-important"></span>
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label for="input_postcode" class="control-label">邮编</label>
                            <div class="controls">
                                <input id="input_postcode" name="postcode" type="text" placeholder="" value="" />
                                <span id="postcode_span" class="label label-important"></span>
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label for="input_phone" class="control-label">手机</label>
                            <div class="controls">
                                <input id="input_phone" name="phone" type="text" placeholder="" value="" />
                                <span id="phone_span" class="label label-important"></span>
                            </div>
                        </div>
                        
                        <div class="controls">
                            <input type="submit" value="保存修改" class="btn btn-primary" />
                            <button class="btn cancel">取消</button>
                        </div>
                    </form>
                    
                </div>
            </div>
            
        </div>
        
        <div id="alert_tips">
        	<i class="icon-2x icon-ok"></i><span>添加到购物车成功</span>
            <button type="button" class="close" onClick="$('#alert_tips').fadeOut('fast')">×</button>
        </div>
        
    </div>
    
	<%@ include file="footer.jsp" %>
	
	<script type="application/javascript" src="/EShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/EShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/EShopping/js/account.js"></script>
    <script type="application/javascript" src="/EShopping/js/check.js"></script>
	<script type="application/javascript" src="/EShopping/js/global.js"></script>
	<script type="application/javascript">
	
		$(document).ready(function(e) {
			if ($("#new_address_form #province_dropdown").val() != -1) {
				on_province_selected();
			}
			address_check('new_address_form');
			address_check('modify_address_form');
        });
		
		function on_modify_province_selected() {
			$.ajax({
				url:"/EShopping/customer/GetCityList.action",
				type:"GET",
				async: false,
				contentType:"application/json;charset=utf-8",
				dataType:"json",
				data:{provinceId: $('#modify_address_form #province_dropdown').val()},
				success: function(result) {
					$('#modify_address_form #city_dropdown').empty();
					$('#modify_address_form #city_dropdown').append("<option value='-1'>请选择城市</option>");
					$("#modify_address_form #town_dropdown").empty();
					$("#modify_address_form #town_dropdown").append("<option value='-1'>请选择地区</option>");
					var resultJson = eval(result);
					$.each(resultJson, function(index, item) {
						$('#modify_address_form #city_dropdown').append("<option value="+ item.cityId +">" + item.cityName + "</option>");
					});
				}
			});
		}

		function on_modify_city_selected() {
			$.ajax({
				type: "GET",
				contentType:"application/json;charset=utf-8",
				dataType:"json",
				async:false,
				url:"/EShopping/customer/GetTownList.action",
				data:{cityId: $('#modify_address_form #city_dropdown').val()},
				success: function(result) {
					var resultJson = eval(result);
					$('#modify_address_form #town_dropdown').empty();
					$('#modify_address_form #town_dropdown').append("<option value='-1'>请选择地区</option>");
					$.each(resultJson, function(index, item) {
						$('#modify_address_form #town_dropdown').append("<option value="+ item.townId +">" + item.townName + "</option>");
					});
				}
			});
		}
		
		function modify_form(addressId, receiverName, provinceId, cityId, townId,
            	receiverAddress, postcode, phone) {
			$("#new_address_form").fadeOut(2);
			$("#modify_address_form").fadeIn("slow");
			$("#modify_address_form #input_receiver").val(receiverName);
			$("#modify_address_form #input_phone").val(phone);
			$("#modify_address_form #province_dropdown").val(provinceId);
			on_modify_province_selected();
			$("#modify_address_form #city_dropdown").val(cityId);
			on_modify_city_selected();
			$("#modify_address_form #town_dropdown").val(townId);
			$("#modify_address_form #input_address_detail").val(receiverAddress);
			$("#modify_address_form #input_postcode").val(postcode);
			$("#modify_address_form #addressId").val(addressId);
		}
		
		function add_new_address() {
			var wrong;
			if (address_submit('new_address_form')) {
				$.ajax({
					url: "/EShopping/customer/AddAddress.action",
					type: "POST",
					async: false,
					dataType:"json",
					data:{receiverName:$("#new_address_form #input_receiver").val(),
						phone:$("#new_address_form #input_phone").val(),
						provinceId:$("#new_address_form #province_dropdown").val(), 
						cityId:$("#new_address_form #city_dropdown").val(), 
						townId:$("#new_address_form #town_dropdown").val(), 
						receiverAddress:$("#new_address_form #input_address_detail").val(), 
						postcode:$("#new_address_form #input_postcode").val()},
					success: function(result) {
						if (result == "success") {
							wrong = 0;
						} else {
							wrong = 1;
						}
					}
				});
				return (wrong === 0);
			} else {
				return false;
			}
		}
		
		function modify_address() {
			return address_submit('modify_address_form')
		}
	</script>
</body>
</html>

