<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/BookShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/bookshopping.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/item.css" rel="stylesheet" media="screen" />
<link href="/BookShopping/css/home.css" rel="stylesheet" media="screen" />
<title>首页</title>
</head>

<body>
<div id="home_header" class="header">
	<div class="container">
		<div id="header1">
			<c:if test="${empty sessionScope['currentNickName'] }">
				<p>欢迎来到网上书城</p>
		    </c:if>
		    <ul id="cart" >
		       	<a href="/BookShopping/customer/PrepareCartItemList.action"><i class="icon-shopping-cart"> </i>购物车</a>
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
	                            <li><a href="/BookShopping/customer/PreparePersonalHome.action"><i class="icon-angle-right"> </i>个人主页</a></li>
	                            <li><a href="/BookShopping/customer/PrepareOrderInfoList.action"><i class="icon-angle-right"> </i>我的订单</a></li>
	                            <li><a href="/BookShopping/customer/PrepareFavorite.action"><i class="icon-angle-right"> </i>收藏夹</a></li>
                                <li><a href="/BookShopping/customer/PrepareAddress.action"><i class="icon-angle-right"> </i>地址簿</a></li>
                                <li><a href="/BookShopping/customer/PreparePersonalInfo.action"><i class="icon-angle-right"> </i>修改信息</a></li>
                                <li><a href="/BookShopping/customer/RedirectToModifyPassword.action"><i class="icon-angle-right"> </i>修改密码</a></li>
                                <li><a href="/BookShopping/customer/PrepareCredits.action"><i class="icon-angle-right"> </i>我的积分</a></li>
                                <li><a href="/BookShopping/customer/Logout.action"><i class="icon-angle-right"> </i>退出登录</a></li>
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

    
    <div class="body">
    	
    	<div class="container">
			<div id="header4">
				<div id="header4_logo">
					<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
					  <!-- Indicators -->
					  <ol class="carousel-indicators">
					    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
					    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
					    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
					    <li data-target="#carousel-example-generic" data-slide-to="3"></li>
					  </ol>
					
					  <!-- Wrapper for slides -->
					  <div class="carousel-inner">
					    <div class="item active">
					      <img src="/BookShopping/img/logo1.png" width="300px" height="400px" alt="">
					    </div>
					    <div class="item">
					      <img src="/BookShopping/img/logo2.png" width="300px" height="400px" alt="">
					    </div>
					    <div class="item">
					      <img src="/BookShopping/img/logo3.png" width="300px" height="400px" alt="">
					    </div>	
					    <div class="item">
					      <img src="/BookShopping/img/logo4.png" width="300px" height="400px" alt="">
					    </div>						   				    					 
					  </div>
				</div>


				</div>
				<div id="tuijian">
	   				<div id="but">
	   					<strong>推荐榜</strong>
<!-- 		    			<button type="button" class="btn btn-info">新书推荐</button>
		    			<button type="button" class="btn btn-info">主编推荐</button> -->
		    			

						

						<ul class="nav nav-tabs">
						  <li class="active xinshu"><a href="#">新书推荐</a></li>
						  <li class="zhubian"><a href="#">主编推荐</a></li>
						</ul>


						
								    			
	    			</div>
	    			<div id="content_xinshu" style="display:inline">
	     	            		<c:forEach begin="0" end="10" var="i" >
			            			<c:if test="${i < fn:length(requestScope['booksCategoryList'][0]) }">
					            		<c:if test="${i < 1 }">
						            	<div class="item span1">
						            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][0][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['booksCategoryList'][0][i].picUrl }" width="120px" height="160px"/></a>		
											<div id="tuijian_content">
												<div id="bookname_item">
												<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][0][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][0][i].bookName }</p></a>
												</div>
												<h5>${requestScope['booksCategoryList'][0][i].author } 著/ ${requestScope['booksCategoryList'][0][i].publisher }</h5>	
												<h5> &yen;<span>${requestScope['booksCategoryList'][0][i].price/100.0 }</span> </h5>  
											</div>   
						            	</div>
					            		</c:if>
					            		
					            		<c:if test="${i < 5 && i > 0 }">
					            		<div class="item span20">
	  	 						            	<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][0][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['booksCategoryList'][0][i].picUrl }" width="60px" height="90px"/></a>	
 	  	 						            	<div id="bookname_items_1">
 	  	 						            		<div id="bookname_item_2">
														<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][0][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][0][i].bookName }</p></a>
 	  	 						            		</div>
													<h5> &yen;<span>${requestScope['booksCategoryList'][0][i].price/100.0 }</span> </h5>  
												</div>  		
					            		</div>
					            		</c:if>
					            	</c:if>
			            		</c:forEach>    		
	    			</div>
	    			<div id="content_zhubian">
	     	            		<c:forEach begin="0" end="10" var="i" >
			            			<c:if test="${i < fn:length(requestScope['booksCategoryList'][1]) }">
					            		<c:if test="${i < 1 }">
						            	<div class="item span1">
						            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][1][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['booksCategoryList'][1][i].picUrl }" width="120px" height="160px"/></a>		
											<div id="tuijian_content">
												<div id="bookname_item">
												<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][1][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][1][i].bookName }</p></a>
												</div>
												<h5>${requestScope['booksCategoryList'][1][i].author } 著/ ${requestScope['booksCategoryList'][1][i].publisher }</h5>	
												<h5> &yen;<span>${requestScope['booksCategoryList'][1][i].price/100.0 }</span> </h5>  
											</div>   
						            	</div>
					            		</c:if>
					            		
					            		<c:if test="${i < 5 && i > 0 }">
					            		<div class="item span20">
	  	 						            	<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][1][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['booksCategoryList'][1][i].picUrl }" width="60px" height="90px"/></a>	
 	  	 						            	<div id="bookname_items_1">
 	  	 						            		<div id="bookname_item_2">
														<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][1][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][1][i].bookName }</p></a>
 	  	 						            		</div>
													<h5> &yen;<span>${requestScope['booksCategoryList'][1][i].price/100.0 }</span> </h5>  
												</div>  		
					            		</div>
					            		</c:if>
					            	</c:if>
			            		</c:forEach>    		
	    			</div>	    			
				</div>
				<div id="xiaoshou">
	    			<div id="but">
	    				<strong>销售榜</strong>
<!-- 		    			<button type="button" class="btn btn-info">总榜</button>
		    			<button type="button" class="btn btn-info">小说</button>
		    			<button type="button" class="btn btn-info">经管</button> -->
						<ul class="nav nav-tabs">
						  <li class="active zongbang"><a href="#">总榜</a></li>
						  <li class="wenyi"><a href="#">文艺</a></li>
						  <li class="jingying"><a href="#">经管</a></li>
						</ul>		    	
	    			</div>
					<div id="content_zongbang" style="display:inline">
	 		            		<c:forEach begin="0" end="10" var="i" >
			            			<c:if test="${i < fn:length(requestScope['zongbangBooksList1']) }">
					            	<div class="item span3">
					            		<c:if test="${i > 0 }">
					            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['zongbangBooksList1'][i].booksId }"><p class="item-name"><strong>${i+1}.</strong>${requestScope['zongbangBooksList1'][i].bookName }</p></a>
										</c:if>
					            		<c:if test="${i < 1 }">
					            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['zongbangBooksList1'][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['zongbangBooksList1'][i].picUrl }" width="60px" height="80px"/></a>	
					            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['zongbangBooksList1'][i].booksId }"><p class="item-name">${requestScope['zongbangBooksList1'][i].bookName }</p></a>
					            		<br>
					            		<h5 class="item-price">&yen;<span>${requestScope['zongbangBooksList1'][i].price/100.0 }</span></h5>
					            		</c:if>
					            	</div>
					            	</c:if>
			            		</c:forEach>   				
					</div>
					<div id="content_wenyi">
	 		            		<c:forEach begin="0" end="10" var="i" >
			            			<c:if test="${i < fn:length(requestScope['wenyiBooksList']) }">
					            	<div class="item span3">
					            		<c:if test="${i > 0 }">
					            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['wenyiBooksList'][i].booksId }"><p class="item-name"><strong>${i+1}.</strong>${requestScope['wenyiBooksList'][i].bookName }</p></a>
										</c:if>
					            		<c:if test="${i < 1 }">
					            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['wenyiBooksList'][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['wenyiBooksList'][i].picUrl }" width="60px" height="80px"/></a>	
					            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['wenyiBooksList'][i].booksId }"><p class="item-name">${requestScope['wenyiBooksList'][i].bookName }</p></a>
					            		<br>
					            		<h5 class="item-price">&yen;<span>${requestScope['wenyiBooksList'][i].price/100.0 }</span></h5>
					            		</c:if>
					            	</div>
					            	</c:if>
			            		</c:forEach>   				
					</div>	
					<div id="content_jingying">
	 		            		<c:forEach begin="0" end="10" var="i" >
			            			<c:if test="${i < fn:length(requestScope['jinguanBooksList']) }">
					            	<div class="item span3">
					            		<c:if test="${i > 0 }">
					            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['jinguanBooksList'][i].booksId }"><p class="item-name"><strong>${i+1}.</strong>${requestScope['jinguanBooksList'][i].bookName }</p></a>
										</c:if>
					            		<c:if test="${i < 1 }">
					            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['jinguanBooksList'][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['jinguanBooksList'][i].picUrl }" width="60px" height="80px"/></a>	
					            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['jinguanBooksList'][i].booksId }"><p class="item-name">${requestScope['jinguanBooksList'][i].bookName }</p></a>
					            		<br>
					            		<h5 class="item-price">&yen;<span>${requestScope['jinguanBooksList'][i].price/100.0 }</span></h5>
					            		</c:if>
					            	</div>
					            	</c:if>
			            		</c:forEach>   				
					</div>									
				</div>
			</div>	

        	
            <c:forEach begin="1" end="${fn:length(requestScope['booksCategoryList']) }" var="booksListIndex">
            <c:if test="${not empty requestScope['booksCategoryList'][booksListIndex-1] }">
            <div class="home-item-block">
            	<legend>${applicationScope['topCategoryList'][booksListIndex-1].categoryName }</legend>
	    	    <c:forEach begin="0" end="${(fn:length(requestScope['booksCategoryList'][booksListIndex-1])-1)/4 }" var="index">
	    	    <!-- 除以4就是4列 -->
	            	<div class="row-fluid item-list">
	            		<c:forEach begin="${(index)*4 }" end="${(index)*4+3 }" var="i" >
	            			<c:if test="${i < fn:length(requestScope['booksCategoryList'][booksListIndex-1]) }">
			            	<div class="item span3">
			            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][booksListIndex-1][i].booksId }"><img src="${requestScope['booksCategoryList'][booksListIndex-1][i].picUrl }" /></a>	
			            		<a href="/BookShopping/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][booksListIndex-1][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][booksListIndex-1][i].bookName }</p></a>
			            		<h5 class="item-price">&yen;<span>${requestScope['booksCategoryList'][booksListIndex-1][i].price/100.0 }</span></h5>
			            	</div>
			            	</c:if>
	            		</c:forEach>
	            	</div>
	           	</c:forEach>
            </div>
            </c:if>
            </c:forEach>

        </div>
        
    </div>
    
	<%@ include file="footer.jsp" %>
	
	<script type="application/javascript" src="/BookShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/BookShopping/js/bootstrap.js"></script>
	<script type="application/javascript" src="/BookShopping/js/global.js"></script> 
</body>
</html>
