<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html> <!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]--> <!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]--> <!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->

<!-- BEGIN HEAD -->
<head>
    <title>${shop:shopTitle('productName')}</title>
    <meta name="decorator" content="default"/>

    <link href="${cdn}/metronic/4.5.2/assets/pages/css/profile.min.css" rel="stylesheet" type="text/css" />
</head>
<!-- END HEAD -->

<body class="page-header-static page-sidebar-closed-hide-logo page-content-white">
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <sys:sidebar navItemName="我的面板" subMenuName="个人信息" />

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
                        <span>个人信息</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 个人信息 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <!-- BEGIN PROFILE SIDEBAR -->
                    <div class="profile-sidebar">
                        <!-- PORTLET MAIN -->
                        <div class="portlet light profile-sidebar-portlet ">
                            <!-- SIDEBAR USERPIC -->
                            <div class="profile-userpic">
                                <c:choose>
                                    <c:when test="${not empty fns:getUser().photo}">
                                        <img src="${fns:getUser().photo}" class="img-responsive" alt="" />
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${cdn}/metronic/4.5.2/assets/layouts/layout/img/avatar.png" class="img-responsive" alt="" />
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- END SIDEBAR USERPIC -->
                            <!-- SIDEBAR USER TITLE -->
                            <div class="profile-usertitle">
                                <div class="profile-usertitle-name"> ${user.name} </div>
                                <div class="profile-usertitle-job">
                                    ${user.company.name}<br />（${user.office.name}）
                                </div>
                            </div>
                            <!-- END SIDEBAR USER TITLE -->
                        </div>
                        <!-- END PORTLET MAIN -->
                    </div>
                    <!-- END PROFILE SIDEBAR -->

                    <div class="profile-content">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="portlet light portlet-fit portlet-form bordered">
                                    <div class="portlet-body">
                                        <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/info" method="post">
                                            <div class="form-body">
                                                <div class="alert alert-danger display-hide">
                                                    <button class="close" data-close="alert"></button><i class="fa fa-close"></i> 表单填写时出现了一些问题，请仔细检查...
                                                </div>
                                                <div class="alert alert-success display-hide">
                                                    <button class="close" data-close="alert"></button><i class="fa fa-check"></i> 正在提交数据，请稍候...
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <sys:uploadImage id="photo" label="头像上传" name="photo" value="${user.photo}" />
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <input type="text" class="form-control" value="${user.company.name}" readonly="readonly" />
                                                    <label> 归属公司</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <input type="text" class="form-control" value="${user.office.name}" readonly="readonly" />
                                                    <label> 归属部门</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:input path="name" htmlEscape="false" maxlength="50" class="form-control required" readonly="true"/>
                                                    <label> 姓名</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:input path="email" htmlEscape="false" maxlength="50" class="form-control email" />
                                                    <label> 邮箱</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:input path="phone" htmlEscape="false" maxlength="50" class="form-control isPhone" />
                                                    <label> 电话</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:input path="mobile" htmlEscape="false" maxlength="50" class="form-control isMobile" />
                                                    <label> 手机</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
                                                    <label> 备注</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <input type="text" class="form-control" value="${fns:getDictLabel(user.userType, 'sys_user_type', '无')}" readonly="readonly" />
                                                    <label> 用户类型</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <input type="text" class="form-control" value="${user.roleNames}" readonly="readonly" />
                                                    <label> 用户角色</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <input type="text" class="form-control" value="IP: ${user.oldLoginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value='${user.oldLoginDate}' type='both' dateStyle='full'/>" readonly="readonly" />
                                                    <label> 上次登录</label>
                                                </div>
                                            </div>
                                            <div class="form-actions" style="margin-top: 20px;">
                                                <input id="btnSubmit" class="btn blue" type="submit" value="保 存" />
                                            </div>
                                        </form:form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END TABLE -->
        </div>
        <!-- END CONTENT BODY -->
    </div>
    <!-- END CONTENT -->
</div>
<!-- END CONTAINER -->

<%@include file="/WEB-INF/views/include/footer.jsp" %>
<sys:validateForm form="inputForm" />
</body>
</html>