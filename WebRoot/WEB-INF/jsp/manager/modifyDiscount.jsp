<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>修改折扣</title>
<style>
body {
	margin:0;
	font-size:14px;
	line-height:30px;
	width:100%;
}/*默认字体大小14px; 行距20px;*/

.header {
	font-size:18px;
	font-family:"Courier New", Courier, monospace;
	background:left;
	background-color:#CCC;
}

.container {
	width:960px;
	margin:0 auto;
}/*最大宽度是960px*/

.breadcrumb {
	width:100%;
	background-color:#FFF;
}

.left_block {
	width:20%;
	float:left;
}

.right_block {
	width:77%;
	margin-left:3%;
	float:left;
}
a{
	text-decoration:none;
}
a:hover{
	text-decoration:underline;
}
.Button
{
	background-color:#CCC;
}
</style>
</head>

<body>

	<div class="header">
    	<div class="container">
         <img src="/EShopping/img/logo_cut_30px.png" />
        尊敬的管理员，Eshopping网上衣城  诚心感谢你的默默付出
        <form name="form1" method="post" action="/EShopping/manager/ManagerLogout.action" enctype="multipart/form-data" onsubmit="return Confirm()">
        <input type="submit"  class="Button" value="注销" style="float:right; margin-top:-25px;"/>
        </form>
        </div><!-- 内容放在这里面 -->
    </div><!-- 头部 -->
    
    <div class="body">
    	<div class="container">
        	<div class="breadcrumb">
            管理系统首页-&gt;折扣管理-&gt;修改折扣
            <hr />
            </div><!-- 面包屑 就是当前页面所在的导航位置 -->
            <div class="left_block">
            <ul>
             <li><a href="/EShopping/manager/Jump.action?jumpId=3">回到首页</a></li>
            <li><a href="/EShopping/manager/Jump.action?jumpId=0">修改密码</a></li>
            <li><a href="/EShopping/manager/PrepareCategory.action">商品类别管理</a></li>
            <li><a href="/EShopping/manager/PrepareClothes.action">商品管理</a></li>
            <li><a href="/EShopping/manager/PrepareOrder.action">订单管理</a></li>
            <li><a href="/EShopping/manager/Jump.action?jumpId=6">销售量统计</a></li>
            <li><a href="/EShopping/manager/PrepareCustomer.action">会员管理</a></li>
            <li><a href="/EShopping/manager/Jump.action?jumpId=4">折扣管理</a></li>
            </ul>
            </div><!-- 左边部分 -->
            
            <div class="right_block">
            修改折扣
            <hr />
            <form name="form2" method="post" action="/EShopping/manager/ModifyDiscount.action" enctype="multipart/form-data">
         <input type="hidden" name="oldDiscountPoints" value="${requestScope['discountPoints'] }" />
            所需积分：&nbsp;&nbsp;<input name="discountPoints" type="text" id="DiscountPoints" size="15px" value="${requestScope['discountPoints']}"/><font size="2" color="#FF0000" id="a" > *必填项</font>
            <br />
            <br />
            对应折扣：&nbsp;&nbsp;<input name="discountRate" type="text" id="DiscountRate" size="15px" value="${requestScope['discountRate']}"/><font size="2" color="#FF0000" id="a" > *必填项</font>
            <br />
            <br />
            <input type="button" value="     修改     " style="float:left; margin-top:4px;" onclick="verify('${requestScope.discountPoints }')"/>&nbsp;&nbsp;
            </form>
            <form name="form3" method="post" action="/EShopping/manager/Jump.action?jumpId=4" enctype="multipart/form-data">
			<input type="submit" value="     返回     " style="float:left; margin-left:130px;margin-top:-26px;"/>&nbsp;&nbsp;&nbsp;&nbsp;
            </form> 
            </div><!-- 右边部分 -->  
        </div><!-- 内容放在这里面 -->
    </div><!-- 中间部分 -->
    
    <div class="footer">
    	<div class="container">
        
        </div><!-- 内容放在这里面 -->
    </div><!-- 底部 -->
    
    <script src="/EShopping/js/jquery-1.9.1.min.js"></script>
    <script src="/EShopping/js/alert.js"></script>
          <script type="text/javascript">
	function Confirm()
	{
		var r=confirm("是否确认注销？");
		if (r==true)
			  	{
					return true;
			 }
		else
				{
					return false;
				}
	}
	
	function verify(discountPoints)
	{
		if(isNaN($('#DiscountPoints').val()))
		{
		   Alert("积分输入格式错误");
		   return false;
		}
		else if(isNaN($('#DiscountRate').val()))
		{
		   Alert("折扣输入格式错误");
		   return false;
		}
		else if($('#DiscountPoints').val()>100000)
		{
			Alert("输入的积分最大值为100000");
			return false;
		}
		else if(parseInt($('#DiscountPoints').val())!=($('#DiscountPoints').val()))
		{
			Alert("输入的积分不是整数");
			return false;
		}
		else if(parseInt($('#DiscountRate').val())!=($('#DiscountRate').val()))
		{
			Alert("输入的折扣不是整数");
			return false;
		}
		else if($('#DiscountPoints').val()<=0)
		{
		   Alert("积分不能为负数或0");
		   $('#DiscountPoints').focus();
		   return false;
		}
		else if ($('#DiscountPoints').val()==""){
			Alert("积分不能为空");
			$('#DiscountPoints').focus();
			return false;
		}
		else if ($('#DiscountRate').val()==""){
			Alert("折扣不能为空");
			$('#DiscountRate').focus();
			return false;
		}
		else if($('#DiscountRate').val()<=0||$('#DiscountRate').val()>100)
		{
		   Alert("折扣范围从1到100");
		   return false;
		}
		else{
			var flag = true;
			if ($("#DiscountPoints").val() != discountPoints) {
				$.ajax({
				url: "/EShopping/manager/DiscountConfirm.action",
				type: "GET",
				async: false,
				contextType: "application/json;charset=utf-8",
				dataType: "json",
				data: {discountPoints:$("#DiscountPoints").val()},
				success: function(result) {
					if (result=="success") {
						flag = true;
					} else {
						flag = false;
						Alert("积分已存在");
					}
				}
				});
			}
			if (flag==true) {
				Alert("修改成功");
				setTimeout( function(){$("[name=form2]").submit();} ,2000);
				return true;
			} else {
				return false;
			}
		}
	}
	</script>
</body>
</html>



<%-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'modifyDiscount.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <h3>修改折扣</h3>
    <form action="ModifyDiscount.action" method="post">
    	<input type="hidden" name="oldDiscountPoints" value="${requestScope['discountPoints'] }" />
    	<br>所需积分：<input name=discountPoints type="text" value="${requestScope['discountPoints']}"/>
    	<br>对应折扣：<input name=discountRate type="text" value="${requestScope['discountRate']}"/>
        <br>
        <input type="submit" value="提交" />
    	<input type="reset" value="重置" />
    </form>
  </body>
</html>
 --%>