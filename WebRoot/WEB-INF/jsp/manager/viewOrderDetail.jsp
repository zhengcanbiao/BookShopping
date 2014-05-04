<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>订单详情</title>
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
            管理系统首页-&gt;订单管理-&gt;订单详情
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
            配送信息
            <hr />

    <table width="850px">
    	<tr>
    		<td>订单号：</td>
    		<td>${order.orderId }</td>
    		<td>用户：</td>
    		<td>${order.tbCustomer.customerName }</td>
    		</tr>
    		<tr>
    		<td>下单时间：</td>
    		<td>${order.orderTime }</td>
   		
   			<td>订单状态：</td>
   			<c:choose>
				<c:when test="${order.orderStatus==-1 }">
					<td>交易失败</td>
				</c:when>
				<c:when test="${order.orderStatus==1 }">
					<td>未发货</td>
				</c:when>
				<c:when test="${order.orderStatus==2 }">
					<td>已发货</td>
				</c:when>
				<c:when test="${order.orderStatus==3 }">
					<td>交易成功</td>
				</c:when>
   			</c:choose>
   			</tr>
   			<tr>
   				<td>收货人信息：</td>
   				<td>${order.receiverInfo }</td>
   			</tr>
    </table>
    <br/><hr/>
    <table width="800px">
    	<tr>
    		<td>商品信息</td>
    		<td>作者</td>
    		<td>单价</td>
    		<td>数量</td>
    		<td>小计</td>
    	</tr>
    	<tr>
    		<c:forEach items="${requestScope['books'] }" var="item" varStatus="status">
    			<c:set var="index" value="${status.index }" />
    			<tr>
    				<td><a href="/BookShopping/manager/PrepareBooksDetail.action?booksId=${item.getBooksId()}">${item.getBookName()}</a></td>
    				<td>${item.author} </td>
    				<%-- <c:choose>
	   					<c:when test="${item.size==0 }"><td>S</td></c:when>
	   					<c:when test="${item.size==1 }"><td>M</td></c:when>
	   					<c:when test="${item.size==2 }"><td>L</td></c:when>
   					</c:choose> --%>
   					<td>&yen;<fmt:formatNumber value='${requestScope.orderDetail.get(index).price/100.0/requestScope.orderDetail.get(index).quantity }' pattern='#0.00'/></td>
   					<td><fmt:formatNumber value="${requestScope['orderDetail'].get(index).quantity }" pattern="#"/></td>
    				<td>&yen;<fmt:formatNumber value="${requestScope['orderDetail'].get(index).price/100.0 }" pattern="#0.00"/></td>
    			</tr>
    		</c:forEach>
    	</tr>
    </table>
    <br/><hr/>
    <table style="float:right" width="300px">
    	<tr>
    		<td>合计</td>
    		<td>积分折扣</td>
    		<td>实付款</td>
    	</tr>
    	<tr>
    		<td>&yen;<fmt:formatNumber value="${requestScope['order'].totalPrice/100.0 }" pattern="#0.00"/></td>
    		<td>${requestScope['order'].discount }%</td>
    		<td>&yen;<fmt:formatNumber value="${requestScope['order'].finalPrice/100.0 }" pattern="#0.00"/></td>
    	</tr>
    </table>
    <br/><br/><br/>
            </div><!-- 右边部分 -->  
        </div><!-- 内容放在这里面 -->
    </div><!-- 中间部分 -->
    
    <div class="footer">
    	<div class="container">
        <a href="/BookShopping/manager/PrepareOrder.action" style="float:right">返回</a>
         <c:if test="${requestScope['order'].orderStatus==1 }">
    	<a href="#" id="click1" onclick="confirm1('/BookShopping/manager/ModifyOrder.action?orderStatus=2&orderId=${requestScope['order'].orderId }')" style="float:right; margin-right:50px;">发货</a>
    </c:if>
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
	 </script>
            
</body>
</html>

<%-- 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'viewOrderDetail.jsp' starting page</title>
    
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
    <h3>订单详情</h3>
    <br>配送信息<hr>
    <table width="800px">
    	<tr>
    		<td>订单号：</td>
    		<td>${order.orderId }</td>
    		<td>客户昵称：</td>
    		<td>${order.tbCustomer.nickName }</td>
    		<td>下单时间：</td>
    		<td>${order.orderTime }</td>
   		</tr>
   		<tr>
   			<td>订单状态：</td>
   			<c:choose>
				<c:when test="${order.orderStatus==-1 }">
					<td>交易失败</td>
				</c:when>
				<c:when test="${order.orderStatus==1 }">
					<td>未发货</td>
				</c:when>
				<c:when test="${order.orderStatus==2 }">
					<td>已发货</td>
				</c:when>
				<c:when test="${order.orderStatus==3 }">
					<td>交易成功</td>
				</c:when>
   			</c:choose>
   			<td>收货人信息：</td>
   			<td>${order.receiverInfo }</td>
   		</tr>
    </table>
    <br><hr>
    <table width="800px">
    	<tr>
    		<td>商品信息</td>
    		<td>尺寸</td>
    		<td>单价</td>
    		<td>数量</td>
    		<td>小计</td>
    	</tr>
    	<tr>
    		<c:forEach items="${requestScope['clothesDetail'] }" var="item" varStatus="status">
    			<c:set var="index" value="${status.index }" />
    			<tr>
    				<td><a href="PrepareBooksDetail.action?clothesId=${item.tbBooks.getBooksId()}">${item.tbBooks.bookName }</a></td>
    				<c:choose>
	   					<c:when test="${item.size==0 }"><td>S</td></c:when>
	   					<c:when test="${item.size==1 }"><td>M</td></c:when>
	   					<c:when test="${item.size==2 }"><td>L</td></c:when>
   					</c:choose>
   					<td>&yen;${requestScope['orderDetail'].get(index).price/100.0 }</td>
   					<td>${requestScope['orderDetail'].get(index).quantity }</td>
    				<td>&yen;${requestScope['orderDetail'].get(index).quantity*requestScope['orderDetail'].get(index).price/100.0 }</td>
    			</tr>
    		</c:forEach>
    	</tr>
    </table>
    <br><hr>
    <table style="float:right" width="300px">
    	<tr>
    		<td>合计</td>
    		<td>积分折扣</td>
    		<td>实付款</td>
    	</tr>
    	<tr>
    		<td>&yen;${requestScope['order'].totalPrice/100.0 }</td>
    		<td>&yen;${requestScope['order'].discount }%</td>
    		<td>&yen;${requestScope['order'].finalPrice/100.0 }</td>
    	</tr>
    </table>
    <br><br><br>
    <c:if test="${requestScope['order'].orderStatus==1 }">
    	<a href="ModifyOrder.action?orderStatus=2&orderId=${requestScope['order'].orderId }" style="float:right; margin-right:50px;">发货</a>
		<a href="ModifyOrder.action?orderStatus=-1&orderId=${requestScope['order'].orderId }" style="float:right; margin-right:50px;">交易失败</a>
    </c:if>
  </body>
</html>
 --%>