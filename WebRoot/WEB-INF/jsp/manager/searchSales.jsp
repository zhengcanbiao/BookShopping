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
<title>销售量统计</title>
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/manager.css" rel="stylesheet" media="screen" />
<style>
.right_block{
	position: relative;
	width: 700px;
	margin: auto;
	padding-top: 50px;
}
#form_dingdang input{
	height: 30px;
}
.shijian {
	margin-left: 28px;
}
#form_dingdang select{
    margin-left: 12px;
    width: 207px;
}
body{
	background-color:#eee;
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
						<i class="icon-eye-open icon-white"></i>
						<span class="selected">销售量统计</span>
					</a>					
				</li>				
				<li>
					<a href="/BookShopping/manager/PrepareCustomer.action">
						<i class="icon-user"></i>
						<span>会员管理</span>
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
						销售量查询
						<button id="search_sale" type="button" class="btn btn-success" style="float:right" onclick="search_saleNum()">销售量趋势查询</button>
<!-- 						<a href="/BookShopping/manager/Jump.action?jumpId=6" style="float:right">销售量趋势查询</a> -->
						<hr/>
					    <form id="form_dingdang" action="/BookShopping/manager/PrepareSalesList.action" method="post"  onsubmit="return verify()">
					    	时间：
					    	<c:choose>
					    		<c:when test="${not empty requestScope['Date'] }">
					    			<input class="shijian" name="Date" type="date" id="date" value="${requestScope['Date']}"/>
					    		</c:when>
					    		<c:otherwise>
					    			<input class="shijian" name="Date" type="date" id="date" value="1970-01-01"/>
					    		</c:otherwise>
					    	</c:choose>
					    	<br/>父类别:&nbsp;&nbsp;&nbsp; 
					   		<select id="first_category_dropdown"  name="firstCategory" onchange="on_first_category_selected()">
					   			<option value="-1">---请选择父类别---</option>
					   			<c:forEach items="${applicationScope['topCategoryList'] }" var="category">
					         		<option value="${category.categoryId }">${category.categoryName }</option>
					         	</c:forEach>
					   		</select>
					   		<br/>   
					    	子类别:&nbsp;&nbsp;&nbsp; 
					    	<select id="subcategory_dropdown" name="categoryId">
					    		<option value='-1' >---请选择子类别---</option>
					    	</select>
					    	<br/>
					    	<input type="submit" class="btn btn-success" value="&nbsp;&nbsp;&nbsp;&nbsp;查询&nbsp;&nbsp;&nbsp;&nbsp;"/>
					        <input type="reset" class="btn btn-success" value="&nbsp;&nbsp;&nbsp;&nbsp;置空&nbsp;&nbsp;&nbsp;&nbsp;" />
					
					    </form>
					    <br/>查询结果 <hr/>
					    <table width="800">
					    	<tr>
					    		<td>商品代码</td>
					    		<td>商品名称</td>
					    		<td>当日销售量</td>
					    		<td>当日销售额</td>
					    		<td>当月销售量</td>
					    		<td>当月销售额</td>
					    	</tr>
					    	<c:if test="${empty requestScope['booksList'] }">
					            	<h3>没有找到相应商品</h3>
					            </c:if>
						    <c:forEach items="${requestScope['booksList'] }" var="item" varStatus="status">
						    	<c:set var="index" value="${status.index }" />
						    	<tr>
						    		<td>${item.booksId }</td>
						    		<td><a href="/BookShopping/manager/PrepareBooksDetail.action?booksId=${item.booksId}">${item.bookName }</a></td>
						    		<td>${requestScope['salesList2'].get(index)[0] }</td>
						    		<td>&yen;<fmt:formatNumber value="${requestScope['salesList2'].get(index)[1]/100.0 }" pattern="#0.00"/></td>
						    		<td>${requestScope['salesList'].get(index)[0] }</td>
						    		<td>&yen;<fmt:formatNumber value="${requestScope['salesList'].get(index)[1]/100.0 }" pattern="#0.00"/></td>
						    	</tr>
						    </c:forEach>
					    </table>
					            <br/>	
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
    <script src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/alert.js"></script>
    <script type="application/javascript" src="/BookShopping/js/manager.js"></script>
    <script type="text/javascript">
        	function search_saleNum(){
				window.location.href="/BookShopping/manager/Jump.action?jumpId=6";
			}
            function verify()
			{
            	if($('#date').val()=="")
            		{
            		Alert("搜索时间不能为空");
                    return false;
            		}
				else if($('#subcategory_dropdown').val()==-1 && $('#first_category_dropdown').val()!=-1)
			 	{
					
                    Alert("请选择子类别，或不选择父类别");
                    return false;
				}
                return true;
			}
            function on_first_category_selected() {
    	 		var firstCategoryId = $("#first_category_dropdown").val();
    	 		$.ajax({
    	 			url: "/BookShopping/manager/GetSubcategoryList.action",
    	 			type: "GET",
    	 			contextType: "application/json;charset=utf-8",
    	 			data: {parentId: firstCategoryId},
    	 			dataType: "json",
    	 			success: function(result) {
    	 				$('#subcategory_dropdown').empty();
    	 				$('#subcategory_dropdown').append("<option value='-1'>---请选择子类别---</option>");
    	 				var resultJson = eval(result);
    	 				$.each(resultJson, function(index, item) {
    	 					$('#subcategory_dropdown').append("<option value="+ item.categoryId +">" + item.categoryName + "</option>");
    	 				});
    	 			}
    	 		});
    	 	}
            
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

















<%-- <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>销售量统计</title>
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
            管理系统首页-&gt;销售量统计
            <hr />
            </div><!-- 面包屑 就是当前页面所在的导航位置 -->
           
            <div class="left_block">
            <ul>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=3">回到首页</a></li>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=0">修改密码</a></li>
            <li><a href="/BookShopping/manager/PrepareCategory.action">商品类别管理</a></li>
            <li><a href="/BookShopping/manager/PrepareBooks.action">商品管理</a></li>
            <li><a href="/BookShopping/manager/PrepareOrder.action">订单管理</a></li>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=6">销售量统计</a></li>
            <li><a href="/BookShopping/manager/PrepareCustomer.action">会员管理</a></li>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=4">折扣管理</a></li>
            </ul>
            </div><!-- 左边部分 -->
            
            <div class="right_block">
	
	销售量查询
	<a href="/BookShopping/manager/Jump.action?jumpId=6" style="float:right">销售量趋势查询</a>
	<hr/>
    <form action="/BookShopping/manager/PrepareSalesList.action" method="post"  onsubmit="return verify()">
    	时间：
    	<c:choose>
    		<c:when test="${not empty requestScope['Date'] }">
    			<input name="Date" type="date" id="date" value="${requestScope['Date']}"/>
    		</c:when>
    		<c:otherwise>
    			<input name="Date" type="date" id="date" value="1970-01-01"/>
    		</c:otherwise>
    	</c:choose>
    	<br/>父类别:&nbsp;&nbsp;&nbsp; 
   		<select id="first_category_dropdown"  name="firstCategory" onchange="on_first_category_selected()">
   			<option value="-1">---请选择父类别---</option>
   			<c:forEach items="${applicationScope['topCategoryList'] }" var="category">
         		<option value="${category.categoryId }">${category.categoryName }</option>
         	</c:forEach>
   		</select>
   		<br/>   
    	子类别:&nbsp;&nbsp;&nbsp; 
    	<select id="subcategory_dropdown" name="categoryId">
    		<option value='-1' >---请选择子类别---</option>
    	</select>
    	<br/>
    	<input type="submit" value="&nbsp;&nbsp;&nbsp;&nbsp;查询&nbsp;&nbsp;&nbsp;&nbsp;"/>
        <input type="reset" value="&nbsp;&nbsp;&nbsp;&nbsp;置空&nbsp;&nbsp;&nbsp;&nbsp;" />

    </form>
    <br/>查询结果 <hr/>
    <table width="800">
    	<tr>
    		<td>商品代码</td>
    		<td>商品名称</td>
    		<td>当日销售量</td>
    		<td>当日销售额</td>
    		<td>当月销售量</td>
    		<td>当月销售额</td>
    	</tr>
    	<c:if test="${empty requestScope['booksList'] }">
            	<h3>没有找到相应商品</h3>
            </c:if>
	    <c:forEach items="${requestScope['booksList'] }" var="item" varStatus="status">
	    	<c:set var="index" value="${status.index }" />
	    	<tr>
	    		<td>${item.booksId }</td>
	    		<td><a href="/BookShopping/manager/PrepareBooksDetail.action?booksId=${item.booksId}">${item.bookName }</a></td>
	    		<td>${requestScope['salesList2'].get(index)[0] }</td>
	    		<td>&yen;<fmt:formatNumber value="${requestScope['salesList2'].get(index)[1]/100.0 }" pattern="#0.00"/></td>
	    		<td>${requestScope['salesList'].get(index)[0] }</td>
	    		<td>&yen;<fmt:formatNumber value="${requestScope['salesList'].get(index)[1]/100.0 }" pattern="#0.00"/></td>
	    	</tr>
	    </c:forEach>
    </table>
            <br/>
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
            function verify()
			{
            	if($('#date').val()=="")
            		{
            		Alert("搜索时间不能为空");
                    return false;
            		}
				else if($('#subcategory_dropdown').val()==-1 && $('#first_category_dropdown').val()!=-1)
			 	{
					
                    Alert("请选择子类别，或不选择父类别");
                    return false;
				}
                return true;
			}
            function on_first_category_selected() {
    	 		var firstCategoryId = $("#first_category_dropdown").val();
    	 		$.ajax({
    	 			url: "/BookShopping/manager/GetSubcategoryList.action",
    	 			type: "GET",
    	 			contextType: "application/json;charset=utf-8",
    	 			data: {parentId: firstCategoryId},
    	 			dataType: "json",
    	 			success: function(result) {
    	 				$('#subcategory_dropdown').empty();
    	 				$('#subcategory_dropdown').append("<option value='-1'>---请选择子类别---</option>");
    	 				var resultJson = eval(result);
    	 				$.each(resultJson, function(index, item) {
    	 					$('#subcategory_dropdown').append("<option value="+ item.categoryId +">" + item.categoryName + "</option>");
    	 				});
    	 			}
    	 		});
    	 	}
            
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
 --%>