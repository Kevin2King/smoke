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
                        <a href="${ctx}/act/model/">模型列表</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>新建模型</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 新建模型 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form id="inputForm" action="${ctx}/act/model/create" target="_blank" method="post">
                            <div class="form-body">
                                <div class="alert alert-danger display-hide">
                                    <button class="close" data-close="alert"></button><i class="fa fa-close"></i> 表单填写时出现了一些问题，请仔细检查...
                                </div>
                                <div class="alert alert-success display-hide">
                                    <button class="close" data-close="alert"></button><i class="fa fa-check"></i> 正在提交数据，请稍候...
                                </div>
                                <div class="form-group form-md-line-input">
                                    <select id="category" name="category" class="form-control required">
                                        <c:forEach items="${fns:getDictList('act_category')}" var="dict">
                                            <option value="${dict.value}">${dict.label}</option>
                                        </c:forEach>
                                    </select>
                                    <label> 流程分类</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <input id="name" name="name" type="text" class="form-control required" />
                                    <label> 模块名称</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <input id="key" name="key" type="text" class="form-control required" />
                                    <label> 模块标识</label>
                                </div>
                                <div class="form-group form-md-line-input">
                                    <textarea id="description" name="description" class="form-control required"></textarea>
                                    <label> 模块描述</label>
                                </div>
                            </div>
                            <div class="form-actions" style="margin-top: 20px;">
                                <input id="btnSubmit" class="btn blue" type="submit" value="保 存" onclick="goModal();" />&nbsp;
                                <input id="btnCancel" class="btn default" type="button" value="返 回" onclick="history.go(-1)"/>
                            </div>
                        </form>
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
<sys:validateForm form="inputForm" />
<script type="text/javascript">
    function goModal() {
        setTimeout(function () {
            location = '${ctx}/act/model/'
        }, 1000);
    }
</script>
</body>
</html>