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
    <sys:sidebar navItemName="在线办公" subMenuName="我的任务"/>

    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <!-- BEGIN CONTENT BODY -->
        <div class="page-content">
            <!-- BEGIN PAGE HEADER-->

            <!-- BEGIN PAGE BAR -->
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li>
                        <a href="${ctx}/">首页</a> <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <a href="${ctx}/act/task/todo/">我的任务</a> <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>新建任务</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 新建任务
                <small></small>
            </h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="portlet light portlet-fit portlet-form bordered">
                    <div class="portlet-title">
                        <form id="searchForm" action="${ctx}/act/task/process/" method="post" class="form-horizontal">
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <label class="col-md-3 control-label">全部分类</label>
                                            <div class="col-md-9">
                                                <select id="category" name="category" class="form-control">
                                                    <option value="">全部分类</option>
                                                    <c:forEach items="${fns:getDictList('act_category')}" var="dict">
                                                        <option value="${dict.value}" ${dict.value==category?'selected':''}>${dict.label}</option>
                                                    </c:forEach> </select>
                                                <div class="form-control-focus"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" style="text-align: right;">
                                        <input id="btnSubmit" class="btn blue" type="submit" value="查 询"/>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="portlet-body">
                        <div class="table-scrollable" style="padding-left: 20px;">
                            <table id="contentTable" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr style="white-space: nowrap;">
                                        <th>流程分类</th>
                                        <th>流程标识</th>
                                        <th>流程名称</th>
                                        <th>流程图</th>
                                        <th>流程版本</th>
                                        <th>更新时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${page.list}" var="object">
                                    <c:set var="process" value="${object[0]}" />
                                    <c:set var="deployment" value="${object[1]}" />
                                    <tr class="active">
                                        <td>${fns:getDictLabel(process.category,'act_category','无分类')}</td>
                                        <td><a href="${ctx}/act/task/form?procDefId=${process.id}">${process.key}</a></td>
                                        <td>${process.name}</td>
                                        <td><a target="_blank" href="${pageContext.request.contextPath}/act/diagram-viewer?processDefinitionId=${process.id}">${process.diagramResourceName}</a></td>
                                        <td><b title='流程版本号'>V: ${process.version}</b></td>
                                        <td><fmt:formatDate value="${deployment.deploymentTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td>
                                            <a href="${ctx}/act/task/form?procDefId=${process.id}">启动流程</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div>${page}</div>
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
    function page(n, s) {
        Custom.initStartPageBlockUI();
        location = '${ctx}/act/task/process/?pageNo=' + n + '&pageSize=' + s;
    }
</script>
</body>
</html>