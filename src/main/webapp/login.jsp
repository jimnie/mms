<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/common/global.jsp" %>
<%@page import="com.educonsulting.mms.Setting" %>
<%@page import="com.educonsulting.mms.Setting.AccountLockType" %>
<%@page import="com.educonsulting.mms.service.RSAService" %>
<%@page import="com.educonsulting.mms.util.SettingUtils" %>
<%@page import="org.apache.commons.codec.binary.Base64" %>
<%@page import="org.apache.commons.lang.ArrayUtils" %>
<%@page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter" %>
<%@page import="org.springframework.context.ApplicationContext" %>
<%@page import="java.security.interfaces.RSAPublicKey" %>
<%@taglib prefix="shiro" uri="/WEB-INF/tld/shiro.tld" %>
<%
    ApplicationContext applicationContext = SpringUtils.getApplicationContext();
    Setting setting = SettingUtils.get();
    if (applicationContext != null) {
%>
<shiro:authenticated>
    <%
        response.sendRedirect(base + "/common/main");
    %>
</shiro:authenticated>
<%
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <link rel="shortcut icon" href="<%=base%>/resources/images/favorite.ico" type="image/x-icon"/>
    <%
        if (applicationContext != null) {
            RSAService rsaService = SpringUtils.getBean("rsaServiceImpl", RSAService.class);
            RSAPublicKey publicKey = rsaService.generateKey(request);
            String modulus = Base64.encodeBase64String(publicKey.getModulus().toByteArray());
            String exponent = Base64.encodeBase64String(publicKey.getPublicExponent().toByteArray());

            String message = null;
            String loginFailure = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
            if (loginFailure != null) {
                if (loginFailure.equals("org.apache.shiro.authc.UnknownAccountException")) {
                    message = "sys.login.unknownAccount";
                } else if (loginFailure.equals("org.apache.shiro.authc.DisabledAccountException")) {
                    message = "sys.login.disabledAccount";
                } else if (loginFailure.equals("org.apache.shiro.authc.LockedAccountException")) {
                    message = "sys.login.lockedAccount";
                } else if (loginFailure.equals("org.apache.shiro.authc.IncorrectCredentialsException")) {
                    if (ArrayUtils.contains(setting.getAccountLockTypes(), AccountLockType.user)) {
                        message = "sys.login.accountLockCount";
                    } else {
                        message = "sys.login.incorrectCredentials";
                    }
                } else if (loginFailure.equals("org.apache.shiro.authc.AuthenticationException")) {
                    message = "sys.login.authentication";
                }
            }
    %>
    <title>
        <%=SpringUtils.getMessage("sys.main.projectName")%>
    </title>
    <link href="<%=base%>/resources/css/login.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=base%>/resources/js/jsbn.js"></script>
    <script type="text/javascript" src="<%=base%>/resources/js/prng4.js"></script>
    <script type="text/javascript" src="<%=base%>/resources/js/rng.js"></script>
    <script type="text/javascript" src="<%=base%>/resources/js/rsa.js"></script>
    <script type="text/javascript" src="<%=base%>/resources/js/base64.js"></script>
    <script type="text/javascript" src="<%=base%>/resources/js/common.js"></script>
    <script type="text/javascript">
        if (window != top) {
            top.location.href = '<%=base%>/common/main';
        }
        $().ready(function () {

            var $loginForm = $('#loginForm');
            var $enPassword = $('#enPassword');
            var $username = $('#username');
            var $password = $('#password');
            var $rememberMe = $('#rememberMe');
            var $loginButton = $('#loginButton');

            // 记住用户名
            if (getCookie('username') != null) {
                $rememberMe.prop('checked', true);
                $username.val(getCookie('username'));
                $password.focus();
            } else {
                $rememberMe.prop('checked', false);
                $username.focus();
            }

            // 表单验证、记住用户名
            $loginForm.submit(function () {
                if ($username.val() == '') {
                    $.messager.alert(title, '<%=SpringUtils.getMessage("sys.login.usernameRequired")%>', 'warning');
                    return false;
                }
                if ($password.val() == '') {
                    $.messager.alert(title, '<%=SpringUtils.getMessage("sys.login.passwordRequired")%>', 'warning');
                    return false;
                }

                if ($rememberMe.prop('checked')) {
                    addCookie('username', $username.val(), {expires: 7 * 24 * 60 * 60});
                } else {
                    removeCookie('username');
                }

                var rsaKey = new RSAKey();
                rsaKey.setPublic(b64tohex('<%=modulus%>'), b64tohex('<%=exponent%>'));
                var enPassword = hex2b64(rsaKey.encrypt($password.val()));
                $enPassword.val(enPassword);
            });

            <%if (message != null) {%>
            $.messager.alert(title, '<%=SpringUtils.getMessage(message, setting.getAccountLockCount())%>', 'error');
            <%}%>

            $loginButton.click(function () {
                $loginForm.submit();
            });

        });
    </script>
    <%} else {%>
    <title>
        <%=SpringUtils.getMessage("sys.login.atemptInfo")%>
    </title>
    <meta http-equiv="expires" content="0"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <link href="<%=base%>/resources/css/login.css" rel="stylesheet" type="text/css"/>
    <%}%>
</head>

<body>
<h1><%=SpringUtils.getMessage("sys.login.title")%><sup>v1.0</sup></h1>

<div class="login" style="margin-top:50px;">

    <div class="header">
        <div class="switch" id="switch">
            <span class="login_title">
                <%=SpringUtils.getMessage("sys.login.logintitle")%>
            </span>
        </div>
    </div>

    <div class="web_qr_login" id="web_qr_login" style="display: block; height: 235px;">
        <div class="web_login" id="web_login">
            <div class="login-box">
                <div class="login_form">
                    <form id="loginForm" accept-charset="utf-8" action="login.jsp" method="post">
                        <input type="hidden" id="enPassword" name="enPassword"/>

                        <div class="uinArea" id="uinArea">
                            <label class="input-tips">
                                <%=SpringUtils.getMessage("sys.login.username")%>:
                            </label>
                            <div class="inputOuter" id="uArea">
                                <input type="text" id="username" name="username"
                                       class="inputstyle"/>
                            </div>
                        </div>

                        <div class="pwdArea" id="pwdArea">
                            <label class="input-tips">
                                <%=SpringUtils.getMessage("sys.login.password")%>:
                            </label>
                            <div class="inputOuter" id="pArea">
                                <input type="password" id="password" name="password"
                                       class="inputstyle"/>
                            </div>
                        </div>

                        <div style="padding-left:50px;margin-top:20px;">
                            <input type="submit"
                                   value="<%=SpringUtils.getMessage("sys.login.login")%>"
                                   style="width:150px;"
                                   class="button_blue"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
<div class="jianyi"><%=SpringUtils.getMessage("sys.login.powered")%>
</div>
</body>
</html>
