<%
    response.setStatus(403);

    //获取异常类
    Throwable ex = Exceptions.getThrowable(request);
    Exception myException = new Exception();
    myException.addSuppressed(ex);
    LogUtils.saveLog(request, null, myException, "操作权限不足");

    // 如果是异步请求或是手机端，则直接返回信息
    if (Servlets.isAjaxRequest(request)) {
        if (ex != null && StringUtils.startsWith(ex.getMessage(), "msg:")) {
            out.print(StringUtils.replace(ex.getMessage(), "msg:", ""));
        } else {
            out.print("操作权限不足...");
        }
    }

    //输出异常信息页面
    else {
%>
<%@ page import="com.funtl.framework.core.utils.Exceptions" %>
<%@ page import="com.funtl.framework.smoke.core.modules.sys.utils.LogUtils" %>
<%@ page import="com.funtl.framework.smoke.core.commons.web.Servlets" %>
<%@ page import="com.funtl.framework.core.utils.StringUtils" %>
<%@page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html> <!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]--> <!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]--> <!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->
<head>
    <title>${shop:shopTitle('productName')} - 操作权限不足</title>
    <%@include file="/WEB-INF/views/include/head.jsp" %>

    <link href="${cdn}/metronic/4.5.2/assets/pages/css/error.min.css" rel="stylesheet" type="text/css"/>
</head>
<body class="page-500-full-page">
<div class="row">
    <div class="row">
        <div class="col-md-12 page-500">
            <div class="number font-red"> 403</div>
            <div class="details">
                <h3>操作权限不足...</h3>
                <%
                    if (ex != null && StringUtils.startsWith(ex.getMessage(), "msg:")) {
                        out.print("<p>" + StringUtils.replace(ex.getMessage(), "msg:", "") + " </p>");
                    }
                %>
                <p><a href="${ctx}/"> 返回首页 </a></p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<%
    }
    out = pageContext.pushBody();
%>