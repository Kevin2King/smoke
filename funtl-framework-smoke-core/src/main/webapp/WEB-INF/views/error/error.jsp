<%
    response.setStatus(500);

    // 获取异常类
    Throwable ex = Exceptions.getThrowable(request);
    if (ex != null) {
        LoggerFactory.getLogger("500.jsp").error(ex.getMessage(), ex);
        Exception myException = new Exception();
        myException.addSuppressed(ex);
        LogUtils.saveLog(request, null, myException, "系统内部错误");
    }

    // 编译错误信息
    StringBuilder sb = new StringBuilder("详细信息：\n");
    if (ex != null) {
        sb.append(Exceptions.getStackTraceAsString(ex));
    } else {
        sb.append("未知错误...\n\n");
    }

    // 如果是异步请求或是手机端，则直接返回信息
    if (Servlets.isAjaxRequest(request)) {
        out.print(sb);
    }

    // 输出异常信息页面
    else {
%>
<%@page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
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
    <title>${shop:shopTitle('productName')} - 系统内部错误</title>
    <%@include file="/WEB-INF/views/include/head.jsp" %>

    <link href="${cdn}/metronic/4.5.2/assets/pages/css/error.min.css" rel="stylesheet" type="text/css"/>
</head>
<body class="page-500-full-page">
<div class="row">
    <div class="row">
        <div class="col-md-12 page-500">
            <div class="number font-red"> 500</div>
            <div class="details">
                <h3>系统内部错误...</h3>
                <p><a href="${ctx}/"> 返回首页 </a></p>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12" style="padding: 20px; padding-left: 50px;">
        <p>
            错误信息：<%=ex == null ? "未知错误..." : StringUtils.toHtml(ex.getMessage())%>
        </p>
        <p>
            <%=StringUtils.toHtml(sb.toString())%>
        </p>
    </div>
</div>
</body>
</html>
<%
    }
    out = pageContext.pushBody();
%>