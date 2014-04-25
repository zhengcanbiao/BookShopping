<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="header">
	<div class="container">
		<div id="header1" >
			<c:if test="${empty sessionScope['currentNickName'] }">
				<p>欢迎来到网上书城</p>
		    </c:if>
		    <ul id="cart" >
		       	<a href="${applicationScope['basePath'] }/customer/PrepareCartItemList.action"><i class="icon-shopping-cart"> </i>购物车</a>
		    	<ul>
		    	</ul>
		    </ul>
		    <c:if test="${empty sessionScope['currentNickName'] }">
		        <a href="/BookShopping/login.jsp">登录/注册<br></a>
		    </c:if>
		    <c:if test="${not empty sessionScope['currentNickName'] }">
		            <p>Hi, ${sessionScope['currentNickName'] },欢迎来到书城</p>
		        	<ul  class="list-unstyled" id="zhanghu">
		                <a href="/BookShopping/customer/PreparePersonalHome.action">我的账户</a>
		                <ul>
	                            <li><a href="${applicationScope['basePath'] }/customer/PreparePersonalHome.action"><i class="icon-angle-right"> </i>个人主页</a></li>
	                            <li><a href="${applicationScope['basePath'] }/customer/PrepareOrderInfoList.action"><i class="icon-angle-right"> </i>我的订单</a></li>
	                            <li><a href="${applicationScope['basePath'] }/customer/PrepareFavorite.action"><i class="icon-angle-right"> </i>收藏夹</a></li>
                                <li><a href="${applicationScope['basePath'] }/customer/PrepareAddress.action"><i class="icon-angle-right"> </i>地址簿</a></li>
                                <li><a href="${applicationScope['basePath'] }/customer/PreparePersonalInfo.action"><i class="icon-angle-right"> </i>修改信息</a></li>
                                <li><a href="${applicationScope['basePath'] }/customer/RedirectToModifyPassword.action"><i class="icon-angle-right"> </i>修改密码</a></li>
                                <li><a href="${applicationScope['basePath'] }/customer/PrepareCredits.action"><i class="icon-angle-right"> </i>我的积分</a></li>
                                <li><a href="${applicationScope['basePath'] }/customer/Logout.action"><i class="icon-angle-right"> </i>退出登录</a></li>
	                    </ul>
		            </ul>
		     </c:if>
		</div>
		<div id="header2">
			<a href="/BookShopping/customer/RedirectToHome.action"><img src="/BookShopping/img/b_1.png" /></a>
		    <div id="search" >
		       <form class="navbar-search pull-left" action="SearchBooks.action?pageNow=1" method="get">
		            <input id="search_input" name="keyword" type="text" class="search-query" placeholder="Search" />
		       		<a href="#">搜索</a>   
		       </form>    
		    </div>		
		</div>
		<ul id="header3" class="nav nav-pills nav-justified">
					<li>
						<p> 所有商品 </p>
					</li>
		       <c:forEach items="${applicationScope['topCategoryList'] }" var="category">
		    		<li>
		           	<a href="${applicationScope['basePath']}/customer/PrepareBooksInfoList.action?categoryId=${category.categoryId }&pageNow=1">${category.categoryName }</a>
		               <ul id="category${category.categoryId }" class="catalog">
		               </ul>
		           	</li>
		       </c:forEach>
		</ul> 

	</div>
   </div>