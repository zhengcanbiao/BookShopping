$(document).ready(function() {
	$(".catalog").each(function(index, element) {
		var id = get_num_in_str(element.id);
		get_subcategory_list(id);
	});
	
	$('#cart').hover(
		function() {
			$.ajax({
				url: "/EShopping/customer/GetCartItemList.action",
				type:"GET",
				async:false,
				contentType:"application/json;charset=utf-8",
				dataType:"json",
				success: function(result) {
					$('#cart ul').empty();
					if (result === "[]") {
						$('#cart ul').append("<li><a href='/EShopping/customer/RedirectToHome.action'>购物车是空的, 快去购物吧!</a></li>");
					} else {
						var resultJson = eval(result);
						$(resultJson).each(function(index, item) {
							if (index < 5) {
								var size = item.size;
								var sizeStr;
								switch (size) {
								case 0: sizeStr="S"; break;
								case 1: sizeStr="M"; break;
								case 2: sizeStr="L"; break;
								}
								$('#cart ul').append("<li class='header-item'>" +
										"<a href='/EShopping/customer/PrepareClothesDetail.action?clothesId=" + item.clothesId + "&categoryId=" + item.categoryId + "'><img src='"+ item.picUrl +"' />" +
												"<div class='header-item-text'>" +
													"<p>尺码:" + sizeStr + "</p>" +
													"<span class='header-item-price'>&yen;" + item.price + "</span><span class='header-item-count'>数量:" + item.clothesNumber + "</span>" +
	 											"</div></a></li>");
							}
						});
						var left = resultJson.length - 5;
						var notice = "";
						if (left > 0) {
							notice = "购物车还有" + left + "件商品";
						}
						$('#cart ul').append("<li><a href='/EShopping/customer/PrepareCartItemList.action'><i class='icon-angle-right'> </i>查看购物车 " + notice + "</a></li>");
					}
				}
			});
			$('#cart ul', this).stop().slideDown('fast');
		},
		function() {
			$('#cart ul', this).stop().slideUp('fast'); 
		}
	);
	
	$('.nav li').hover(
			  function () {
				  //show its submenu
				  $('ul', this).stop().slideDown('fast');
			  }, 
			  function () {
				  //hide its submenu
				  $('ul', this).stop().slideUp('fast');            
	});
	
});

function get_num_in_str(str) {
	var n = str.replace(/\D/g,"");
	return n;
}

function get_subcategory_list(i) {
	var category_id = "#category" + i;
	$.ajax({
		url:"/EShopping/customer/GetSubcategoryList.action",
		type:"GET",
		async:false,
		contentType:"application/json;charset=utf-8",
		dataType:"json",
		data:{parentId: i},
		success: function(result) {
			$(category_id).empty();
			var resultJson = eval(result);
			$.each(resultJson, function(index, item) {
				$(category_id).append("<li><a href='/EShopping/customer/PrepareClothesInfoList.action?categoryId=" + item.categoryId + "&pageNow=1'><i class=icon-angle-right> </i>"+item.categoryName+"</a></li>");
			});
		}
	});
}

function show_tips(string, type) {
	var icon_type = "icon-" + type + "-sign";
	
	$("#alert_tips").hide();
	
	$("#alert_tips span").text(string);
	$("#alert_tips i").removeClass();
	$("#alert_tips i").addClass(icon_type);
	$("#alert_tips i").addClass("icon-2x");
	$("#alert_tips").fadeIn("fast");
	
	setTimeout("$('#alert_tips').fadeOut('fast')",3000);
}

