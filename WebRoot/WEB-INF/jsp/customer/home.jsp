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
	<%@ include file="header.jsp" %>

    
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
					
					  <!-- Controls -->
<!-- 					  <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
					    <i class="icon-chevron-left"></i>
					  </a>
					  <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
					    <span class="icon-chevron-right"></span>
					  </a> -->
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
						            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][0][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['booksCategoryList'][0][i].picUrl }" width="120px" height="160px"/></a>		
											<div id="tuijian_content">
												<div id="bookname_item">
												<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][0][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][0][i].bookName }</p></a>
												</div>
												<h5>${requestScope['booksCategoryList'][0][i].author } 著/ ${requestScope['booksCategoryList'][0][i].publisher }</h5>	
												<h5> &yen;<span>${requestScope['booksCategoryList'][0][i].price/100.0 }</span> </h5>  
											</div>   
						            	</div>
					            		</c:if>
					            		
					            		<c:if test="${i < 5 && i > 0 }">
					            		<div class="item span20">
	  	 						            	<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][0][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['booksCategoryList'][0][i].picUrl }" width="60px" height="90px"/></a>	
 	  	 						            	<div id="bookname_items_1">
 	  	 						            		<div id="bookname_item_2">
														<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][0][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][0][i].bookName }</p></a>
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
						            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][1][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['booksCategoryList'][1][i].picUrl }" width="120px" height="160px"/></a>		
											<div id="tuijian_content">
												<div id="bookname_item">
												<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][1][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][1][i].bookName }</p></a>
												</div>
												<h5>${requestScope['booksCategoryList'][1][i].author } 著/ ${requestScope['booksCategoryList'][1][i].publisher }</h5>	
												<h5> &yen;<span>${requestScope['booksCategoryList'][1][i].price/100.0 }</span> </h5>  
											</div>   
						            	</div>
					            		</c:if>
					            		
					            		<c:if test="${i < 5 && i > 0 }">
					            		<div class="item span20">
	  	 						            	<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][1][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['booksCategoryList'][1][i].picUrl }" width="60px" height="90px"/></a>	
 	  	 						            	<div id="bookname_items_1">
 	  	 						            		<div id="bookname_item_2">
														<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][1][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][1][i].bookName }</p></a>
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
			            			<c:if test="${i < fn:length(requestScope['booksCategoryList'][0]) }">
					            	<div class="item span3">
					            		<c:if test="${i > 0 }">
					            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][0][i].booksId }"><p class="item-name"><strong>${i+1}.</strong>${requestScope['booksCategoryList'][0][i].bookName }</p></a>
										</c:if>
					            		<c:if test="${i < 1 }">
					            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][0][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['booksCategoryList'][0][i].picUrl }" width="60px" height="80px"/></a>	
					            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][0][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][0][i].bookName }</p></a>
					            		<h5 class="item-price">&yen;<span>${requestScope['booksCategoryList'][0][i].price/100.0 }</span></h5>
					            		</c:if>
					            	</div>
					            	</c:if>
			            		</c:forEach>   				
					</div>
					<div id="content_wenyi">
	 		            		<c:forEach begin="0" end="10" var="i" >
			            			<c:if test="${i < fn:length(requestScope['booksCategoryList'][1]) }">
					            	<div class="item span3">
					            		<c:if test="${i > 0 }">
					            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][1][i].booksId }"><p class="item-name"><strong>${i+1}.</strong>${requestScope['booksCategoryList'][1][i].bookName }</p></a>
										</c:if>
					            		<c:if test="${i < 1 }">
					            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][1][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['booksCategoryList'][1][i].picUrl }" width="60px" height="80px"/></a>	
					            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][1][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][1][i].bookName }</p></a>
					            		<h5 class="item-price">&yen;<span>${requestScope['booksCategoryList'][1][i].price/100.0 }</span></h5>
					            		</c:if>
					            	</div>
					            	</c:if>
			            		</c:forEach>   				
					</div>	
					<div id="content_jingying">
	 		            		<c:forEach begin="0" end="10" var="i" >
			            			<c:if test="${i < fn:length(requestScope['booksCategoryList'][2]) }">
					            	<div class="item span3">
					            		<c:if test="${i > 0 }">
					            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][2][i].booksId }"><p class="item-name"><strong>${i+1}.</strong>${requestScope['booksCategoryList'][2][i].bookName }</p></a>
										</c:if>
					            		<c:if test="${i < 1 }">
					            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][2][i].booksId }"><strong>${i+1}.</strong><img src="${requestScope['booksCategoryList'][2][i].picUrl }" width="60px" height="80px"/></a>	
					            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksInfoList.action?booksId=${requestScope['booksCategoryList'][2][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][2][i].bookName }</p></a>
					            		<h5 class="item-price">&yen;<span>${requestScope['booksCategoryList'][2][i].price/100.0 }</span></h5>
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
			            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][booksListIndex-1][i].booksId }"><img src="${requestScope['booksCategoryList'][booksListIndex-1][i].picUrl }" /></a>	
			            		<a href="${applicationScope['basePath'] }/customer/PrepareBooksDetail.action?booksId=${requestScope['booksCategoryList'][booksListIndex-1][i].booksId }"><p class="item-name">${requestScope['booksCategoryList'][booksListIndex-1][i].bookName }</p></a>
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
