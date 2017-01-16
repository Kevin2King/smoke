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
    <sys:sidebar navItemName="机构用户" subMenuName="用户管理" />

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
                        <span>用户管理</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                    <shiro:hasPermission name="sys:user:edit">
                        <div class="btn-group pull-right">
                            <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                                操作 <i class="fa fa-angle-down"></i>
                            </button>
                            <ul class="dropdown-menu pull-right" role="menu">
                                <li>
                                    <a href="${ctx}/sys/user/form"><i class="icon-plus"></i> 用户添加 </a>
                                </li>
                                <li>
                                    <a href="javascript:;" data-target="#importUser" data-toggle="modal"><i class="fa fa-file-excel-o"></i> 导入用户 </a>
                                </li>
                                <li>
                                    <a id="btnExport" href="javascript:;"><i class="fa fa-file-excel-o"></i> 导出用户 </a>
                                </li>
                            </ul>
                        </div>
                    </shiro:hasPermission>
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 用户列表 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN IMPORT MODAL -->
            <div class="modal fade modal-scroll in" id="importUser" role="basic" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                            <h4 class="modal-title">导入用户</h4>
                        </div>
                        <div class="modal-body">
                            <form id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data" onsubmit="Custom.initStartPageBlockUI();">
                                <input id="uploadFile" name="file" type="file" style="width:330px"/>
                                <br />
                                <input id="btnImportSubmit" class="btn blue" type="submit" value="导入"/>
                                <a href="${ctx}/sys/user/import/template">下载模板</a>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn default" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END IMPORT MODAL -->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/list" method="post">
                            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                            <sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}" title="归属公司" url="/sys/office/treeData?type=1" />
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" title="归属部门" url="/sys/office/treeData?type=2" notAllowSelectParent="false" />
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <form:input path="loginName" htmlEscape="false" maxlength="50" class="form-control"/>
                                            <label>登录名</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <form:input path="name" htmlEscape="false" maxlength="50" class="form-control"/>
                                            <label>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</label>
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
                            <th>归属公司</th>
                            <th>归属部门</th>
                            <th class="sort-column login_name">登录名</th>
                            <th class="sort-column name">姓名</th>
                            <th>电话</th>
                            <th>手机</th>
                            <shiro:hasPermission name="sys:user:edit">
                                <th>操作</th>
                            </shiro:hasPermission>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="user">
                            <tr class="active">
                                <td>${user.company.name}</td>
                                <td>${user.office.name}</td>
                                <td><a href="${ctx}/sys/user/form?id=${user.id}">${user.loginName}</a></td>
                                <td>${user.name}</td>
                                <td>${user.phone}</td>
                                <td>${user.mobile}</td>
                                <shiro:hasPermission name="sys:user:edit">
                                    <td>
                                        <a href="${ctx}/sys/user/form?id=${user.id}">修改</a>
                                        <a href="${ctx}/sys/user/delete?id=${user.id}" onclick="return Custom.initBootBoxConfirm('确认要删除该用户吗？', this.href)">删除</a>
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
    $(function() {
        $("#btnExport").click(function(){
            bootbox.dialog({
                message: "确定要导出用户数据吗？",
                title: "温馨提示",
                buttons: {
                    danger: {
                        label: "取消",
                        className: "default",
                        callback: function() {

                        }
                    },
                    main: {
                        label: "确定",
                        className: "blue",
                        callback: function() {
                            $("#searchForm").attr("action","${ctx}/sys/user/export");
                            $("#searchForm").submit();
                        }
                    }
                }
            });
        });
    });

    function page(n,s){
        Custom.initStartPageBlockUI();
        if(n) $("#pageNo").val(n);
        if(s) $("#pageSize").val(s);
        $("#searchForm").attr("action","${ctx}/sys/user/list");
        $("#searchForm").submit();
        return false;
    }
</script>
</body>
</html>