<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/EShopping/css/bootstrap.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/font-awesome.min.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/flat-button.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/eshopping.css" rel="stylesheet" media="screen" />
<link href="/EShopping/css/account.css" rel="stylesheet" media="screen" />
<title>个人信息</title>
</head>

<body>
	<%@ include file="header.jsp" %>
    
    <div class="body">
    	
    	<div class="container">
        
        	<ul class="inline bread">
              <li><a href="/EShopping/customer/RedirectToHome.action">首页</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li><a href="#">我的账户</a></li>
              <li><i class="icon-angle-right"> </i></li>
              <li class="active">修改信息</li>
            </ul>
        
        	<div class="row-fluid">
        		<%@ include file="leftBar.jsp" %>
           
                <div class="span10">
                	<s:actionerror />
                    <p class="myAccount_title">个人信息</p>
                    
                    <form id="personal_info_form" action="ModifyPersonalInfo.action" class="form-horizontal" method="post" onSubmit="return personal_submit()">
                        
                        <div class="control-group">
                            <label for="input_nickname" class="control-label">昵称</label>
                            <div class="controls">
                                <input id="input_nickname" name="nickName" type="text" placeholder="" value="${requestScope['nickName'] }" /><span id="nickname_span" class="label label-important"></span>
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label for="input_sex" class="control-label">性别</label>
                            <div class="controls">
                            	<label class="radio inline">
                                	<input name="sex" type="radio" value="0" <c:if test="${requestScope['sex']==0}">checked="checked"</c:if> />保密
                                </label>
                                <label class="radio inline">
                                	<input name="sex" type="radio" value="1" <c:if test="${requestScope['sex']==1}">checked="checked"</c:if> />男
                                </label>
                                <label class="radio inline">
                                	<input name="sex" type="radio" value="2" <c:if test="${requestScope['sex']==2}">checked="checked"</c:if> />女
                                </label>
                                <label class="radio inline">
                                	<input name="sex" type="radio" value="3" <c:if test="${sessionScope['sex']==3}">checked="checked"</c:if> />其他
                                </label>
                            </div>
                        </div>
      
                        <div class="controls">
                            <input type="submit" value="保存修改" class="btn" />
                        </div>
                	</form>
                    
                </div>
            
            </div>
            
        </div>
        
    </div>
    
	<%@ include file="footer.jsp" %>

	<script type="application/javascript" src="/EShopping/js/jquery-1.9.1.min.js"></script>
    <script type="application/javascript" src="/EShopping/js/bootstrap.js"></script>
    <script type="application/javascript" src="/EShopping/js/account.js"></script>
    <script type="application/javascript" src="/EShopping/js/check.js"></script>
	<script type="application/javascript" src="/EShopping/js/global.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(e) {
			personal_check();
		});
	</script>
	
</body>
</html>
