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
        <img src="/EShopping/img/logo_cut_30px.png" />
        尊敬的管理员，Eshopping网上衣城  诚心感谢你的默默付出
        <form name="form1" method="post" action="/EShopping/manager/ManagerLogout.action" enctype="multipart/form-data" onsubmit="return Confirm()">
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
	
	销售量查询
	<a href="/EShopping/manager/Jump.action?jumpId=6" style="float:right">销售量趋势查询</a>
	<hr/>
    <form action="/EShopping/manager/PrepareSalesList.action" method="post"  onsubmit="return verify()">
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
    	<c:if test="${empty requestScope['clothesList'] }">
            	<h3>没有找到相应商品</h3>
            </c:if>
	    <c:forEach items="${requestScope['clothesList'] }" var="item" varStatus="status">
	    	<c:set var="index" value="${status.index }" />
	    	<tr>
	    		<td>${item.clothesId }</td>
	    		<td><a href="/EShopping/manager/PrepareClothesDetail.action?clothesId=${item.clothesId}">${item.clothesName }</a></td>
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
     <script src="/EShopping/js/jquery-1.9.1.min.js"></script>
     <script src="/EShopping/js/alert.js"></script>
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
    	 			url: "/EShopping/manager/GetSubcategoryList.action",
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
