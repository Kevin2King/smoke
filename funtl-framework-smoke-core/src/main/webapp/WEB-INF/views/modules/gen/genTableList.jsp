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
    <sys:sidebar navItemName="代码生成" subMenuName="业务表配置" />

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
                        <span>业务表列表</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                    <shiro:hasPermission name="gen:genTable:edit">
                        <div class="btn-group pull-right">
                            <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                                操作 <i class="fa fa-angle-down"></i>
                            </button>
                            <ul class="dropdown-menu pull-right" role="menu">
                                <li>
                                    <a href="${ctx}/gen/genTable/form"><i class="icon-plus"></i> 业务表添加 </a>
                                </li>
                            </ul>
                        </div>
                    </shiro:hasPermission>
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 业务表列表 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form:form id="searchForm" modelAttribute="genTable" action="${ctx}/gen/genTable/" method="post">
                            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                            <sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <form:input path="nameLike" htmlEscape="false" maxlength="50" class="form-control"/>
                                            <label>表名</label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <form:input path="comments" htmlEscape="false" maxlength="50" class="form-control"/>
                                            <label>说明</label>
                                        </div>
                                    </div>
                                        <%--<div class="col-md-4">--%>
                                        <%--<div class="form-group form-md-line-input">--%>
                                        <%--<label>父表表名</label>--%>
                                        <%--<div class="col-md-9">--%>
                                        <%--<form:input path="parentTable" htmlEscape="false" maxlength="50" class="form-control"/>--%>
                                        <%--<div class="form-control-focus"> </div>--%>
                                        <%--</div>--%>
                                        <%--</div>--%>
                                        <%--</div>--%>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" style="text-align: right;">
                                        <input id="btnSubmit" class="btn blue" type="submit" value="查 询" onclick="return page();" />
                                    </div>
                                </div>
                            </div>
                        </form:form>
                    </div>
                    <table id="contentTable" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr style="white-space: nowrap;">
                            <th class="sort-column name">表名</th>
                            <th>说明</th>
                            <th>主键名</th>
                            <th class="sort-column class_name">类名</th>
                            <%--<th class="sort-column parent_table">父表</th>--%>
                            <shiro:hasPermission name="gen:genTable:edit">
                                <th>操作</th>
                            </shiro:hasPermission>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="genTable">
                            <tr>
                                <td><a href="${ctx}/gen/genTable/form?id=${genTable.id}">${genTable.name}</a></td>
                                <td>${genTable.comments}</td>
                                <td>${genTable.primaryId}</td>
                                <td>${genTable.className}</td>
                                    <%--<td title="点击查询子表">--%>
                                    <%--<a href="javascript:" onclick="$('#parentTable').val('${genTable.parentTable}');$('#searchForm').submit();">${genTable.parentTable}</a>--%>
                                    <%--</td>--%>
                                <shiro:hasPermission name="gen:genTable:edit">
                                    <td>
                                        <a href="${ctx}/gen/genTable/form?id=${genTable.id}">修改</a>
                                        <a href="${ctx}/gen/genTable/delete?id=${genTable.id}" onclick="return Custom.initBootBoxConfirm('确认要删除该业务表吗？', this.href)">删除</a>
                                    </td>
                                </shiro:hasPermission>
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
        if (n) $("#pageNo").val(n);
        if (s) $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }
</script>
</body>
</html>