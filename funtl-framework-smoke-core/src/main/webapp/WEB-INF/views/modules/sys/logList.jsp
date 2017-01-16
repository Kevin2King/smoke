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
    <sys:sidebar navItemName="日志查询" subMenuName="日志查询" />

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
                        <span>日志查询</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 日志列表 <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <form:form id="searchForm" action="${ctx}/sys/log/" method="post">
                            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <input name="title" type="text" class="form-control" value="${log.title}">
                                            <label>操作菜单</label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <input name="createBy.id" type="text" class="form-control" value="${log.createBy.id}">
                                            <label>用户标识</label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <input name="requestUri" type="text" class="form-control" value="${log.requestUri}">
                                            <label>URI</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group form-md-line-input">
                                            <div class="input-group date-picker input-daterange" data-date-format="yyyy-mm-dd">
                                                <input type="text" class="form-control" name="beginDate" value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>" style="text-align: center;" />
                                                <span class="input-group-addon"> 至 </span>
                                                <input type="text" class="form-control" name="endDate" value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" style="text-align: center;" />
                                                <label>日期范围</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group form-md-checkboxes" style="padding-top: 30px;">
                                            <div class="md-checkbox">
                                                <input id="checkbox_1" name="exception" type="checkbox" class="md-check" ${log.exception eq '1'?' checked':''} value="1">
                                                <label for="checkbox_1">
                                                    <span class="inc"></span>
                                                    <span class="check"></span>
                                                    <span class="box"></span> 只查询异常信息
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" style="text-align: right;">
                                        <input id="btnSubmit" class="btn blue" type="submit" value="查 询" onclick="Custom.initStartPageBlockUI()" />
                                    </div>
                                </div>
                            </div>
                        </form:form>
                    </div>
                    <table id="contentTable" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr style="white-space: nowrap;">
                            <th>操作菜单</th>
                            <th>操作用户</th>
                            <th>所在公司</th>
                            <th>所在部门</th>
                            <th>URI</th>
                            <th>提交方式</th>
                            <th>操作者IP</th>
                            <th>操作时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            request.setAttribute("strEnter", "\n");
                            request.setAttribute("strTab", "\t");
                        %>
                        <c:forEach items="${page.list}" var="log">
                            <tr class="active">
                                <c:choose>
                                    <c:when test="${not empty log.exception}">
                                        <td class="font-red"><strong>${log.title}</strong></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>${log.title}</td>
                                    </c:otherwise>
                                </c:choose>
                                <td>${log.createBy.name}</td>
                                <td>${log.createBy.company.name}</td>
                                <td>${log.createBy.office.name}</td>
                                <td><strong>${log.requestUri}</strong></td>
                                <td>${log.method}</td>
                                <td>${log.remoteAddr}</td>
                                <td><fmt:formatDate value="${log.createDate}" type="both"/></td>
                            </tr>
                            <c:if test="${not empty log.exception}">
                                <tr>
                                    <td colspan="8" style="word-wrap:break-word;word-break:break-all;">
                                        异常信息:
                                        <br/> ${fn:replace(fn:replace(fns:escapeHtml(log.exception), strEnter, '<br/>'), strTab, '&nbsp; &nbsp; ')}
                                    </td>
                                </tr>
                            </c:if>
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
</body>
</html>