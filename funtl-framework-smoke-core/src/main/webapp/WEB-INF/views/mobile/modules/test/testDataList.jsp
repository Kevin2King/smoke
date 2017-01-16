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
    <sys:sidebar navItemName="生成案例" subMenuName="单表数据" />

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
                        <span>单表数据列表</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                    <shiro:hasPermission name="test:testData:edit">
                        <div class="btn-group pull-right">
                            <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                                操作 <i class="fa fa-angle-down"></i>
                            </button>
                            <ul class="dropdown-menu pull-right" role="menu">
                                <li>
                                    <a href="${ctx}/test/testData/form"><i class="icon-plus"></i> 单表数据添加 </a>
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
						<form:form id="searchForm" modelAttribute="testData" action="${ctx}/test/testData/" method="post">
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<div class="form-body">
								<div class="row">
									<div class="col-md-4">
										<div class="form-group form-md-line-input">
												<sys:treeselect id="user" name="user.id" value="${testData.user.id}" labelName="user.name" labelValue="${testData.user.name}" title="归属用户" url="/sys/office/treeData?type=3" cssClass="form-control" notAllowSelectParent="true" />
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group form-md-line-input">
												<sys:treeselect id="office" name="office.id" value="${testData.office.id}" labelName="office.name" labelValue="${testData.office.name}" title="归属部门" url="/sys/office/treeData?type=2" cssClass="form-control" notAllowSelectParent="true" />
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group form-md-line-input">
												<sys:treeselect id="area" name="area.id" value="${testData.area.id}" labelName="area.name" labelValue="${testData.area.name}" title="归属区域" url="/sys/area/treeData" cssClass="form-control" notAllowSelectParent="true"/>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-4">
										<div class="form-group form-md-line-input">
												<form:input path="name" htmlEscape="false" maxlength="100" class="form-control" />
												<label>名称</label>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group form-md-line-input">
												<form:select path="sex" class="form-control">
													<form:option value="" label=""/>
													<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" />
												</form:select>
												<label>性别</label>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group form-md-line-input">
												<div class="input-group date form_datetime">
													<input type="text" name="inDate" size="16" readonly class="form-control" value="<fmt:formatDate value="${testData.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" style="text-align: center;">
														<span class="input-group-btn">
															<button class="btn default date-set" type="button">
																<i class="fa fa-calendar"></i>
															</button>
														</span>
													<label>加入日期</label>
												</div>
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
							<th>归属用户</th>
							<th>归属部门</th>
							<th>归属区域</th>
							<th>名称</th>
							<th>性别</th>
							<th>加入日期</th>
							<th>更新时间</th>
							<th>备注信息</th>
							<shiro:hasPermission name="test:testData:edit"><th>操作</th></shiro:hasPermission>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="testData">
							<tr class="active">
								<td><a href="${ctx}/test/testData/form?id=${testData.id}">
									${testData.user.name}
								</a></td>
								<td>
									${testData.office.name}
								</td>
								<td>
									${testData.area.name}
								</td>
								<td>
									${testData.name}
								</td>
								<td>
									${fns:getDictLabel(testData.sex, 'sex', '')}
								</td>
								<td>
									<fmt:formatDate value="${testData.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									<fmt:formatDate value="${testData.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									${testData.remarks}
								</td>
								<shiro:hasPermission name="test:testData:edit"><td>
									<a href="${ctx}/test/testData/form?id=${testData.id}">修改</a>
									<a href="${ctx}/test/testData/delete?id=${testData.id}" onclick="return Custom.initBootBoxConfirm('确认要删除该单表数据吗？', this.href)">删除</a>
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