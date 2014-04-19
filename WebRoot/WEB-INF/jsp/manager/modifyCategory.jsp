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
<title>修改类别</title>
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
	line-height:40px;
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
         <img src="/BookShopping/img/logo_cut_30px.png" />
        尊敬的管理员，Eshopping网上衣城  诚心感谢你的默默付出
        <form name="form1" method="post" action="/BookShopping/manager/ManagerLogout.action" enctype="multipart/form-data" onsubmit="return Confirm()">
        <input type="submit"  class="Button" value="注销" style="float:right; margin-top:-25px;"/>
        </form>
        </div><!-- 内容放在这里面 -->
    </div><!-- 头部 -->
    
    <div class="body">
    	<div class="container">
        	<div class="breadcrumb">
            管理系统首页-&gt;商品类别管理-&gt;修改类别
            <hr />
            </div><!-- 面包屑 就是当前页面所在的导航位置 -->
           
            <div class="left_block">
            <ul>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=3">回到首页</a></li>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=0">修改密码</a></li>
            <li><a href="/BookShopping/manager/PrepareCategory.action">商品类别管理</a></li>
            <li><a href="/BookShopping/manager/PrepareClothes.action">商品管理</a></li>
            <li><a href="/BookShopping/manager/PrepareOrder.action">订单管理</a></li>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=6">销售量统计</a></li>
            <li><a href="/BookShopping/manager/PrepareCustomer.action">会员管理</a></li>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=4">折扣管理</a></li>
            </ul>
            </div><!-- 左边部分 -->
            
            <div class="right_block">
            <form name="form2" method="post" action="/BookShopping/manager/ModifyCategory.action" enctype="multipart/form-data">
            修改类别
            <hr />
            <input type="hidden" name="categoryId" value="${requestScope['Category'].categoryId}"/>
     		<p/>类别名:&nbsp;
			<input name="categoryName" type="text" id="categoryname" value="${requestScope['Category'].categoryName}"/><font size="2" color="#FF0000" id="a"> *必填项</font>
			<br/>
            父类别:&nbsp;&nbsp;<select id="first_category_dropdown" name="parentId">
            <c:forEach items="${applicationScope['topCategoryList'] }" var="category">
         		<option <c:if test="${requestScope['Category'].parentId==category.categoryId }">selected="selected"</c:if> 
         		value="${category.categoryId }">&nbsp;&nbsp;&nbsp;&nbsp;${category.categoryName }&nbsp;&nbsp;&nbsp;&nbsp;</option>
         	</c:forEach>
				  </select>
			<br />
            <input type="button" value="确认修改" onclick="verify('${requestScope.Category.categoryName}')"/>
            <input type="reset" value="重置"/>
            </form>
            <form name="form3" method="post" action="/BookShopping/manager/PrepareCategory.action" enctype="multipart/form-data">
			<input type="submit" value="  返回  " style="float:left; margin-left:190px;margin-top:-45px;"/>
            </form>
            </div><!-- 右边部分 --> 
        </div><!-- 内容放在这里面 -->
    </div><!-- 中间部分 -->
    
    <div class="footer">
    	<div class="container">
        
        </div><!-- 内容放在这里面 -->
    </div><!-- 底部 -->
     <script src="/BookShopping/js/jquery-1.9.1.min.js"></script>
     <script src="/BookShopping/js/alert.js"></script>
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
	
	function verify(categoryName)
	{
		if($('#categoryname').val().length<=0 || $('#categoryname').val().length>15)
		{
			Alert("输入名称不符合规范，名字长度为1~15位");
			return false;
		}
		else{
			var flag = true;
			if (categoryName != $("#categoryname").val()) {
				$.ajax({
				url: "/BookShopping/manager/CategoryExist.action",
				type: "GET",
				async: false,
				contextType: "application/json;charset=utf-8",
				dataType: "json",
				data: {categoryName:$("#categoryname").val(), parentId:$("#first_category_dropdown").val()},
				success: function(result) {
					if (result=="success") {
						flag = true;
					} else {
						flag = false;
						Alert("该类别名在此父类别中已经存在");
					}
				}
				});
			}
			if (flag == true) { 
				Alert("修改成功");
				setTimeout( function(){$("[name=form2]").submit();} ,2000);
				return true;
			}
			else {
				return false;
			}
		}
	}
	</script>

</body>
</html>

<%-- 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Untitled Document</title>
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
	line-height:40px;
	float:left;
}
a{
	text-decoration:none;
}
a:hover{
	text-decoration:underline;
}
</style>
</head>

<body>

	<div class="header">
    	<div class="container">
         <img src="/BookShopping/img/logo_cut_30px.png" />
        尊敬的管理员admin，Eshopping网上衣城  诚心感谢你的默默付出
        <a href="ManagerLogout.action" style="float:right; margin-top:13px;" >注销</a>
        </div><!-- 内容放在这里面 -->
    </div><!-- 头部 -->
    
    <div class="body">
    	<div class="container">
        	<div class="breadcrumb">
            管理系统首页->商品类别管理->修改类别
            <hr />
            </div><!-- 面包屑 就是当前页面所在的导航位置 -->
           
            <div class="left_block">
            <ul>
           <li><a href="Jump.action?jumpId=3">回到首页</a></li>
            <li><a href="Jump.action?jumpId=0">修改密码</a></li>
            <li><a href="PrepareCategory.action">商品类别管理</a></li>
            <li><a href="PrepareClothes.action">商品管理</a></li>
            <li><a href="orderList.html">订单管理</a></li>
            <li><a href="findSales.html">销售量统计</a></li>
            <li><a href="PrepareCustomer.action">会员管理</a></li>
            <li><a href="Jump.action?jumpId=4">折扣管理</a></li>
            </ul>
            </div><!-- 左边部分 -->
            
            <div class="right_block">
            <form name="form1" method="post" action="ModifyCategory.action" enctype="multipart/form-data" onsubmit="return verify()">
            修改类别
            <hr />
            <input type="hidden" name="categoryId" value="${requestScope['Category'].categoryId}"/>
     		<p>类别名:&nbsp;
			<input name="categoryName" type="text" id="categoryname" value="${requestScope['Category'].categoryName}"><font size="2" color="#FF0000" id="a"> *必填项</font>
			<br>
            父类别:&nbsp;&nbsp;<select id="first_category_dropdown" name="parentId">
            <c:forEach items="${applicationScope['topCategoryList'] }" var="category">
         		<option <c:if test="${requestScope['Category'].parentId==category.categoryId }">selected="selected"</c:if> 
         		value="${category.categoryId }">&nbsp;&nbsp;&nbsp;&nbsp;${category.categoryName }&nbsp;&nbsp;&nbsp;&nbsp;</option>
         	</c:forEach>
				  </select>
			<br />
            <input type="reset" value="重置">&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="submit" value="确认修改">&nbsp;&nbsp;&nbsp;&nbsp;
            </form>
            <form name="form1" method="post" action="PrepareCategory.action" enctype="multipart/form-data">
			<input type="submit" value="  返回  " style="float:left; margin-left:190px;margin-top:-45px;">&nbsp;&nbsp;&nbsp;&nbsp;
            </form>
            </div><!-- 右边部分 --> 
        </div><!-- 内容放在这里面 -->
    </div><!-- 中间部分 -->
    
    <div class="footer">
    	<div class="container">
        
        </div><!-- 内容放在这里面 -->
    </div><!-- 底部 -->
     <script src="/BookShopping/js/jquery-1.9.1.min.js"></script>
            <script type="application/javascript">
			function verify()
			{
				 if ($('#categoryname').val()==""){
					alert("输入有空缺，请补全后再提交");
					return false;
				}
				else{
					alert("修改成功");
					return true;
				}
			}
			</script>

</body>
</html> --%>

<%-- 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'modifyCategory.jsp' starting page</title>
    
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
    <h3>修改类别</h3>
    <form action="ModifyCategory.action" method="post">
    	<input type="hidden" name="categoryId" value="${requestScope['Category'].categoryId}"/>
    	<br>类别名：<input name="categoryName" type="text" value="${requestScope['Category'].categoryName}"/>
    	<br>父类别：
   		<select id="first_category_dropdown" name="parentId">
         	<c:forEach items="${applicationScope['topCategoryList'] }" var="category">
         		<option <c:if test="${requestScope['Category'].parentId==category.categoryId }">selected="selected"</c:if> value="${category.categoryId }">${category.categoryName }</option>
         	</c:forEach>
        </select>
        <br>
        <input type="submit" value="提交" />
    	<input type="reset" value="重置" />
    </form>
  </body>
</html>
 --%>