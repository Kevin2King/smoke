<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<meta charset="utf-8"/>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta content="width=device-width, initial-scale=1" name="viewport" />

<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="${ctxStatic}/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css"/>
<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL PLUGINS -->
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css"/>
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-daterangepicker/daterangepicker.min.css" rel="stylesheet" type="text/css"/>
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css" rel="stylesheet" type="text/css" />
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/morris/morris.css" rel="stylesheet" type="text/css"/>
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css"/>
<link href="${cdn}/plugins/jquery-validation/1.11.0/jquery.validate.min.css" rel="stylesheet" type="text/css"/>
<link href="${cdn}/plugins/treeTable/themes/vsStyle/treeTable.min.css" rel="stylesheet" type="text/css"/>
<link href="${cdn}/plugins/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
<link href="${cdn}/metronic/4.5.2/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
<!-- END PAGE LEVEL PLUGINS -->

<!-- BEGIN THEME GLOBAL STYLES -->
<link href="${cdn}/metronic/4.5.2/assets/global/css/components-rounded.min.css" rel="stylesheet" id="style_components" type="text/css"/>
<link href="${cdn}/metronic/4.5.2/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css"/>
<!-- END THEME GLOBAL STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->
<link href="${cdn}/metronic/4.5.2/assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css"/>
<link href="${cdn}/metronic/4.5.2/assets/layouts/layout/css/themes/darkblue.min.css" rel="stylesheet" type="text/css" id="style_color"/>
<link href="${ctxStatic}/assets/layouts/layout/css/custom.css" rel="stylesheet" type="text/css"/>
<!-- END PAGE LEVEL STYLES -->
<c:set value="${shop:shopIcon()}" var="icon_shop" />
<c:if test="${empty icon_shop}">
    <link rel="icon" href="${ctxStatic}/favicon.ico"/>
</c:if>
<c:if test="${not empty icon_shop}">
    <link rel="icon" href="${icon_shop}"/>
</c:if>

<script src="${cdn}/metronic/4.5.2/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/baidu-ueditor/ueditor.config.js" type="text/javascript"></script>
<script src="${ctxStatic}/baidu-ueditor/ueditor.all.js" type="text/javascript"></script>
<script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}';</script>