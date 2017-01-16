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
    <sys:sidebar navItemName="通知管理" subMenuName="发布通知" />

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
                        <c:choose>
                            <c:when test="${oaNotify.self}">
                                <a href="${ctx}/oa/oaNotify/self">通知列表</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${ctx}/oa/oaNotify/">通知列表</a>
                            </c:otherwise>
                        </c:choose>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>${oaNotify.status eq '1' ? '查看' : not empty oaNotify.id ? '修改' : '发布'}通知</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> ${oaNotify.status eq '1' ? '查看' : not empty oaNotify.id ? '修改' : '发布'}通知 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form:form id="inputForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/save" method="post">
                            <form:hidden path="id"/>
                            <div class="form-body">
                                <div class="alert alert-danger display-hide">
                                    <button class="close" data-close="alert"></button><i class="fa fa-close"></i> 表单填写时出现了一些问题，请仔细检查...
                                </div>
                                <div class="alert alert-success display-hide">
                                    <button class="close" data-close="alert"></button><i class="fa fa-check"></i> 正在提交数据，请稍候...
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:select path="type" class="form-control required">
                                        <form:option value="" label=""/>
                                        <form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                    </form:select>
                                    <label> 类型</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:input path="title" htmlEscape="false" maxlength="200" class="form-control required"/>
                                    <label> 标题</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:textarea path="content" htmlEscape="false" rows="6" maxlength="2000" class="form-control required"/>
                                    <label> 内容</label>
                                </div>
                                <c:if test="${oaNotify.status ne '1'}">
                                    <div class="form-group form-md-line-input">
                                        <sys:uploadFile id="files" name="files" label="附件" value="${oaNotify.files}" />
                                    </div>
                                    <div class="form-group form-md-line-input">
                                        <form:select path="status" class="form-control required">
                                            <form:option value="" label=""/>
                                            <form:options items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                        <label> 状态</label>
                                        <span class="help-block">发布后不能进行操作</span>
                                    </div>
                                    <div class="form-group form-md-line-input">
                                        <sys:treeselect id="oaNotifyRecord" name="oaNotifyRecordIds" value="${oaNotify.oaNotifyRecordIds}" labelName="oaNotifyRecordNames" labelValue="${oaNotify.oaNotifyRecordNames}" title="用户" url="/sys/office/treeData?type=3" cssClass="form-control required" notAllowSelectParent="true" checked="true"/>
                                    </div>
                                </c:if>
                                <c:if test="${oaNotify.status eq '1'}">
                                    <div class="form-group form-md-line-input">
                                        <sys:uploadFile id="files" name="files" label="附件" value="${oaNotify.files}" />
                                    </div>
                                    <div class="form-group form-md-line-input">
                                        <div class="row">
                                            <div class="portlet">
                                                <div class="portlet-title" style="padding-left: 18px;">
                                                    接受人
                                                </div>
                                                <div class="portlet-body">
                                                    <div class="table-scrollable" style="padding-left: 20px;">
                                                        <table id="contentTable" class="table table-striped table-bordered table-hover">
                                                            <thead>
                                                            <tr style="white-space: nowrap;">
                                                                <th>接受人</th>
                                                                <th>接受部门</th>
                                                                <th>阅读状态</th>
                                                                <th>阅读时间</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach items="${oaNotify.oaNotifyRecordList}" var="oaNotifyRecord">
                                                                <tr class="active">
                                                                    <td>
                                                                            ${oaNotifyRecord.user.name}
                                                                    </td>
                                                                    <td>
                                                                            ${oaNotifyRecord.user.office.name}
                                                                    </td>
                                                                    <td>
                                                                            ${fns:getDictLabel(oaNotifyRecord.readFlag, 'oa_notify_read', '')}
                                                                    </td>
                                                                    <td>
                                                                        <fmt:formatDate value="${oaNotifyRecord.readDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                            <tr>
                                                                <td colspan="4">已查阅：${oaNotify.readNum} &nbsp; 未查阅：${oaNotify.unReadNum} &nbsp; 总共：${oaNotify.readNum + oaNotify.unReadNum}</td>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            <div class="form-actions" style="margin-top: 20px;">
                                <c:if test="${oaNotify.status ne '1'}">
                                    <shiro:hasPermission name="oa:oaNotify:edit"><input id="btnSubmit" class="btn blue" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
                                </c:if>
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