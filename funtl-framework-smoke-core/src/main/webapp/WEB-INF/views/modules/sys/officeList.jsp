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
    <sys:sidebar navItemName="机构用户" subMenuName="机构管理" />

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
                        <span>机构管理</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                    <shiro:hasPermission name="sys:office:edit">
                        <div class="btn-group pull-right">
                            <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                                操作 <i class="fa fa-angle-down"></i>
                            </button>
                            <ul class="dropdown-menu pull-right" role="menu">
                                <li>
                                    <a href="${ctx}/sys/office/form?parent.id=${office.id}"><i class="icon-plus"></i> 机构添加
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </shiro:hasPermission>
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 机构列表 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form">
                        <table id="treeTable" class="table table-striped table-bordered table-hover table-condensed">
                            <thead>
                            <tr>
                                <th>机构名称</th>
                                <th>归属区域</th>
                                <th>机构编码</th>
                                <th>机构类型</th>
                                <th>备注</th>
                                <shiro:hasPermission name="sys:office:edit">
                                    <th>操作</th>
                                </shiro:hasPermission>
                            </tr>
                            </thead>
                            <tbody id="treeTableList"></tbody>
                        </table>
                        <script type="text/template" id="treeTableTpl">
                            <tr id="{{row.id}}" pId="{{pid}}" class="active">
                                <td><a href="${ctx}/sys/office/form?id={{row.id}}" onclick="Custom.initStartPageBlockUI();">{{row.name}}</a></td>
                                <td>{{row.area.name}}</td>
                                <td>{{row.code}}</td>
                                <td>{{dict.type}}</td>
                                <td>{{row.remarks}}</td>
                                <shiro:hasPermission name="sys:office:edit">
                                    <td>
                                        <a href="${ctx}/sys/office/form?id={{row.id}}" onclick="Custom.initStartPageBlockUI();">修改</a>
                                        <a href="${ctx}/sys/office/delete?id={{row.id}}" onclick="return Custom.initBootBoxConfirm('要删除该机构及所有子机构项吗？', this.href)">删除</a>
                                        <a href="${ctx}/sys/office/form?parent.id={{row.id}}" onclick="Custom.initStartPageBlockUI();">添加下级机构</a>
                                    </td>
                                </shiro:hasPermission>
                            </tr>
                        </script>
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
    $(function () {
        var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g, "");
        var data = ${fns:toJson(list)}, rootId = "${not empty office.id ? office.id : '0'}";
        addRow("#treeTableList", tpl, data, rootId, true);
        $("#treeTable").treeTable({expandLevel: 5});
    });

    function addRow(list, tpl, data, pid, root) {
        for (var i = 0; i < data.length; i++) {
            var row = data[i];
            if ((${fns:jsGetVal('row.parentId')}) == pid) {
                $(list).append(Mustache.render(tpl, {
                    dict: {
                        type: Custom.initGetDictLabel(${fns:toJson(fns:getDictList('sys_office_type'))}, row.type)
                    }, pid: (root ? 0 : pid), row: row
                }));
                addRow(list, tpl, data, row.id);
            }
        }
    }
</script>
</body>
</html>