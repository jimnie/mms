<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="head.jsp"/>
<head>
    <title>
        <%=SpringUtils.getMessage("sys.main.projectName")%>
    </title>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/css/index.css">
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
        <table id="acts" class="easyui-datagrid" border="false" fit="true"
               rownumbers="true" pagination="true" sortName="sortNo" sortOrder="asc"
               data-options="singleSelect:true,url:'${pageContext.request.contextPath}/act/list',method:'get',pageSize:20,width:500,striped:true">
            <thead>
            <tr>
                <th data-options="field:'id',hidden:true"></th>
                <th data-options="field:'name',width:150,sortable:true,halign:'center'">
                    <%=SpringUtils.getMessage("action.datagrid.name")%>
                </th>
                <th data-options="field:'enName',width:120,halign:'center'">
                    <%=SpringUtils.getMessage("action.datagrid.enName")%>
                </th>
                <th data-options="field:'handler',width:120,halign:'center'">
                    <%=SpringUtils.getMessage("action.datagrid.handler")%>
                </th>
                <th data-options="field:'status',width:100,halign:'center',align:'center',sortable:true,formatter:statusFormatter">
                    <%=SpringUtils.getMessage("action.datagrid.status")%>
                </th>
                <th data-options="field:'sortNo',width:80,halign:'center',align:'right',sortable:true">
                    <%=SpringUtils.getMessage("action.datagrid.sortNo")%>
                </th>
                <th data-options="field:'memo',width:220,halign:'center'">
                    <%=SpringUtils.getMessage("action.datagrid.memo")%>
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
</div>

<div style="display: none">
    <form id="delform" method="post">
        <input type="hidden" id="actid" name="actid" value=""/>
    </form>
</div>

</body>