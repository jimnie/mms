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
                </tr>
            </table>
        </div>
    </div>

    <div region="center" border="false">
        <table id="rank" class="easyui-datagrid" border="false" fit="true"
               rownumbers="true" pagination="true" sortName="createDate" sortOrder="asc"
               data-options="singleSelect:true,fitColumns:true,url:'${pageContext.request.contextPath}/rank/list',method:'get',pageSize:20,striped:true">
            <thead>
            <tr>
                <th data-options="field:'id',hidden:true">ID</th>
                <th data-options="field:'name',width:100,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("rank.form.name")%>
                </th>
                <th data-options="field:'scale',width:100,halign:'center',align:'right',sortable:true">
                    <%=SpringUtils.getMessage("rank.form.scale")%>
                </th>
                <th data-options="field:'amount',width:100,halign:'center',align:'right'">
                    <%=SpringUtils.getMessage("rank.form.amount")%>
                </th>
                <th data-options="field:'createDate',width:150,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("page.common.createDate")%>
                </th>
                <th data-options="field:'modifyDate',width:150,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("page.common.modifyDate")%>
                </th>
                <th data-options="field:'isDefault',width:100,halign:'center',align:'center',sortable:true,formatter:defaultFormatter">
                    <%=SpringUtils.getMessage("rank.form.isDefault")%>
                </th>
                <th data-options="field:'isSpecial',width:100,halign:'center',align:'center',formatter:specialFormatter">
                    <%=SpringUtils.getMessage("rank.form.isSpecial")%>
                </th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<div id="dlg" style="width:400px;height:300px;"
     class="easyui-dialog" closed="true" modal="true" buttons="#dlg-buttons">
    <div style="padding:20px 0px 0px 40px;">
        <div style="float:center">
            <form id="addform" method="post" style="margin:0;padding:0">
                <jsp:include page="form.jsp"/>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="dlg-buttons" style="text-align: center;">
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
        <input type="hidden" id="rankId" name="rankId" value=""/>
    </form>
</div>

</body>