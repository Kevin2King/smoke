<%
    response.setStatus(400);

    // 获取异常类
    Throwable ex = Exceptions.getThrowable(request);
    Exception myException = new Exception();
    myException.addSuppressed(ex);
    LogUtils.saveLog(request, null, myException, "请求出错");

    // 编译错误信息
    StringBuilder sb = new StringBuilder("错误信息：\n");
    if (ex != null) {
        if (ex instanceof BindException) {
            for (ObjectError e : ((BindException) ex).getGlobalErrors()) {
                sb.append("☆" + e.getDefaultMessage() + "(" + e.getObjectName() + ")\n");
            }
            for (FieldError e : ((BindException) ex).getFieldErrors()) {
                sb.append("☆" + e.getDefaultMessage() + "(" + e.getField() + ")\n");
            }
            LoggerFactory.getLogger("400.jsp").warn(ex.getMessage(), ex);
        } else if (ex instanceof ConstraintViolationException) {
            for (ConstraintViolation<?> v : ((ConstraintViolationException) ex).getConstraintViolations()) {
                sb.append("☆" + v.getMessage() + "(" + v.getPropertyPath() + ")\n");
            }
        } else {
            //sb.append(Exceptions.getStackTraceAsString(ex));
            sb.append("☆" + ex.getMessage());
        }
    } else {
        sb.append("未知错误...");
    }

    // 如果是异步请求或是手机端，则直接返回信息
    if (Servlets.isAjaxRequest(request)) {
        out.print(sb);
    }

    // 输出异常信息页面
    else {
%>
<%@page import="javax.validation.ConstraintViolation" %>
<%@page import="javax.validation.ConstraintViolationException" %>
<%@page import="org.springframework.validation.BindException" %>
<%@page import="org.springframework.validation.ObjectError" %>
<%@page import="org.springframework.validation.FieldError" %>
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
    <title>${shop:shopTitle('productName')} - 请求出错</title>
    <%@include file="/WEB-INF/views/include/head.jsp" %>

    <link href="${cdn}/metronic/4.5.2/assets/pages/css/error.min.css" rel="stylesheet" type="text/css"/>
</head>
<body class="page-500-full-page">
<div class="row">
    <div class="row">
        <div class="col-md-12 page-500">
            <div class="number font-red"> 400</div>
            <div class="details">
                <h3>参数有误,服务器无法解析...</h3>
                <p>
                    <%=StringUtils.toHtml(sb.toString())%>
                </p>
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