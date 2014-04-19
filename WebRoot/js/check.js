// JavaScript Document

function email_check(email) {
	//var email_reg = /^([a-zA-Z0-9]+[\_|\.]?)*[a-zA-Z0-9]+@+[a-zA-Z0-9]+([a-zA-Z0-9]+[\_|\.]?)*[a-zA-Z0-9]+\.+[a-zA-Z]{2,4}$/;	
	var email_reg = /^[0-9a-z]+(?:\.{0,1}[\w-]+)*@[a-z0-9]+(?:[-.][a-z0-9]+)*\.[a-z]+$/;
	return email_reg.test(email);
}

function postcode_check(postcode) {
	var postcode_reg = /^[0-9]\d{5}(?!\d)$/;	
	return postcode_reg.test(postcode);
}

function phone_check(phone) {
	var phone_reg = /^1[3458][0-9]{9}$/;	
	return phone_reg.test(phone);
}

function nickname_check(name) {
	var nickname_reg = /^([\u4e00-\u9fa5]|(\w)|-){4,24}$/;
	return nickname_reg.test(name);
}

//check the input before submit
function register_check() {
	
	$("#register_form #input_username").blur(function(){
		if ($("#input_username").val() == '') {
			$("#username_span").removeClass("label-success");
			$("#username_span").addClass("label-important");
			$("#username_span").text("请输入用户名");
			wrong = 1;
		}
		else {
			if (! email_check( $("#input_username").val()) ){
				$("#username_span").removeClass("label-success");
				$("#username_span").addClass("label-important");
				$("#username_span").text("邮箱格式不对");
				wrong = 1;
			}
			else {
				
				$.ajax({
					url: "/BookShopping/customer/CheckCustomerName.action",
					type: "GET",
					dataType:"json",
					contentType:"application/json;charset=utf-8",
					data: {customerName: $("#input_username").val()},
					success: function(result) {
						
						if (result != "success") {
							$("#username_span").removeClass("label-important");
							$("#username_span").addClass("label-success");
							$("#username_span").text("");
							$("#username_span").append("<i class='icon-ok'></i>");
						} else {
							$("#username_span").removeClass("label-success");
							$("#username_span").addClass("label-important");
							$("#username_span").text("该邮箱已被注册");
						}
					}
				});
			}
		}
	});
	
	
	$("#register_form #input_nickname").blur(function(){
		if ($("#input_nickname").val() == '') {
			$("#nickname_span").removeClass("label-success");
			$("#nickname_span").addClass("label-important");
			$("#nickname_span").text("请输入昵称");
		}
		else {
			
			if ($("#input_nickname").val().length < 4){
				$("#nickname_span").removeClass("label-success");
				$("#nickname_span").addClass("label-important");
				$("#nickname_span").text("昵称长度4~24位");
			}
			else {
				if ($("#input_nickname").val().length > 24){
					$("#nickname_span").removeClass("label-success");
					$("#nickname_span").addClass("label-important");
					$("#nickname_span").text("昵称长度4~24位");
				}
				else {
					if ( ! nickname_check( $("#input_nickname").val() )) {
						$("#nickname_span").removeClass("label-success");
						$("#nickname_span").addClass("label-important");
						$("#nickname_span").text("只能包含中文,字母,数字,\"-\",\"_\"");	
					}
					else {
						$.ajax({
							url: "/BookShopping/customer/CheckNickName.action",
							type: "GET",
							dataType:"json",
							contentType:"application/json;charset=utf-8",
							data: {nickName: $("#input_nickname").val()},
							success: function(result) {
								if (result != "success") {
									$("#nickname_span").removeClass("label-important");
									$("#nickname_span").addClass("label-success");
									$("#nickname_span").text("好名字");
								} 
								else {
									$("#nickname_span").removeClass("label-success");
									$("#nickname_span").addClass("label-important");
									$("#nickname_span").text("该昵称已存在");
								}
							}
						});
					}
				}
			}
		}
		
	});
	
	$("#register_form #input_password").blur(function(){
		if ($("#input_password").val() == '') {
			$("#password_span").removeClass("label-success");
			$("#password_span").addClass("label-important");
			$("#password_span").text("请输入密码");
		}
		else {
			if ($("#input_password").val().length < 6) {
				$("#password_span").removeClass("label-success");
				$("#password_span").addClass("label-important");
				$("#password_span").text("密码长度6~16位");
			}
			else {
				if ($("#input_password").val().length > 16) {
					$("#password_span").removeClass("label-success");
					$("#password_span").addClass("label-important");
					$("#password_span").text("密码长度6~16位");
				}
				else {
					$("#password_span").text("");
				}
			}
		}
	});
	
	$("#register_form #input_password_again").blur(function(){
		if ($("#input_password_again").val() == '') {
			$("#password_again_span").removeClass("label-success");
			$("#password_again_span").addClass("label-important");
			$("#password_again_span").text("请再次确认密码");
		}
		else {
			if ( $("#input_password_again").val() != $("#input_password").val() ){
				$("#password_again_span").addClass("label-important");
				$("#password_again_span").text("两次密码不一样");
			}
			else {
				$("#password_again_span").text("");
			}
		}
	});
}


//check the input when click submit
//check the input when click submit
function register_submit() {
	var wrong = 0;
	
	//username
	if ($("#input_username").val() == '') {
		$("#username_span").removeClass("label-success");
		$("#username_span").addClass("label-important");
		$("#username_span").text("请输入用户名");
		wrong = 1;
	}
	else {
		if (! email_check( $("#input_username").val()) ){
			$("#username_span").removeClass("label-success");
			$("#username_span").addClass("label-important");
			$("#username_span").text("邮箱格式不对");
			wrong = 1;
		}
		else {
			
			$.ajax({
				url: "/BookShopping/customer/CheckCustomerName.action",
				type: "GET",
				dataType:"json",
				contentType:"application/json;charset=utf-8",
				data: {customerName: $("#input_username").val()},
				success: function(result) {
					
					if (result != "success") {
						$("#username_span").removeClass("label-important");
						$("#username_span").addClass("label-success");
						$("#username_span").text("");
						$("#username_span").append("<i class='icon-ok'></i>");
					} else {
						$("#username_span").removeClass("label-success");
						$("#username_span").addClass("label-important");
						$("#username_span").text("该邮箱已被注册");
					}
				}
			});
		}
	}
	
	//nickname
	if ($("#input_nickname").val() == '') {
		$("#nickname_span").removeClass("label-success");
		$("#nickname_span").addClass("label-important");
		$("#nickname_span").text("请输入昵称");
	}
	else {
		
		if ($("#input_nickname").val().length < 4){
			$("#nickname_span").removeClass("label-success");
			$("#nickname_span").addClass("label-important");
			$("#nickname_span").text("昵称长度4~24位");
		}
		else {
			if ($("#input_nickname").val().length > 24){
				$("#nickname_span").removeClass("label-success");
				$("#nickname_span").addClass("label-important");
				$("#nickname_span").text("昵称长度4~24位");
			}
			else {
				if ( ! nickname_check( $("#input_nickname").val() )) {
					$("#nickname_span").removeClass("label-success");
					$("#nickname_span").addClass("label-important");
					$("#nickname_span").text("只能包含中文,字母,数字,\"-\",\"_\"");	
				}
				else {
					$.ajax({
						url: "/BookShopping/customer/CheckNickName.action",
						type: "GET",
						dataType:"json",
						contentType:"application/json;charset=utf-8",
						data: {nickName: $("#input_nickname").val()},
						success: function(result) {
							if (result != "success") {
								$("#nickname_span").removeClass("label-important");
								$("#nickname_span").addClass("label-success");
								$("#nickname_span").text("好名字");
							} else {
								$("#nickname_span").removeClass("label-success");
								$("#nickname_span").addClass("label-important");
								$("#nickname_span").text("该昵称已存在");
							}
						}
					});
				}
			}
		}
	}

	//password
	if ($("#input_password").val() == '') {
		$("#password_span").removeClass("label-success");
		$("#password_span").addClass("label-important");
		$("#password_span").text("请输入密码");
		wrong = 1;
	}
	else {
		if ($("#input_password").val().length < 6) {
			$("#password_span").removeClass("label-success");
			$("#password_span").addClass("label-important");
			$("#password_span").text("密码长度6~16位");
			wrong = 1;
		}
		else {
			if ($("#input_password").val().length > 16) {
				$("#password_span").removeClass("label-success");
				$("#password_span").addClass("label-important");
				$("#password_span").text("密码长度6~16位");
				wrong = 1;
			}
		}
	}
	
	if ($("#input_password_again").val() == '') {
		$("#password_again_span").removeClass("label-success");
		$("#password_again_span").addClass("label-important");
		$("#password_again_span").text("请再次确认密码");
		wrong = 1;
	}
	else {
		if ( $("#input_password_again").val() != $("#input_password").val() ){
			$("#password_again_span").addClass("label-important");
			$("#password_again_span").text("两次密码不一样");
			wrong = 1;
		}
		else {
			$("#password_again_span").text("");
		}
	}
	
	if(wrong) {
		//alert(0);
		return false;
	}
	else {
		//alert(1);
		return true;
	}
		
}



// check the input before submit
function login_check() {
	
	$("#login_form #input_username").blur(function(){
		
		if ($("#input_username").val() == '') {
			$("#username_span").removeClass("label-success");
			$("#username_span").addClass("label-important");
			$("#username_span").text("请输入用户名");
		}
		else if (! email_check( $("#input_username").val()) ){
			$("#username_span").removeClass("label-success");
			$("#username_span").addClass("label-important");
			$("#username_span").text("邮箱格式不对");
		}
		else {
			$("#username_span").text("");
		}
	});
	
	
	$("#login_form #input_password").blur(function(){
		$("#password_span").text("");
	});
	
}



//check the input when click submit
function login_submit() {
	var wrong = 0;
	
	if ($("#input_username").val() == '') {
		$("#username_span").removeClass("label-success");
		$("#username_span").addClass("label-important");
		$("#username_span").text("请输入用户名");
		wrong = 1;
	}
	else if (! email_check( $("#input_username").val()) ){
		$("#username_span").removeClass("label-success");
		$("#username_span").addClass("label-important");
		$("#username_span").text("邮箱格式不对");
		wrong = 1;
	} else 	if ($("#input_password").val() == '') {
		$("#password_span").removeClass("label-success");
		$("#password_span").addClass("label-important");
		$("#password_span").text("请输入密码");
		wrong = 1;
	} else  {
		$.ajax({
			url: "/BookShopping/customer/CheckCustomerName.action",
			type: "GET",
			async:false,
			dataType:"json",
			contentType:"application/json;charset=utf-8",
			data: {customerName: $("#input_username").val()},
			success: function(result) {
				if (result == "success") {
					$("#username_span").removeClass("label-important");
					$("#username_span").addClass("label-success");
					$("#username_span").text("");

					$.ajax({
						url: "/BookShopping/customer/Login.action",
						type: "GET",
						async:false,
						dataType:"json",
						contentType:"application/json;charset=utf-8",
						data: {customerName: $("#input_username").val(),password:$("#input_password").val()},
						success: function(result) {
								if (result == "success") {
									$("#username_span").removeClass("label-important");
									$("#username_span").addClass("label-success");
									$("#username_span").text("");
								} else if (result == "wrongPassword") {
									$("#password_span").removeClass("label-success");
									$("#password_span").addClass("label-important");
									$("#password_span").text("密码错误");
									wrong = 1;
								} else {
									$("#username_span").removeClass("label-success");
									$("#username_span").addClass("label-important");
									$("#username_span").text("该用户已被冻结");
									wrong = 1;
								}
						}
					});
				} else {
					$("#username_span").removeClass("label-success");
					$("#username_span").addClass("label-important");
					$("#username_span").text("用户名不存在");
					wrong = 1;
				}
			}
		});
	}
	
	if(wrong === 1) {
		//alert(0);
		return false;
	}
	else {
		//alert(1);
		return true;
	}
		
}


//找回密码

function find_password_submit() {
	var wrong = 0;
	
	if ($("#input_username").val() == '') {
		$("#username_span").removeClass("label-success");
		$("#username_span").addClass("label-important");
		$("#username_span").text("请输入用户名");
		wrong = 1;
	}
	else {
		if (! email_check( $("#input_username").val()) ){
			$("#username_span").removeClass("label-success");
			$("#username_span").addClass("label-important");
			$("#username_span").text("邮箱格式不对");
			wrong = 1;
		}
	}
	
	if(wrong) {
		//alert(0);
		return false;
	}
	else {
		$.ajax({
			url: "/BookShopping/customer/ForgetPassword.action",
			type: "POST",
			async: false,
			dataType:"json",
			data:{customerName:$("#input_username").val()},
			success: function(result) {
				if (result == "success") {
					wrong = 0;
				} else {
					wrong = 1;
					$("#username_span").removeClass("label-success");
					$("#username_span").addClass("label-important");
					$("#username_span").text("邮箱不存在");
				}
			}
		});
		return (wrong === 0);
	}
}

function find_password_check() {
	$("#forget_password_form #input_username").blur(function(){
	
		if ($("#input_username").val() == '') {
			$("#username_span").removeClass("label-success");
			$("#username_span").addClass("label-important");
			$("#username_span").text("请输入用户名");
			wrong = 1;
		}
		else {
			if (! email_check( $("#input_username").val()) ){
				$("#username_span").removeClass("label-success");
				$("#username_span").addClass("label-important");
				$("#username_span").text("邮箱格式不对");
			}
			else {
				$("#username_span").text("");
			}
		}
		
	});
}



/*修改密码*/
function modify_password_check() {
	var wrong = 0;
	$("#input_original_password").blur(function() {
		if ( $("#input_original_password").val() == '') {
			$("#original_password_span").addClass("label-important");
			$("#original_password_span").text("请输入原始密码");
			wrong = 1;
		}
		else {
			if ($("#input_original_password").val().length < 6) {
				$("#original_password_span").removeClass("label-success");
				$("#original_password_span").addClass("label-important");
				$("#original_password_span").text("密码长度6~16位");
				wrong = 1;
			}
			else {
				if ($("#input_original_password").val().length > 16) {
					$("#original_password_span").removeClass("label-success");
					$("#original_password_span").addClass("label-important");
					$("#original_password_span").text("密码长度6~16位");
					wrong = 1;
				}
				else {
					$.ajax({
						url: "/BookShopping/customer/CheckPassword.action",
						type: "POST",
						dataType: "json",
						async: false,
						data: {password: $("#input_original_password").val()},
						success: function(result) {
							if (result != "success") {
								$("#original_password_span").addClass("label-important");
								$("#original_password_span").text("初始密码错误");
								wrong = 1;
							}
							else {
								$.ajax({
									url: "/BookShopping/customer/CheckPassword.action",
									type: "POST",
									dataType: "json",
									async: false,
									data: {password: $("#input_original_password").val()},
									success: function(result) {
										if (result != "success") {
											$("#original_password_span").addClass("label-important");
											$("#original_password_span").text("初始密码错误");
											wrong = 1;
										}
										else {
											$("#original_password_span").text("");
										}
									}
								});
							}
						}
					});
				}
			}
		}
	});
	
	$("#input_new_password").blur(function() {
		if ($("#input_new_password").val() == '') {
			$("#new_password_span").removeClass("label-success");
			$("#new_password_span").addClass("label-important");
			$("#new_password_span").text("请输入密码");
		}
		else {
			if ($("#input_new_password").val().length < 6) {
				$("#new_password_span").removeClass("label-success");
				$("#new_password_span").addClass("label-important");
				$("#new_password_span").text("密码长度6~16位");
			}
			else {
				if ($("#input_new_password").val().length > 16) {
					$("#new_password_span").removeClass("label-success");
					$("#new_password_span").addClass("label-important");
					$("#new_password_span").text("密码长度6~16位");
				}
				else {
					if ($("#input_new_password").val() == $("#input_original_password").val() ){
						$("#new_password_span").text("新旧密码不能相同");
					}
					else {
						$("#new_password_span").text("");
					}
				}
			}
		}
	});
	
	$("#input_new_password_again").blur(function(){
		if ($("#input_new_password_again").val() == '') {
			$("#new_password_again_span").removeClass("label-success");
			$("#new_password_again_span").addClass("label-important");
			$("#new_password_again_span").text("请再次确认密码");
		}
		else {
			if ( $("#input_new_password_again").val() != $("#input_new_password").val() ){
				$("#new_password_again_span").addClass("label-important");
				$("#new_password_again_span").text("两次密码不一样");
			}
			else {
				$("#new_password_again_span").text("");
			}
		}
	});
	return (wrong === 0);
}

function modify_password_submit() {
	var wrong = 0;
	
	if ( $("#input_original_password").val() == '') {
		$("#original_password_span").addClass("label-important");
		$("#original_password_span").text("请输入原始密码");
		wrong = 1;
	}
	else {
		if ($("#input_original_password").val().length < 6) {
			$("#original_password_span").removeClass("label-success");
			$("#original_password_span").addClass("label-important");
			$("#original_password_span").text("密码长度6~16位");
			wrong = 1;
		}
		else {
			if ($("#input_original_password").val().length > 16) {
				$("#original_password_span").removeClass("label-success");
				$("#original_password_span").addClass("label-important");
				$("#original_password_span").text("密码长度6~16位");
				wrong = 1;
			}
		}
	}
	
	if ($("#input_new_password").val() == '') {
		$("#new_password_span").removeClass("label-success");
		$("#new_password_span").addClass("label-important");
		$("#new_password_span").text("请输入密码");
		wrong = 1;
	}
	else {
		if ($("#input_new_password").val().length < 6) {
			$("#new_password_span").removeClass("label-success");
			$("#new_password_span").addClass("label-important");
			$("#new_password_span").text("密码长度6~16位");
			wrong = 1;
		}
		else {
			if ($("#input_new_password").val().length > 16) {
				$("#new_password_span").removeClass("label-success");
				$("#new_password_span").addClass("label-important");
				$("#new_password_span").text("密码长度6~16位");
				wrong = 1;
			}
			else {
				if ($("#input_new_password").val() == $("#input_original_password").val() ){
					$("#new_password_span").text("新旧密码不能相同");
					wrong = 1;
				}
				else {
					$("#new_password_span").text("");
				}
			}
		}
	}
	
	if ($("#input_new_password_again").val() == '') {
		$("#new_password_again_span").removeClass("label-success");
		$("#new_password_again_span").addClass("label-important");
		$("#new_password_again_span").text("请再次确认密码");
		wrong = 1;
	}
	else {
		if ( $("#input_new_password_again").val() != $("#input_new_password").val() ){
			$("#new_password_again_span").addClass("label-important");
			$("#new_password_again_span").text("两次密码不一样");
			wrong = 1;
		}
		else {
			$("#new_password_again_span").text("");
		}
	}
	
	if(wrong) {
		//alert(0);
		return false;
	}
	else {
		$.ajax({
			url: "/BookShopping/customer/CheckPassword.action",
			type: "POST",
			dataType: "json",
			async: false,
			data: {password: $("#input_original_password").val()},
			success: function(result) {
				if (result != "success") {
					$("#original_password_span").addClass("label-important");
					$("#original_password_span").text("初始密码错误");
					wrong = 1;
				}
			}
		});
		if (wrong) {
			return false;
		} else {
			return true;
		}
	}
}



/*address*/
function address_check(form) {
	var form_id = "#" + form;
	
	$(form_id + " " + "#input_receiver").blur(function() {
		if ($(form_id + " " + "#input_receiver").val().replace(/(^\s*)|(\s*$)/g, "") == "") {
			$(form_id + " " + "#receiver_span").text("请输入收货人名字");
		}
		else {
			if ( $(form_id + " " + "#input_receiver").val().length < 2 || $(form_id + " " + "#input_receiver").val().length > 15) {
				$(form_id + " " + "#receiver_span").text("名字长度2~15位");
			}
			else {
				$("#receiver_span").text("");
			}
		}
	});
	
	/*dropdown*/
	$(form_id + " " + "#province_dropdown").blur(function(){
		if ($(form_id + " " + "#province_dropdown").val() == "-1") {
			$(form_id + " " + "#area_span").text("请选择省份");
		}	
		else {
			$(form_id + " " + "#area_span").text("");
		}
	});
	
	$(form_id + " " + "#city_dropdown").blur(function(){
		if ($(form_id + " " + "#province_dropdown").val() == "-1") {
			$(form_id + " " + "#area_span").text("请选择城市");
		}	
		else {
			$(form_id + " " + "#area_span").text("");
		}
	});
	
	$(form_id + " " + "#town_dropdown").blur(function(){
		if ($(form_id + " " + "#province_dropdown").val() == "-1") {
			$(form_id + " " + "#area_span").text("请选择地区");
		}	
		else {
			$(form_id + " " + "#area_span").text("");
		}
	});
	
	 $(form_id + " " + "#input_address_detail").blur(function() {
		if ($(form_id + " " + "#input_address_detail").val().replace(/(^\s*)|(\s*$)/g, "") == "") {
			$(form_id + " " + "#address_detail_span").text("请输入详细地址");
		}
		else {
			if ( $(form_id + " " + "#input_address_detail").val().length < 1 || $(form_id + " " + "#input_address_detail").val().length > 50) {
				$(form_id + " " + "#address_detail_span").text("详细地址长度1~50位");
			}
			else {
				$(form_id + " " + "#address_detail_span").text("");
			}
		}
	 });
	
	$(form_id + " " + "#input_postcode").blur(function() {
		if ($(form_id + " " + "#input_postcode").val() == '') {
			$(form_id + " " + "#postcode_span").text("请输入邮编");
		}
		else {
			if (! postcode_check( $(form_id + " " + "#input_postcode").val()) ){
				$(form_id + " " + "#postcode_span").text("邮编为6位数字");
			}
			else {
				$(form_id + " " + "#postcode_span").text('');
			}
		}
	});
	
	$(form_id + " " + "#input_phone").blur(function() {
		if ($(form_id + " " + "#input_phone").val() == '') {
			$(form_id + " " + "#phone_span").text("请输入手机");
		}
		else {
			if (! phone_check( $(form_id + " " + "#input_phone").val()) ){
				$(form_id + " " + "#phone_span").text("手机格式不对");
			}
			else {
				$(form_id + " " + "#phone_span").text('');
			}
		}
	});
}

function address_submit(form) {
	
	var form_id = "#" + form;
	
	var wrong = 0;
	
	if ($(form_id + " " + "#input_receiver").val().replace(/(^\s*)|(\s*$)/g, "") == "") {
		$(form_id + " " + "#receiver_span").text("请输入收货人名字");
		wrong = 1;
	}
	else {
		if ( $(form_id + " " + "#input_receiver").val().length < 2 || $(form_id + " " + "#input_receiver").val().length > 15) {
			$(form_id + " " + "#receiver_span").text("名字长度2~15位");
			wrong = 1;
		}
		else {
			$(form_id + " " + "#receiver_span").text("");
		}
	}
	
	/*dropdown*/
	if ($(form_id + " " + "#province_dropdown").val() == "-1") {
		$(form_id + " " + "#area_span").text("请选择省份");
		wrong = 1;
	}
	else {
		
		if ($(form_id + " " + "#city_dropdown").val() == "-1") {
			$(form_id + " " + "#area_span").text("请选择城市");
			wrong = 1;
		}
		else {	
			if ($(form_id + " " + "#town_dropdown").val() == "-1") {
				$(form_id + " " + "#area_span").text("请选择地区");
				wrong = 1;
			}
		}
	}
	
	
	if ($(form_id + " " + "#input_address_detail").val().replace(/(^\s*)|(\s*$)/g, "") == "") {
		$(form_id + " " + "#address_detail_span").text("请输入详细地址");
		wrong = 1;
	}
	else {
		if ( $(form_id + " " + "#input_address_detail").val().length < 1 || $(form_id + " " + "#input_address_detail").val().length > 50) {
			$(form_id + " " + "#address_detail_span").text("详细地址长度1~50位");
			wrong = 1;
		}
		else {
			$(form_id + " " + "#address_detail_span").text("");
		}
	}
	
	
	if ($(form_id + " " + "#input_postcode").val() == '') {
		$(form_id + " " + "#postcode_span").text("请输入邮编");
		wrong = 1;
	}
	else {
		if (! postcode_check( $(form_id + " " + "#input_postcode").val()) ){
			$(form_id + " " + "#postcode_span").text("邮编为6位数字");
			wrong = 1;
		}
		else {
			$(form_id + " " + "#postcode_span").text("");
		}
	}
	
	if ($(form_id + " " + "#input_phone").val() == '') {
		$(form_id + " " + "#phone_span").text("请输入手机");
		wrong = 1;
	}
	else {
		if (! phone_check( $(form_id + " " + "#input_phone").val()) ){
			$(form_id + " " + "#phone_span").text("手机格式不对");
			wrong = 1;
		}
		else {
			$(form_id + " " + "#phone_span").text("");
		}
	}

	
	
	if(wrong) {
		return false;
	}
	else {
		return true;
	}
}


/*个人信息修改页面*/
function personal_check() {
	$("#input_nickname").blur(function(){
		if ($("#input_nickname").val() == '') {
			$("#nickname_span").removeClass("label-success");
			$("#nickname_span").addClass("label-important");
			$("#nickname_span").text("请输入昵称");
		}
		else {
			
			if ($("#input_nickname").val().length < 4){
				$("#nickname_span").removeClass("label-success");
				$("#nickname_span").addClass("label-important");
				$("#nickname_span").text("昵称长度4~24位");
			}
			else {
				if ($("#input_nickname").val().length > 24){
					$("#nickname_span").removeClass("label-success");
					$("#nickname_span").addClass("label-important");
					$("#nickname_span").text("昵称长度4~24位");
				}
				else {
					if ( ! nickname_check( $("#input_nickname").val() )) {
						$("#nickname_span").removeClass("label-success");
						$("#nickname_span").addClass("label-important");
						$("#nickname_span").text("只能包含中文,字母,数字,\"-\",\"_\"");	
					}
					else {
						$.ajax({
							url: "/BookShopping/CheckNickName.action",
							type: "GET",
							dataType:"json",
							contentType:"application/json;charset=utf-8",
							data: {nickName: $("#input_nickname").val()},
							success: function(result) {
								if (result != "success") {
									$("#nickname_span").removeClass("label-important");
									$("#nickname_span").addClass("label-success");
									$("#nickname_span").text("好名字");
								} 
								else {
									$("#nickname_span").removeClass("label-success");
									$("#nickname_span").addClass("label-important");
									$("#nickname_span").text("该昵称已存在");
								}
							}
						});
					}
				}
			}
		}
	});
}

function personal_submit() {
	var wrong = 0;
	
	if ($("#input_nickname").val() == '') {
		$("#nickname_span").removeClass("label-success");
		$("#nickname_span").addClass("label-important");
		$("#nickname_span").text("请输入昵称");
		wrong = 1
	}
	else {
		
		if ($("#input_nickname").val().length < 4){
			$("#nickname_span").removeClass("label-success");
			$("#nickname_span").addClass("label-important");
			$("#nickname_span").text("昵称长度4~24位");
			wrong = 1
		}
		else {
			if ($("#input_nickname").val().length > 24){
				$("#nickname_span").removeClass("label-success");
				$("#nickname_span").addClass("label-important");
				$("#nickname_span").text("昵称长度4~24位");
				wrong = 1
			}
			else {
				if ( ! nickname_check( $("#input_nickname").val() )) {
					$("#nickname_span").removeClass("label-success");
					$("#nickname_span").addClass("label-important");
					$("#nickname_span").text("只能包含中文,字母,数字,\"-\",\"_\"");	
					wrong = 1
				}
				else {
					$.ajax({
						url: "/BookShopping/customer/CheckNickName.action",
						type: "GET",
						dataType:"json",
						contentType:"application/json;charset=utf-8",
						data: {nickName: $("#input_nickname").val()},
						success: function(result) {
							if (result != "success") {
								$("#nickname_span").removeClass("label-important");
								$("#nickname_span").addClass("label-success");
								$("#nickname_span").text("好名字");
							} 
							else {
								$("#nickname_span").removeClass("label-success");
								$("#nickname_span").addClass("label-important");
								$("#nickname_span").text("该昵称已存在");
								wrong = 1
							}
						}
					});
				}
			}
		}
	}
	
	if(wrong) {
		//alert(0);
		return false;
	}
	else {
		//alert(1);
		return true;
	}
}