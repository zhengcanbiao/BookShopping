<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="header">
	<div class="container">
		<div id="header1">
			<c:if test="${empty sessionScope['currentNickName'] }">
				<p>欢迎来到网上书城</p>
		        <a href="/BookShopping/login.jsp">登录/注册<br></a>
		    </c:if>
		    <ul id="cart" >
		       	<a href="${applicationScope['basePath'] }/customer/PrepareCartItemList.action"><i class="icon-shopping-cart"> </i>购物车</a>
		    	<ul>
		    	</ul>
		    </ul>
		    <c:if test="${not empty sessionScope['currentNickName'] }">
		            <p>Hi, ${sessionScope['currentNickName'] },欢迎来到书城</p>
		        	<ul  class="list-unstyled">
		                <a href="/BookShopping/customer/PreparePersonalHome.action">我的账户</a>
		            </ul>
		     </c:if>
		</div>
		<div id="header2">
			<a href="/BookShopping/customer/RedirectToHome.action"><img src="/BookShopping/img/b_1.png" /></a>
		    <div id="search" >
		       <form class="navbar-search pull-left" action="SearchBooks.action?pageNow=1" method="get">
		            <input id="search_input" name="keyword" type="text" class="search-query" placeholder="Search" />
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