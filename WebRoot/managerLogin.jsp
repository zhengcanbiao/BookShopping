<%-- <%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员登陆</title>
</head>
<style type="text/css">
.aj {
	position:absolute;
	left:200px;
	font-size:20px;
	line-height:60px;
	font-weight:bold;
}
.checkCode {
   	position:absolute;
	background-color:#CCC;
	margin-right:10px; margin-top:20px;
}

</style>
<body class="aj"  onLoad="createCode();">
	<img src="/BookShopping/img/logo_cut_30px_gery.png">
	<form name="form1" method="post" action="/BookShopping/manager/ManagerLogin.action" enctype="multipart/form-data" onsubmit="return verify()">
		<h2>管理员登录</h2>
		<p>用户名:
		<input name="adminName" type="text" id="username" >
		<br>密&nbsp;&nbsp;码:
		<input name="password" type="password" id="password">${requestScope['errorPwd'] }
		<br>验证码：<input type="text" id="yzm" size="10" />
		<input type="button" id="checkCode" onClick="createCode()"/>
		<p>
		<input type="submit" style="float:right; margin-right:10px;" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;登录&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" >
		<br>
	</form>
	${requestScope['errorMsg'] }
	<script src="/BookShopping/js/jquery-1.9.1.min.js"></script>
	<script src="/BookShopping/js/alert.js"></script>
	<script type="text/javascript">
	function verify()
	{
		var inputCode = document.getElementById("yzm").value.toUpperCase();
		if ($('#username').val()==""||$('#password').val()==""||$('#Verification').val()==""){
			Alert("输入有空缺，请补全后再登陆");
			return false;
		}
		else if($('#username').val().length<4 || $('#username').val().length>24) {
			Alert("用户名长度4到24位");
			return false;
		}
		else if($('#password').val().length<6 || $('#password').val().length>16) {
			Alert("密码长度6到16位");
			return false;
		}
		else if(inputCode != code ){ Alert("验证码错误！"); return false; }
		else {
			var flag = false;
			$.ajax({
			url: "/BookShopping/manager/AdminExist.action",
			type: "GET",
			async: false,
			contextType: "application/json;charset=utf-8",
			dataType: "json",
			data: {adminName:$("#username").val()},
			success: function(result) {
				if (result=="success") {
					flag = true;
				} else {
					flag = false;
					Alert("用户名不存在");
				}
			}
			});
			return flag;
		}
	}
	function createCode(){ 
		code = new Array();
		var codeLength = 4;
		var checkCode = document.getElementById("checkCode");
		checkCode.value = "";
		var selectChar = new Array(2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z');
		for(var i=0;i<codeLength;i++) {
		   var charIndex = Math.floor(Math.random()*32);
		   code +=selectChar[charIndex];
		}
		checkCode.value = code;
	}
	</script>
</body>
</html> --%>















<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员登陆</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>修改密码</title>
<link href="/BookShopping/css/manager.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<style>
#form_manager_login{
	position: relative;
	width: 340px;
	margin: auto;
	top: 150px;
	border: 1px solid #DDDDDD;
    box-shadow: 0 0 4px rgba(0, 0, 0, 0.15);
    padding: 10px 20px 20px 20px;
}
#username, #password, #yzm, #checkCode {
	height: 30px;
}
#username, #password {
	width: 300px;
}
#yzm {
	width: 200px;
}
#checkCode {
	width: 90px;
	margin-bottom: 10px;
}
#info {
	position: relative;
	align: center;
	top: 160px;
	color: #FF0000;
	font-size: 18px;
	text-align: center;
}
</style>
</head>
<body onLoad="createCode();">


	
		<form id="form_manager_login" name="form1" method="post" action="/BookShopping/manager/ManagerLogin.action" enctype="multipart/form-data" onsubmit="return verify()">
			<legend>管理员登录</legend>
			<label>用户名</label>
			<input id="username" name="adminName" type="text"/>
			<label>密码</label>
			<input id="password" name="password" type="password" />
			<label>验证码</label>
			<input id="yzm" type="text" size="10" />
			<input id="checkCode" type="button" onClick="createCode()"/>
			
			<input type="submit" style="width:300px; height:40px; margin-top:10px;" class="btn btn-large btn-success" value="登陆"  />
		</form>
		<p id="info">
			${requestScope['errorPwd'] }
		<p>

	
	
    <script src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/alert.js"></script>
    <script type="application/javascript" src="/BookShopping/js/manager.js"></script>
	<script type="text/javascript">
		function verify()
		{
			var inputCode = document.getElementById("yzm").value.toUpperCase();
			if ($('#username').val()==""||$('#password').val()==""||$('#Verification').val()==""){
				Alert("输入有空缺，请补全后再登陆");
				return false;
			}
			else if($('#username').val().length<4 || $('#username').val().length>24) {
				Alert("用户名长度4到24位");
				return false;
			}
			else if($('#password').val().length<6 || $('#password').val().length>16) {
				Alert("密码长度6到16位");
				return false;
			}
			else if(inputCode != code ){ Alert("验证码错误！"); return false; }
			else {
				var flag = false;
				$.ajax({
				url: "/BookShopping/manager/AdminExist.action",
				type: "GET",
				async: false,
				contextType: "application/json;charset=utf-8",
				dataType: "json",
				data: {adminName:$("#username").val()},
				success: function(result) {
					if (result=="success") {
						flag = true;
					} else {
						flag = false;
						Alert("用户名不存在");
					}
				}
				});
				return flag;
			}
		}
		function createCode(){ 
			code = new Array();
			var codeLength = 4;
			var checkCode = document.getElementById("checkCode");
			checkCode.value = "";
			var selectChar = new Array(2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z');
			for(var i=0;i<codeLength;i++) {
			   var charIndex = Math.floor(Math.random()*32);
			   code +=selectChar[charIndex];
			}
			checkCode.value = code;
		}
	</script>

</body>
</html>