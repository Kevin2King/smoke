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
    <sys:sidebar navItemName="系统设置" subMenuName="角色管理" />

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
                        <a href="${ctx}/sys/role/">角色列表</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>角色分配</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                    <shiro:hasPermission name="sys:role:edit">
                        <div class="btn-group pull-right">
                            <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                                操作 <i class="fa fa-angle-down"></i>
                            </button>
                            <ul class="dropdown-menu pull-right" role="menu">
                                <li>
                                    <a href="${ctx}/sys/role/usertorole?id=${role.id}" data-target="#ajax" data-toggle="modal"><i class="icon-user"></i> 角色分配 </a>
                                </li>
                            </ul>
                        </div>
                    </shiro:hasPermission>
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 角色分配 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <div class="form-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group form-md-line-input">
                                        <input type="text" class="form-control" readonly="readonly" value="${role.name}" />
                                        <label>角色名称</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group form-md-line-input">
                                        <input type="text" class="form-control" readonly="readonly" value="${role.office.name}" />
                                        <label>归属机构</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group form-md-line-input">
                                        <input type="text" class="form-control" readonly="readonly" value="${role.enname}" />
                                        <label>英文名称</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group form-md-line-input">
                                        <input type="text" class="form-control" readonly="readonly" value="${role.roleType}" />
                                        <label>角色类型</label>
                                    </div>
                                </div>
                                <c:set var="dictvalue" value="${role.dataScope}" scope="page" />
                                <div class="col-md-4">
                                    <div class="form-group form-md-line-input">
                                        <input type="text" class="form-control" readonly="readonly" value="${fns:getDictLabel(dictvalue, 'sys_data_scope', '')}" />
                                        <label>数据范围</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <form id="assignRoleForm" action="${ctx}/sys/role/assignrole" method="post" class="hide">
                        <input type="hidden" name="id" value="${role.id}"/>
                        <input id="idsArr" type="hidden" name="idsArr" value=""/>
                    </form>
                    <table id="contentTable" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr style="white-space: nowrap;">
                            <th>归属公司</th>
                            <th>归属部门</th>
                            <th>登录名</th>
                            <th>姓名</th>
                            <th>电话</th>
                            <th>手机</th>
                            <shiro:hasPermission name="sys:user:edit">
                                <th>操作</th>
                            </shiro:hasPermission>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${userList}" var="user">
                            <tr class="active">
                                <td>${user.company.name}</td>
                                <td>${user.office.name}</td>
                                <td><a href="${ctx}/sys/user/form?id=${user.id}">${user.loginName}</a></td>
                                <td>${user.name}</td>
                                <td>${user.phone}</td>
                                <td>${user.mobile}</td>
                                <shiro:hasPermission name="sys:role:edit">
                                    <td>
                                        <a href="${ctx}/sys/role/outrole?userId=${user.id}&roleId=${role.id}" onclick="return Custom.initBootBoxConfirm('确认要将用户<b>[${user.name}]</b>从<b>[${role.name}]</b>角色中移除吗？', this.href)">删除</a>
                                    </td>
                                </shiro:hasPermission>
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