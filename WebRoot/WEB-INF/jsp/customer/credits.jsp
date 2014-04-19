<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/EShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/eshopping.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/account.css" rel="stylesheet" media="screen" />
<title>我的积分</title>
</head>

<body>
	<%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">
        
        	<ul class="inline bread">
              <li><a href="/EShopping/customer/RedirectToHome.action">首页</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li><a href="/EShopping/customer/PreparePersonalHome.action">我的账户</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li class="active">我的积分</li>
            </ul>
        
        	<div class="row-fluid">
                <%@ include file="leftBar.jsp" %>
               
                <div class="span10">
                    <p class="myAccount_title">我的积分</p>
                    <div id="myCredits_block">
                    	<c:if test="${requestScope['currentLevel']==0 }">
                        	<p>当前等级: <span>0</span></p>
                        	<p>当前优惠: <span class="label label-warning">无</span></p>
                    	</c:if>
                    	<c:if test="${requestScope['currentLevel']!=0 }">
                    		<p>当前等级: <span>${requestScope["currentLevel"] }</span></p>
                        	<p>当前优惠: <span class="label label-warning">${applicationScope['discountList'][requestScope['currentLevel']].discountRate }折</span></p>
                    	</c:if>
                    	<p>当前积分: <span>${request['currentPoints'] }</span><span class="credits_next">距离下次升级还有${request['pointsToNextLevel'] }积分</span></p>
                    </div>
                   	
                    <p class="myAccount_title">积分优惠一览表</p>
                    <table  class="table table-striped">
                    	<tr>
                        	<th>等级</th>
                            <th>优惠</th>
                            <th>所需积分</th>
                        </tr>
                        
                        <c:forEach var="i" begin="1" end="${fn:length(applicationScope['discountList']) - 1 }">
                        	<tr>
                        		<td>${i }</td>
                        		<td>${applicationScope['discountList'][i].discountRate }折</td>
                        		<td>${applicationScope['discountList'][i].discountPoints }</td>
                        	</tr>
                        </c:forEach>

                    </table>
                </div>
            </div>
            
        </div>
        
    </div>
    
	<%@ include file="footer.jsp" %>
	
	<script type="application/javascript" src="/EShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/EShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/EShopping/js/account.js"></script>
	<script type="application/javascript" src="/EShopping/js/global.js"></script>
	<script type="application/javascript">
		$("#header3").css("visibility", "hidden");
	</script>
	
</body>
</html>
