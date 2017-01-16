<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html> <!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]--> <!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]--> <!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->

<!-- BEGIN HEAD -->
<head>
    <title>${shop:shopTitle('productName')}</title>
    <meta name="decorator" content="default"/>
</head>
<!-- END HEAD -->

<body class="page-header-static page-sidebar-closed-hide-logo page-content-white">
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <sys:sidebar navItemName="系统设置" subMenuName="菜单管理" />

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
                        <a href="${ctx}/sys/menu">菜单列表</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>菜单${not empty menu.id ? '修改' : '添加'}</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 菜单${not empty menu.id ? '修改' : '添加'} <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form:form id="inputForm" modelAttribute="menu" action="${ctx}/sys/menu/save" method="post">
                            <form:hidden path="id"/>
                            <div class="form-body">
                                <div class="alert alert-danger display-hide">
                                    <button class="close" data-close="alert"></button><i class="fa fa-close"></i> 表单填写时出现了一些问题，请仔细检查...
                                </div>
                                <div class="alert alert-success display-hide">
                                    <button class="close" data-close="alert"></button><i class="fa fa-check"></i> 正在提交数据，请稍候...
                                </div>
                                <div class="form-group form-md-line-input">
                                    <sys:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}" title="上级菜单" url="/sys/menu/treeData" extId="${menu.id}" cssClass="required" />
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="name" htmlEscape="false" class="form-control required"/>
                                    <label><span class="required">*</span> 名称</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="href" htmlEscape="false" class="form-control"/>
                                    <label> 链接</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="target" htmlEscape="false" class="form-control"/>
                                    <label> 目标</label>
                                    <span class="help-block">链接地址打开的目标窗口</span>
                                </div>
                                <div class="form-group">
                                    <label> 图标</label>
                                    <sys:iconselect id="icon" name="icon" value="${menu.icon}"/>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="sort" htmlEscape="false" class="form-control required"/>
                                    <label> 排序</label>
                                    <span class="help-block">排列顺序，升序</span>
                                </div>
                                <div class="form-group">
                                    <label> 可见</label>
                                    <form:radiobuttons path="isShow" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="form-control required"/>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="permission" htmlEscape="false" class="form-control"/>
                                    <label> 权限标识</label>
                                    <span class="help-block">控制器中定义的权限标识，如：@RequiresPermissions("权限标识")</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
                                    <label> 备注</label>
                                </div>
                            </div>
                            <div class="form-actions" style="margin-top: 20px;">
                                <shiro:hasPermission name="sys:menu:edit"><input id="btnSubmit" class="btn blue" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
                                <input id="btnCancel" class="btn default" type="button" value="返 回" onclick="history.go(-1)"/>
                            </div>
                        </form:form>
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