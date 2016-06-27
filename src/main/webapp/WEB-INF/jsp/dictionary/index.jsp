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
        <table id="dictionaries" class="easyui-datagrid" border="false" fit="true"
               rownumbers="true" pagination="true" sortName="nickname" sortOrder="asc"
               data-options="singleSelect:true,fitColumns:true,url:'${pageContext.request.contextPath}/dict/list',method:'get',pageSize:20,striped:true">
            <thead>
            <tr>
                <th data-options="field:'id',hidden:true">ID</th>
                <th data-options="field:'nickname',width:100,halign:'center',sortable:true">
                    <%=SpringUtils.getMessage("dict.datagrid.nickname")%>
                </th>
                <th data-options="field:'value',width:100,halign:'center',sortable:true">
                    <%=SpringUtils.getMessage("dict.datagrid.value")%>
                </th>
                <th data-options="field:'name',width:100,halign:'center'">
                    <%=SpringUtils.getMessage("dict.datagrid.name")%>
                </th>
                <th data-options="field:'createDate',width:150,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("page.common.createDate")%>
                </th>
                <th data-options="field:'modifyDate',width:150,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("page.common.modifyDate")%>
                </th>
                <th data-options="field:'type',width:100,halign:'center',align:'right',sortable:true">
                    <%=SpringUtils.getMessage("dict.datagrid.type")%>
                </th>
                <th data-options="field:'updatable',width:100,halign:'center',align:'center',formatter:updatableFormatter">
                    <%=SpringUtils.getMessage("dict.datagrid.updatable")%>
                </th>
                <th data-options="field:'creator',width:100,halign:'center'">
                    <%=SpringUtils.getMessage("dict.datagrid.creator")%>
                </th>
                <th data-options="field:'status',width:100,halign:'center',align:'center',formatter:statusFormatter">
                    <%=SpringUtils.getMessage("dict.datagrid.status")%>
                </th>
                <th data-options="field:'sortNo',width:100,halign:'center',align:'right'">
                    <%=SpringUtils.getMessage("dict.datagrid.sortNo")%>
                </th>
                <th data-options="field:'memo',width:200,halign:'center'">
                    <%=SpringUtils.getMessage("dict.datagrid.memo")%>
                </th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<div id="dlg" style="width:400px;height:360px;"
     class="easyui-dialog" closed="true" modal="true" buttons="#dlg-buttons">
    <div style="padding:20px 0px 0px 40px;">
        <div style="float:center">
            <form id="addform" method="post" style="margin:0;padding:0">
                <jsp:include page="form.jsp"/>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="dlg-buttons" style="text-align:center;">
        <a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="saveItem()">
            <%=SpringUtils.getMessage("page.action.save")%>
        </a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#dlg').dialog('close')">
            <%=SpringUtils.getMessage("page.action.close")%>
        </a>
    </div>
</div>

<div style="display: none">
    <form id="delform" method="post">
        <input type="hidden" id="dictId" name="dictId" value=""/>
    </form>
</div>

</body>