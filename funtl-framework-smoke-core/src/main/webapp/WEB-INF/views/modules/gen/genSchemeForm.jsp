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
    <sys:sidebar navItemName="代码生成" subMenuName="生成方案配置" />

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
                        <a href="${ctx}/gen/genScheme/">生成方案列表</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>生成方案${not empty genScheme.id?'修改':'添加'}</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 生成方案${not empty genScheme.id?'修改':'添加'} <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form:form id="inputForm" modelAttribute="genScheme" action="${ctx}/gen/genScheme/save" method="post">
                            <form:hidden path="id"/>
                            <form:hidden path="flag"/>
                            <div class="form-body">
                                <div class="alert alert-danger display-hide">
                                    <button class="close" data-close="alert"></button><i class="fa fa-close"></i> 表单填写时出现了一些问题，请仔细检查...
                                </div>
                                <div class="alert alert-success display-hide">
                                    <button class="close" data-close="alert"></button><i class="fa fa-check"></i> 正在提交数据，请稍候...
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="name" htmlEscape="false" class="form-control required"/>
                                    <label> 方案名称</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:select path="category" class="form-control required">
                                        <form:options items="${config.categoryList}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                    </form:select>
                                    <label> 模板分类</label>
                                    <span class="help-block">生成结构：{包名}/{模块名}/{分层(dao,entity,service,web)}/{子模块名}/{java类}</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="packageName" htmlEscape="false" class="form-control required"/>
                                    <label> 生成包路径</label>
                                    <span class="help-block">建议模块包：com.funtl.*.modules</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="moduleName" htmlEscape="false" class="form-control required"/>
                                    <label> 生成模块名</label>
                                    <span class="help-block">可理解为子系统名，例如 sys</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="subModuleName" htmlEscape="false" class="form-control"/>
                                    <label> 生成子模块名</label>
                                    <span class="help-block">可选，分层下的文件夹</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="functionName" htmlEscape="false" class="form-control required"/>
                                    <label> 模块名称</label>
                                    <span class="help-block">将设置到类描述（模块名称，同菜单模块名，用于绑定菜单选中样式）</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="functionNameSimple" htmlEscape="false" class="form-control required"/>
                                    <label> 功能名称</label>
                                    <span class="help-block">用作功能提示，如：保存“某某”成功（同菜单里的功能名称，用于绑定菜单选中样式）</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="functionAuthor" htmlEscape="false" class="form-control required"/>
                                    <label> 生成功能作者</label>
                                    <span class="help-block">功能开发者</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:select path="genTable.id" class="form-control required">
                                        <form:options items="${tableList}" itemLabel="nameAndComments" itemValue="id" htmlEscape="false"/>
                                    </form:select>
                                    <label> 业务表名</label>
                                    <span class="help-block">生成的数据表，一对多情况下请选择主表</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
                                    <label> 备注</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:checkbox path="replaceFile" label="是否替换现有文件" class="checkbox" />
                                </div>
                            </div>
                            <div class="form-actions" style="margin-top: 20px;">
                                <shiro:hasPermission name="gen:genScheme:edit">
                                    <input id="btnSubmit" class="btn blue" type="submit" value="保存方案" onclick="$('#flag').val('0');"/>&nbsp;
                                    <input id="btnSubmit" class="btn red" type="submit" value="保存并生成代码" onclick="$('#flag').val('1');"/>&nbsp;
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
</body>
</html>