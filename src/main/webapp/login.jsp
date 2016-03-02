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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <link rel="shortcut icon" href="<%=base%>/resources/images/favicon.ico" type="image/x-icon"/>
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
            top.location.href = location.href;
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
                    $.messager.alert('警告', '<%=SpringUtils.getMessage("sys.login.usernameRequired")%>', 'warning');
                    return false;
                }
                if ($password.val() == '') {
                    $.messager.alert('警告', '<%=SpringUtils.getMessage("sys.login.passwordRequired")%>', 'warning');
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
            $.messager.alert('错误', '<%=SpringUtils.getMessage(message, setting.getAccountLockCount())%>', 'error');
            <%}%>

            $loginButton.click(function () {
                $loginForm.submit();
            });

        });
    </script>
    <%} else {%>
    <title>提示信息</title>
    <meta http-equiv="expires" content="0"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <link href="<%=base%>/resources/css/login.css" rel="stylesheet" type="text/css"/>
    <%}%>
</head>

<body>
<div class="login">
    <div class="header">
        <div class="header-title">
            <%=SpringUtils.getMessage("sys.login.title")%>
        </div>
    </div>
    <div class="middle">
        <form id="loginForm" action="login.jsp" method="post">
            <input type="hidden" id="enPassword" name="enPassword"/>
            <table cellpadding="5" cellspacing="0">
                <tr>
                    <td>
                        <%=SpringUtils.getMessage("sys.login.username")%>:
                    </td>
                    <td>
                        <input type="text" id="username" name="username" class="easyui-textbox"
                               maxlength="20"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <%=SpringUtils.getMessage("sys.login.password")%>:
                    </td>
                    <td>
                        <input type="password" id="password" class="easyui-textbox" maxlength="20"
                               autocomplete="off"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <label>
                            <input type="checkbox" id="rememberMe" value="true"/>
                            <%=SpringUtils.getMessage("sys.login.rememberUsername")%>
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <a id="loginButton" href="javascript:void(0);" class="easyui-linkbutton"
                           style="width: 60px; font-size: large;">
                            <%=SpringUtils.getMessage("sys.login.login")%>
                        </a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div class="footer">
        <%=SpringUtils.getMessage("sys.login.powered")%>
    </div>
</div>
</body>
</html>
