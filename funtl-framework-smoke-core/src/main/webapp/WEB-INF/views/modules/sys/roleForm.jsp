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
                        <span>角色${not empty role.id?'修改':'添加'}</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 角色${not empty role.id?'修改':'添加'} <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form:form id="inputForm" modelAttribute="role" action="${ctx}/sys/role/save" method="post">
                            <form:hidden path="id"/>
                            <div class="form-body">
                                <div id="messageBox" class="alert alert-danger ${empty message ? 'display-hide' : ''}">
                                    <button class="close" data-close="alert"></button> ${message}
                                </div>
                                <div class="form-group form-md-line-input">
                                    <sys:treeselect id="office" name="office.id" value="${role.office.id}" labelName="office.name" labelValue="${role.office.name}" title="归属机构" url="/sys/office/treeData" cssClass="required"/>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <input id="oldName" name="oldName" type="hidden" value="${role.name}">
                                    <form:input path="name" htmlEscape="false" class="form-control required"/>
                                    <label><span class="required">*</span> 角色名称</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <input id="oldEnname" name="oldEnname" type="hidden" value="${role.enname}">
                                    <form:input path="enname" htmlEscape="false" class="form-control required isEnglish"/>
                                    <label><span class="required">*</span> 英文名称</label>
                                    <span class="help-block">工作流用户组标识</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:select path="roleType" class="form-control">
                                        <form:option value="assignment">任务分配</form:option>
                                        <form:option value="security-role">管理角色</form:option>
                                        <form:option value="user">普通角色</form:option>
                                    </form:select>
                                    <label> 角色类型</label>
                                    <span class="help-block" title="activiti有3种预定义的组类型：security-role、assignment、user 如果使用Activiti Explorer，需要security-role才能看到manage页签，需要assignment才能claim任务">工作流组用户组类型（任务分配：assignment、管理角色：security-role、普通角色：user）</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:select path="sysData" class="form-control">
                                        <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                    </form:select>
                                    <label> 是否系统数据</label>
                                    <span class="help-block">“是”代表此数据只有超级管理员能进行修改，“否”则表示拥有角色修改人员的权限都能进行修改</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:select path="useable" class="form-control">
                                        <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                    </form:select>
                                    <label> 是否可用</label>
                                    <span class="help-block">“是”代表此数据可用，“否”则表示此数据不可用</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:select path="dataScope" class="form-control">
                                        <form:options items="${fns:getDictList('sys_data_scope')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                    </form:select>
                                    <label> 数据范围</label>
                                    <span class="help-block">殊情况下，设置为“按明细设置”，可进行跨机构授权</span>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
                                    <label> 备注</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <div class="row">
                                        <div class="portlet">
                                            <div class="portlet-title" style="padding-left: 18px;">
                                                角色授权
                                            </div>
                                            <div class="portlet-body">
                                                <div class="col-md-3">
                                                    <div id="menuTree" class="ztree"></div>
                                                    <form:hidden path="menuIds"/>
                                                </div>
                                                <div class="col-md-3">
                                                    <div id="officeTree" class="ztree"></div>
                                                    <form:hidden path="officeIds"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions" style="margin-top: 20px;">
                                <c:if test="${(role.sysData eq fns:getDictValue('是', 'yes_no', '1') && fns:getUser().admin)||!(role.sysData eq fns:getDictValue('是', 'yes_no', '1'))}">
                                    <shiro:hasPermission name="sys:role:edit"><input id="btnSubmit" class="btn blue" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
                                </c:if>
                                <input id="btnCancel" class="btn default" type="button" value="返 回" onclick="history.go(-1)"/>
                            </div>
                        </form:form>
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
        $("#name").focus();

        var form = $('#inputForm');
        var error = $('.alert-danger', form);
        var success = $('.alert-success', form);
        form.validate({
            errorElement: 'span',
            errorClass: 'help-block help-block-error',
            focusInvalid: false,
            ignore: "",
            errorContainer: "#messageBox",

            rules: {
                name: {remote: "${ctx}/sys/role/checkName?oldName=" + encodeURIComponent("${role.name}")},
                enname: {remote: "${ctx}/sys/role/checkEnname?oldEnname=" + encodeURIComponent("${role.enname}")}
            },
            messages: {
                name: {remote: "角色名已存在"},
                enname: {remote: "英文名已存在"}
            },

            invalidHandler: function (event, validator) {
                success.hide();
                error.show();
                App.scrollTo(error, -200);
            },

            errorPlacement: function (error, element) {
                $("#messageBox").text("表单填写时出现了一些问题，请仔细检查...");
                if (element.is(':checkbox')) {
                    error.insertAfter(element.closest(".md-checkbox-list, .md-checkbox-inline, .checkbox-list, .checkbox-inline"));
                } else if (element.is(':radio')) {
                    error.insertAfter(element.closest(".md-radio-list, .md-radio-inline, .radio-list,.radio-inline"));
                } else {
                    error.insertAfter(element);
                }
            },

            highlight: function (element) {
                $(element).closest('.form-group').addClass('has-error');
            },

            unhighlight: function (element) {
                $(element).closest('.form-group').removeClass('has-error');
            },

            success: function (label) {
                label.closest('.form-group').removeClass('has-error');
            },

            submitHandler: function (form) {
                var ids = [], nodes = tree.getCheckedNodes(true);
                for (var i = 0; i < nodes.length; i++) {
                    ids.push(nodes[i].id);
                }
                $("#menuIds").val(ids);
                var ids2 = [], nodes2 = tree2.getCheckedNodes(true);
                for (var i = 0; i < nodes2.length; i++) {
                    ids2.push(nodes2[i].id);
                }
                $("#officeIds").val(ids2);
                Custom.initStartPageBlockUI();
                form.submit();
            }
        });

        var setting = {
            check: {enable: true, nocheckInherit: true}, view: {selectedMulti: false},
            data: {simpleData: {enable: true}}, callback: {
                beforeClick: function (id, node) {
                    tree.checkNode(node, !node.checked, true, true);
                    return false;
                }
            }
        };

        // 用户-菜单
        var zNodes = [
                <c:forEach items="${menuList}" var="menu">{
                id: "${menu.id}",
                pId: "${not empty menu.parent.id?menu.parent.id:0}",
                name: "${not empty menu.parent.id?menu.name:'权限列表'}"
            },
            </c:forEach>];
        // 初始化树结构
        var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
        // 不选择父节点
        tree.setting.check.chkboxType = {"Y": "ps", "N": "s"};
        // 默认选择节点
        var ids = "${role.menuIds}".split(",");
        for (var i = 0; i < ids.length; i++) {
            var node = tree.getNodeByParam("id", ids[i]);
            try {
                tree.checkNode(node, true, false);
            } catch (e) {
            }
        }
        // 默认展开全部节点
        tree.expandAll(true);

        // 用户-机构
        var zNodes2 = [
                <c:forEach items="${officeList}" var="office">{
                id: "${office.id}",
                pId: "${not empty office.parent?office.parent.id:0}",
                name: "${office.name}"
            },
            </c:forEach>];
        // 初始化树结构
        var tree2 = $.fn.zTree.init($("#officeTree"), setting, zNodes2);
        // 不选择父节点
        tree2.setting.check.chkboxType = {"Y": "ps", "N": "s"};
        // 默认选择节点
        var ids2 = "${role.officeIds}".split(",");
        for (var i = 0; i < ids2.length; i++) {
            var node = tree2.getNodeByParam("id", ids2[i]);
            try {
                tree2.checkNode(node, true, false);
            } catch (e) {
            }
        }
        // 默认展开全部节点
        tree2.expandAll(true);
        // 刷新（显示/隐藏）机构
        refreshOfficeTree();
        $("#dataScope").change(function () {
            refreshOfficeTree();
        });
    });

    function refreshOfficeTree() {
        if ($("#dataScope").val() == 9) {
            $("#officeTree").show();
        } else {
            $("#officeTree").hide();
        }
    }
</script>
</body>
</html>