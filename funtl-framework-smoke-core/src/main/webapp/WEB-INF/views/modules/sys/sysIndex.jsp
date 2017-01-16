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
    <sys:sidebar navItemName="" subMenuName="" />

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
                        <span>控制面板</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <span class="page-title" style="margin: 0px;padding: 0px;border: none;display: ${fns:isNewestVersion()?'none':'inline-block'};"><small>
                <a href="${ctx}/version/versionInfo/listing" class="font-red">
                    <marquee behavior="left" loop="-1" scrollamount="4" scrolldelay="10" hspace="15" vspace="0"
                             onmouseover="this.stop()" onmouseout="this.start()">
                        发现新版本啦！ 快去【系统设置】->【检查更新】->【立即更新】升级吧~~~<span style="margin: 0 30px 0 30px;">&nbsp;</span>
                        发现新版本啦！ 快去【系统设置】->【检查更新】->【立即更新】升级吧~~~<span style="margin: 0 30px 0 30px;">&nbsp;</span>
                        发现新版本啦！ 快去【系统设置】->【检查更新】->【立即更新】升级吧~~~<span style="margin: 0 30px 0 30px;">&nbsp;</span>
                        发现新版本啦！ 快去【系统设置】->【检查更新】->【立即更新】升级吧~~~<span style="margin: 0 30px 0 30px;">&nbsp;</span>
                        发现新版本啦！ 快去【系统设置】->【检查更新】->【立即更新】升级吧~~~
                    </marquee>
                </a></small>
            </span>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 控制面板 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN DASHBOARD STATS-->
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="dashboard-stat green">
                        <div class="visual">
                            <i class="icon-users"></i>
                        </div>
                        <div class="details">
                            <div class="number">
                                <span data-counter="counterup" data-value="${userCount}">0</span>个
                            </div>
                            <div class="desc"> 后台用户 </div>
                        </div>
                        <shiro:hasPermission name="sys:user:view">
                            <a class="more" href="${ctx}/sys/user">
                                查看 <i class="m-icon-swapright m-icon-white"></i>
                            </a>
                        </shiro:hasPermission>
                        <shiro:lacksPermission name="sys:user:view">
                            <a class="more" href="javascript:;"> &nbsp; </a>
                        </shiro:lacksPermission>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="dashboard-stat red">
                        <div class="visual">
                            <i class="fa fa-bug"></i>
                        </div>
                        <div class="details">
                            <div class="number">
                                <span data-counter="counterup" data-value="${logCount}">0</span>次
                            </div>
                            <div class="desc"> 系统异常 </div>
                        </div>
                        <shiro:hasPermission name="sys:log:view">
                            <a class="more" href="${ctx}/sys/log?exception=1">
                                查看 <i class="m-icon-swapright m-icon-white"></i>
                            </a>
                        </shiro:hasPermission>
                        <shiro:lacksPermission name="sys:log:view">
                            <a class="more" href="javascript:;"> &nbsp; </a>
                        </shiro:lacksPermission>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="dashboard-stat purple">
                        <div class="visual">
                            <i class="fa fa-battery-half"></i>
                        </div>
                        <div class="details">
                            <div class="number">
                                <span id="memoryPercent" data-counter="counterup" data-value="${memoryPercent}">0</span>%
                            </div>
                            <div class="desc"> 内存使用率 </div>
                        </div>
                        <a class="more" href="javascript:;"> &nbsp;
                            <%--<i class="m-icon-swapright m-icon-white"></i>--%>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="dashboard-stat blue">
                        <div class="visual">
                            <i class="fa fa-heartbeat"></i>
                        </div>
                        <div class="details">
                            <div class="number">
                                <span id="cpuCombined" data-counter="counterup" data-value="${cpuCombined}">0</span>%
                            </div>
                            <div class="desc"> CPU使用率 </div>
                        </div>
                        <a class="more" href="javascript:;"> &nbsp;
                            <%--<i class="m-icon-swapright m-icon-white"></i>--%>
                        </a>
                    </div>
                </div>
            </div>
            <!-- END DASHBOARD STATS-->

            <div class="clearfix"></div>

            <shiro:hasPermission name="sys:sigar:view">
                <div class="row">
                    <div class="col-md-6 col-sm-6">
                        <!-- BEGIN PORTLET-->
                        <div class="portlet light bordered">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="fa fa-battery-half font-purple"></i>
                                    <span class="caption-subject font-purple bold uppercase">内存监控</span>
                                </div>
                                <div class="actions">
                                </div>
                            </div>
                            <div class="portlet-body">
                                <div id="memChart" style="height: 300px;">

                                </div>
                            </div>
                        </div>
                        <!-- END PORTLET-->
                    </div>
                    <div class="col-md-6 col-sm-6">
                        <!-- BEGIN PORTLET-->
                        <div class="portlet light bordered">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="fa fa-heartbeat font-blue"></i>
                                    <span class="caption-subject font-blue bold uppercase">CPU监控</span>
                                </div>
                                <div class="actions">
                                </div>
                            </div>
                            <div class="portlet-body">
                                <div id="cpuChart" style="height: 300px;">

                                </div>
                            </div>
                        </div>
                        <!-- END PORTLET-->
                    </div>
                </div>
            </shiro:hasPermission>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <div class="portlet light bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-rocket font-blue"></i>
                                <span class="caption-subject font-blue bold uppercase">我的通知</span>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="scroller" data-always-visible="1" data-rail-visible="0">
                                <ul class="feeds">
                                    <c:forEach items="${oaNotifyList}" var="oaNotify" varStatus="status">
                                        <li>
                                            <div class="col1">
                                                <div class="cont">
                                                    <div class="cont-col1">
                                                        <div class="label label-sm label-info">
                                                            ${status.index + 1}
                                                        </div>
                                                    </div>
                                                    <div class="cont-col2">
                                                        <div class="desc">
                                                            <a href="${ctx}/oa/oaNotify/view?id=${oaNotify.id}">${oaNotify.title}</a>
                                                            <span class="label label-sm label-${oaNotify.readFlag eq '0' ? 'danger' : 'default'}"> ${oaNotify.readFlag eq '0' ? '未读' : '已读'} </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col2">
                                                <div class="date"> <fmt:formatDate value="${oaNotify.updateDate}" pattern="MM-dd"/> </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="scroller-footer">
                                <div class="btn-arrow-link pull-right">
                                    <a href="${ctx}/oa/oaNotify/self">全部通知</a>
                                    <i class="icon-arrow-right"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END CONTENT BODY -->
    </div>
    <!-- END CONTENT -->
</div>
<!-- END CONTAINER -->

<%@include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
    $(function () {
        <shiro:hasPermission name="sys:sigar:view">
        var memChart = echarts.init(document.getElementById('memChart'));
        var cpuChart = echarts.init(document.getElementById('cpuChart'));

        var memDate = [];
        var memData = [];
        var cpuDate = [];
        var cpuData = [];

        function addMemData(val) {
            var now = new Date();
            now = [now.getHours(), now.getMinutes().toString().length == 1 ? "0" + now.getMinutes() : now.getMinutes(), now.getSeconds().toString().length == 1 ? "0" + now.getSeconds() : now.getSeconds()].join(":");
            memDate.push(now);
            memData.push(val);
        }

        function addCpuData(val) {
            var now = new Date();
            now = [now.getHours(), now.getMinutes().toString().length == 1 ? "0" + now.getMinutes() : now.getMinutes(), now.getSeconds().toString().length == 1 ? "0" + now.getSeconds() : now.getSeconds()].join(":");
            cpuDate.push(now);
            cpuData.push(val);
        }

        memChart.setOption({
            title: {
                text: ''
            },

            tooltip : {
                trigger: 'axis',
                formatter: function (params) {
                    return '物理内存使用：' + params[0].value + 'M';
                }
            },

            color: ['#8E44AD'],

            grid: {
                top: 20,
                left: 0,
                right: '4%',
                bottom: '3%',
                containLabel: true
            },

            xAxis: {
                type: 'category',
                boundaryGap : false,
                data: memDate
            },

            yAxis: {
                max: ${memoryTotal},
                type: 'value'
            },

            series: [{
                name: '内存监控',
                type: 'line',
                smooth: true,
                symbol: 'none',
                stack: 'a',
                data: memData
            }]
        });

        cpuChart.setOption({
            title: {
                text: ''
            },

            tooltip : {
                trigger: 'axis',
                formatter: function (params) {
                    return 'CPU使用率：' + params[0].value + '%';
                }
            },

            color: ['#3598DC'],

            grid: {
                top: 20,
                left: 0,
                right: '4%',
                bottom: '3%',
                containLabel: true
            },

            xAxis: {
                type: 'category',
                boundaryGap : false,
                data: cpuDate
            },

            yAxis: {
                max: 100,
                type: 'value'
            },

            series: [{
                name: 'CPU监控',
                type: 'line',
                smooth: true,
                symbol: 'none',
                stack: 'a',
                data: cpuData
            }]
        });

        setInterval(function () {
            $.get(ctx + '/sys/sigar/all').done(function (json) {
                $("#memoryPercent").html(json.memoryPercent);
                $("#cpuCombined").html(json.cpuCombined);

                addMemData(json.memoryUsed);
                addCpuData(json.cpuCombined);

                memChart.setOption({
                    xAxis: {
                        data: memDate
                    },
                    series: [{
                        name:'内存监控',
                        data: memData
                    }]
                });

                cpuChart.setOption({
                    xAxis: {
                        data: cpuDate
                    },
                    series: [{
                        name:'CPU监控',
                        data: cpuData
                    }]
                });
            });
        }, 5000);
        </shiro:hasPermission>
    });
</script>
</body>
</html>