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
    <sys:sidebar navItemName="通知管理" subMenuName="${oaNotify.self ? '我的通知' : '发布通知'}" />

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
                        <span>通知列表</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                    <shiro:hasPermission name="oa:oaNotify:edit">
                        <div class="btn-group pull-right">
                            <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                                操作 <i class="fa fa-angle-down"></i>
                            </button>
                            <ul class="dropdown-menu pull-right" role="menu">
                                <li>
                                    <a href="${ctx}/oa/oaNotify/form"><i class="icon-plus"></i> 发布通知 </a>
                                </li>
                            </ul>
                        </div>
                    </shiro:hasPermission>
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 通知列表 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form:form id="searchForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/${oaNotify.self?'self':''}" method="post">
                            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <form:input path="title" htmlEscape="false" maxlength="200" class="form-control"/>
                                            <label>标题</label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <form:select path="type" class="form-control">
                                                <form:option value="" label=""/>
                                                <form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                            </form:select>
                                            <label>类型</label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <c:if test="${!requestScope.oaNotify.self}">
                                                <form:select path="status" class="form-control">
                                                    <form:option value="" label=""/>
                                                    <form:options items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                                </form:select>
                                                <label>状态</label>
                                            </c:if>
                                        </div>
                                    </div>
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
                            <th>标题</th>
                            <th>类型</th>
                            <th>状态</th>
                            <th>查阅状态</th>
                            <th>更新时间</th>
                            <th>发布人</th>
                            <c:if test="${!oaNotify.self}">
                                <shiro:hasPermission name="oa:oaNotify:edit">
                                    <th>操作</th>
                                </shiro:hasPermission>
                            </c:if>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="oaNotify">
                            <tr class="active">
                                <td>
                                    <a href="${ctx}/oa/oaNotify/${requestScope.oaNotify.self?'view':'form'}?id=${oaNotify.id}">${fns:abbr(oaNotify.title,50)}</a>
                                </td>
                                <td>
                                        ${fns:getDictLabel(oaNotify.type, 'oa_notify_type', '')}
                                </td>
                                <td>
                                        ${fns:getDictLabel(oaNotify.status, 'oa_notify_status', '')}
                                </td>
                                <td>
                                    <c:if test="${requestScope.oaNotify.self}">
                                        <span class="${oaNotify.readFlag eq '0' ? 'font-red' : ''}">${fns:getDictLabel(oaNotify.readFlag, 'oa_notify_read', '')}</span>
                                    </c:if>
                                    <c:if test="${!requestScope.oaNotify.self}">
                                        ${oaNotify.readNum} / ${oaNotify.readNum + oaNotify.unReadNum}
                                    </c:if>
                                </td>
                                <td>
                                    <fmt:formatDate value="${oaNotify.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </td>
                                <td>${oaNotify.createBy.name}</td>
                                <c:if test="${!requestScope.oaNotify.self}">
                                    <shiro:hasPermission name="oa:oaNotify:edit">
                                        <td>
                                            <a href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}">修改</a>
                                            <a href="${ctx}/oa/oaNotify/delete?id=${oaNotify.id}" onclick="return Custom.initBootBoxConfirm('确认要删除该通知吗？', this.href)">删除</a>
                                        </td>
                                    </shiro:hasPermission>
                                </c:if>
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
    function page(n,s){
        Custom.initStartPageBlockUI();
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }
</script>
</body>
</html>