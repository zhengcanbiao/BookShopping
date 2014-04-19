<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>会员管理</title>
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
        <input type="submit" class="Button"  value="注销" style="float:right; margin-top:-25px;"/>
        </form>
        </div><!-- 内容放在这里面 -->
    </div><!-- 头部 -->
    
    <div class="body">
    	<div class="container">
        	<div class="breadcrumb">
            管理系统首页-&gt;会员管理
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
            会员管理
	<form name="form1" method="post" action="/BookShopping/manager/SearchCustomer.action" enctype="multipart/form-data">
    	<input type="submit" style="float:right" value="搜索" />
		<select name="searchChoice" style="float:right">
			<option value="0" <c:if test="${requestScope['searchChoice']==0 }">selected="selected"</c:if> >按名称排序</option>
			<option value="1" <c:if test="${requestScope['searchChoice']==1 }">selected="selected"</c:if> >按昵称排序</option>
			<option value="2" <c:if test="${requestScope['searchChoice']==2 }">selected="selected"</c:if> >按积分排序</option>
		</select>
		<input name="keyword" type="text" id="keyword" value="${requestScope['keyword'] }" style="float:right;width:200px;" placeholder="只按照会员名，昵称搜索"/>
	</form>
	<br/>
            <hr />
            <table width="770">
            <tr>
            <td>会员名</td>
            <td>会员昵称</td>
            <td>性别</td>
            <td>等级</td>
            <td>积分</td>
            <td>折扣</td>
            <td>注册时间</td>
            <td>操作</td>
            </tr>
            <c:if test="${empty requestScope['CustomerList'] }">
            	<h3>没有找到相应会员</h3>
            </c:if>
            <c:forEach items="${requestScope['CustomerList'] }" var="item" varStatus="status">
	    <c:set var="index" value="${status.index }" />
	    <tr>
	    <td>${item.getCustomerName()}</td>
	    <td>${item.getNickName()}</td>
	    
	    <c:choose>
	  		<c:when test="${item.getSex()==0 }">
	  			<td>保密</td>
	  		</c:when>
	  		<c:when test="${item.getSex()==1 }">
	  			<td>男</td>
	  		</c:when>
	  		<c:when test="${item.getSex()==2 }">
	  			<td>女</td>
	  		</c:when>
	  		<c:when test="${item.getSex()==3 }">
	  			<td>其他</td>
	  		</c:when>
	  	</c:choose>
	  	<td>${requestScope['RankList'][index]}级</td>
	  	<td>${item.getPoints()}积分</td>
	  	<td>${requestScope['DiscountList'][index].discountRate}%</td>
	  	<td>${item.getRegisterTime()}</td>
	  	
	  	<c:choose>
	  		<c:when test="${item.valid==true }">
	  			<td><a href="#" id="click1" onclick="return show_confirm('/BookShopping/manager/ValidateCustomer.action?customerName=${item.getCustomerName()}&valid=0','1')">冻结</a></td>
	  		</c:when>
	  		<c:otherwise>
	  			<td><a href="#" id="click2" onclick="return show_confirm('/BookShopping/manager/ValidateCustomer.action?customerName=${item.getCustomerName()}&valid=1','2')">激活</a></td>
	  		</c:otherwise>
	  	</c:choose>
	  	</tr>
  	</c:forEach>
 
            </table>
            </div><!-- 右边部分 -->  
        </div><!-- 内容放在这里面 -->
    </div><!-- 中间部分 -->
    
    <div class="footer">
    	<div class="container" align="right">
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
            function show_confirm(path,id)
			{
            	var href = path;
            	var click_id = "#click" + id;
            	//alert(click_id);
				if($(click_id).text() == "冻结")
				{
					var r=confirm("是否确认冻结？");
					if (r==true)
	  			  	{
	  					Alert("冻结成功");
	  					//alert("冻结成功");
						$(click_id).text("激活");
						setTimeout( function(){window.location.href = href;} ,2000);
						
	 				 }
					else
	  				{
	  					Alert("冻结撤销");
						$(click_id).text("冻结");
	  				}
					return r;
				}
				else if($(click_id).text() == "激活")
				{
					var r=confirm("是否确认激活？");
					if (r==true)
	  			  	{
	  					Alert("激活成功");
						$(click_id).text("冻结");
						setTimeout( function(){window.location.href = href;} ,2000);
						
	 				 }
					else
	  				{
	  					Alert("激活撤销");
						$(click_id).text("激活");
	  				}
					return r;
				}
			}
      </script>
</body>
</html>

<%-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'viewCustomer.jsp' starting page</title>
    
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
  	<c:forEach items="${requestScope['CustomerList'] }" var="item" varStatus="status">
	    <c:set var="index" value="${status.index }" />
	    ${item.getCustomerName()}
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    ${item.getNickName()}
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    <c:choose>
	  		<c:when test="${item.getSex()==0 }">
	  			保密
	  		</c:when>
	  		<c:when test="${item.getSex()==1 }">
	  			男
	  		</c:when>
	  		<c:when test="${item.getSex()==2 }">
	  			女
	  		</c:when>
	  		<c:when test="${item.getSex()==3 }">
	  			其他
	  		</c:when>
	  	</c:choose>
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	${requestScope['RankList'][index]}级
	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	${item.getPoints()}积分
	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	${requestScope['DiscountList'][index].discountRate}%
	  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	${item.getRegisterTime()}
	  	<c:choose>
	  		<c:when test="${item.valid==true }">
	  			<a href="ValidateCustomer.action?customerName=${item.getCustomerName()}&valid=0">冻结</a>
	  		</c:when>
	  		<c:otherwise>
	  			<a href="ValidateCustomer.action?customerName=${item.getCustomerName()}&valid=1">激活</a>
	  		</c:otherwise>
	  	</c:choose>
	  	<br><br><br>
  	</c:forEach>
  </body>
</html>
 --%>