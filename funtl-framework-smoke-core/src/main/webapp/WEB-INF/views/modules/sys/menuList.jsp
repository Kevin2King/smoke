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
    <sys:sidebar navItemName="系统设置" subMenuName="菜单管理" />

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
                        <span>菜单列表</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                    <shiro:hasPermission name="sys:menu:edit">
                        <div class="btn-group pull-right">
                            <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                                操作 <i class="fa fa-angle-down"></i>
                            </button>
                            <ul class="dropdown-menu pull-right" role="menu">
                                <li>
                                    <a href="${ctx}/sys/menu/form"><i class="icon-plus"></i> 菜单添加 </a>
                                </li>
                            </ul>
                        </div>
                    </shiro:hasPermission>
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 菜单列表 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form">
                        <form id="listForm" method="post">
                            <table id="treeTable" class="table table-striped table-bordered table-hover table-condensed">
                                <thead>
                                <tr>
                                    <th>名称</th>
                                    <th>链接</th>
                                    <th style="text-align:center;">排序</th>
                                    <th>可见</th>
                                    <th>权限标识</th>
                                    <shiro:hasPermission name="sys:menu:edit">
                                        <th>操作</th>
                                    </shiro:hasPermission>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="menu">
                                    <tr id="${menu.id}" pId="${menu.parent.id ne '1' ? menu.parent.id:'0'}" class="active">
                                        <td nowrap>
                                            <i class="${not empty menu.icon ? menu.icon:' hide'}"></i>
                                            <a href="${ctx}/sys/menu/form?id=${menu.id}">${menu.name}</a>
                                        </td>
                                        <td title="${menu.href}">${fns:abbr(menu.href, 30)}</td>
                                        <td style="text-align:center;">
                                            <shiro:hasPermission name="sys:menu:edit">
                                                <input type="hidden" name="ids" value="${menu.id}"/>
                                                <input name="sorts" type="text" value="${menu.sort}" class="form-control input-sm input-inline" style="text-align: center; width: 50px;">
                                            </shiro:hasPermission>
                                            <shiro:lacksPermission name="sys:menu:edit">
                                                ${menu.sort}
                                            </shiro:lacksPermission>
                                        </td>
                                        <td>${menu.isShow eq '1'?'显示':'隐藏'}</td>
                                        <td title="${menu.permission}">${fns:abbr(menu.permission,30)}</td>
                                        <shiro:hasPermission name="sys:menu:edit">
                                            <td nowrap>
                                                <a href="${ctx}/sys/menu/form?id=${menu.id}">修改</a>
                                                <a href="${ctx}/sys/menu/delete?id=${menu.id}" onclick="return Custom.initBootBoxConfirm('要删除该菜单及所有子菜单项吗？', this.href);">删除</a>
                                                <a href="${ctx}/sys/menu/form?parent.id=${menu.id}">添加下级菜单</a>
                                            </td>
                                        </shiro:hasPermission>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </form>
                        <div class="form-actions" style="margin-top: 20px;">
                            <shiro:hasPermission name="sys:menu:edit">
                                <button id="btnSubmit" type="button" class="btn blue" onclick="updateSort();">保存排序</button>
                            </shiro:hasPermission>
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
    $(function() {
        $("#treeTable").treeTable({expandLevel : 2}).show();
    });

    function updateSort() {
        Custom.initStartPageBlockUI();
        $("#listForm").attr("action", "${ctx}/sys/menu/updateSort");
        $("#listForm").submit();
    }
</script>
</body>
</html>