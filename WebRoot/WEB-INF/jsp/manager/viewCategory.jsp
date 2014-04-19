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
<title>商品类别管理</title>
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
.jquery-dialog .icon-question {
	position: absolute;
	width: 32px;
	height: 32px;
	background-image: url("icons.gif");
	background-position: 0 -32px;
}
</style>
</head>
<body>

	<div class="header">
    	<div class="container">
         <img src="/BookShopping/img/logo_cut_30px.png"/>
        尊敬的管理员，Eshopping网上衣城  诚心感谢你的默默付出
        <form name="form1" method="post" action="/BookShopping/manager/ManagerLogout.action" enctype="multipart/form-data" onsubmit="return Confirm()">
        <input type="submit" class="Button" value="注销" style="float:right; margin-top:-25px;"/>
        </form>
        </div><!-- 内容放在这里面 -->
    </div><!-- 头部 -->
    
    <div class="body">
    	<div class="container">
        	<div class="breadcrumb">
            管理系统首页-&gt;商品类别管理
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
            商品类别管理
            <form name="form1" method="post" action="/BookShopping/manager/Jump.action?jumpId=2" enctype="multipart/form-data">
            <input type="submit" value="添加新类别" style="float:right; margin-top:-25px;"/>
        	</form>
            <hr />
             
            <table width="710px">
            <tr>
            <td>&nbsp;&nbsp;&nbsp;类别名称</td>
            <td>操作</td>
            </tr>
            </table>
             <c:forEach items="${applicationScope['topCategoryList'] }" var="item" varStatus="status">
    	<c:set var="index" value="${status.index }" />
    	<br/>${item.categoryName }
    	<ul>
	    	<c:forEach items="${requestScope['AllSecondCategoryList'].get(index) }" var="subCategory">
	    		<c:if test="${subCategory.valid==true}">
		    		<li>
			    		${subCategory.categoryName }
			    		<a href="/BookShopping/manager/PrepareCategoryDetail.action?categoryId=${subCategory.categoryId }" style="float:right; margin-right:200px;">修改</a>&nbsp;&nbsp;
			    		<a href="#" onclick="show_confirm('/BookShopping/manager/DeleteCategory.action?categoryId=${subCategory.categoryId }')" style="float:right; margin-right:-80px;">删除</a>
		    		</li>
	    		</c:if>
	    	</c:forEach>
    	</ul>
    </c:forEach>
            </div><!-- 右边部分 -->  
        </div><!-- 内容放在这里面 -->
    </div><!-- 中间部分 -->
    
    <div class="footer">
    	<div align="right" class="container">
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
	
  		function show_confirm(path)
	{
  			var href = path;
		var r=confirm("是否确认删除？");
		if (r==true)
			  	{
			//return true;
					Alert("删除成功");
					window.location.href = href;
			 }
		else
				{
			//return false;
					Alert("撤销删除");
				}
	}
	</script>
</body>
</html>

<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
         <img src="/BookShopping/img/logo_cut_30px.png"/>
        尊敬的管理员admin，Eshopping网上衣城  诚心感谢你的默默付出
        <a href="ManagerLogout.action" style="float:right; margin-top:13px;" >注销</a>
        </div><!-- 内容放在这里面 -->
    </div><!-- 头部 -->
    
    <div class="body">
    	<div class="container">
        	<div class="breadcrumb">
            管理系统首页->商品类别管理
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
            商品类别管理
            <form name="form1" method="post" action="Jump.action?jumpId=2" enctype="multipart/form-data">
            <input type="submit" value="添加新类别" style="float:right; margin-top:-25px;">
        	</form>
            <hr />
             
            <table width="710px">
            <tr>
            <td>&nbsp;&nbsp;&nbsp;类别名称</td>
            <td>操作</td>
            </tr>
            </table>
            
             <c:forEach items="${applicationScope['topCategoryList'] }" var="item" varStatus="status">
    	<c:set var="index" value="${status.index }" />
    	<br>${item.categoryName }
    	<ul>
	    	<c:forEach items="${requestScope['AllSecondCategoryList'].get(index) }" var="subCategory">
	    		<c:if test="${subCategory.valid==true}">
		    		<li>
			    		${subCategory.categoryName }
			    		<a href="PrepareCategoryDetail.action?categoryId=${subCategory.categoryId }" style="float:right; margin-right:200px;">修改</a>&nbsp;&nbsp;
			    		<a href="DeleteCategory.action?categoryId=${subCategory.categoryId }" onclick="alert('删除成功')" style="float:right; margin-right:-80px;">删除</a>
		    		</li>
	    		</c:if>
	    	</c:forEach>
    	</ul>
    </c:forEach>
 
            </div><!-- 右边部分 -->  
        </div><!-- 内容放在这里面 -->
    </div><!-- 中间部分 -->
    
    <div class="footer">
    	<div align="right" class="container">
        </div><!-- 内容放在这里面 -->
    </div><!-- 底部 -->
    
</body>
</html> --%>

<%-- 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'viewCategory.jsp' starting page</title>
    
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
    <h1>商品类别管理</h1>
    <a href="Jump.action?jumpId=2">添加分类</a><br>
    <c:forEach items="${applicationScope['topCategoryList'] }" var="item" varStatus="status">
    	<c:set var="index" value="${status.index }" />
    	<br>${item.categoryName }
    	<ul>
	    	<c:forEach items="${requestScope['AllSecondCategoryList'].get(index) }" var="subCategory">
	    		<c:if test="${subCategory.valid==true}">
		    		<li>
			    		${subCategory.categoryName }
			    		<a href="PrepareCategoryDetail.action?categoryId=${subCategory.categoryId }" style="float:right; margin-right:900px;">修改</a>
			    		<a href="DeleteCategory.action?categoryId=${subCategory.categoryId }" onclick="alert('删除成功')" style="float:right; margin-right:-80px;">删除</a>
		    		</li>
	    		</c:if>
	    	</c:forEach>
    	</ul>
    </c:forEach>
  </body>
</html>
 --%>