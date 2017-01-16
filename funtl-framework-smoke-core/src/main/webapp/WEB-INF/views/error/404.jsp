<%
    response.setStatus(404);

    // 如果是异步请求或是手机端，则直接返回信息
    if (Servlets.isAjaxRequest(request)) {
        out.print("页面不存在...");
    }

    //输出异常信息页面
    else {
%>
<%@ page import="com.funtl.framework.smoke.core.commons.web.Servlets" %>
<%@page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html> <!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]--> <!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]--> <!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->
<head>
    <title>${shop:shopTitle('productName')} - 页面不存在</title>
    <%@include file="/WEB-INF/views/include/head.jsp" %>

    <link href="${cdn}/metronic/4.5.2/assets/pages/css/error.min.css" rel="stylesheet" type="text/css" />
</head>
<body class="page-404-full-page">
    <div class="row">
        <div class="col-md-12 page-404">
            <div class="number font-red"> 404 </div>
            <div class="details">
                <h3>页面不存在...</h3>
                <p> <a href="${ctx}/"> 返回首页 </a> </p>
            </div>
        </div>
    </div>
</body>
</html>
<%
        out.print("<!--" + request.getAttribute("javax.servlet.forward.request_uri") + "-->");
    }
    out = pageContext.pushBody();
%>