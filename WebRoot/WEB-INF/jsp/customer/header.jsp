
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="header">
	<div class="navbar navbar-fixed-top">
    	<div class="navbar-inner">
        	<div class="container">
               
           	<ul class="nav">
               	<li id="logo">
                   	<a href="${applicationScope['basePath'] }/customer/RedirectToHome.action"><img src="/BookShopping/img/logo_cut_30px.png" /></a>
                   </li>
                   
                   <c:forEach items="${applicationScope['topCategoryList'] }" var="category">
                		<li>
	                   	<a href="${applicationScope['basePath']}/customer/PrepareBooksInfoList.action?categoryId=${category.categoryId }&pageNow=1">${category.categoryName }</a>
	                       <ul id="category${category.categoryId }" class="catalog">
	                       </ul>
	                   	</li>
                   </c:forEach>
                   
                   <li id="search">
                   	<form class="navbar-search pull-left" action="SearchClothes.action?pageNow=1" method="get">
                       	<input id="search_input" name="keyword" type="text" class="search-query" placeholder="Search" />
                    </form>
                   </li>
                   
                   	<c:if test="${empty sessionScope['currentNickName'] }">
	                   	<li id="myAccount_login">
	                   		<a href="/BookShopping/login.jsp">登录/注册<br></a>
	                   	</li>
                   	</c:if>
	                       
	                <c:if test="${not empty sessionScope['currentNickName'] }">
	                	<li id="myAccount">
	                        <a href="/BookShopping/customer/PreparePersonalHome.action">Hi, ${sessionScope['currentNickName'] }<br />
										我的账户</a>
	                        <ul>
	                            <li>
	                            	<li><a href="${applicationScope['basePath'] }/customer/PreparePersonalHome.action"><i class="icon-angle-right"> </i>个人主页</a></li>
	                            	<li><a href="${applicationScope['basePath'] }/customer/PrepareOrderInfoList.action"><i class="icon-angle-right"> </i>我的订单</a></li>
	                            	<li><a href="${applicationScope['basePath'] }/customer/PrepareFavorite.action"><i class="icon-angle-right"> </i>收藏夹</a></li>
	                                <li><a href="${applicationScope['basePath'] }/customer/PrepareAddress.action"><i class="icon-angle-right"> </i>地址簿</a></li>
	                                <li><a href="${applicationScope['basePath'] }/customer/PreparePersonalInfo.action"><i class="icon-angle-right"> </i>修改信息</a></li>
	                                <li><a href="${applicationScope['basePath'] }/customer/RedirectToModifyPassword.action"><i class="icon-angle-right"> </i>修改密码</a></li>
	                                <li><a href="${applicationScope['basePath'] }/customer/PrepareCredits.action"><i class="icon-angle-right"> </i>我的积分</a></li>
	                                <li><a href="${applicationScope['basePath'] }/customer/Logout.action"><i class="icon-angle-right"> </i>退出登录</a></li>
	                            </li>
	                        </ul>
                        </li>
                   </c:if>
                   
                   
                   <li id="cart">
                   		<a href="${applicationScope['basePath'] }/customer/PrepareCartItemList.action"><i class="icon-shopping-cart"> </i>购物车</a>
                		<ul>
                		</ul>
                   </li>
               </ul>
               </div>
           </div>
        </div>
   </div>