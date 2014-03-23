<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>订单管理</title>
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
<s:actionerror/>
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
            管理系统首页-&gt;订单管理
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
            订单列表
	<form name="form1" method="post" action="/EShopping/manager/SearchOrder.action" enctype="multipart/form-data">
    	<input type="submit" style="float:right" value="搜索" />
		<select name="searchChoice" style="float:right">
			<option value="0" <c:if test="${requestScope['searchChoice']==0 }">selected="selected"</c:if> >按订单号排序</option>
			<option value="1" <c:if test="${requestScope['searchChoice']==1 }">selected="selected"</c:if> >按用户名排序</option>
		</select>
		<input name="keyword" type="text" id="keyword" value="${requestScope['keyword'] }" style="float:right;width:200px;" placeholder="只按照订单号，用户名搜索"/>
		
	</form>
	<br/>
            <hr />
            <table width="800">
            <tr>
            <td>订单号</td>
            <td>用户</td>
            <td>下单时间</td>
            <td>订单状态</td>
            <td>操作</td>
            </tr>
            <c:if test="${empty requestScope['orderList'] }">
            	<h3>没有找到相应订单</h3>
            </c:if>
            <c:forEach items="${requestScope['orderList'] }" var="item" varStatus="status">
    		<tr>
    			<td>${item.orderId }</td>
    			<td>${item.tbCustomer.customerName }</td>
    			<td>${item.orderTime }</td>
    			<c:choose>
   					<c:when test="${item.orderStatus==-1 }">
   						<td>交易失败</td>
   						<td><a href="/EShopping/manager/PrepareOrderDetail.action?orderId=${item.orderId }">详情</a></td>
   					</c:when>
   					<c:when test="${item.orderStatus==1 }">
   						<td>未发货</td>
   						<td>
   							<a href="/EShopping/manager/PrepareOrderDetail.action?orderId=${item.orderId }">详情</a>
   							<a href="#" id="click1" onclick="confirm1('/EShopping/manager/ModifyOrder.action?orderId=${item.orderId }')">发货</a>
   						</td>
   					</c:when>
   					<c:when test="${item.orderStatus==2 }">
   						<td>已发货</td>
   						<td><a href="/EShopping/manager/PrepareOrderDetail.action?orderId=${item.orderId }">详情</a></td>
   					</c:when>
   					<c:when test="${item.orderStatus==3 }">
   						<td>交易成功</td>
   						<td><a href="/EShopping/manager/PrepareOrderDetail.action?orderId=${item.orderId }">详情</a></td>
   					</c:when>
    			</c:choose>
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
    
    <script src="/EShopping/js/jquery-1.9.1.min.js"></script>
    <script src="/EShopping/js/alert.js"></script>
            <script type="text/javascript">
            
            function confirm1(path)
			{
				var href = path;
            	var click_id = "#click1";
				if($(click_id).text() == "发货")
				{
			var r=confirm("是否确认发货？");
				if (r==true)
  			  		{
  					Alert("发货成功");
  				/* 	$(click_id).text("上架"); */
  					setTimeout( function(){window.location.href = href;} ,2000);
 				 	}
				else
  					{
					
  					//Alert("发货撤销");
  					  /* $(click_id).text("发货");  */
  					}
				return r;
				
				}
			}
            
           /* function confirm2(path)
			{
				var href = path;
            	var click_id = "#click2";
				if($(click_id).text() == "交易失败")
				{
			var r=confirm("是否确认交易失败？");
				if (r==true)
  			  		{
  					Alert("交易失败");
  				/* 	$(click_id).text("上架"); *//*
  					setTimeout( function(){window.location.href = href;} ,2000);
 				 	}
				else
  					{
					
  					//Alert("发货撤销");
  					  /* $(click_id).text("发货");  *//*
  					}
				return r;
				
				}
			}*/
            
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
			</script>
            
</body>
</html>

<%-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'viewOrder.jsp' starting page</title>
    
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
    <h3>订单列表</h3>
    <table width="750">
    	<tr>
	    	<td>订单号</td>
	    	<td>用户</td>
	    	<td>下单时间</td>
	    	<td>订单状态</td>
	    	<td>操作</td>
    	</tr>
    	<c:forEach items="${requestScope['orderList'] }" var="item" varStatus="status">
    		<tr>
    			<td>${item.orderId }</td>
    			<td>${item.tbCustomer.nickName }</td>
    			<td>${item.orderTime }</td>
    			<c:choose>
   					<c:when test="${item.orderStatus==-1 }">
   						<td>交易失败</td>
   						<td><a href="PrepareOrderDetail.action?orderId=${item.orderId }">详情</a></td>
   					</c:when>
   					<c:when test="${item.orderStatus==1 }">
   						<td>未发货</td>
   						<td>
   							<a href="PrepareOrderDetail.action?orderId=${item.orderId }">详情</a>
   							<a href="ModifyOrder.action?orderStatus=2&orderId=${item.orderId }">发货</a>
   							<a href="ModifyOrder.action?orderStatus=-1&orderId=${item.orderId }">交易失败</a>
   						</td>
   					</c:when>
   					<c:when test="${item.orderStatus==2 }">
   						<td>已发货</td>
   						<td><a href="PrepareOrderDetail.action?orderId=${item.orderId }">详情</a></td>
   					</c:when>
   					<c:when test="${item.orderStatus==3 }">
   						<td>交易成功</td>
   						<td><a href="PrepareOrderDetail.action?orderId=${item.orderId }">详情</a></td>
   					</c:when>
    			</c:choose>
    		</tr>
    	</c:forEach>
    </table>
  </body>
</html>
 --%>