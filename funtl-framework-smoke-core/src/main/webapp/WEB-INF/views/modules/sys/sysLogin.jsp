<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html> <!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]--> <!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]--> <!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->

<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8"/>
    <title>${shop:shopTitle('productName')} 登录</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>

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
    <link href="${cdn}/plugins/jquery-validation/1.11.0/jquery.validate.min.css" rel="stylesheet" type="text/css"/>
    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN THEME GLOBAL STYLES -->
    <link href="${cdn}/metronic/4.5.2/assets/global/css/components-rounded.min.css" rel="stylesheet" id="style_components" type="text/css"/>
    <link href="${cdn}/metronic/4.5.2/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css"/>
    <!-- END THEME GLOBAL STYLES -->

    <!-- BEGIN PAGE LEVEL STYLES -->
    <link href="${cdn}/metronic/4.5.2/assets/pages/css/login.min.css" rel="stylesheet" type="text/css"/>
    <!-- END PAGE LEVEL STYLES -->
    <link rel="shortcut icon" href="favicon.ico"/>
</head>

<style type="text/css">
    body {
        font-family: 'Microsoft YaHei', 'simsun', 'Helvetica Neue', Arial, Helvetica, sans-serif;
    }
</style>
<!-- END HEAD -->

<body class=" login">
<div class="menu-toggler sidebar-toggler"></div>
<!-- END SIDEBAR TOGGLER BUTTON -->
<!-- BEGIN LOGO -->
<div class="logo font-red-intense">
    <h1>${shop:shopTitle('productName')}</h1>
</div>
<!-- END LOGO -->

<!-- BEGIN LOGIN -->
<div class="content">
    <!-- BEGIN LOGIN FORM -->
    <form id="login-form" class="login-form" action="${ctx}/login" method="post">
        <h3 class="form-title font-green">系统登录</h3>
        <div id="messageBox" class="alert alert-danger ${empty message ? 'display-hide' : ''}">
            <button class="close" data-close="alert"></button>
            <span id="loginError"> ${message} </span>
        </div>
        <div class="form-group">
            <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
            <label class="control-label visible-ie8 visible-ie9">登录账号</label>
            <input class="form-control form-control-solid placeholder-no-fix required" type="text" autocomplete="off" placeholder="登录账号" name="username" value="${username}"/>
        </div>
        <div class="form-group">
            <label class="control-label visible-ie8 visible-ie9">登录密码</label>
            <input class="form-control form-control-solid placeholder-no-fix required" type="password" autocomplete="off" placeholder="登录密码" name="password"/>
        </div>
        <c:if test="${isValidateCodeLogin}">
            <div class="validateCode">
                <label class="control-label visible-ie8 visible-ie9">验证码</label>
                <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
            </div>
        </c:if>
        <div class="form-actions">
            <button type="submit" class="btn green uppercase">登录</button>
            <label class="rememberme check"> <input type="checkbox" name="rememberMe" ${rememberMe ? 'checked' : ''}/>记住我
            </label> <a href="javascript:;" id="forget-password" class="forget-password">忘记密码？</a>
        </div>
    </form>
    <!-- END LOGIN FORM -->

    <!-- BEGIN FORGOT PASSWORD FORM -->
    <form class="forget-form" action="" method="post">
        <h3 class="font-green">忘记密码？</h3>
        <p> 请联系管理员修改 </p>
        <div class="form-actions">
            <button type="button" id="back-btn" class="btn btn-default">后退</button>
        </div>
    </form>
    <!-- END FORGOT PASSWORD FORM -->
</div>

<div class="copyright"> 2015-2016 © ${shop:shopTitle('productName')}</div>

<!--[if lt IE 9]>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/respond.min.js"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/excanvas.min.js"></script><![endif]-->

<!-- BEGIN CORE PLUGINS -->
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->

<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/jquery-validation/js/jquery.validate.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/jquery-validation/js/additional-methods.min.js" type="text/javascript"></script>
<script src="${cdn}/metronic/4.5.2/assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
<script src="${cdn}/plugins/jquery-validation/1.11.0/jquery.validate.min.js" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->

<!-- BEGIN THEME GLOBAL SCRIPTS -->
<script src="${cdn}/metronic/4.5.2/assets/global/scripts/app.min.js" type="text/javascript"></script>
<!-- END THEME GLOBAL SCRIPTS -->

<!-- BEGIN PAGE LEVEL SCRIPTS -->
<!-- END PAGE LEVEL SCRIPTS -->

<script type="text/javascript">
    $(function () {
        $(".login-form").validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                validateCode: {
                    remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"
                },
                username: {
                    required: true
                },
                password: {
                    required: true
                },
                remember: {
                    required: false
                }
            },

            messages: {
                username: {
                    required: "请填写用户名."
                },
                password: {
                    required: "请填写密码."
                },
                validateCode: {
                    remote: "验证码不正确.",
                    required: "请填写验证码."
                }
            },
            errorLabelContainer: "#messageBox",
            errorPlacement: function (error, element) {
                error.appendTo($("#loginError").parent());
            }
        });
    });
</script>
<script src="${cdn}/metronic/4.5.2/assets/pages/scripts/login.min.js" type="text/javascript"></script>
</body>
</html>