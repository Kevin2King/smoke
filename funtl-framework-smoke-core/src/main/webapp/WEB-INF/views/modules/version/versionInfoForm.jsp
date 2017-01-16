<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<%--
  ~ /*
  ~   @copyright 		Copyright © 2016 - 2020. [相关部门] All rights reserved.
  ~   @project   		script - funtl-framework-ssm-admin
  ~   @file      		versionInfoForm.jsp
  ~   @author    		warne
  ~   @date      		16-12-14 上午10:11
  ~
  ~   @lastModifie 		16-12-10 上午11:28
  ~  */
  --%>

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
    <sys:sidebar navItemName="系统版本" subMenuName="系统版本" />

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
                        <a href="${ctx}/sys/versionInfo/">系统版本列表</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>系统版本${not empty versionInfo.id?'修改':'添加'}</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 系统版本${not empty versionInfo.id?'修改':'添加'} <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
				<div class="col-md-12">
					<div class="portlet light portlet-fit portlet-form bordered">
						<form:form id="inputForm" modelAttribute="versionInfo" action="${ctx}/sys/versionInfo/save" method="post">
							<form:hidden path="id"/>
							<div class="form-body">
								<div class="alert alert-danger display-hide">
									<button class="close" data-close="alert"></button><i class="fa fa-close"></i> 表单填写时出现了一些问题，请仔细检查...
								</div>
								<div class="alert alert-success display-hide">
									<button class="close" data-close="alert"></button><i class="fa fa-check"></i> 正在提交数据，请稍候...
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="uniqueCode" htmlEscape="false" maxlength="255" class="form-control required" />
									<label><span class="required">*</span> 唯一识别码</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="versionName" htmlEscape="false" maxlength="255" class="form-control required" />
									<label><span class="required">*</span> 版本名称</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="innerVersion" htmlEscape="false" maxlength="255" class="form-control required" />
									<label><span class="required">*</span> 内部版本号</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="projectCode" htmlEscape="false" maxlength="255" class="form-control required" />
									<label><span class="required">*</span> 项目编码</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="admin" htmlEscape="false" maxlength="255" class="form-control required" />
									<label><span class="required">*</span> 账号</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="password" htmlEscape="false" maxlength="255" class="form-control required" />
									<label><span class="required">*</span> 密码</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="serverUrl" htmlEscape="false" maxlength="255" class="form-control required" />
									<label><span class="required">*</span> 版本服务器地址</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="apiVersion" htmlEscape="false" maxlength="255" class="form-control required" />
									<label><span class="required">*</span> api版本</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="versionListUrl" htmlEscape="false" maxlength="255" class="form-control " />
									<label> 版本列表url</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="callbackUrl" htmlEscape="false" maxlength="255" class="form-control required" />
									<label><span class="required">*</span> 回调地址</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="versionUpdateUrl" htmlEscape="false" maxlength="255" class="form-control " />
									<label> 版本更新url</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="versionType" htmlEscape="false" maxlength="60" class="form-control " />
									<label> 版本类型 100当前版本 101历史版本</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="updateVersion" htmlEscape="false" maxlength="255" class="form-control required" />
									<label><span class="required">*</span> 申请更新的版本</label>
								</div>
							</div>
							<div class="form-actions" style="margin-top: 20px;">
								<shiro:hasPermission name="version:versionInfo:edit"><input id="btnSubmit" class="btn blue" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
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