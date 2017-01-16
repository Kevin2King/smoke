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
    <sys:sidebar navItemName="系统设置" subMenuName="计划任务" />

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
                        <span>计划任务列表</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                    <shiro:hasPermission name="sys:taskJob:edit">
                        <div class="btn-group pull-right">
                            <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                                操作 <i class="fa fa-angle-down"></i>
                            </button>
                            <ul class="dropdown-menu pull-right" role="menu">
                                <li>
                                    <a href="${ctx}/sys/taskJob/form"><i class="icon-plus"></i> 计划任务添加 </a>
                                </li>
                            </ul>
                        </div>
                    </shiro:hasPermission>
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 计划任务列表 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
				<div class="col-md-12">
					<div class="portlet light portlet-fit portlet-form bordered">
						<form:form id="searchForm" modelAttribute="taskJob" action="${ctx}/sys/taskJob/" method="post">
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<div class="form-body">
								<div class="col-md-4">
									<div class="form-group form-md-line-input">
										<form:input path="taskJobName" htmlEscape="false" maxlength="100" class="form-control" />
										<label>任务名称</label>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group form-md-line-input">
										<form:select path="taskJobStatus" class="form-control">
											<form:option value="" label=""/>
											<form:options items="${fns:getDictList('task_job_status')}" itemLabel="label" itemValue="value" htmlEscape="false" />
										</form:select>
										<label>任务状态</label>
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
					<table id="contentTable" class="table table-striped table-bordered table-hover">
						<thead>
						<tr style="white-space: nowrap;">
							<th>任务编码</th>
							<th>任务名称</th>
							<th>任务分组</th>
							<th>任务表达式</th>
							<th>任务状态</th>
							<th>排序</th>
							<th>SPRING</th>
							<th>任务调用方法</th>
							<th>执行服务器IP</th>
							<th>更新时间</th>
							<th>备注</th>
							<shiro:hasPermission name="sys:taskJob:edit"><th>操作</th></shiro:hasPermission>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${list}" var="taskJob">
							<tr class="active">
								<td><a href="${ctx}/sys/taskJob/form?id=${taskJob.id}">
										${taskJob.taskJobCode}
								</a></td>
								<td>
										${taskJob.taskJobName}
								</td>
								<td>
										${taskJob.taskJobGroup}
								</td>
								<td>
										${taskJob.taskJobCron}
								</td>
								<td>
									<c:choose>
										<c:when test="${taskJob.taskJobStatus eq '0'}">
											${fns:getDictLabel(taskJob.taskJobStatus, 'task_job_status', '')}
										</c:when>
										<c:otherwise>
											<span class="font-blue">${fns:getDictLabel(taskJob.taskJobStatus, 'task_job_status', '')}</span>
										</c:otherwise>
									</c:choose>
								</td>
								<td>${taskJob.sort}</td>
								<td>
										${taskJob.taskJobSpring}
								</td>
								<td>
										${taskJob.taskJobMethod}
								</td>
								<td>
										${taskJob.taskJobIp}
								</td>
								<td>
									<fmt:formatDate value="${taskJob.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
										${taskJob.remarks}
								</td>
								<shiro:hasPermission name="sys:taskJob:edit"><td>
									<a href="${ctx}/sys/taskJob/changeJobStatus?ip=${taskJob.taskJobIp}&id=${taskJob.id}&cmd=${taskJob.taskJobStatus eq "0" ? "start" : "stop"}">${taskJob.taskJobStatus eq "0" ? "启动" : "停止"}</a>
									<a href="${ctx}/sys/taskJob/form?id=${taskJob.id}">修改</a>
									<a href="${ctx}/sys/taskJob/delete?id=${taskJob.id}" onclick="return Custom.initBootBoxConfirm('确认要删除该计划任务吗？', this.href)">删除</a>
								</td></shiro:hasPermission>
							</tr>
						</c:forEach>
						</tbody>
					</table>
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
</body>
</html>