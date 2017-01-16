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
    <sys:sidebar navItemName="机构用户" subMenuName="用户管理" />

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
                        <a href="${ctx}/sys/user/list">用户列表</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>用户${not empty user.id ? '修改' : '添加'}</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 用户${not empty user.id ? '修改' : '添加'} <small></small></h3>
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
                                    <c:when test="${not empty user.photo}">
                                        <img src="${user.photo}" class="img-responsive" alt="" />
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
                                <div class="profile-usertitle-job"> ${user.company.name}<br/>（${user.office.name}） </div>
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
                                        <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post">
                                            <form:hidden path="id"/>
                                            <div class="form-body">
                                                <div class="alert alert-danger display-hide">
                                                    <button class="close" data-close="alert"></button><i class="fa fa-close"></i> 表单填写时出现了一些问题，请仔细检查...
                                                </div>
                                                <div class="alert alert-success display-hide">
                                                    <button class="close" data-close="alert"></button><i class="fa fa-check"></i> 正在提交数据，请稍候...
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <sys:uploadImage id="photo" label="头像上传" name="photo" value="${user.photo}"/>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}" title="归属公司" url="/sys/office/treeData?type=1" cssClass="required" />
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" title="归属部门" url="/sys/office/treeData?type=2" cssClass="required" notAllowSelectParent="false" />
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:input path="no" htmlEscape="false" maxlength="50" class="form-control required" />
                                                    <label><span class="required">*</span> 工号</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:input path="name" htmlEscape="false" maxlength="50" class="form-control required" />
                                                    <label><span class="required">*</span> 姓名</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
                                                    <form:input path="loginName" htmlEscape="false" maxlength="50" class="form-control required" />
                                                    <label><span class="required">*</span> 登录名</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <input id="newPassword" name="newPassword" type="password" maxlength="50" minlength="6" class="form-control ${empty user.id?'required':''}" />
                                                    <label><c:if test="${empty user.id}"><span class="required">*</span></c:if> 密码</label>
                                                    <c:if test="${not empty user.id}"><span class="help-block">若不修改密码，请留空</span></c:if>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <input id="confirmNewPassword" name="confirmNewPassword" type="password" maxlength="50" minlength="6" class="form-control" equalTo="#newPassword" />
                                                    <label><c:if test="${empty user.id}"><span class="required">*</span></c:if> 确认密码</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:input path="email" htmlEscape="false" maxlength="100" class="form-control email" />
                                                    <label> 邮箱</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:input path="phone" htmlEscape="false" maxlength="100" class="form-control isPhone" />
                                                    <label> 电话</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:input path="mobile" htmlEscape="false" maxlength="100" class="form-control isMobile" />
                                                    <label> 手机</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:select path="loginFlag" class="form-control required">
                                                        <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                                    </form:select>
                                                    <label><span class="required">*</span> 是否允许登录</label>
                                                    <span class="help-block">“是”代表此账号允许登录，“否”则表示此账号不允许登录</span>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:select path="userType" class="form-control required">
                                                        <form:option value="" label="请选择"/>
                                                        <form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                                    </form:select>
                                                    <label> 用户类型</label>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <label><span class="required">*</span> 用户角色</label>
                                                    <div class="checkbox-list" style="margin-top: 20px;">
                                                        <form:checkboxes path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="checkbox required" />
                                                    </div>
                                                </div>
                                                <div class="form-group form-md-line-input">
                                                    <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
                                                    <label> 备注</label>
                                                </div>
                                                <c:if test="${not empty user.id}">
                                                    <div class="form-group form-md-line-input">
                                                        <input type="text" class="form-control" value="<fmt:formatDate value="${user.createDate}" type="both" dateStyle="full"/>" readonly="readonly" />
                                                        <label> 创建时间</label>
                                                    </div>
                                                    <div class="form-group form-md-line-input">
                                                        <input type="text" class="form-control" value="IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full"/>" readonly="readonly" />
                                                        <label> 最后登陆</label>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="form-actions" style="margin-top: 20px;">
                                                <shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn blue" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
                                                <input id="btnCancel" class="btn default" type="button" value="返 回" onclick="history.go(-1)"/>
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