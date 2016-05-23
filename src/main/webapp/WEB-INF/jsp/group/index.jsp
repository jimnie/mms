<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
    <jsp:include page="head.jsp"></jsp:include>
</head>
<body style="margin:0px;">

<div class="easyui-layout" fit="true">

    <div region="north" border="false" style="height: 35px">
        <div class="toolbar">
            <table cellpadding="0" cellspacing="0" style="width:95%;">
                <tr>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'icon-add'" onclick="newItem()">
                            <%=SpringUtils.getMessage("page.action.add")%>
                        </a>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'icon-edit'" onclick="editItem()">
                            <%=SpringUtils.getMessage("page.action.edit")%>
                        </a>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'icon-remove'" onclick="delItem()">
                            <%=SpringUtils.getMessage("page.action.remove")%>
                        </a>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'icon-man'" onclick="addUsers()">
                            <%=SpringUtils.getMessage("group.datagrid.groupUserRelate")%>
                        </a>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'icon-man'" onclick="addRoles()">
                            <%=SpringUtils.getMessage("group.datagrid.groupRoleRelate")%>
                        </a>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div region="west" border="false"
         style="border-right:1px solid #92B7D0;width:150px;padding:5px;">
        <div id="allTrees">
            <ul id="groupTree" class="easyui-tree"
                data-options="url:'${pageContext.request.contextPath}/group/tree',method:'get',animate:false,lines:true"></ul>
        </div>
    </div>

    <div region="center" border="false">
        <table id="users" class="easyui-datagrid"
               title="<%=SpringUtils.getMessage("group.datagrid.userinfo")%>"
               fit="true" border="false"
               pagination="true"
               singleSelect="true" rownumbers="true" disabled="true" data-options="striped:true">
            <thead>
            <tr>
                <th data-options="field:'id',hidden:true">ID</th>
                <th data-options="field:'username',width:80,halign:'center',sortable:true">
                    <%=SpringUtils.getMessage("user.datagrid.username")%>
                </th>
                <th data-options="field:'isEnabled',width:80,halign:'center',align:'center',sortable:true,
                formatter:isEnabledFormatter">
                    <%=SpringUtils.getMessage("user.datagrid.isEnabled")%>
                </th>
                <th data-options="field:'isSystem',width:80,halign:'center',align:'center',sortable:true,
                formatter:isSystemFormatter">
                    <%=SpringUtils.getMessage("user.datagrid.isSystem")%>
                </th>
                <th data-options="field:'loginDate',width:160,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("user.datagrid.loginDate")%>
                </th>
                <th data-options="field:'loginIp',width:160,halign:'center',align:'left',sortable:true">
                    <%=SpringUtils.getMessage("user.datagrid.loginIp")%>
                </th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<div id="dlg" style="width: 400px;height: 340px;"
     class="easyui-dialog" closed="true" modal="true" buttons="#dlg-buttons">
    <div style="padding:20px 0px 0px 40px;">
        <div style="float:center">
            <form id="addform" method="post">
                <jsp:include page="form.jsp"/>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="dlg-buttons" style="text-align:center">
        <a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="saveItem()">
            <%=SpringUtils.getMessage("page.action.save")%>
        </a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#dlg').dialog('close')">
            <%=SpringUtils.getMessage("page.action.close")%>
        </a>
    </div>
</div>
<%--添加用户--%>
<div id="addUserdlg" style="width:500px;height:420px;"
     class="easyui-dialog" closed="true" modal="true" buttons="#addUser-buttons">
    <div style="padding:20px 0px 0px 40px;">
        <div style="float:center">
            <form id="addUserform" method="post">
                <jsp:include page="addUserform.jsp"/>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="addUser-buttons" style="text-align:center">
        <a href="javascript:;" class="easyui-linkbutton" iconCls="icon-save" onclick="saveUsers()">
            <%=SpringUtils.getMessage("page.action.save")%>
        </a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#addUserdlg').dialog('close')">
            <%=SpringUtils.getMessage("page.action.close")%>
        </a>
    </div>
</div>
<%--授权角色--%>
<div id="addRolesdlg" style="width:500px;height:420px;"
     class="easyui-dialog" closed="true" modal="true" buttons="#addRoles-buttons">
    <div style="padding:20px 0px 0px 40px;">
        <div style="float:center">
            <form id="addRolesform" method="post">
                <jsp:include page="addRoleform.jsp"/>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="addRoles-buttons" style="text-align:center">
        <a href="javascript:;" class="easyui-linkbutton" iconCls="icon-save" onclick="saveRoles()">
            <%=SpringUtils.getMessage("page.action.save")%>
        </a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#addRolesdlg').dialog('close')">
            <%=SpringUtils.getMessage("page.action.close")%>
        </a>
    </div>
</div>

<div style="display: none">
    <form id="groupForm">
        <input type="hidden" id="groupid" name="groupid" value="">
    </form>
</div>

<div style="display: none">
    <form id="delform">
        <input type="hidden" id="delGroupId" name="delGroupId" value="">
    </form>
</div>

</body>