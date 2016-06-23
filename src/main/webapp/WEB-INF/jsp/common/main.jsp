<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@include file="global.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><%=SpringUtils.getMessage("sys.main.projectName")%>
    </title>
    <link rel="shortcut icon" href="<%=base%>/resources/images/favorite.ico" type="image/x-icon"/>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/css/icon-extension.css">
    <script type="text/javascript">
        var navsJson = ${sessionScope.navs};
        var modsJson = ${sessionScope.mods};
    </script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</head>

<body class="easyui-layout" scroll="no">

<noscript>
    <div style="position: absolute; z-index: 100000; height: 2046px; top: 0px; left: 0px;
            width: 100%; background: white; text-align: center;">
        <img src="images/noscript.gif" alt='<%=SpringUtils.getMessage("page.main.noscript")%>'/>
    </div>
</noscript>

<!-- 页头 -->
<div data-options="region:'north',split:true,border:false"
     style="overflow: hidden; height: 40px;
             background: url(<%=base%>/resources/images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%;
             line-height: 30px; color: #fff; font-family: Verdana, 微软雅黑,黑体">

    <span style="padding-left: 10px; font-size: 16px; float: left;">
        <img src="<%=base%>/resources/images/blocks.gif" width="20" height="20" align="absmiddle"/>
        <%=SpringUtils.getMessage("sys.main.systemName")%>
    </span>

    <ul id="css3menu" style="padding: 0px; margin: 0px; list-type: none; float: left;
            margin-left: 40px;">
    </ul>
    <span style="float: right; padding-right: 20px;">
        <label id="bgclock"></label>
    </span>
    <span style="float: right; padding-right: 20px;" class="head">
        <%=SpringUtils.getMessage("sys.main.hello")%>
        <label><shiro:principal/></label>
        <a href="javascript:void(0);" id="editPwd">
            <%=SpringUtils.getMessage("sys.main.modifyPassword")%>
        </a>
        <a href="javascript:void(0);" id="loginOut">
            <%=SpringUtils.getMessage("sys.main.logout")%>
        </a>
    </span>

</div>

<!-- 导航菜单 -->
<div id="west" data-options="region:'west',split:true"
     title="<%=SpringUtils.getMessage("sys.main.nevigatioin")%>"
     style="width: 180px;">
    <div id="nav" class="easyui-accordion" data-options="fit:true,border:false,">
        <!--  导航内容 -->
    </div>
</div>

<!-- 内容 -->
<div id="mainPanle" data-options="region:'center'" style="background: #eee; overflow-y: hidden">
    <div id="tabs" class="easyui-tabs" data-options="fit:true,border:false">
        <div id="home" title="<%=SpringUtils.getMessage("sys.main.welcomeToUse")%>"
             style="padding: 20px; overflow: hidden;">
            <h1>Welcome !</h1>
        </div>
    </div>
</div>

<!-- 页脚 -->
<div data-options="region:'south',split:true" style="height: 30px; background: #D2E0F2;">
    <div class="footer"><%=SpringUtils.getMessage("sya.main.footerInfo")%>
    </div>
</div>

<!-- 右键菜单 -->
<div id="rightMenu" class="easyui-menu" style="width: 150px;">
    <div id="tabRefresh">
        刷新
    </div>
    <div class="menu-sep">
    </div>
    <div id="tabClose">
        关闭
    </div>
    <div id="tabCloseAll">
        全部关闭
    </div>
    <div id="tabCloseOther">
        除此之外全部关闭
    </div>
    <div class="menu-sep">
    </div>
    <div id="tabCloseRight">
        当前页右侧全部关闭
    </div>
    <div id="tabCloseLeft">
        当前页左侧全部关闭
    </div>
    <div class="menu-sep">
    </div>
    <div id="tabExit">
        退出
    </div>
</div>

<!--修改密码窗口-->
<div id="modifyPassword" class="easyui-window"
     title="<%=SpringUtils.getMessage("page.main.modifyPassword")%>"
     data-options="iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false,modal:true,closed:true"
     style="width: 300px; height: 150px; padding: 5px;
        background: #fafafa;">
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'center',border:false"
             style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <table cellpadding="3">
                <tr>
                    <td>
                        <%=SpringUtils.getMessage("page.main.newPassword")%>
                    </td>
                    <td>
                        <input id="inputNewPwd" name="inputNewPwd" type="password"
                               class="easyui-validatebox textbox"
                               data-options="required:true,validType:length[3,10]">
                    </td>
                </tr>
                <tr>
                    <td>
                        <%=SpringUtils.getMessage("page.main.confirmPassword")%>
                    </td>
                    <td>
                        <input id="reNewPwd" name="reNewPwd" type="password"
                               class="easyui-validatebox textbox"
                               data-options="required:true,invalidMessage:'<%=SpringUtils.getMessage("page.main.matchError")%>'"
                               validType="equalTo['#inputNewPwd']">
                    </td>
                </tr>
            </table>
        </div>
        <div region="south" border="false"
             style="text-align: right; height: 30px; line-height: 30px;">
            <a id="btnOk" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">
                <%=SpringUtils.getMessage("page.main.ok")%>
            </a>
            <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel"
               href="javascript:void(0)">
                <%=SpringUtils.getMessage("page.main.cancel")%>
            </a>
        </div>
    </div>
</div>

</body>
</html>