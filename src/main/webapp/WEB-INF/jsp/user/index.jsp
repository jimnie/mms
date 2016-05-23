<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                           data-options="iconCls:'icon-add'" onclick="newItem();">
                            <%=SpringUtils.getMessage("page.action.add")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-edit'" onclick="editItem();">
                            <%=SpringUtils.getMessage("page.action.edit")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-remove'" onclick="delItem();">
                            <%=SpringUtils.getMessage("page.action.remove")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-reload'" onclick="refresh();">
                            <%=SpringUtils.getMessage("page.action.refresh")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-lock'" onclick="lock();">
                            <%=SpringUtils.getMessage("page.action.lock")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-lock'" onclick="unlock();">
                            <%=SpringUtils.getMessage("page.action.unlock")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-redo'" onclick="resetPassword();">
                            <%=SpringUtils.getMessage("page.action.resetPassword")%>
                        </a>
                    </td>
                    <td style="text-align:right">
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-search'" onclick="advanceQuery();">
                            <%=SpringUtils.getMessage("page.common.advencedQuery")%>
                        </a>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div region="center" border="false">
        <table id="users" class="easyui-datagrid" border="false" fit="true"
               rownumbers="true" pagination="true" sortName="username" sortOrder="asc"
               data-options="singleSelect:true,fitColumns:true,url:'${pageContext.request.contextPath}/user/list',method:'get',striped:true">
            <thead>
            <tr>
                <th data-options="field:'id',hidden:true">ID</th>
                <th data-options="field:'username',width:80,halign:'center',sortable:true">
                    <%=SpringUtils.getMessage("user.datagrid.username")%>
                </th>
                <th data-options="field:'createDate',width:100,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("page.common.createDate")%>
                </th>
                <th data-options="field:'modifyDate',width:100,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("page.common.modifyDate")%>
                </th>
                <th data-options="field:'isEnabled',width:40,halign:'center',align:'center',sortable:true,
                formatter:isEnabledFormatter">
                    <%=SpringUtils.getMessage("user.datagrid.isEnabled")%>
                </th>
                <th data-options="field:'isSystem',width:40,halign:'center',align:'center',sortable:true,
                formatter:isSystemFormatter">
                    <%=SpringUtils.getMessage("user.datagrid.isSystem")%>
                </th>
                <th data-options="field:'isLocked',width:40,halign:'center',align:'center',sortable:true,
                formatter:isLockedFormatter">
                    <%=SpringUtils.getMessage("user.datagrid.isLocked")%>
                </th>
                <th data-options="field:'lockedDate',width:100,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("user.datagrid.lockedDate")%>
                </th>
                <th data-options="field:'loginFailureCount',width:80,halign:'center',align:'right',sortable:true">
                    <%=SpringUtils.getMessage("user.datagrid.loginFailureCount")%>
                </th>
                <th data-options="field:'loginDate',width:100,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("user.datagrid.loginDate")%>
                </th>
                <th data-options="field:'loginIp',width:150,halign:'center',sortable:true">
                    <%=SpringUtils.getMessage("user.datagrid.loginIp")%>
                </th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<div id="dlg" style="width:400px;height:220px;"
     class="easyui-dialog" closed="true" modal="true" buttons="#dlg-buttons">
    <div style="padding:20px 0px 0px 40px;">
        <div style="float:center">
            <form id="addform" method="post">
                <jsp:include page="form.jsp"/>
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

<div style="display: none">
    <form id="delform" method="post">
        <input type="hidden" id="userId" name="userId" value=""/>
    </form>
</div>

</body>