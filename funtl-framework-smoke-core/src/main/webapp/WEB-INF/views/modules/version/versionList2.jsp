<%--
  ~ /*
  ~   @copyright 		Copyright © 2016 - 2020. [相关部门] All rights reserved.
  ~   @project   		script - funtl-framework-ssm-admin
  ~   @file      		versionList.jsp
  ~   @author    		warne
  ~   @date      		16-12-1 上午5:18
  ~
  ~   @lastModifie 		16-12-1 上午1:49
  ~  */
  --%>

<%--
  Created by IntelliJ IDEA.
  User: KXYL
  Date: 2016/11/30
  Time: 19:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html> <!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]--> <!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]--> <!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->

<!-- BEGIN HEAD -->
<head>
    <title>${shop:shopTitle('productName')}</title>
    <meta name="decorator" content="default"/>
    <style type="text/css">
        ul>.mt-list-item {
            padding-right: 0px !important
        }
        .mt-element-list .list-todo.mt-list-container ul>.mt-list-item>.list-todo-item:after {
            border: none;
        }
        .mt-list-item>.list-todo-item {
            width: 95% !important;
        }
        .mt-element-list .list-todo.mt-list-container ul>.mt-list-item>.list-todo-item .task-list .task-list-item>.task-content>h4,ul {
            font-size: 13px !important;
        }
        .mt-element-list .list-todo.mt-list-container ul>.mt-list-item{
            padding: 0 6px 0 6px !important;
        }
        .current {
            color: red;
            font-weight: 700;
        }
        .version-click-bg{
            background-color: #EEF1F5 !important;
            color: black !important;
            border-radius: 5px;
        }
        li.mt-list-item{
            border-bottom: 1px dashed #DEE5EC !important;
        }
        div.list-toggle:hover{
            background-color: #DEE5EC !important;
        }
    </style>
</head>
<!-- END HEAD -->

<body class="page-header-static page-sidebar-closed-hide-logo page-content-white">
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <sys:sidebar navItemName="系统设置" subMenuName="关于商城" />

    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <!-- BEGIN CONTENT BODY -->
        <div class="page-content">
            <!-- BEGIN PAGE HEADER-->

            <!-- BEGIN PAGE BAR -->
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li>
                        <a href="${ctx}/">首页</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>系统设置</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 系统版本列表<small></small></h3>
            <!-- END PAGE TITLE-->
            <!-- END PAGE HEADER-->
            <div class="row">
                <div class="col-mod-12">
                    <div class="portlet light portlet-fit bordered">
                        <div class="portlet-body">
                            <div class="mt-element-list">
                                <div class="mt-list-container list-todo" style="border: none;">
                                    <div class="list-todo-line"></div>
                                    <ul >
                                        <c:forEach items="${versions}" var="v" varStatus="p">
                                            <c:choose>
                                                <c:when test="${p.index eq 0}">
                                                    <li class="mt-list-item" >
                                                        <div class="list-todo-icon bg-white">
                                                                <%--<i class="fa fa-database"></i>--%>
                                                            <i class="fa fa-stack-exchange"></i>
                                                        </div>
                                                        <div class="list-todo-item">
                                                            <a class="list-toggle-container font-white" data-toggle="collapse" href="#task-${p.index}" aria-expanded="true">
                                                                <div class="list-toggle done uppercase version-click-bg well font-red-mint" title="点击展开或收起"
                                                                     style="padding: 3px 10px 3px 10px;color: black;">
                                                                    <div class="list-toggle-title ${v.currentVersion}" style="width:35%;padding-left: 10px;">
                                                                        版本：${v.exVerNo} &nbsp;&nbsp; <fmt:formatDate value="${v.releaseTime}" type="both"/>  发布
                                                                    </div>
                                                                    <div style="width: 25%;display: inline-block;color: red;">&nbsp;</div>
                                                                    <div style="display: inline-block;">
                                                                        <%--<button id="now-update-version" class="btn sbold uppercase btn-outline red-mint">--%>
                                                                        <button id="now-update-version" class="btn blue">
                                                                            立即更新
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </a>
                                                            <div class="task-list panel-collapse collapse in" id="task-${p.index}" style="border: 0px;" aria-expanded="true">
                                                                <ul>
                                                                    <li class="task-list-item" >
                                                                        <div class="task-icon">
                                                                            <a href="javascript:;">
                                                                                    <%--<i class="fa fa-table"></i>--%>
                                                                                <i class="fa fa-map-signs"></i>
                                                                            </a>
                                                                        </div>
                                                                        <div class="task-content">
                                                                            <h4 class="uppercase">
                                                                                <a href="javascript:;" title="新功能">新增功能</a>
                                                                            </h4>
                                                                            <ul >
                                                                                <li>${v.verFeature}</li>
                                                                            </ul>
                                                                        </div>
                                                                    </li>
                                                                    <li class="task-list-item">
                                                                        <div class="task-icon">
                                                                            <a href="javascript:;">
                                                                                    <%--<i class="fa fa-pencil"></i>--%>
                                                                                <i class="fa fa-bug"></i>
                                                                            </a>
                                                                        </div>
                                                                        <div class="task-content">
                                                                            <h4 class="uppercase ">
                                                                                <a href="javascript:;" title="优化系统">系统优化</a>
                                                                            </h4>
                                                                            <ul >
                                                                                <li>${v.verFixbug}</li>
                                                                            </ul>
                                                                        </div>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </c:when>
                                                <c:when test="${p.index ne 0 }">
                                                    <li class="mt-list-item" >
                                                        <div class="list-todo-icon bg-white">
                                                                <%--<i class="fa fa-database"></i>--%>
                                                            <i class="fa fa-stack-exchange"></i>
                                                        </div>
                                                        <div class="list-todo-item">
                                                            <a class="list-toggle-container font-white collapsed" data-toggle="collapse" href="#task-${p.index}" aria-expanded="false">
                                                                <div class="list-toggle done uppercase version-click-bg" title="点击展开或收起"
                                                                     style="padding: 3px 10px 3px 10px;color: black;">
                                                                    <div class="list-toggle-title" style="padding-left: 10px;width: 35%;">
                                                                        <span class="${v.currentVersion}">版本： ${v.exVerNo}</span> &nbsp;&nbsp;
                                                                            <fmt:formatDate value="${v.releaseTime}" type="both"/>  发布
                                                                    </div>
                                                                    <div style="width: 25%;display: inline-block">&nbsp;</div>
                                                                    <div style="display: inline-block;">
                                                                        <button id="now-rollback-version" class="btn default" disabled>
                                                                            立即回退
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </a>
                                                            <div class="task-list panel-collapse collapse" id="task-${p.index}" style="border: 0px;">
                                                                <ul>
                                                                    <li class="task-list-item" >
                                                                        <div class="task-icon">
                                                                            <a href="javascript:;">
                                                                                <i class="fa fa-map-signs"></i>
                                                                            </a>
                                                                        </div>
                                                                        <div class="task-content">
                                                                            <h4 class="uppercase">
                                                                                <a href="javascript:;" title="新功能">新增功能</a>
                                                                            </h4>
                                                                            <ul >
                                                                                <li>${v.verFeature}</li>
                                                                            </ul>
                                                                        </div>
                                                                    </li>
                                                                    <li class="task-list-item">
                                                                        <div class="task-icon">
                                                                            <a href="javascript:;">
                                                                                <i class="fa fa-bug"></i>
                                                                            </a>
                                                                        </div>
                                                                        <div class="task-content">
                                                                            <h4 class="uppercase">
                                                                                <a href="javascript:;" title="优化系统">系统优化</a>
                                                                            </h4>
                                                                            <ul >
                                                                                <li>${v.verFixbug}</li>
                                                                            </ul>
                                                                        </div>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </c:when>
                                            </c:choose>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row" style="height: 50px;">
                <div class="col-mod-12">
                    <div class="portlet box yellow" style="border: 0px;">
                        <div class="portlet-body" style="padding-bottom: 0px;padding-top: 0px; margin-bottom: 0px;margin-top: 0px;">
                            <div class="well font-red-mint" style="line-height: 50px;margin-bottom: 0px;padding-top: 0px;padding-bottom: 0px;">
                                <div class="font-green" >我的版本： ${fns:getConfig('version')}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-mod-12">
                    <div>
                        <div class="portlet box yellow" style="border: 0px;">
                            <div class="portlet-body" >
                                <div class="well font-red-mint">
                                    <h4>温馨提示</h4>
                                    <ul style="font-size: 14px !important;">
                                        <li> 升级坏了不要找我哈！</li>
                                        <li> 升级坏了不要找我哈！</li>
                                        <li> 升级坏了不要找我哈！</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <!-- END CONTENT BODY -->
    </div>
    <!-- END CONTENT -->
</div>
<!-- END CONTAINER -->

<%@include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
//    $(function () {
//        $('div.list-toggle').hover(function(){
//            $(this).css('backgroundColor','red !important');
//        }, function () {
//            $(this).css('backgroundColor','#EEF1F5');
//        });
//    });
</script>
</body>
</html>
