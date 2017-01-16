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
    <sys:sidebar navItemName="机构用户" subMenuName="机构管理" />

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
                        <a href="${ctx}/sys/office/list?id=&parentIds=">机构列表</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>机构${not empty office.id?'修改':'添加'}</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 机构${not empty office.id?'修改':'添加'} <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form:form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" method="post">
                            <form:hidden path="id"/>
                            <div class="form-body">
                                <div class="alert alert-danger display-hide">
                                    <button class="close" data-close="alert"></button><i class="fa fa-close"></i> 表单填写时出现了一些问题，请仔细检查...
                                </div>
                                <div class="alert alert-success display-hide">
                                    <button class="close" data-close="alert"></button><i class="fa fa-check"></i> 正在提交数据，请稍候...
                                </div>
                                <div class="form-group form-md-line-input">
                                    <sys:treeselect id="office" name="parent.id" value="${office.parent.id}" labelName="parent.name" labelValue="${office.parent.name}" title="上级机构" url="/sys/office/treeData" extId="${office.id}"  />
                                </div>
                                <div class="form-group form-md-line-input">
                                    <sys:treeselect id="area" name="area.id" value="${office.area.id}" labelName="area.name" labelValue="${office.area.name}" title="归属区域" url="/sys/area/treeData" cssClass="required"/>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="name" htmlEscape="false" class="form-control required"/>
                                    <label><span class="required">*</span> 机构名称</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="code" htmlEscape="false" class="form-control"/>
                                    <label> 机构编码</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:select path="type" class="form-control">
                                        <form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                    </form:select>
                                    <label> 机构类型</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:select path="grade" class="form-control">
                                        <form:options items="${fns:getDictList('sys_office_grade')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                    </form:select>
                                    <label> 机构级别</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:select path="useable" class="form-control">
                                        <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                    </form:select>
                                    <label> 是否可用</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <sys:treeselect id="primaryPerson" name="primaryPerson.id" value="${office.primaryPerson.id}" labelName="office.primaryPerson.name" labelValue="${office.primaryPerson.name}" title="主负责人" url="/sys/office/treeData?type=3" notAllowSelectParent="true"/>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <sys:treeselect id="deputyPerson" name="deputyPerson.id" value="${office.deputyPerson.id}" labelName="office.deputyPerson.name" labelValue="${office.deputyPerson.name}" title="副负责人" url="/sys/office/treeData?type=3" notAllowSelectParent="true"/>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="address" htmlEscape="false" class="form-control"/>
                                    <label> 联系地址</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="zipCode" htmlEscape="false" class="form-control isZipCode"/>
                                    <label> 邮政编码</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="master" htmlEscape="false" class="form-control"/>
                                    <label> 负责人</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="phone" htmlEscape="false" class="form-control isPhone"/>
                                    <label> 电话</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="fax" htmlEscape="false" class="form-control isPhone"/>
                                    <label> 传真</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="email" htmlEscape="false" class="form-control email"/>
                                    <label> 邮箱</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
                                    <label> 备注</label>
                                </div>
                                <c:if test="${empty office.id}">
                                    <div class="form-group form-md-line-input">
                                        <label> 快速添加下级部门</label>
                                        <div class="checkbox-list" style="margin-top: 20px;">
                                            <form:checkboxes path="childDeptList" items="${fns:getDictList('sys_office_common')}" itemLabel="label" itemValue="value" htmlEscape="false" class="checkbox" />
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            <div class="form-actions" style="margin-top: 20px;">
                                <shiro:hasPermission name="sys:office:edit"><input id="btnSubmit" class="btn blue" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
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