<%@ page contentType="text/html;charset=UTF-8" %>

<!-- BEGIN FOOTER -->
<div class="page-footer">
    <div class="page-footer-inner"> 2015-2017 &copy; ${shop:shopName('productName')}
    </div>
    <div class="scroll-to-top">
        <i class="icon-arrow-up"></i>
    </div>
</div>
<!-- END FOOTER -->

<!-- BEGIN MODAL -->
<div class="modal fade modal-scroll in" id="ajax" role="basic" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <img src="${cdn}/metronic/4.5.2/assets/global/img/loading-spinner-grey.gif" alt="" class="loading">
                <span> &nbsp;&nbsp;加载中... </span>
            </div>
        </div>
    </div>
</div>
<!-- END MODAL -->

<!--[if lt IE 9]>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/respond.min.js"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/excanvas.min.js"></script><![endif]-->

<!-- BEGIN CORE PLUGINS -->
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->

<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/moment.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-daterangepicker/daterangepicker.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-datepicker/js/cn/bootstrap-datepicker.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/morris/morris.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/morris/raphael-min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/counterup/jquery.waypoints.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/counterup/jquery.counterup.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/flot/jquery.flot.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/flot/jquery.flot.resize.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/flot/jquery.flot.categories.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/jquery-easypiechart/jquery.easypiechart.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/jquery.sparkline.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootbox/bootbox.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/mustache.min.js" type="text/javascript"></script>
<script src="${cdn}/plugins/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
<script src="${cdn}/plugins/jquery-validation/1.11.1/additional-methods.min.js" type="text/javascript"></script>
<script src="${cdn}/plugins/jquery-validation/1.11.1/localization/messages_zh.js" type="text/javascript"></script>
<script src="${cdn}/plugins/treeTable/jquery.treeTable.min.js" type="text/javascript"></script>
<script src="${cdn}/plugins/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script>
<script src="${cdn}/plugins/baidu-echarts/echarts.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->

<!-- BEGIN THEME GLOBAL SCRIPTS -->
<script src="${cdn}/metronic/4.5.2/assets/global/scripts/app.js" type="text/javascript"></script>
<!-- END THEME GLOBAL SCRIPTS -->

<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="${cdn}/metronic/4.5.2/assets/pages/scripts/components-date-time-pickers.js" type="text/javascript"></script>
<!-- END PAGE LEVEL SCRIPTS -->

<!-- BEGIN THEME LAYOUT SCRIPTS -->
<script src="${cdn}/metronic/4.5.2/assets/layouts/layout/scripts/layout.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/layouts/layout/scripts/demo.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/layouts/layout/scripts/custom.js" type="text/javascript"></script>
<!-- END THEME LAYOUT SCRIPTS -->

<sys:message content="${message}"/>
<script type="text/javascript">
    $(function() {
        // 加载遮罩
        $("a").each(function(){
            $(this).click(function () {
                var aHref = $(this).attr("href");
                var aTarget = $(this).attr("target");
                var aDataTarget = $(this).attr("data-target");
                var aHtml = $(this).html();
                if (aHref != null
                        && aHref != "undefined"
                        && aHref.indexOf("/a/") != -1
                        && (aTarget == null || aTarget == "" || aTarget == "undefined")
                        && (aDataTarget == null || aDataTarget == "" || aDataTarget == "undefined")
                        && aHtml.indexOf("删除") == -1
                        && aHtml.indexOf("部署") == -1
                        && aHtml.indexOf("激活") == -1
                        && aHtml.indexOf("挂起") == -1
                        && aHtml.indexOf("转换为模型") == -1
                        && aHtml.indexOf("下载模板") == -1
                        && aHtml.indexOf("归还") == -1) {
                    Custom.initStartPageBlockUI();
                }
            });
        });

        // checkbox样式
        $(".checkbox-list").find("label").each(function () {
           $(this).attr("style", "margin-right:50px;");
        });

        // 如果是微信浏览器则引入JSSDK
        if (Custom.initIsWeChat()) {
            wx.config({
                debug: false,
                appId: '${jsApiParam.appid}',
                timestamp: '${jsApiParam.timeStamp}',
                nonceStr: '${jsApiParam.nonceStr}',
                signature: '${jsApiParam.signature}',
                jsApiList: ['scanQRCode']
            });
        }
    });
</script>