<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
    <jsp:include page="head.jsp"></jsp:include>
</head>
<body style="margin:0px;">
<form id="groupForm">
    <input type="hidden" id="groupid" name="groupid" value="">
</form>
<form id="delform">
    <input type="hidden" id="delGroupId" name="delGroupId" value="">
</form>
<div class="easyui-layout" fit="true">

    <div region="north" border="false" style="height: 35px">
        <div class="toolbar">
            <a href="javascript:void(0);" class="easyui-linkbutton"
               data-options="iconCls:'icon-add'"
               onclick="newItem()">新增组</a>
            <a href="javascript:void(0);" class="easyui-linkbutton"
               data-options="iconCls:'icon-edit'"
               onclick="editItem()">修改组</a>
            <a href="javascript:void(0);" class="easyui-linkbutton"
               data-options="iconCls:'icon-remove'"
               onclick="delItem()">删除组</a>
            <a href="javascript:void(0);" class="easyui-linkbutton"
               data-options="iconCls:'icon-search'"
               onclick="lookItem()">查看组</a>
            <a href="javascript:void(0);" class="easyui-linkbutton"
               data-options="iconCls:'icon-man'"
               onclick="addUsers()">组用户维护</a>
            <a href="javascript:void(0);" class="easyui-linkbutton"
               data-options="iconCls:'icon-man'"
               onclick="addRoles()">组角色维护</a>
            <a href="javascript:void(0);" class="easyui-linkbutton"
               data-options="iconCls:'icon-clear'"
               onclick="delUsers()">解除组用户</a>
            <a href="javascript:void(0);" class="easyui-linkbutton"
               data-options="iconCls:'icon-clear'"
               onclick="delRoles()">解除组角色</a>
            <a href="javascript:void(0);" class="easyui-linkbutton"
               data-options="iconCls:'icon-search'"
               onclick="lookGroupHaveRole()">查看组拥有的角色</a>

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
        <table id="users" class="easyui-datagrid" title="用户信息"
               fit="true" border="false"
               pagination="true"
               singleSelect="true" rownumbers="true" disabled="true">
            <thead>
            <tr>
                <th field="username" width="100">用户名称</th>
                <th field="position" width="50">职位</th>
                <th field="age" width="50">年龄</th>
                <th field="sex" width="50">性别</th>
                <th field="education" width="100">教育情况</th>
                <th field="address" width=100>地址</th>
                <th field="phone" width="100">电话</th>
                <th field="email" width="150">邮箱</th>
                <th field="memo" width="300">备注</th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<div id="dlg" style="width:600px;height:500px;"
     class="easyui-dialog" closed="true" modal="true" buttons="#dlg-buttons">
    <div style="padding:40px 0px 0px 150px;">
        <div style="float:center">
            <form id="addform" method="post">
                <jsp:include page="form.jsp"/>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="dlg-buttons" style="text-align:center">
        <a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="saveItem()">保存</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#dlg').dialog('close')">关闭</a>
    </div>
</div>
<%--添加用户--%>
<div id="addUserdlg" style="width:620px;height:450px;"
     class="easyui-dialog" closed="true" modal="true" buttons="#addUser-buttons">
    <div style="padding:40px 0px 0px 100px;">
        <div style="float:center">
            <form id="addUserform" method="post">
                <jsp:include page="addUserform.jsp"/>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="addUser-buttons" style="text-align:center">
        <a href="javascript:;" class="easyui-linkbutton" iconCls="icon-save" onclick="saveUsers()">保存</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#addUserdlg').dialog('close')">关闭</a>
    </div>
</div>
<%--授权角色--%>
<div id="addRolesdlg" style="width:620px;height:450px;"
     class="easyui-dialog" closed="true" modal="true" buttons="#addRoles-buttons">
    <div style="padding:40px 0px 0px 100px;">
        <div style="float:center">
            <form id="addRolesform" method="post">
                <jsp:include page="addRoleform.jsp"/>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="addRoles-buttons" style="text-align:center">
        <a href="javascript:;" class="easyui-linkbutton" iconCls="icon-save" onclick="saveRoles()">保存</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#addRolesdlg').dialog('close')">关闭</a>
    </div>
</div>
</body>