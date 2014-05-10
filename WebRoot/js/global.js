$(document).ready(function() {
	$("#search .pull-left a").click(function(){
		var temp = $("#search_input").val();
		location.href= "/BookShopping/customer/SearchBooks.action?keyword=" + temp;
	});
	$("#search_input").click(function(){
		$("#search_input").css("border-color","#1ABC9C");
	});
	$(".catalog").each(function(index, element) {
		var id = get_num_in_str(element.id);
		get_subcategory_list(id);
	});
	$('#zhanghu').hover(
			  function () {
				  //show its submenu
				  $('ul', this).stop().slideDown('fast');
			  }, 
			  function () {
				  //hide its submenu
				  $('ul', this).stop().slideUp('fast');            
	});
	
	$('#cart').hover(
		function() {
			$.ajax({
				url: "/BookShopping/customer/GetCartItemList.action",
				type:"GET",
				async:false,
				contentType:"application/json;charset=utf-8",
				dataType:"json",
				success: function(result) {
					$('#cart ul').empty();
					if (result === "[]" || result == null ) {
						$('#cart ul').append("<li><a href='/BookShopping/customer/RedirectToHome.action'>购物车是空的, 快去购物吧!</a></li>");
					} else {
					//	alert(result);
						var resultJson = eval(result);
						$(resultJson).each(function(index, item) {
							if (index < 5) {
								$('#cart ul').append("<li class='header-item'>" +
										"<a href='/BookShopping/customer/PrepareBooksDetail.action?booksId=" + item.booksId + "&categoryId=" + item.categoryId + "'><img src='"+ item.picUrl +"' />" +
												"<div class='header-item-text'>" +
													"<p>书名:" + item.bookName + "</p>" +
													"<span class='header-item-price'>&yen;" + item.price + "</span><span class='header-item-count'>数量:" + item.booksNumber + "</span>" +
	 											"</div></a></li>");
							}
						});
						var left = resultJson.length - 5;
						var notice = "";
						if (left > 0) {
							notice = "购物车还有" + left + "件商品";
						}
						$('#cart ul').append("<li><a href='/BookShopping/customer/PrepareCartItemList.action'><i class='icon-angle-right'> </i>查看购物车 " + notice + "</a></li>");
					}
				}
			});
			$('ul', this).stop().slideDown('fast');
		},
		function() {
			$('ul', this).stop().slideUp('fast'); 
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
	$('.carousel').carousel();
	
	var active = "active";
	var temp = ".zongbang";
	var choose = "#content_zongbang";
	$('.zhubian').mouseover(function(){
        $('.xinshu').removeClass(active);
        $(this).addClass(active);
        $('#content_xinshu').css("display","none");
        $('#content_zhubian').css("display","block");
	});
	$('.xinshu').mouseover(function(){
        $('.zhubian').removeClass(active);
        $(this).addClass(active);
        $('#content_zhubian').css("display","none");
        $('#content_xinshu').css("display","block");
	});
	
	$('.zongbang').mouseover(function(){
        $(temp).removeClass(active);
        $(this).addClass(active);
        temp = ".zongbang";
        $(choose).css("display","none");
        $('#content_zongbang').css("display","block");
        choose = "#content_zongbang";
	});
	$('.wenyi').mouseover(function(){
        $(temp).removeClass(active);
        $(this).addClass(active);
        temp = ".wenyi";
        $(choose).css("display","none");
        $('#content_wenyi').css("display","block");
        choose = "#content_wenyi";
	});
	$('.jingying').mouseover(function(){
        $(temp).removeClass(active);
        $(this).addClass(active);
        temp = ".jingying";
        $(choose).css("display","none");
        $('#content_jingying').css("display","block");
        choose = "#content_jingying";
	});
	
});

function get_num_in_str(str) {
	var n = str.replace(/\D/g,"");
	return n;
}

function get_subcategory_list(i) {
	var category_id = "#category" + i;
	$.ajax({
		url:"/BookShopping/customer/GetSubcategoryList.action",
		type:"GET",
		async:false,
		contentType:"application/json;charset=utf-8",
		dataType:"json",
		data:{parentId: i},
		success: function(result) {
			$(category_id).empty();
			var resultJson = eval(result);
			$.each(resultJson, function(index, item) {
				
				$(category_id).append("<li><a href='/BookShopping/customer/PrepareBooksInfoList.action?categoryId=" + item.categoryId + "&pageNow=1'><i class=icon-angle-right> </i>"+item.categoryName+"</a></li>");
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

