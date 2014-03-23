// JavaScript Document


$(document).ready(function() {
    
});

function delete_address(i) {
	$.ajax({
		url:"/EShopping/customer/DeleteAddress.action",
		type:"GET",
		contentType:"application/json;charset=utf-8",
		dataType:"json",
		data:{addressId: i},
		success: function(result) {
			var address_id = "#address_info_" + i;
			$(address_id).fadeOut("fast", function() {
				$(address_id).remove();
			});
			show_tips("删除成功", "ok");
		}
	});
}

function set_default_address(i) {
	$.ajax({
		url:"/EShopping/customer/SetDefaultAddress.action",
		type:"GET",
		contentType:"application/json;charset=utf-8",
		dataType:"json",
		data:{addressId: i},
		success: function(result) {
			var default_id = "#address_info_" + i + " .address_default a";
			
			$('.address_default a').removeClass("set_default_show").addClass("set_default");
			$(default_id).addClass("set_default_show");	
		}
	});
}

function edit_password() {
	$("#edit_password").toggle("fast", function() {
		if( $("#edit_password").is(":visible") == false){
			$("#show_edit_password").text("修改密码");
		}
	
		if( $("#edit_password").is(":visible") == true) {
			$("#show_edit_password").text("不改密码了");
		}
	});
}

function delete_favorite(i) {
	
	if (window.confirm("确定删除？")) {
		$.ajax({
			url:"/EShopping/customer/DeleteFavorite.action",
			type:"GET",
			async: false,
			contentType:"application/json;charset=utf-8",
			dataType:"json",
			data:{favoriteId: i},
			success: function(result) {
				var favorite_item_id = "#favorite_item_" + i;
				
				$(favorite_item_id).fadeOut("500", function() {
					$(favorite_item_id).remove();
				});
				show_tips("删除成功", "ok");
			}
		});
	}
	
	
}

function on_province_selected() {
	$.ajax({
		url:"/EShopping/customer/GetCityList.action",
		type:"GET",
		contentType:"application/json;charset=utf-8",
		dataType:"json",
		data:{provinceId: $('#new_address_form #province_dropdown').val()},
		success: function(result) {
			$('#new_address_form #city_dropdown').empty();
			$('#new_address_form #city_dropdown').append("<option value='-1'>请选择城市</option>");
			$("#new_address_form #town_dropdown").empty();
			$("#new_address_form #town_dropdown").append("<option value='-1'>请选择地区</option>");
			var resultJson = eval(result);
			$.each(resultJson, function(index, item) {
				$('#new_address_form #city_dropdown').append("<option value="+ item.cityId +">" + item.cityName + "</option>");
			});
		}
	});
}

function on_city_selected() {
	$.ajax({
		type: "GET",
		contentType:"application/json;charset=utf-8",
		dataType:"json",
		url:"/EShopping/customer/GetTownList.action",
		data:{cityId: $('#new_address_form #city_dropdown').val()},
		success: function(result) {
			var resultJson = eval(result);
			$('#new_address_form #town_dropdown').empty();
			$('#new_address_form #town_dropdown').append("<option value='-1'>请选择地区</option>");
			$.each(resultJson, function(index, item) {
				$('#new_address_form #town_dropdown').append("<option value="+ item.townId +">" + item.townName + "</option>");
			});
		}
	});
}

function clothes_size_selected(remainder) {
	$("#remainder").removeAttr("hidden");
	$("#remainder span").empty();
	$("#remainder span").text(remainder);
}