<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>

<!DOCTYPE html> <!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]--> <!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]--> <!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->

<!-- BEGIN HEAD -->
<head>
    <title><sitemesh:title/></title>
    <%@include file="/WEB-INF/views/include/head.jsp" %>
    <sitemesh:head/>
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body class="page-header-static page-sidebar-closed-hide-logo page-content-white">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-static-top">
    <!-- BEGIN HEADER INNER -->
    <div class="page-header-inner">
        <!-- BEGIN LOGO -->
        <div class="page-logo" style="width: 260px;">
            <a href="${ctx}/">
                <span style="line-height: 46px;" class="font-lg logo-default">${shop:shopName('productName')}</span>
            </a>
            <div class="menu-toggler sidebar-toggler"> </div>
        </div>
        <!-- END LOGO -->

        <!-- BEGIN RESPONSIVE MENU TOGGLER -->
        <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>
        <!-- END RESPONSIVE MENU TOGGLER -->

        <!-- BEGIN TOP NAVIGATION MENU -->
        <div class="top-menu">
            <ul class="nav navbar-nav pull-right">
                <li class="dropdown dropdown-extended dropdown-notification" style="display: ${fns:isNewestVersion()?'none':'inline-block'};">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                        <i class="icon-bell"></i>
                        <span class="badge badge-default"> 1 </span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="external">
                            <h3> 通知 </h3>
                        </li>
                        <li>
                            <ul class="dropdown-menu-list scroller order-remind-wrap" style="height: 55px;" data-handle-color="#637283">
                                <li style="width:100%;display: ${fns:isNewestVersion()?'none':'block'};">
                                    <a href="${ctx}/version/versionInfo/listing" >
                                        <span class="details" >
                                        <i class="font-blue fa fa-circle"></i>
                                        发现系统新版本.
                                        </span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li class="dropdown dropdown-user">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                        <c:choose>
                            <c:when test="${not empty fns:getUser().photo}">
                                <img alt="" class="img-circle" src="${fns:getUser().photo}" />
                            </c:when>
                            <c:otherwise>
                                <img alt="" class="img-circle" src="${cdn}/metronic/4.5.2/assets/layouts/layout/img/avatar.png" />
                            </c:otherwise>
                        </c:choose>
                        <span class="username username-hide-on-mobile"> 您好, ${fns:getUser().name} </span> <i class="fa fa-angle-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-default">
                        <li>
                            <a href="${ctx}/sys/user/info"> <i class="icon-user"></i> 个人信息 </a>
                        </li>
                        <li>
                            <a href="${ctx}/sys/user/modifyPwd"> <i class="icon-lock-open"></i> 修改密码 </a>
                        </li>
                        <li>
                            <a href="${ctx}/oa/oaNotify/self"> <i class="icon-bell"></i> 我的通知 </a>
                        </li>
                    </ul>
                </li>
                <!-- END USER LOGIN DROPDOWN -->

                <!-- BEGIN QUICK SIDEBAR TOGGLER -->
                <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                <li class="dropdown dropdown-quick-sidebar-toggler">
                    <a href="${ctx}/logout" class="dropdown-toggle">
                        <i class="icon-logout"></i>
                    </a>
                </li>
                <!-- END QUICK SIDEBAR TOGGLER -->
            </ul>
        </div>
        <!-- END TOP NAVIGATION MENU -->
    </div>
    <!-- END HEADER INNER -->
</div>
<!-- END HEADER -->

<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"> </div>
<!-- END HEADER & CONTENT DIVIDER -->
<sitemesh:body/>
</body>
<!-- END BODY-->

</html>