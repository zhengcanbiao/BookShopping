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
<title>修改商品</title>
<link href="/BookShopping/css/manager.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<style>
.right_block{
	position: relative;
	width: 600px;
	margin: auto;
	padding-top: 50px;
}
#form_dingdang input{
	height: 30px;
}
#form_dingdang select{
	width: 150px;
}
body{
	background-color:#eee;
}


#clothesname{ margin-left: 10px; }
#price{ margin-left: 10px; }
#sremainder{ margin-left: 23px; }
#producer{ margin-left: 37px; }
#material{ margin-left: 23px; }
#material_date{ margin-left: 10px; }
#first_category_dropdown{ margin-left: 23px; }
#subcategory_dropdown{ margin-left: 23px; }

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
			            <form id="form_dingdang" name="form2" method="post" action="/BookShopping/manager/ModifyBooksDetail.action" enctype="multipart/form-data">
			            	修改商品
			            	<button id="back" type="button" class="btn btn-success" style="float:right" onclick="to_back()">返回 </button>
				            <hr />
				            <input type="hidden" name="booksId" value="${requestScope['Books'].booksId }" />
				            <p/>商品名称:
							<input name="bookName" type="text" id="clothesname" value="${requestScope['Books'].bookName}"/><font size="2" color="#FF0000" id="a"> *必填项</font>
				            <p/>商品价格:
							<input name="price" type="text" id="price" value="<fmt:formatNumber value='${requestScope.Books.price/100.0}' pattern='#0.00'/>"/><font size="2" color="#FF0000" id="a" > *必填项</font>
				            <p/>库存量:
							<input name="remainder" type="text" id="sremainder" value="${requestScope['Books'].remainder}"/><font size="2" color="#FF0000" id="a" > *库存量三项必填一项</font>
				            <p/>作者:
							<input name="author" type="text" id="producer" value="${requestScope['Books'].author }"/>
				            <p/>出版社:
							<input name="publisher" type="text" id="material" value="${requestScope['Books'].publisher }"/>
							<p/>出版日期:
							<input name="publicationDate" type="text" id="material_date" value="${requestScope['Books'].publicationDate }"/>
							
				            <p/>父类别:
				            
				            <select id="first_category_dropdown" onchange="on_first_category_selected()">
				         	<option value="-1">---请选择父类别---</option>
				         	<c:forEach items="${applicationScope['topCategoryList'] }" var="category">
				         		<option <c:if test="${requestScope['Books'].tbCategory.parentId==category.categoryId }">selected="selected"</c:if> value="${category.categoryId }">${category.categoryName }</option>
				         	</c:forEach>
					         </select>
						    &nbsp;子类别: 
					         <select id="subcategory_dropdown" name="secondCategory">
				          	<option value="-1">---请选择子类别---</option>
				          	<c:forEach items="${requestScope['SubCategoryList'] }" var="subCategory">
				         		<option <c:if test="${requestScope['Books'].tbCategory.categoryId==subCategory.categoryId }">selected="selected"</c:if> value="${subCategory.categoryId }">${subCategory.categoryName }</option>
				         	</c:forEach>
				         	</select>
				
				            <p/>商品图片:&nbsp;&nbsp;&nbsp;
				            <img src="${requestScope['Books'].picUrl}" width="100px;" height="100px;"/>
				   			<input type="file" name="image" id="pic" accept="image/jpeg" /> 
				            <pre style="float:inherit; margin-bottom:5px;">商品介绍:
							<textarea style="float:left; margin-left:20px; height: 100px; width: 538px;" name="booksDescription" id="BooksDescription" class="introduce">${requestScope['Books'].booksDescription }</textarea>
				            </pre>
				            <input type="submit" class="btn btn-success" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;修改商品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" style="float:left; " />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				 			</form>
			            <br />
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
        function to_back(){
			window.location.href="/BookShopping/manager/PrepareBooks.action";
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
			if (r==true) {
				return true;
			} else {
				return false;
			}
		}
		function verify(remainder0, remainder1, remainder2)
		{
			if($('#clothesname').val().length<=0 || $('#clothesname').val().length>100)
			{
			   Alert("输入名称不符合规范，名字长度为1~100位");
			   $('#clothesname').focus();
			   return false;
			}
			else if($('#price').val()=="" || isNaN($('#price').val()))
			{
			   Alert("输入价格格式错误");
			   $('#price').focus();
			   return false;
			}
			else if($('#price').val()<=0)
			{
			   $('#price').val("0.01");
			   Alert("商品价格不合理");
			   $('#price').focus();
			   return false;
			}
			else if($('#price').val()>20000000.00)
			{
			   $('#price').val("20000000.00");
			   Alert("商品价格过大");
			   $('#price').focus();
			   return false;
			}
			else if($('#sremainder').val()=="" && $('#mremainder').val()=="" && $('#lremainder').val()=="")
			{
				Alert("必须有一种尺寸有商品库存量输入");
				$('#sremainder').focus();
				return false;
			}
			else if($('#sremainder').val()=="" && remainder0!="") {
				Alert("已经存在S尺寸商品了，请输入S尺寸商品库存");
				$('#sremainder').focus();
				return false;
			}
			else if($('#mremainder').val()=="" && remainder1!="") {
				Alert("已经存在M尺寸商品了，请输入M尺寸商品库存");
				$('#mremainder').focus();
				return false;
			}
			else if($('#lremainder').val()=="" && remainder2!="") {
				Alert("已经存在L尺寸商品了，请输入L尺寸商品库存");
				$('#lremainder').focus();
				return false;
			}
			else if($('#sremainder').val()!="" && isNaN($('#sremainder').val()) )
			{
				Alert("输入S尺寸格式错误");
				return false;
			}
			else if($('#mremainder').val()!="" && isNaN($('#mremainder').val()) )
			{
				Alert("输入M尺寸格式错误");
				return false;
			}
			else if($('#lremainder').val()!="" && isNaN($('#lremainder').val()) )
			{
				Alert("输入L尺寸格式错误");
				return false;
			}
			else if($('#sremainder').val()>2147483647)
			{
			   $('#sremainder').val("2147483647");
			   Alert("商品S尺寸库存输入过多");
			   $('#sremainder').focus();
			   return false;
			}
			else if($('#mremainder').val()>2147483647)
			{
			   $('#mremainder').val("2147483647");
			   Alert("商品M尺寸库存输入过多");
			   $('#mremainder').focus();
			   return false;
			}
			else if($('#lremainder').val()>2147483647)
			{
			   $('#lremainder').val("2147483647");
			   Alert("商品L尺寸库存输入过多");
			   $('#lremainder').focus();
			   return false;
			}
			else if($('#sremainder').val()<0)
			{
			   $('#sremainder').val("1");
			   Alert("商品S尺寸库存输入不合规范");
			   $('#sremainder').focus();
			   return false;
			}
			else if($('#mremainder').val()<0)
			{
			   $('#mremainder').val("1");
			   Alert("商品M尺寸库存输入不合规范");
			   $('#mremainder').focus();
			   return false;
			}
			else if($('#lremainder').val()<0)
			{
			   $('#lremainder').val("1");
			   Alert("商品L尺寸库存输入不合规范");
			   $('#lremainder').focus();
			   return false;
			}
			else if($('#sremainder').val()!="" && parseInt($('#sremainder').val())!=($('#sremainder').val()))
			{
				Alert("输入的S尺寸库存不是整数");
				return false;
			}
			else if($('#mremainder').val()!="" && parseInt($('#mremainder').val())!=($('#mremainder').val()))
			{
				Alert("输入的M尺寸库存不是整数");
				return false;
			}
			else if($('#lremainder').val()!="" && parseInt($('#lremainder').val())!=($('#lremainder').val()))
			{
				Alert("输入的L尺寸库存不是整数");
				return false;
			}
			else if( $('#sremainder').val().indexOf("+")>=0)
			{
				Alert("输入的S尺寸库存不能有+号");
				return false;
			}
			else if($('#mremainder').val().indexOf("+")>=0)
			{
				Alert("输入的M尺寸库存不能有+号");
				return false;
			}
			else if($('#lremainder').val().indexOf("+")>=0)
			{
				Alert("输入的L尺寸库存不能有+号");
				return false;
			}
			else if ($('#producer').val().length>100)
			{
				Alert("生厂商名称过长，请重新输入");
				return false;
			}
			else if ($('#material').val().length>100)
			{
				Alert("材质名称过长，请重新输入");
				return false;
			}
			else if ($('#BooksDescription').val().length>200)
			{
				Alert("输入的介绍过长，请重新输入");
				return false;
			}
			else if ($('#subcategory_dropdown').val()==-1)
			{
				Alert("请选择子类别");
				return false;
			}
			else if ($('#pic').val()!="" && $('#pic').val().indexOf(".jpg")<0 && $('#pic').val().indexOf(".JPG")<0) {
				Alert("图片格式只能为jpg");
				$('#pic').focus();
				return false;
			}
			 else
			 {
				Alert("修改成功");
				setTimeout( function(){$("[name=form2]").submit();} ,2000);
				return true;
			 }         
		}
	</script>

</body>
</html>





















<%-- <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>修改商品</title>
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

.introduce {
	height:80px;
}

.right_block {
	width:77%;
	margin-left:3%;
	float:left;
	line-height:16px;
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
        <img src="/BookShopping/img/logo_cut_30px.png"/>
        尊敬的管理员，Eshopping网上衣城  诚心感谢你的默默付出
       <form name="form1" method="post" action="/BookShopping/manager/ManagerLogout.action" enctype="multipart/form-data" onsubmit="return Confirm()">
        <input type="submit"  class="Button" value="注销" style="float:right; margin-top:-25px;"/>
        </form>
        </div><!-- 内容放在这里面 -->
    </div><!-- 头部 -->
    
    <div class="body">
    	<div class="container">
        	<div class="breadcrumb">
            管理系统首页-&gt;商品管理-&gt;添加商品
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
            <form name="form2" method="post" action="/BookShopping/manager/ModifyBooksDetail.action" enctype="multipart/form-data">
            修改商品
            <hr />
            <input type="hidden" name="booksId" value="${requestScope['Books'].booksId }" />
            <p/>商品名称:&nbsp;&nbsp;&nbsp;
			<input name="bookName" type="text" id="clothesname" value="${requestScope['Books'].bookName}"/><font size="2" color="#FF0000" id="a"> *必填项</font>
            <p/>商品价格:&nbsp;&nbsp;&nbsp;
			<input name="price" type="text" id="price" value="<fmt:formatNumber value='${requestScope.Books.price/100.0}' pattern='#0.00'/>"/><font size="2" color="#FF0000" id="a" > *必填项</font>
            <p/>库存量:
			<input name="remainder" type="text" id="sremainder" value="${requestScope['Books'].remainder}"/><font size="2" color="#FF0000" id="a" > *库存量三项必填一项</font>
            <p/>作者:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input name="author" type="text" id="producer" value="${requestScope['Books'].author }"/>
            <p/>出版社:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input name="publisher" type="text" id="material" value="${requestScope['Books'].publisher }"/>
			<p/>出版日期:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input name="publicationDate" type="text" id="material" value="${requestScope['Books'].publicationDate }"/>
			
            <p/>父类别:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            <select id="first_category_dropdown" onchange="on_first_category_selected()">
         	<option value="-1">---请选择父类别---</option>
         	<c:forEach items="${applicationScope['topCategoryList'] }" var="category">
         		<option <c:if test="${requestScope['Books'].tbCategory.parentId==category.categoryId }">selected="selected"</c:if> value="${category.categoryId }">${category.categoryName }</option>
         	</c:forEach>
         </select>
	    &nbsp;子类别: 
         <select id="subcategory_dropdown" name="secondCategory">
          	<option value="-1">---请选择子类别---</option>
          	<c:forEach items="${requestScope['SubCategoryList'] }" var="subCategory">
         		<option <c:if test="${requestScope['Books'].tbCategory.categoryId==subCategory.categoryId }">selected="selected"</c:if> value="${subCategory.categoryId }">${subCategory.categoryName }</option>
         	</c:forEach>
         </select>

            <p/>商品图片:&nbsp;&nbsp;&nbsp;
            <img src="${requestScope['Books'].picUrl}" width="100px;" height="100px;"/>
   			<input type="file" name="image" id="pic" accept="image/jpeg" /> 
            <pre style="float:inherit; margin-bottom:5px;">商品介绍:
			<textarea style="float:left; margin-left:90px; margin-top:-15px;" name="booksDescription" id="BooksDescription" class="introduce">${requestScope['Books'].booksDescription }</textarea>
            </pre>
            <br />
            <br />
            <br />
            <br />
            <input type="submit" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;修改商品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" style="float:left; margin-left:90px;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			</form>
            <form name="form3" method="post" action="/BookShopping/manager/PrepareBooks.action" enctype="multipart/form-data">
            <input type="submit" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;返回&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" style="float:left; margin-left:50px;margin-top:-14px;"/>
            </form>
            <br />
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
		if (r==true) {
			return true;
		} else {
			return false;
		}
	}
	function verify(remainder0, remainder1, remainder2)
	{
		if($('#clothesname').val().length<=0 || $('#clothesname').val().length>100)
		{
		   Alert("输入名称不符合规范，名字长度为1~100位");
		   $('#clothesname').focus();
		   return false;
		}
		else if($('#price').val()=="" || isNaN($('#price').val()))
		{
		   Alert("输入价格格式错误");
		   $('#price').focus();
		   return false;
		}
		else if($('#price').val()<=0)
		{
		   $('#price').val("0.01");
		   Alert("商品价格不合理");
		   $('#price').focus();
		   return false;
		}
		else if($('#price').val()>20000000.00)
		{
		   $('#price').val("20000000.00");
		   Alert("商品价格过大");
		   $('#price').focus();
		   return false;
		}
		else if($('#sremainder').val()=="" && $('#mremainder').val()=="" && $('#lremainder').val()=="")
		{
			Alert("必须有一种尺寸有商品库存量输入");
			$('#sremainder').focus();
			return false;
		}
		else if($('#sremainder').val()=="" && remainder0!="") {
			Alert("已经存在S尺寸商品了，请输入S尺寸商品库存");
			$('#sremainder').focus();
			return false;
		}
		else if($('#mremainder').val()=="" && remainder1!="") {
			Alert("已经存在M尺寸商品了，请输入M尺寸商品库存");
			$('#mremainder').focus();
			return false;
		}
		else if($('#lremainder').val()=="" && remainder2!="") {
			Alert("已经存在L尺寸商品了，请输入L尺寸商品库存");
			$('#lremainder').focus();
			return false;
		}
		else if($('#sremainder').val()!="" && isNaN($('#sremainder').val()) )
		{
			Alert("输入S尺寸格式错误");
			return false;
		}
		else if($('#mremainder').val()!="" && isNaN($('#mremainder').val()) )
		{
			Alert("输入M尺寸格式错误");
			return false;
		}
		else if($('#lremainder').val()!="" && isNaN($('#lremainder').val()) )
		{
			Alert("输入L尺寸格式错误");
			return false;
		}
		else if($('#sremainder').val()>2147483647)
		{
		   $('#sremainder').val("2147483647");
		   Alert("商品S尺寸库存输入过多");
		   $('#sremainder').focus();
		   return false;
		}
		else if($('#mremainder').val()>2147483647)
		{
		   $('#mremainder').val("2147483647");
		   Alert("商品M尺寸库存输入过多");
		   $('#mremainder').focus();
		   return false;
		}
		else if($('#lremainder').val()>2147483647)
		{
		   $('#lremainder').val("2147483647");
		   Alert("商品L尺寸库存输入过多");
		   $('#lremainder').focus();
		   return false;
		}
		else if($('#sremainder').val()<0)
		{
		   $('#sremainder').val("1");
		   Alert("商品S尺寸库存输入不合规范");
		   $('#sremainder').focus();
		   return false;
		}
		else if($('#mremainder').val()<0)
		{
		   $('#mremainder').val("1");
		   Alert("商品M尺寸库存输入不合规范");
		   $('#mremainder').focus();
		   return false;
		}
		else if($('#lremainder').val()<0)
		{
		   $('#lremainder').val("1");
		   Alert("商品L尺寸库存输入不合规范");
		   $('#lremainder').focus();
		   return false;
		}
		else if($('#sremainder').val()!="" && parseInt($('#sremainder').val())!=($('#sremainder').val()))
		{
			Alert("输入的S尺寸库存不是整数");
			return false;
		}
		else if($('#mremainder').val()!="" && parseInt($('#mremainder').val())!=($('#mremainder').val()))
		{
			Alert("输入的M尺寸库存不是整数");
			return false;
		}
		else if($('#lremainder').val()!="" && parseInt($('#lremainder').val())!=($('#lremainder').val()))
		{
			Alert("输入的L尺寸库存不是整数");
			return false;
		}
		else if( $('#sremainder').val().indexOf("+")>=0)
		{
			Alert("输入的S尺寸库存不能有+号");
			return false;
		}
		else if($('#mremainder').val().indexOf("+")>=0)
		{
			Alert("输入的M尺寸库存不能有+号");
			return false;
		}
		else if($('#lremainder').val().indexOf("+")>=0)
		{
			Alert("输入的L尺寸库存不能有+号");
			return false;
		}
		else if ($('#producer').val().length>100)
		{
			Alert("生厂商名称过长，请重新输入");
			return false;
		}
		else if ($('#material').val().length>100)
		{
			Alert("材质名称过长，请重新输入");
			return false;
		}
		else if ($('#BooksDescription').val().length>200)
		{
			Alert("输入的介绍过长，请重新输入");
			return false;
		}
		else if ($('#subcategory_dropdown').val()==-1)
		{
			Alert("请选择子类别");
			return false;
		}
		else if ($('#pic').val()!="" && $('#pic').val().indexOf(".jpg")<0 && $('#pic').val().indexOf(".JPG")<0) {
			Alert("图片格式只能为jpg");
			$('#pic').focus();
			return false;
		}
		 else
		 {
			Alert("修改成功");
			setTimeout( function(){$("[name=form2]").submit();} ,2000);
			return true;
		 }         
	}
	</script>
</body>
</html> --%>

