<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="span2">
    <ul id="myAccount_list">
        <li><h4>我的账户</h4></li>
        <li><a href="${applicationScope['basePath'] }/customer/PreparePersonalHome.action"><i class="icon-home"> </i>个人主页</a></li>
        <li><a href="${applicationScope['basePath'] }/customer/PrepareOrderInfoList.action"><i class="icon-list"> </i>我的订单</a></li>
        <li><a href="${applicationScope['basePath'] }/customer/PrepareFavorite.action"><i class="icon-heart"> </i>收藏夹</a></li>
        <li><a href="${applicationScope['basePath'] }/customer/PrepareAddress.action"><i class="icon-truck"> </i>地址簿</a></li>
        <li><a href="${applicationScope['basePath'] }/customer/PreparePersonalInfo.action"><i class="icon-user"> </i>修改信息</a></li>
        <li><a href="${applicationScope['basePath'] }/customer/RedirectToModifyPassword.action"><i class="icon-lock"></i>修改密码</a></li>
        <li><a href="${applicationScope['basePath'] }/customer/PrepareCredits.action"><i class="icon-gift"> </i>我的积分</a></li>
    </ul>
</div>