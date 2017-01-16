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
                        <span>流程列表</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                    <div class="btn-group pull-right">
                        <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                            操作 <i class="fa fa-angle-down"></i>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu">
                            <li>
                                <a href="${ctx}/act/process/deploy/"><i class="icon-plus"></i> 部署流程 </a>
                            </li>
                            <li>
                                <a href="${ctx}/act/process/running/"><i class="icon-plus"></i> 运行中的流程 </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 流程列表 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form id="searchForm" action="${ctx}/act/process/" method="post">
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
                        </form>
                    </div>
                    <table id="contentTable" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr style="white-space: nowrap;">
                            <th>流程分类</th>
                            <th>流程ID</th>
                            <th>流程标识</th>
                            <th>流程名称</th>
                            <th>流程版本</th>
                            <th>流程XML</th>
                            <th>流程图</th>
                            <th>部署时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="object">
                            <c:set var="process" value="${object[0]}" />
                            <c:set var="deployment" value="${object[1]}" />
                            <tr class="active">
                                <td><a href="javascript:updateCategory('${process.id}', '${process.category}')" title="设置分类">${fns:getDictLabel(process.category,'act_category','无分类')}</a></td>
                                <td>${process.id}</td>
                                <td>${process.key}</td>
                                <td>${process.name}</td>
                                <td><b title='流程版本号'>V: ${process.version}</b></td>
                                <td><a target="_blank" href="${ctx}/act/process/resource/read?procDefId=${process.id}&resType=xml">${process.resourceName}</a></td>
                                <td><a target="_blank" href="${ctx}/act/process/resource/read?procDefId=${process.id}&resType=image">${process.diagramResourceName}</a></td>
                                <td><fmt:formatDate value="${deployment.deploymentTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <c:if test="${process.suspended}">
                                        <a href="${ctx}/act/process/update/active?procDefId=${process.id}" onclick="return Custom.initBootBoxConfirm('确认要激活吗？', this.href)">激活</a>
                                    </c:if>
                                    <c:if test="${!process.suspended}">
                                        <a href="${ctx}/act/process/update/suspend?procDefId=${process.id}" onclick="return Custom.initBootBoxConfirm('确认挂起除吗？', this.href)">挂起</a>
                                    </c:if>
                                    <a href='${ctx}/act/process/delete?deploymentId=${process.deploymentId}' onclick="return Custom.initBootBoxConfirm('确认要删除该流程吗？', this.href)">删除</a>
                                    <a href='${ctx}/act/process/convert/toModel?procDefId=${process.id}' onclick="return Custom.initBootBoxConfirm('确认要转换为模型吗？', this.href)">转换为模型</a>
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
            <form id="categoryForm" action="${ctx}/act/process/updateCategory" method="post" class="form-horizontal" onsubmit="Custom.initStartPageBlockUI();">
                <input id="categoryBoxId" type="hidden" name="procDefId" value="" />
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
        location = '${ctx}/act/process/?pageNo=' + n + '&pageSize=' + s;
    }

    function updateCategory(id, category){
        $("#categoryBoxId").val(id);
        $("#categoryBoxCategory").val(category);
        $("#categoryModal").modal("show");
    }
</script>
</body>
</html>