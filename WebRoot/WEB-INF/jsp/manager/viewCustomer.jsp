<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<link href="/BookShopping/css/manager.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<style>
.right_block{
	position: relative;
	width: 800px;
	margin: auto;
	padding-top: 50px;
}
#form_dingdang input{
	height: 30px;
}
#form_dingdang select{
	width: 150px;
}


</style>
</head>
<body>
	<div class="admin_head">
		<p>网上书城系统-管理员后台</p>
	</div>
	<div class="admin_container">
		<div class="admin_left">
			<div class="welcome">
				<span>管理员 </span>
				<a href="/BookShopping/manager/ManagerLogout.action">退出</a>
			</div>
			<hr/>
			<ul>
				<li>
					<a href="/BookShopping/manager/Jump.action?jumpId=3">
						<i class="icon-home"></i>
						<span>回到首页</span>
					</a>				
				</li>
				<li>
					<a href="/BookShopping/manager/Jump.action?jumpId=0">
						<i class="icon-wrench"></i>
						<span>修改密码</span>
					</a>					
				</li>
				<li>
					<a href="/BookShopping/manager/PrepareCategory.action">
						<i class="icon-bookmark"></i>
						<span>商品类别管理</span>
					</a>					
				</li>
				<li>
					<a href="/BookShopping/manager/PrepareBooks.action">
						<i class="icon-book"></i>
						<span>商品管理</span>
					</a>					
				</li>
				<li>
					<a href="/BookShopping/manager/PrepareOrder.action">
						<i class="icon-shopping-cart"></i>
						<span>订单管理</span>
					</a>					
				</li>
				<li>
					<a href="/BookShopping/manager/Jump.action?jumpId=6">
						<i class="icon-eye-open"></i>
						<span>销售量统计</span>
					</a>					
				</li>				
				<li>
					<a href="/BookShopping/manager/PrepareCustomer.action">
						<i class="icon-user icon-white"></i>
						<span class="selected">会员管理</span>
					</a>					
				</li>
				<li>
					<a href="/BookShopping/manager/Jump.action?jumpId=4">
						<i class="icon-star"></i>
						<span>折扣管理</span>
					</a>					
				</li>								
			</ul>
		</div>
		<div class="admin_right">
			<div class="bg_right">
				<div class="admin_right_to_center">
					<div class="right_block">
				           会员管理
					<form id="form_dingdang" name="form1" method="post" action="/BookShopping/manager/SearchCustomer.action" enctype="multipart/form-data">
				    	<input type="submit" class="btn btn-success" style="float:right" value="搜索" />
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
					  	<td><fmt:formatDate value="${item.getRegisterTime()}" type="both"/></td>
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
					</div>
				
				
				
<!-- 	                <form id="form_pwd" name="form2" class="form-horizontal" role="form" action="/BookShopping/manager/ManagerChangePsw.action" method="post" enctype="multipart/form-data" >
	                	<label>输入旧密码</label>
	                	<input id="oldPwd" name="old_password" type="password"/>
	                	<label>输入新密码</label>
	                	<input id="newPwd" name="new_password" type="password" />
	                	<label>再次输入新密码</label>
	                	<input id="renewPwd" name="new_password" type="password" />
	                	
	                	<input type="button" value="确认" class="btn btn-large btn-success" style="width:300px; height:40px; margin-top:10px;" onclick="verify()" />
	                </form> -->
		            
		            
			
				</div>
			</div>
		</div>
	</div>
	
	
    <script src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/alert.js"></script>
    <script type="application/javascript" src="/BookShopping/js/manager.js"></script>
    <script type="text/javascript">
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





<%-- <head>
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
	  	<td><fmt:formatDate value="${item.getRegisterTime()}" type="both"/></td>
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

 --%>