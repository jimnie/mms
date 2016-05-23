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
                           data-options="iconCls:'icon-add'"
                           onclick="newItem();"><%=SpringUtils.getMessage("page.action.add")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-edit'"
                           onclick="editItem();"><%=SpringUtils.getMessage("page.action.edit")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-remove'"
                           onclick="delItem();"><%=SpringUtils.getMessage("page.action.remove")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-reload'"
                           onclick="refresh();"><%=SpringUtils.getMessage("page.action.refresh")%>
                        </a>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div region="center" border="false">
        <table id="resources" class="easyui-treegrid" border="false" fit="true"
               data-options="pagination: false,
                       rownumbers:true,
                       animate: false,
                       fitColumns:true,
                       url:'${pageContext.request.contextPath}/resource/list',
                       method:'get',
                       idField:'id',
                       striped:true,
                       treeField:'text',
                       onBeforeLoad:function(row,param){
                            if (row) {
                                $(this).treegrid('options').url = '${pageContext.request.contextPath}/resource/query/'+row.id;
                            }
                        }">
            <thead>
            <tr>
                <th data-options="field:'id',hidden:true">id</th>
                <th data-options="field:'parentid',hidden:true">parentid</th>
                <th data-options="field:'createDate',hidden:true">createDate</th>
                <th data-options="field:'modifyDate',hidden:true">modifyDate</th>
                <th data-options="field:'text',width:'120',halign:'center'">
                    <%=SpringUtils.getMessage("resource.datagrid.text")%>
                </th>
                <th data-options="field:'resourceType',width:60,halign:'center',align:'center',formatter:resourceTypeFormatter">
                    <%=SpringUtils.getMessage("resource.datagrid.resourceType")%>
                </th>
                <th data-options="field:'url',width:100,halign:'center'">
                    <%=SpringUtils.getMessage("resource.datagrid.url")%>
                </th>
                <th data-options="field:'icon',width:80,halign:'center',align:'center',formatter:iconFormatter">
                    <%=SpringUtils.getMessage("resource.datagrid.icon")%>
                </th>
                <th data-options="field:'isLeaf',width:40,halign:'center',align:'center',formatter:isLeafFormatter">
                    <%=SpringUtils.getMessage("resource.datagrid.isLeaf")%>
                </th>
                <th data-options="field:'status',width:40,halign:'center',align:'center',formatter:statusFormatter">
                    <%=SpringUtils.getMessage("resource.datagrid.status")%>
                </th>
                <th data-options="field:'editable',width:40,halign:'center',align:'center',formatter:editableFormatter">
                    <%=SpringUtils.getMessage("resource.datagrid.editable")%>
                </th>
                <th data-options="field:'sortNo',width:40,halign:'center',align:'right'">
                    <%=SpringUtils.getMessage("resource.datagrid.sortNo")%>
                </th>
                <th data-options="field:'memo',width:100,halign:'center'">
                    <%=SpringUtils.getMessage("resource.datagrid.memo")%>
                </th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<div id="dlg" style="width:400px;height:420px;"
     class="easyui-dialog" closed="true" modal="true" buttons="#dlg-buttons">
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
           onclick="saveItem()"><%=SpringUtils.getMessage("page.action.save")%>
        </a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
           onclick="javascript:$('#dlg').dialog('close')">
            <%=SpringUtils.getMessage("page.action.close")%>
        </a>
    </div>
</div>

<div style="display: none">
    <form id="delform" method="post">
        <input type="hidden" id="resid" name="resid" value=""/>
    </form>
</div>

</body>