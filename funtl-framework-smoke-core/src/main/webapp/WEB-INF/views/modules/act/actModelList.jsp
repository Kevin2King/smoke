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
    <sys:sidebar navItemName="流程管理" subMenuName="模型管理" />

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
                        <span>模型列表</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                    <div class="btn-group pull-right">
                        <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                            操作 <i class="fa fa-angle-down"></i>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu">
                            <li>
                                <a href="${ctx}/act/model/create"><i class="icon-plus"></i> 新建模型 </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 模型列表 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form:form id="searchForm" action="${ctx}/act/model/" method="post">
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <select id="category" name="category" class="form-control">
                                                <option value="">全部分类</option>
                                                <c:forEach items="${fns:getDictList('act_category')}" var="dict">
                                                    <option value="${dict.value}" ${dict.value==category?'selected':''}>${dict.label}</option>
                                                </c:forEach>
                                            </select>
                                            <label>流程分类</label>
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
                    <table id="contentTable" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr style="white-space: nowrap;">
                            <th>流程分类</th>
                            <th>模型ID</th>
                            <th>模型标识</th>
                            <th>模型名称</th>
                            <th>版本号</th>
                            <th>创建时间</th>
                            <th>最后更新时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="model">
                            <tr class="active">
                                <td><a href="javascript:updateCategory('${model.id}', '${model.category}');">${fns:getDictLabel(model.category,'act_category','无分类')}</a></td>
                                <td>${model.id}</td>
                                <td>${model.key}</td>
                                <td>${model.name}</td>
                                <td><b title='流程版本号'>V: ${model.version}</b></td>
                                <td><fmt:formatDate value="${model.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td><fmt:formatDate value="${model.lastUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/act/process-editor/modeler.jsp?modelId=${model.id}" target="_blank">编辑</a>
                                    <a href="${ctx}/act/model/deploy?id=${model.id}" onclick="return Custom.initBootBoxConfirm('确认要部署该模型吗？', this.href)">部署</a>
                                    <a href="${ctx}/act/model/export?id=${model.id}" target="_blank">导出</a>
                                    <a href="${ctx}/act/model/delete?id=${model.id}" onclick="return Custom.initBootBoxConfirm('确认要删除该模型吗？', this.href)">删除</a>
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

<!-- BEGIN MODAL -->
<div class="modal fade modal-scroll in" id="categoryModal" role="basic" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="categoryForm" action="${ctx}/act/model/updateCategory" method="post" class="form-horizontal" onsubmit="Custom.initStartPageBlockUI();">
                <input id="categoryBoxId" type="hidden" name="id" value="" />
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">设置分类</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group form-md-line-input">
                        <div style="padding-left:20px; padding-right: 20px;">
                            <select id="categoryBoxCategory" name="category" class="form-control">
                                <c:forEach items="${fns:getDictList('act_category')}" var="dict">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input id="categorySubmit" class="btn blue" type="submit" value="  保  存  "/>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- END MODAL -->

<%@include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
    function page(n,s){
        Custom.initStartPageBlockUI();
        location = '${ctx}/act/model/?pageNo=' + n + '&pageSize=' + s;
    }

    function updateCategory(id, category){
        $("#categoryBoxId").val(id);
        $("#categoryBoxCategory").val(category);
        $("#categoryModal").modal("show");
    }
</script>
</body>
</html>