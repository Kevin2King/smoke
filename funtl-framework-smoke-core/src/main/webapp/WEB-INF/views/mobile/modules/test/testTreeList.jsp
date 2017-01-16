<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html> <!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]--> <!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]--> <!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->

<!-- BEGIN HEAD -->
<head>
    <title>${shop:shopTitle('productName')}</title>
    <meta name="decorator" content="mobile"/>
</head>
<!-- END HEAD -->

<body class="page-header-static page-sidebar-closed-hide-logo page-content-white">
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <sys:sidebar navItemName="生成案例" subMenuName="树结构表" />

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
                        <span>树结构表列表</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                    <shiro:hasPermission name="test:testTree:edit">
                        <div class="btn-group pull-right">
                            <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                                操作 <i class="fa fa-angle-down"></i>
                            </button>
                            <ul class="dropdown-menu pull-right" role="menu">
                                <li>
                                    <a href="${ctx}/test/testTree/form"><i class="icon-plus"></i> 树结构表添加 </a>
                                </li>
                            </ul>
                        </div>
                    </shiro:hasPermission>
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
            	<div class="col-md-12">
            		<div class="portlet light portlet-fit portlet-form bordered">
						<form:form id="searchForm" modelAttribute="testTree" action="${ctx}/test/testTree/" method="post">
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<div class="form-body">
								<div class="row">
									<div class="col-md-4">
										<div class="form-group form-md-line-input">
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group form-md-line-input">
												<form:input path="name" htmlEscape="false" maxlength="100" class="form-control" />
												<label>名称</label>
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
							<th>父级编号</th>
							<th>名称</th>
							<th>更新时间</th>
							<th>备注信息</th>
							<shiro:hasPermission name="test:testTree:edit"><th>操作</th></shiro:hasPermission>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="testTree">
							<tr class="active">
								<td><a href="${ctx}/test/testTree/form?id=${testTree.id}">
									${testTree.parent.id}
								</a></td>
								<td>
									${testTree.name}
								</td>
								<td>
									<fmt:formatDate value="${testTree.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									${testTree.remarks}
								</td>
								<shiro:hasPermission name="test:testTree:edit"><td>
									<a href="${ctx}/test/testTree/form?id=${testTree.id}">修改</a>
									<a href="${ctx}/test/testTree/delete?id=${testTree.id}" onclick="return Custom.initBootBoxConfirm('确认要删除该树结构表吗？', this.href)">删除</a>
								</td></shiro:hasPermission>
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
<sys:scrolltable table="contentTable" />
</body>
</html>