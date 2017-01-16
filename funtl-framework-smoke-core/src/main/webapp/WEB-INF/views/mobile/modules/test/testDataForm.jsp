<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html> <!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]--> <!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]--> <!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->

<!-- BEGIN HEAD -->
<head>
    <title>${shop:shopTitle('productName')}</title>
    <meta name="decorator" content="mobile"/>
</head>
<!-- END HEAD -->

<body class="page-header-static page-sidebar-closed-hide-logo page-content-white">
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <sys:sidebar navItemName="生成案例" subMenuName="单表数据" />

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
                        <a href="${ctx}/test/testData/">单表数据列表</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>单表数据${not empty testData.id?'修改':'添加'}</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
				<div class="col-md-12">
					<div class="portlet light portlet-fit portlet-form bordered">
						<form:form id="inputForm" modelAttribute="testData" action="${ctx}/test/testData/save" method="post">
							<form:hidden path="id"/>
							<div class="form-body">
								<div class="alert alert-danger display-hide">
									<button class="close" data-close="alert"></button><i class="fa fa-close"></i> 表单填写时出现了一些问题，请仔细检查...
								</div>
								<div class="alert alert-success display-hide">
									<button class="close" data-close="alert"></button><i class="fa fa-check"></i> 正在提交数据，请稍候...
								</div>
								<div class="form-group form-md-line-input">
									<sys:treeselect id="user" name="user.id" value="${testData.user.id}" labelName="user.name" labelValue="${testData.user.name}" title="归属用户" url="/sys/office/treeData?type=3" cssClass="form-control " notAllowSelectParent="true" />
								</div>
								<div class="form-group form-md-line-input">
									<sys:treeselect id="office" name="office.id" value="${testData.office.id}" labelName="office.name" labelValue="${testData.office.name}" title="归属部门" url="/sys/office/treeData?type=2" cssClass="form-control " notAllowSelectParent="true" />
								</div>
								<div class="form-group form-md-line-input">
									<sys:treeselect id="area" name="area.id" value="${testData.area.id}" labelName="area.name" labelValue="${testData.area.name}" title="归属区域" url="/sys/area/treeData" cssClass="form-control " notAllowSelectParent="true" />
								</div>
								<div class="form-group form-md-line-input">
									<form:input path="name" htmlEscape="false" maxlength="100" class="form-control " />
									<label> 名称</label>
								</div>
								<div class="form-group form-md-line-input">
									<form:select path="sex" class="form-control ">
										<form:option value="" label=""/>
										<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
									<label> 性别</label>
								</div>
								<div class="form-group form-md-line-input">
									<div class="input-group date form_datetime">
										<input type="text" name="inDate" size="16" readonly class="form-control " value="<fmt:formatDate value="${testData.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>">
											<span class="input-group-btn">
												<button class="btn default date-set" type="button">
													<i class="fa fa-calendar"></i>
												</button>
											</span>
										<label> 加入日期</label>
									</div>
								</div>
								<div class="form-group form-md-line-input">
									<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="255" class="form-control "/>
									<label> 备注信息</label>
								</div>
							</div>
							<div class="form-actions" style="margin-top: 20px;">
								<shiro:hasPermission name="test:testData:edit"><input id="btnSubmit" class="btn blue" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
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