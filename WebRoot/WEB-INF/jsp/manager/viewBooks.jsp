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
<title>商品管理</title>
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/manager.css" rel="stylesheet" media="screen" />
<style>
.right_block{
	position: relative;
	width: 800px;
	height: 100%;
	margin: auto;
	padding-top: 50px;

}
#form_dingdang input{
	height: 30px;
}
#form_dingdang select{
	width: 150px;
}
#bottom{
	margin-bottom: 50px;
}
body{
	background-color:#eee;
}
.pagination {
	margin-left: 28%;
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
						<i class="icon-book icon-white"></i>
						<span class="selected">商品管理</span>
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
					           商品管理
					    <form name="form1" id="form_dingdang" method="post" action="/BookShopping/manager/SearchBooks.action" enctype="multipart/form-data">
					    	<input type="submit" class="btn btn-success" style="float:right" value="搜索" />
							<select name="searchChoice" style="float:right">
								<option value="0" <c:if test="${requestScope['searchChoice']==0 }">selected="selected"</c:if> >按ID排序</option>
								<option value="1" <c:if test="${requestScope['searchChoice']==1 }">selected="selected"</c:if> >按名称排序</option>
								<option value="2" <c:if test="${requestScope['searchChoice']==2 }">selected="selected"</c:if> >按价格排序</option>
							</select>
							<input name="keyword" type="text" id="keyword" value="${requestScope['keyword'] }" style="float:right;width:300px;" placeholder="搜索"/>
						</form>
						<br/>
					    <hr/>
							<form name="form1" method="post" action="/BookShopping/manager/Jump.action?jumpId=1" enctype="multipart/form-data">
					            <input type="submit" class="btn btn-success" value="添加商品" style="float:right; margin-right:0px;"/>
					        </form>    
					        <table id="bottom" align="left" width="700px">
					            <tr>
					            <td>商品ID</td>
					            <td style="width:250px;">商品名称</td>
					            <td>图片</td>
					            <td>
					            </td>
					            <td>价格</td>
					            <td>操作</td>
					            <td>
					            </td>
					            </tr>
					            <c:if test="${empty requestScope['BooksList'] }">
					            	<h3>没有找到相应商品</h3>
					            </c:if>
					        <c:forEach items="${requestScope['BooksList'] }" var="item" varStatus="status">
							    <c:set var="index" value="${status.index }" />
							    <tr>
							    <td>${item.booksId}</td>
							    <td>${item.bookName}</td>
							    <td><img src="${item.picUrl}" width="80px;" height="100px;"/></td>
							  	<c:choose>
							  		<c:when test="${item.valid==true }">
							  			<td></td>
							  		</c:when>
							  		<c:otherwise>
							  			<td><span id="status">此商品已下架</span></td>
							  		</c:otherwise>
							  	</c:choose>	
							  	<td>&yen;<fmt:formatNumber value='${item.price/100.0}' pattern='#0.00'/></td>
							  	<td><a href="/BookShopping/manager/PrepareBooksDetail.action?booksId=${item.booksId}">修改</a></td>
							  	<c:choose>
							  		<c:when test="${item.valid==true }">
							  			<td><a href="#" id="click1" onclick="show_confirm('/BookShopping/manager/ValidateBooks.action?booksId=${item.booksId}&valid=0','1')">下架</a></td>
							  		</c:when>
							  		<c:otherwise>
							  			<td><a href="#" id="click2" onclick="show_confirm('/BookShopping/manager/ValidateBooks.action?booksId=${item.booksId}&valid=1','2')">上架</a></td>
							  	</c:otherwise>
							  	</c:choose>	
							  	</tr>
					  		</c:forEach>				  							 
					     </table>
					   <%--  <div class="pagination">
						    <ul>
						<!--     <li><a href="#">Prev</a></li>
						    <li><a href="#">1</a></li>
						    <li><a href="#">2</a></li>
						    <li><a href="#">3</a></li>
						    <li><a href="#">4</a></li>
						    <li><a href="#">5</a></li>
						    <li><a href="#">Next</a></li>  -->
						     <c:if test="${pageNow!=1 }"><li ><a class="test" href="${applicationScope['basePath'] }/manager/PrepareBooks.action?pageNow=${pageNow-1 }">prev</a></li></c:if>
                	<c:forEach begin="1" end="${requestScope['pageCount'] }" var="index">
                		<li <c:if test="${pageNow==index }">class="active"</c:if>><a href="${applicationScope['basePath'] }/manager/PrepareBooks.action?pageNow=${index }">${index }</a></li>
                	</c:forEach>
                    <c:if test="${pageNow!=pageCount }"><li><a href="${applicationScope['basePath'] }/manager/PrepareBooks.action?pageNow=${pageNow+1 }">Next</a></li></c:if> 
						    </ul>
					    </div> --%>
					</div>
			
				</div>
			</div>
		</div>
		<%-- <div class="pagination">
                <ul>
                	<c:if test="${pageNow!=1 }"><li ><a class="test" href="${applicationScope['basePath'] }/customer/SearchBooks.action?keyword=${requestScope['keyword'] }&pageNow=${pageNow-1 }&orderIndex=${requestScope['orderIndex']}">prev</a></li></c:if>
                	<c:forEach begin="1" end="${requestScope['pageCount'] }" var="index">
                		<li <c:if test="${pageNow==index }">class="active"</c:if>><a href="${applicationScope['basePath'] }/customer/SearchBooks.action?keyword=${requestScope['keyword'] }&pageNow=${index }&orderIndex=${requestScope['orderIndex']}">${index }</a></li>
                	</c:forEach>
                    <c:if test="${pageNow!=pageCount }"><li><a href="${applicationScope['basePath'] }/customer/SearchBooks.action?keyword=${requestScope['keyword'] }&pageNow=${pageNow+1 }&orderIndex=${requestScope['orderIndex']}">Next</a></li></c:if>
                </ul>
            </div> --%>
	</div>
	
	
    <script src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/BookShopping/js/alert.js"></script>
    <script type="application/javascript" src="/BookShopping/js/manager.js"></script>
    <script type="text/javascript">	
	    $('#click').click(function(){
			if($('#click').text() == "下架"){
				$('#click').text("上架");
			}else{
				$('#click').text("下架");
			}
			
			if($('#click').text() == "下架")
			  {
					    $("#status").css("visibility","hidden");
					  };
				 if($('#click').text() == "上架")
			  {
					    $("#status").css("visibility","visible");
			      };
		});
		function show_confirm(path,id)
		{
			var href = path;
	          	var click_id = "#click" + id;
			if($(click_id).text() == "下架")
			{
		var r=confirm("是否确认下架？");
			if (r==true)
				  	{
						alert("下架成功");
						$(click_id).text("上架");
						setTimeout( function(){window.location.href = href;} ,2000);
				 }
			else
					{
						alert("下架撤销");
						$(click_id).text("下架");
					}
			}
			else if($(click_id).text() == "上架")
			{
		var r=confirm("是否确认上架？");
			if (r==true)
				  	{
						alert("上架成功");
						$(click_id).text("下架");
						setTimeout( function(){window.location.href = href;} ,2000);
	
				 }
			else
					{
						alert("上架撤销");
				$(click_id).text("上架");
	
					}
			}
		}
	</script>

</body>
</html>








<%-- 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>商品管理</title>
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
            管理系统首页-&gt;商品管理
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
            商品管理
    <form name="form1" method="post" action="/BookShopping/manager/SearchBooks.action" enctype="multipart/form-data">
    	<input type="submit" style="float:right" value="搜索" />
		<select name="searchChoice" style="float:right">
			<option value="0" <c:if test="${requestScope['searchChoice']==0 }">selected="selected"</c:if> >按ID排序</option>
			<option value="1" <c:if test="${requestScope['searchChoice']==1 }">selected="selected"</c:if> >按名称排序</option>
			<option value="2" <c:if test="${requestScope['searchChoice']==2 }">selected="selected"</c:if> >按价格排序</option>
		</select>
		<input name="keyword" type="text" id="keyword" value="${requestScope['keyword'] }" style="float:right;width:300px;" placeholder="只按照衣服名，生产商，材质，衣服描述搜索"/>
	</form>
	<br/>
    <hr/>
		<form name="form1" method="post" action="/BookShopping/manager/Jump.action?jumpId=1" enctype="multipart/form-data">
            <input type="submit" value="添加商品" style="float:right; margin-right:0px;"/>
            </form>    
            <table align="left" width="700px">
            <tr>
            <td>商品ID</td>
            <td style="width:250px;">商品名称</td>
            <td>图片</td>
            <td>
            </td>
            <td>价格</td>
            <td>操作</td>
            <td>
            </td>
            </tr>
            <c:if test="${empty requestScope['BooksList'] }">
            	<h3>没有找到相应商品</h3>
            </c:if>
            <c:forEach items="${requestScope['BooksList'] }" var="item" varStatus="status">
	    <c:set var="index" value="${status.index }" />
	    <tr>
	    <td>${item.booksId}</td>
	    <td>${item.bookName}</td>
	    <td><img src="${item.picUrl}" width="80px;" height="100px;"/></td>
	  	<c:choose>
	  		<c:when test="${item.valid==true }">
	  			<td></td>
	  		</c:when>
	  		<c:otherwise>
	  			<td><span id="status">此商品已下架</span></td>
	  		</c:otherwise>
	  	</c:choose>	
	  	<td>&yen;<fmt:formatNumber value='${item.price/100.0}' pattern='#0.00'/></td>
	  	<td><a href="/BookShopping/manager/PrepareBooksDetail.action?booksId=${item.booksId}">修改</a></td>
	  	<c:choose>
	  		<c:when test="${item.valid==true }">
	  			<td><a href="#" id="click1" onclick="show_confirm('/BookShopping/manager/ValidateBooks.action?booksId=${item.booksId}&valid=0','1')">下架</a></td>
	  		</c:when>
	  		<c:otherwise>
	  			<td><a href="#" id="click2" onclick="show_confirm('/BookShopping/manager/ValidateBooks.action?booksId=${item.booksId}&valid=1','2')">上架</a></td>
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
        <br />
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
	
          $('#click').click(function(){
		if($('#click').text() == "下架"){
			$('#click').text("上架");
		}else{
			$('#click').text("下架");
		}
		
		if($('#click').text() == "下架")
		  {
				    $("#status").css("visibility","hidden");
				  };
			 if($('#click').text() == "上架")
		  {
				    $("#status").css("visibility","visible");
		      };
	});
	function show_confirm(path,id)
	{
		var href = path;
          	var click_id = "#click" + id;
		if($(click_id).text() == "下架")
		{
	var r=confirm("是否确认下架？");
		if (r==true)
			  	{
					alert("下架成功");
					$(click_id).text("上架");
					setTimeout( function(){window.location.href = href;} ,2000);
			 }
		else
				{
					alert("下架撤销");
					$(click_id).text("下架");
				}
		}
		else if($(click_id).text() == "上架")
		{
	var r=confirm("是否确认上架？");
		if (r==true)
			  	{
					alert("上架成功");
					$(click_id).text("下架");
					setTimeout( function(){window.location.href = href;} ,2000);

			 }
		else
				{
					alert("上架撤销");
			$(click_id).text("上架");

				}
		}
	}
	</script>
    
  <!--   <script src="/BookShopping/js/jquery-1.9.1.min.js"></script>
            <script type="application/javascript">
            $('#click').click(function(){
				if($('#click').text() == "下架"){
					$('#click').text("上架");
				}else{
					$('#click').text("下架");
				}
				
				if($('#click').text() == "下架")
				  {
  				    $("#status").css("visibility","hidden");
  				  };
 				 if($('#click').text() == "上架")
				  {
  				    $("#status").css("visibility","visible");
 			      };
			});

			function show_confirm()
			{
				if($('#click').text() == "下架")
				{
			var r=confirm("是否确认下架？");
				if (r==true)
  			  	{
  					alert("下架成功");
 				 }
				else
  				{
  					alert("下架撤销");
  				}
				}
				else if($('#click').text() == "上架")
				{
			var r=confirm("是否确认上架？");
				if (r==true)
  			  	{
  					alert("上架成功");
 				 }
				else
  				{
  					alert("上架撤销");
  				}
				}
			}
			</script> -->
</body>
</html>
 --%>