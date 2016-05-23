<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
    <jsp:include page="head.jsp"></jsp:include>
</head>
<body style="margin: 0px">

<div class="easyui-layout" fit="true">

    <div region="north" border="false" style="height: 35px">
        <div class="toolbar">
            <table cellpadding="0" cellspacing="0" style="width:95%;">
                <tr>
                    <td>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-add'" onclick="newItem()">
                            <%=SpringUtils.getMessage("page.action.add")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-edit'" onclick="editItem()">
                            <%=SpringUtils.getMessage("page.action.edit")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-remove'" onclick="delItem()">
                            <%=SpringUtils.getMessage("page.action.remove")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-reload'" onclick="refresh()">
                            <%=SpringUtils.getMessage("page.action.refresh")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-search'" onclick="assignResource()">
                            <%=SpringUtils.getMessage("page.action.assignResource")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-search'" onclick="assignAuthority()">
                            <%=SpringUtils.getMessage("page.action.assignAuthority")%>
                        </a>
                    </td>
                    <td style="text-align:right">
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-search'" onclick="advanceQuery()">
                            <%=SpringUtils.getMessage("page.common.advencedQuery")%>
                        </a>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div region="center" border="false">
        <table id="roles" class="easyui-datagrid" border="false" fit="true"
               rownumbers="true" pagination="true" sortName="sortNo" sortOrder="asc"
               data-options="singleSelect:true,url:'${pageContext.request.contextPath}/role/list',method:'get',width:500,striped:true">
            <thead>
            <tr>
                <th data-options="field:'id',hidden:true"></th>
                <th data-options="field:'name',width:100,halign:'center',align:'left',sortable:true">
                    <%=SpringUtils.getMessage("role.datagrid.name")%>
                </th>
                <th data-options="field:'createDate',width:140,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("page.common.createDate")%>
                </th>
                <th data-options="field:'modifyDate',width:140,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("page.common.modifyDate")%>
                </th>
                <th data-options="field:'status',width:80,halign:'center',align:'center',sortable:true,formatter:statusFormatter">
                    <%=SpringUtils.getMessage("role.datagrid.status")%>
                </th>
                <th data-options="field:'editable',width:80,halign:'center',align:'center',sortable:true,formatter:editableFormatter">
                    <%=SpringUtils.getMessage("role.datagrid.editable")%>
                </th>
                <th data-options="field:'sortNo',width:80,halign:'center',align:'right',sortable:true">
                    <%=SpringUtils.getMessage("role.datagrid.sortNo")%>
                </th>
                <th data-options="field:'memo',halign:'center',width:220">
                    <%=SpringUtils.getMessage("role.datagrid.memo")%>
                </th>
            </tr>
            </thead>
        </table>
    </div>

    <div id="dlg" class="easyui-dialog" style="width:400px;height:300px;"
         closed="true" modal="true" buttons="#dlg-buttons">
        <div style="padding:20px 0px 0px 40px;">
            <div style="float:center">
                <form id="addform" method="post">
                    <jsp:include page="form.jsp"></jsp:include>
                </form>
            </div>
            <div style="clear:both"></div>
        </div>
        <div id="dlg-buttons" style="text-align:center;">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
               onclick="saveItem()">
                <%=SpringUtils.getMessage("page.action.save")%>
            </a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
               onclick="javascript:$('#dlg').dialog('close')">
                <%=SpringUtils.getMessage("page.action.close")%>
            </a>
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
               onclick="saveAssignedResources()">
                <%=SpringUtils.getMessage("page.action.save")%>
            </a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
               onclick="javascript:$('#auth').dialog('close')">
                <%=SpringUtils.getMessage("page.action.close")%>
            </a>
        </div>
    </div>

    <div id="ac" class="easyui-dialog" style="width:900px;height:500px;"
         closed="true" modal="true" buttons="#actions-buttons">

        <form id="authform" method="post">
            <div class="toolbar">
                <%=SpringUtils.getMessage("role.form.choiseModel")%>
                <input class="easyui-combobox" name="moduleId" id="moduleId">
                <%=SpringUtils.getMessage("role.form.choiseResource")%>
                <input class="easyui-combobox" name="resource" id="resource">
                <%=SpringUtils.getMessage("role.form.choiseAction")%>
                <input class="easyui-combobox" name="act" id="act"
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
                   data-options="iconCls:'icon-add'" onclick="addAuth()">
                    <%=SpringUtils.getMessage("page.action.add")%>
                </a>
                <a href="javascript:void(0)" class="easyui-linkbutton"
                   data-options="iconCls:'icon-remove'" onclick="delAuth()">
                    <%=SpringUtils.getMessage("page.action.remove")%>
                </a>
            </div>
            <div>
                <table id="authorities" class="easyui-datagrid"
                       title="<%=SpringUtils.getMessage("role.form.authorities")%>"
                       border="false" rownumbers="true" width="100%"
                       data-options="singleSelect:true">
                    <thead>
                    <tr>
                        <th data-options="field:'id',hidden:true"></th>
                        <th data-options="field:'actAlias',hidden:true"></th>
                        <th data-options="field:'roleId',hidden:true"></th>
                        <th data-options="field:'resourceId',hidden:true"></th>
                        <th data-options="field:'resourceName',halign:'center',width:120">
                            <%=SpringUtils.getMessage("role.form.resourceName")%>
                        </th>
                        <th data-options="field:'actName',halign:'center',width:120">
                            <%=SpringUtils.getMessage("role.form.authorityName")%>
                        </th>
                        <th data-options="field:'perms',halign:'center',width:180">
                            <%=SpringUtils.getMessage("role.form.expression")%>
                        </th>
                    </tr>
                    </thead>
                </table>
            </div>
        </form>

        <div id="actions-buttons" style="text-align:center">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
               onclick="saveResourcesAuths()">
                <%=SpringUtils.getMessage("page.action.save")%>
            </a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
               onclick="javascript:$('#ac').dialog('close')">
                <%=SpringUtils.getMessage("page.action.close")%>
            </a>
        </div>
    </div>

    <div id="detail" class="easyui-dialog" style="width:350px;height:430px;"
         closed="true" modal="true" buttons="#detail-buttons">
        <form id="detailform">
            <%-- <jsp:include page="_detail.jsp"></jsp:include> --%>
        </form>
        <div id="detail-buttons" style="text-align:center">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
               onclick="javascript:$('#detail').dialog('close')">
                <%=SpringUtils.getMessage("page.action.close")%>
            </a>
        </div>
    </div>
</div>

<div style="display: none">
    <form id="delform" method="post">
        <input type="hidden" id="roleId" name="roleId" value=""/>
    </form>
</div>

</body>