<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
    <jsp:include page="head.jsp"></jsp:include>
</head>
<body style="margin:0px;">
<form id="delform" method="post">
    <input type="hidden" id="roleId" name="roleId" value=""/>
</form>
<div class="easyui-layout" fit="true">

    <div region="north" border="false" style="height: 35px">
        <div class="toolbar">
            <table cellpadding="0" cellspacing="0" style="width:95%;">
                <tr>
                    <td>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-add'" onclick="newItem()">新增</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-edit'"
                           onclick="editItem()">修改</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-remove'"
                           onclick="delItem()">删除</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-reload'"
                           onclick="refresh()">刷新</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-search'" onclick="assignResources()">资源配置</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-search'" onclick="assignActs()">权限配置</a>
                    </td>
                    <td style="text-align:right">
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-search'"
                           onclick="advanceQuery()">条件查询</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div region="center" border="false">
        <table id="roles" class="easyui-datagrid" border="false" fit="true"
               rownumbers="true" pagination="true" sortName="sortNo" sortOrder="asc"
               data-options="singleSelect:true,url:'${pageContext.request.contextPath}/role/list',method:'get',width:500">
            <thead>
            <tr>
                <th data-options="field:'id',hidden:true"></th>
                <th data-options="field:'name',width:100,halign:'center',sortable:true">角色名称</th>
                <th data-options="field:'status',width:60,halign:'center',sortable:true,formatter:statusFormatter">
                    状态
                </th>
                <th data-options="field:'editable',width:60,halign:'center',sortable:true,formatter:editableFormatter">
                    可修改
                </th>
                <th data-options="field:'sortNo',width:60,halign:'center',sortable:true">排序</th>
                <th data-options="field:'memo',halign:'center',width:250">备注</th>
            </tr>
            </thead>
        </table>
    </div>

    <div id="dlg" class="easyui-dialog" style="width:600px;height:500px;"
         closed="true" modal="true" buttons="#dlg-buttons">
        <div style="padding:40px 0px 0px 150px;">
            <div style="float:center">
                <form id="addform" method="post">
                    <jsp:include page="form.jsp"></jsp:include>
                </form>
            </div>
            <div style="clear:both"></div>
        </div>
        <div id="dlg-buttons" style="text-align:center;">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
               onclick="saveItem()">保存</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
               onclick="javascript:$('#dlg').dialog('close')">关闭</a>
        </div>
    </div>

    <div id="auth" class="easyui-dialog" style="width:350px;height:500px;"
         closed="true" modal="true" buttons="#auth-buttons">
        <form id="authorization" method="post">
            <input type="hidden" id="r_roleid" name="r_roleid">
            <input type="hidden" id="r_resources" name="r_resources">
            <ul id="tt"></ul>
        </form>
        <div id="auth-buttons" style="text-align:center">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
               onclick="saveAssignedResources()">保存</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
               onclick="javascript:$('#auth').dialog('close')">关闭</a>
        </div>
    </div>

    <div id="ac" class="easyui-dialog" style="width:900px;height:500px;"
         closed="true" modal="true" buttons="#actions-buttons">

        <form id="authform" method="post">
            <div class="toolbar">
                选择模块：<input class="easyui-combobox" name="moduleId" id="moduleId">
                选择资源：<input class="easyui-combobox" name="resource" id="resource">
                操作权限：<input class="easyui-combobox" name="act" id="act"
                            data-options="url:'${pageContext.request.contextPath}/act/loadActs',
                                method:'get',
                                valueField:'enName',
                                textField:'name',
                                panelHeight:'auto'">
                <input type="hidden" id="role" name="role">
                <input type="hidden" id="auths" name="auths">
                <input type="hidden" id="inserted" name="inserted">
                <input type="hidden" id="updated" name="updated">
                <input type="hidden" id="deleted" name="deleted">
                <a href="javascript:void(0)" class="easyui-linkbutton"
                   data-options="iconCls:'icon-add'" onclick="addAuth()">添加</a>
                <a href="javascript:void(0)" class="easyui-linkbutton"
                   data-options="iconCls:'icon-remove'" onclick="delAuth()">删除</a>
            </div>
            <div>
                <table id="authorities" class="easyui-datagrid" title="资源权限表"
                       border="false" rownumbers="true" width="100%"
                       data-options="singleSelect:true">
                    <thead>
                    <tr>
                        <th data-options="field:'id',hidden:true"></th>
                        <th data-options="field:'actAlias',hidden:true"></th>
                        <th data-options="field:'roleId',hidden:true"></th>
                        <th data-options="field:'resourceId',hidden:true"></th>
                        <th data-options="field:'resourceName',halign:'center',width:120">资源名称</th>
                        <th data-options="field:'actName',halign:'center',width:120">权限名称</th>
                        <th data-options="field:'perms',halign:'center',width:180">资源权限表达式</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </form>

        <div id="actions-buttons" style="text-align:center">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
               onclick="saveResourcesAuths()">保存</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
               onclick="javascript:$('#ac').dialog('close')">关闭</a>
        </div>
    </div>

    <div id="detail" class="easyui-dialog" style="width:350px;height:430px;"
         closed="true" modal="true" buttons="#detail-buttons">
        <form id="detailform">
            <%-- <jsp:include page="_detail.jsp"></jsp:include> --%>
        </form>
        <div id="detail-buttons" style="text-align:center">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
               onclick="javascript:$('#detail').dialog('close')">关闭</a>
        </div>
    </div>
</div>
</body>