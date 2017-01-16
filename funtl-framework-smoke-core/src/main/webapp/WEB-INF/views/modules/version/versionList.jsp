<%--
  ~ /*
  ~   @copyright 		Copyright © 2016 - 2020. [相关部门] All rights reserved.
  ~   @project   		script - funtl-framework-ssm-admin
  ~   @file      		versionList.jsp
  ~   @author    		warne
  ~   @date      		16-12-14 上午10:13
  ~
  ~   @lastModifie 		16-12-13 下午9:09
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
        .mt-element-list .list-todo.mt-list-container ul>.mt-list-item>.list-todo-item:after {
            border: none;
        }

        .mt-element-list .list-todo.mt-list-container ul>.mt-list-item>.list-todo-item {
            width: 94% !important;
        }

        .mt-element-list .list-todo.mt-list-container ul>.mt-list-item>.list-todo-item .task-list {
            border-bottom: 0;
            border-left: 0;
            border-right: 0;
        }

        .currentVersion {
            color: #E43A45;
            font-weight: bold;
        }
    </style>
</head>
<!-- END HEAD -->

<body class="page-header-static page-sidebar-closed-hide-logo page-content-white">
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <sys:sidebar navItemName="系统设置" subMenuName="检查更新" />

    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <!-- BEGIN CONTENT BODY -->
        <div class="page-content">
            <!-- BEGIN PAGE HEADER-->

            <!-- BEGIN PAGE BAR -->
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li >
                        <a href="${ctx}/">首页</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>系统设置</span>
                    </li>
                    <%--<sys:versionnotify contentType="setting" />--%>
                </ul>
                <div class="page-toolbar" style="display: ${fns:isNewestVersion()?'none':'inline-block'};">
                    <shiro:hasPermission name="version:versionInfo:edit">
                        <div class="btn-group pull-right">
                            <span>
                                <a class="btn green btn-sm btn-outline dropdown-toggle" href="javascript:void(0);"
                                   onclick="clickOKNowUpdate()">立即更新</a>
                            </span>
                        </div>
                    </shiro:hasPermission>
                </div>
            </div>
            <!-- END PAGE BAR -->
            <!-- END PAGE TITLE-->
            <!-- END PAGE HEADER-->
            <div class="row" style="margin-top: 20px;display: ${fns:isNewestVersion()?'none':'inline-block'};">
                <div class="col-md-12">
                    <div class="portlet-body">
                        <div class="mt-element-list">
                            <div class="mt-list-head list-todo font-white bg-green">
                                <div class="list-head-title-container">
                                    <h3 class="list-title">系统版本列表</h3>
                                    <div style="float: left; margin-top: -22px; padding-left: 150px;">
                                        <marquee behavior="left" loop="-1" scrollamount="3" scrolldelay="0" hspace="20" vspace="0" onmouseover="this.stop()" onmouseout="this.start()">
                                            系统当前版本为${fns:versionName()}，赶紧点击【立即更新】升级吧~~~<span style="margin: 0 30px 0 30px;">&nbsp;</span>
                                            系统当前版本为${fns:versionName()}，赶紧点击【立即更新】升级吧~~~<span style="margin: 0 30px 0 30px;">&nbsp;</span>
                                            系统当前版本为${fns:versionName()}，赶紧点击【立即更新】升级吧~~~<span style="margin: 0 30px 0 30px;">&nbsp;</span>
                                            系统当前版本为${fns:versionName()}，赶紧点击【立即更新】升级吧~~~<span style="margin: 0 30px 0 30px;">&nbsp;</span>
                                            系统当前版本为${fns:versionName()}，赶紧点击【立即更新】升级吧~~~<span style="margin: 0 30px 0 30px;">&nbsp;</span>
                                        </marquee>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-list-container list-todo">
                                <div class="list-todo-line"></div>
                                <ul>
                                <c:forEach items="${versions}" var="v" varStatus="p">
                                    <li class="mt-list-item">
                                        <div class="list-todo-icon bg-white">
                                            <i class="fa fa-level-up"></i>
                                        </div>
                                        <div class="list-todo-item">
                                            <a class="list-toggle-container font-dark ${p.index==0?'collapsed':''}" data-toggle="collapse" href="#task-${p.index}" aria-expanded="${p.index==0?'true':'false'}">
                                                <div class="list-toggle done bg-grey-steel" title="点击展开或收起">
                                                    <div class="list-toggle-title bold">
                                                        <span class="${v.currentVersion}">版本： ${v.exVerNo}</span>&nbsp;&nbsp; <fmt:formatDate value="${v.releaseTime}" type="both"/>  &nbsp;&nbsp;发布
                                                    </div>
                                                </div>
                                                <input id="innerVersion${p.index}" value="${v.inVerNo}" type="hidden">
                                            </a>
                                            <div class="task-list panel-collapse collapse ${p.index==0?'in':''}" id="task-${p.index}" aria-expanded="${p.index==0?'true':'false'}">
                                                <ul>
                                                    <li class="task-list-item done">
                                                        <div class="task-icon">
                                                            <a href="javascript:;">
                                                                <i class="fa fa-volume-up"></i>
                                                            </a>
                                                        </div>
                                                        <div class="task-content">
                                                            <h4 class="uppercase bold">
                                                                <a href="javascript:;">新增功能</a>
                                                            </h4>
                                                            <p style="line-height: 25px;"> ${v.verFeature} </p>
                                                        </div>
                                                    </li>
                                                    <li class="task-list-item">
                                                        <div class="task-icon">
                                                            <a href="javascript:;">
                                                                <i class="fa fa-bug"></i>
                                                            </a>
                                                        </div>
                                                        <div class="task-content">
                                                            <h4 class="uppercase bold">
                                                                <a href="javascript:;">系统优化</a>
                                                            </h4>
                                                            <p style="line-height: 25px;"> ${v.verFixbug} </p>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- password modal --%>
        <div id="modifyPassword" class="modal fade" tabindex="-1" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="margin-top: 300px;">
            <div class="modal-dialog" style="width: 500px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title" style="padding-left: 5px;"> 温馨提示 <span class="small font-red-mint"> 服务器root密码 </span></h4>
                    </div>
                    <div class="modal-body">
                        <div class="tip-msg" style="padding-left: 5px;color: red;display: none;"> 密码不能为空 </div>
                        <div class="form-group form-md-line-input">
                            <input id="new-passwd" type="password" class="form-control" style="margin-top: 0px; margin-bottom: 10px;padding-left: 5px;" placeholder="服务器root密码" maxlength="20" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" data-dismiss="modal" class="btn default"> 取消 </button>
                        <button id="save-passwd-btn" type="button" class="btn blue"> 保存 </button>
                    </div>
                </div>
            </div>
        </div>

        <%-- password modal --%>
        <div id="resultTip" class="modal fade" tabindex="-1" aria-hidden="true" style="margin-top: 400px;" >
            <div class="modal-dialog" style="width: 300px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title" style="padding-left: 5px;"> 温馨提示 </h4>
                    </div>
                    <div class="tip-result-msg" style="height: 50px;padding: 12px 0 0 20px;"></div>
                    <div class="modal-footer" style="padding: 7px 15px 7px 15px;">
                        <button type="button" data-dismiss="modal" class="btn blue"> 关闭 </button>
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
    $(function () {
        //$('#modifyPassword').modal('show');
        //$('#resultTip').modal('show');
        valueChange();
    });

    //# 确认更新
    function clickOKNowUpdate() {
       return Custom.initBootBoxConfirmWithCallback('系统升级需要5-10分钟，请尽量选择在非业务繁忙时段进行！', function () { return false;
        }, function () {
           doAjaxNowUpdate();
       });
    }

    //# 修改密码
    function doModifyPasswd() {
        $('#save-passwd-btn').on('click', function () {
            var pw = $.trim($('#new-passwd').val());
            if (pw.length < 1) {
                $('.tip-msg').css({'display': 'inline-block'});
            } else {
                $('#modifyPassword').modal('hide');
                //# submit
                var action = '${ctx}/version/versionInfo/modify/password/'+pw;
                $.ajax({
                    url: action,
                    type: "POST",
                    async: true,
                    success: function(data) {
                        var state = data['state'];
                        if(state == true){
                            doAjaxNowUpdate();
                        }else {
                            $('.tip-result-msg').text("修改密码失败");
                            $('#resultTip').modal('show')
                        }
                    },
                    error: function () {
                        $('.tip-result-msg').text("发生了未知错误，刷新试试");//# hehe ~
                        $('#resultTip').modal('show')
                    }
                });
            }
        });
    }

    //# 值变事件
    function valueChange() {
        $('#new-passwd').on('blur keyup', function () {
            cursorEvent();
        });
    }
    function cursorEvent() {
        var pw = $.trim($('#new-passwd').val());
        if (pw.length < 1) {
            $('.tip-msg').css({'display': 'inline-block'});
        } else {
            $('.tip-msg').css({'display': 'none'});
        }
        return;
    }

    function doAjaxNowUpdate() {
        $('#modifyPassword').modal('hide');
        $('#resultTip').modal('hide');
        var innerVersion = $('#innerVersion0').val();
        var action = '${ctx}/version/versionInfo/update/upgrade/'+innerVersion;
        $.ajax({
            url: action,
            type: "POST",
            async: true,
            success: function(data) {
                var state = data['state'];
                var code = data['code'];
                var msg = data['msg'];

                if(state == false){
                    if(code == '0001'){ //# 密码错误
                       $('#modifyPassword').modal('show');
                        doModifyPasswd();
                    }else{
                        $('.tip-result-msg').text(msg);
                        $('#resultTip').modal('show');
                    }
                }
            },
            error: function () {
                $('.tip-result-msg').text("发生了未知错误，刷新试试");//# hehe ~
                $('#resultTip').modal('show')
            }
        });
    }

</script>
</body>
</html>
