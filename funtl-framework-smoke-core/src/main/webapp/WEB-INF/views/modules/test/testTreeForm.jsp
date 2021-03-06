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
    <sys:sidebar navItemName="生成案例" subMenuName="树结构表" />

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
                        <a href="${ctx}/test/testTree/">树结构表列表</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>树结构表${not empty testTree.id?'修改':'添加'}</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 树结构表${not empty testTree.id?'修改':'添加'} <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
				<div class="col-md-12">
					<div class="portlet light portlet-fit portlet-form bordered">
						<form:form id="inputForm" modelAttribute="testTree" action="${ctx}/test/testTree/save" method="post">
							<form:hidden path="id"/>
							<div class="form-body">
								<div class="alert alert-danger display-hide">
									<button class="close" data-close="alert"></button><i class="fa fa-close"></i> 表单填写时出现了一些问题，请仔细检查...
								</div>
								<div class="alert alert-success display-hide">
									<button class="close" data-close="alert"></button><i class="fa fa-check"></i> 正在提交数据，请稍候...
								</div>
								<div class="form-group form-md-line-input">
									<label><span class="required">*</span> 父级编号</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="parentIds" htmlEscape="false" maxlength="2000" class="form-control required" />
									<label><span class="required">*</span> 所有父级编号</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="name" htmlEscape="false" maxlength="100" class="form-control required" />
									<label><span class="required">*</span> 名称</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="sort" htmlEscape="false" class="form-control required" />
									<label><span class="required">*</span> 排序</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="255" class="form-control "/>
									<label> 备注信息</label>
								</div>
							</div>
							<div class="form-actions" style="margin-top: 20px;">
								<shiro:hasPermission name="test:testTree:edit"><input id="btnSubmit" class="btn blue" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
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