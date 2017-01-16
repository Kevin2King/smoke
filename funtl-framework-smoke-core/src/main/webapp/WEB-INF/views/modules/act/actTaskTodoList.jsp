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
    <sys:sidebar navItemName="在线办公" subMenuName="我的任务" />

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
                        <span>我的任务</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                    <div class="btn-group pull-right">
                        <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                            操作 <i class="fa fa-angle-down"></i>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu">
                            <li>
                                <a href="${ctx}/act/task/historic/"><i class="icon-plus"></i> 已办任务 </a>
                            </li>
                            <li>
                                <a href="${ctx}/act/task/process/"><i class="icon-plus"></i> 新建任务 </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 我的任务 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="portlet light portlet-fit portlet-form bordered">
                    <div class="portlet-title">
                        <form:form id="searchForm" modelAttribute="act" action="${ctx}/act/task/todo/" method="get" class="form-horizontal">
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <label class="col-md-3 control-label">流程类型</label>
                                            <div class="col-md-9">
                                                <form:select path="procDefKey" class="form-control">
                                                    <form:option value="" label="全部流程"/>
                                                    <form:options items="${fns:getDictList('act_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                                </form:select>
                                                <div class="form-control-focus"> </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <label class="col-md-3 control-label">创建时间</label>
                                            <div class="col-md-9">
                                                <div class="input-group date-picker input-daterange" data-date-format="yyyy-mm-dd">
                                                    <input type="text" class="form-control" name="beginDate" value="<fmt:formatDate value="${act.beginDate}" pattern="yyyy-MM-dd"/>" style="text-align: center;" />
                                                    <span class="input-group-addon"> 至 </span>
                                                    <input type="text" class="form-control" name="endDate" value="<fmt:formatDate value="${act.endDate}" pattern="yyyy-MM-dd"/>" style="text-align: center;" />
                                                </div>
                                                <div class="form-control-focus"> </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" style="text-align: right;">
                                        <input id="btnSubmit" class="btn blue" type="submit" value="查 询" />
                                    </div>
                                </div>
                            </div>
                        </form:form>
                    </div>
                    <div class="portlet-body">
                        <div class="table-scrollable" style="padding-left: 20px;">
                            <table id="contentTable" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr style="white-space: nowrap;">
                                        <th>标题</th>
                                        <th>当前环节</th>
                                        <th>流程名称</th>
                                        <th>流程版本</th>
                                        <th>创建时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="act">
                                    <c:set var="task" value="${act.task}" />
                                    <c:set var="vars" value="${act.vars}" />
                                    <c:set var="procDef" value="${act.procDef}" />
                                    <c:set var="status" value="${act.status}" />
                                    <tr class="active">
                                        <td>
                                            <c:if test="${empty task.assignee}">
                                                <a href="javascript:claim('${task.id}');" title="签收任务">${fns:abbr(not empty act.vars.map.title ? act.vars.map.title : task.id, 60)}</a>
                                            </c:if>
                                            <c:if test="${not empty task.assignee}">
                                                <a href="${ctx}/act/task/form?taskId=${task.id}&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=${status}">${fns:abbr(not empty vars.map.title ? vars.map.title : task.id, 60)}</a>
                                            </c:if>
                                        </td>
                                        <td>
                                            <a target="_blank" href="${pageContext.request.contextPath}/act/diagram-viewer?processDefinitionId=${task.processDefinitionId}&processInstanceId=${task.processInstanceId}">${task.name}</a>
                                        </td>
                                        <td>${procDef.name}</td>
                                        <td><b title='流程版本号'>V: ${procDef.version}</b></td>
                                        <td><fmt:formatDate value="${task.createTime}" type="both"/></td>
                                        <td>
                                            <c:if test="${empty task.assignee}">
                                                <a href="javascript:claim('${task.id}');">签收任务</a>
                                            </c:if>
                                            <c:if test="${not empty task.assignee}">
                                                <a href="${ctx}/act/task/form?taskId=${task.id}&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=${status}">任务办理</a>
                                            </c:if>
                                            <shiro:hasPermission name="act:process:edit">
                                                <c:if test="${empty task.executionId}">
                                                    <a href="${ctx}/act/task/deleteTask?taskId=${task.id}&reason=" onclick="return Custom.initBootBoxConfirm('确认删除该任务吗？', this.href);">删除任务</a>
                                                </c:if>
                                            </shiro:hasPermission>
                                            <a target="_blank" href="${pageContext.request.contextPath}/act/diagram-viewer?processDefinitionId=${task.processDefinitionId}&processInstanceId=${task.processInstanceId}">跟踪</a>
                                            
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
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
<script type="text/javascript">

</script>
</body>
</html>