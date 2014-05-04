<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>添加商品</title>
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
<s:actionerror/>
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
            <li><a href="/BookShopping/manager/PrepareClothes.action">商品管理</a></li>
            <li><a href="/BookShopping/manager/PrepareOrder.action">订单管理</a></li>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=6">销售量统计</a></li>
            <li><a href="/BookShopping/manager/PrepareCustomer.action">会员管理</a></li>
            <li><a href="/BookShopping/manager/Jump.action?jumpId=4">折扣管理</a></li>
            </ul>
            </div><!-- 左边部分 -->
            
            <div class="right_block">
            <form name="form2" method="post" action="/BookShopping/manager/AddBooksDetail.action" enctype="multipart/form-data">
            添加商品
            <hr />
            <p/>商品名称:&nbsp;&nbsp;&nbsp;
			<input name="bookName" type="text" id="clothesname" /><font size="2" color="#FF0000" id="a"> *必填项</font>
            <p/>商品价格:&nbsp;&nbsp;&nbsp;
			<input name="price" type="text" id="price" /><font size="2" color="#FF0000" id="a" > *必填项</font>
            <p/>库存量:
			<input name="remainder" type="text" id="sremainder" /><font size="2" color="#FF0000" id="a" > *库存量三项必填一项</font>
            <p/>作者:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input name="author" type="text" id="producer" />
            <p/>出版社:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input name="publisher" type="text" id="material" />
			<p/>出版日期:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input name="publicationDate" type="text" id="material" />
			
            <p/>父类别:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select id="first_category_dropdown"  name="firstCategory" onchange="on_first_category_selected()">
	         	<option value="-1">---请选择父类别---</option>
	         	<c:forEach items="${applicationScope['topCategoryList'] }" var="category">
	         		<option value="${category.categoryId }">${category.categoryName }</option>
	         	</c:forEach>
	         </select> 
	          子类别: <select id="subcategory_dropdown" name="categoryId">
	          	<option value='-1' >---请选择子类别---</option>
	          </select>

            <p/>商品图片:&nbsp;&nbsp;&nbsp;
   			<input type="file" name="image" id="pic" accept="image/jpeg" /> 
   			<font size="2" color="#FF0000" id="a" style="float:right; margin-right:400px; margin-top:-20px;"> *必选项</font>
            <pre style="float:inherit; margin-bottom:5px;">商品介绍:
			<textarea style="float:left; margin-left:90px; margin-top:-15px;"name="booksDescription" id="ClothesDescription" class="introduce"></textarea>
            </pre>
            <br/>
            <br/>
            <br/>
            <br/>
            <input type="submit" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;添加商品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" style="float:left; margin-left:90px;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			</form>
            <form name="form3" method="post" action="/BookShopping/manager/PrepareClothes.action" enctype="multipart/form-data">
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
		if (r==true)
		{
			return true;
		 }
		else
		{
			return false;
		}
	}
	function verify()
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
		else if($('#sremainder').val()==""&&$('#mremainder').val()==""&&$('#lremainder').val()=="")
		{
			Alert("必须有一种尺寸有商品库存量输入");
			$('#sremainder').focus();
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
		else if ($('#ClothesDescription').val().length>200)
		{
			Alert("输入的介绍过长，请重新输入");
			return false;
		}
		else if ($('#subcategory_dropdown').val()==-1)
		{
			Alert("请选择子类别");
			return false;
		}
		else if ($('#pic').val()=="") {
			Alert("请选择图片");
			$('#pic').focus();
			return false;
		}
		else if ($('#pic').val().indexOf(".jpg")<0 && $('#pic').val().indexOf(".JPG")<0) {
			Alert("图片格式只能为jpg");
			$('#pic').focus();
			return false;
		}
		 else
		 {
			Alert("添加成功");
			setTimeout( function(){$("[name=form2]").submit();} ,2000);
			return true;
		 }         
	}
	</script>
</body>
</html>


<%-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'addClothes.jsp' starting page</title>
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
    <h2>添加商品</h2>
    <form action="AddClothesDetail.action" method="post" enctype="multipart/form-data" >
    <p>商品名称: <input name="clothesName" type="text" > <br>
	         价格: <input name="price" type="text" > <br> 
             尺寸库存量：0<input name="remainder0" type="text"/>
    		&nbsp;&nbsp;&nbsp;
    		1<input name="remainder1" type="text"/>
    		&nbsp;&nbsp;&nbsp;
    		2<input name="remainder2" type="text"/>
	         <br>生产商: <input name="producer" type="text" > <br>
	         材质: <input name="material" type="text" > <br>
	         父类别: <select id="first_category_dropdown"  name="firstCategory" onChange="on_first_category_selected()">
	         	<option value="-1">---请选择父类别---</option>
	         	<c:forEach items="${applicationScope['topCategoryList'] }" var="category">
	         		<option value="${category.categoryId }">${category.categoryName }</option>
	         	</c:forEach>
	         	 </select>   
	         <option value="${requestScope['firstCategoryList'].get(0).getCategoryName() }" selected>${requestScope['firstCategoryList'].get(0).getCategoryName() }</option>                                             
             <option value="${requestScope['firstCategoryList'].get(1).getCategoryName() }" >${requestScope['firstCategoryList'].get(1).getCategoryName() }</option>  
             <option value="${requestScope['firstCategoryList'].get(2).getCategoryName() }" >${requestScope['firstCategoryList'].get(2).getCategoryName() }</option> 
             <option value="${requestScope['firstCategoryList'].get(3).getCategoryName() }" >${requestScope['firstCategoryList'].get(3).getCategoryName() }</option> 
	          子类别: <select id="subcategory_dropdown" name="categoryId">
	          	<option value='-1' >---请选择父类别---</option>
	          </select>
	         商品介绍: <input name="booksDescription" type="text" > <br>
	          商品图片: <input type="file" name="image"><br>
	          <input type="submit" value="提交" />
    		  <input type="reset" value="重置" />
	 </form>
	 <!-- <input class="pop" />
	 <input class="pop" /> -->
	 <!-- ".pop" -->
	 <script type="text/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
	 <script type="text/javascript">
	 	function on_first_category_selected() {
	 		var firstCategoryId = $("#first_category_dropdown").val();
	 		$.ajax({
	 			url: "/BookShopping/GetSubcategoryList.action",
	 			type: "GET",
	 			contextType: "application/json;charset=utf-8",
	 			data: {parentId: firstCategoryId},
	 			dataType: "json",
	 			success: function(result) {
	 				$('#subcategory_dropdown').empty();
	 				$('#subcategory_dropdown').append("<option value='-1'>---请选择父类别---</option>");
	 				var resultJson = eval(result);
	 				$.each(resultJson, function(index, item) {
	 					$('#subcategory_dropdown').append("<option value="+ item.categoryId +">" + item.categoryName + "</option>");
	 				});
	 			}
	 		});
	 	}
	 	
	 </script>
  </body>
</html>
 --%>