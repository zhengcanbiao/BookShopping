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
<title>折扣管理</title>
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
            管理系统首页-&gt;折扣管理
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
            折扣管理
            <form name="form1" method="post" action="/BookShopping/manager/Jump.action?jumpId=5" enctype="multipart/form-data">
            <input type="submit" value="添加折扣" style="float:right; margin-top:-25px;"/>
            </form>
            <hr />
            <table width="700">
            <tr>
            <td>会员等级</td>
            <td>会员积分</td>
            <td>对应折扣</td>
            <td>操作</td>
            </tr>
            
             <c:forEach items="${applicationScope['discountList'] }" begin="1" var="item" varStatus="status">
	    	<tr>
	    		<td>等级${status.index }</td>
	    		<td>${item.discountPoints }</td>
	    		<td>${item.discountRate }%</td>
	    		<td><a href="/BookShopping/manager/PrepareDiscount.action?discountPoints=${item.discountPoints }">修改</a></td>
	    		<td><a href="#" onclick="show_confirm('/BookShopping/manager/DeleteDiscount.action?discountPoints=${item.discountPoints }&discountRate=${item.discountRate }')">删除</a></td>
	    		
    		</tr>
	    </c:forEach>
            </table>
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
			
    		function show_confirm(path)
			{
    			var href = path;
				var r=confirm("是否确认删除？");
				if (r==true)
  			  	{
  					Alert("删除成功");
  					window.location.href = href;
 				 }
				else
  				{
  					Alert("撤销删除");
  				}
			}
	</script>
</body>
</html>


<%-- 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'viewDiscount.jsp' starting page</title>
    
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
    <h3>折扣管理</h3>
    <a href="Jump.action?jumpId=5">添加折扣</a><br>
    <table width="500">
	    <tr>
		    <td>会员等级</td>
		    <td>会员积分</td>
		    <td>对应折扣</td>
		    <td>操作</td>
	    </tr>
	    <c:forEach items="${applicationScope['discountList'] }" begin="1" var="item" varStatus="status">
	    	<tr>
	    		<td>等级${status.index }</td>
	    		<td>${item.discountPoints }</td>
	    		<td>${item.discountRate }%</td>
	    		<td><a href="PrepareDiscount.action?discountPoints=${item.discountPoints }&discountRate=${item.discountRate }">修改</a></td>
	    		<td><a href="DeleteDiscount.action?discountPoints=${item.discountPoints }&discountRate=${item.discountRate }">删除</a></td>
    		</tr>
	    </c:forEach>
    </table>
  </body>
</html>
 --%>