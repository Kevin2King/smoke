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
    <sys:sidebar navItemName="流程管理" subMenuName="流程管理" />

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
                        <a href="${ctx}/act/process/">流程列表</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>运行中的流程</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 运行中的流程 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form id="searchForm" action="${ctx}/act/process/running/" method="post">
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <input type="text" id="procInsId" name="procInsId" value="${procInsId}" class="form-control"/>
                                            <label>流程实例ID</label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <input type="text" id="procDefKey" name="procDefKey" value="${procDefKey}" class="form-control"/>
                                            <label>流程定义Key</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" style="text-align: right;">
                                        <input id="btnSubmit" class="btn blue" type="submit" value="查 询" />
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <table id="contentTable" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr style="white-space: nowrap;">
                            <th>执行ID</th>
                            <th>流程实例ID</th>
                            <th>流程定义ID</th>
                            <th>当前环节</th>
                            <th>是否挂起</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="procIns">
                            <tr class="active">
                                <td>${procIns.id}</td>
                                <td>${procIns.processInstanceId}</td>
                                <td>${procIns.processDefinitionId}</td>
                                <td>${procIns.activityId}</td>
                                <td>${procIns.suspended}</td>
                                <td>
                                    <shiro:hasPermission name="act:process:edit">
                                        <a href="${ctx}/act/process/deleteProcIns?procInsId=${procIns.processInstanceId}&reason=" onclick="return Custom.initBootBoxConfirm('确认删除该正在运行的流程吗？', this.href);">删除流程</a>
                                    </shiro:hasPermission>&nbsp;
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div>${page}</div>
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
    function page(n, s) {
        Custom.initStartPageBlockUI();
        location = '${ctx}/act/process/running/?pageNo=' + n + '&pageSize=' + s;
    }
</script>
</body>
</html>