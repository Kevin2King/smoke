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
    <sys:sidebar navItemName="系统设置" subMenuName="邮箱配置" />

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
                        <span>邮箱配置</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 邮箱配置 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form:form id="inputForm" modelAttribute="sysMail" action="${ctx}/sys/sysMail/save" method="post">
                            <form:hidden path="id"/>
                            <div class="form-body">
                                <div class="alert alert-danger display-hide">
                                    <button class="close" data-close="alert"></button><i class="fa fa-close"></i> 表单填写时出现了一些问题，请仔细检查...
                                </div>
                                <div class="alert alert-success display-hide">
                                    <button class="close" data-close="alert"></button><i class="fa fa-check"></i> 正在提交数据，请稍候...
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="mailHost" htmlEscape="false" maxlength="100" class="form-control required" />
                                    <label><span class="required">*</span> 主机名</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="mailPort" htmlEscape="false" class="form-control required digits" />
                                    <label><span class="required">*</span> 主机端口</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="mailUsername" htmlEscape="false" maxlength="100" class="form-control required" />
                                    <label><span class="required">*</span> 邮箱地址</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input type="password" path="mailPassword" htmlEscape="false" maxlength="100" class="form-control required" />
                                    <label><span class="required">*</span> 邮箱密码</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="mailFrom" htmlEscape="false" maxlength="100" class="form-control required" />
                                    <label><span class="required">*</span> 发件人名称</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:select path="mailSsl" class="form-control required">
                                        <form:option value="" label=""/>
                                        <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                    </form:select>
                                    <label><span class="required">*</span> 使用SSL/TLS</label>
                                </div>
                            </div>
                            <div class="form-actions" style="margin-top: 20px;">
                                <shiro:hasPermission name="sys:sysMail:edit">
                                    <input id="btnSubmit" class="btn blue" type="submit" value="保 存"/>&nbsp;
                                    <input id="btnMail" class="btn red" type="button" value="发送测试邮件" onclick="sendMail();"/>&nbsp;
                                </shiro:hasPermission>
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
<script type="text/javascript">
    // 登录CRM
    function sendMail() {
        Custom.initStartPageBlockUI();
        $("#inputForm").attr("action", "${ctx}/sys/sysMail/sendTestMail");
        $("#inputForm").submit();
    }
</script>
</body>
</html>