<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<head>
    <jsp:include page="head.jsp"></jsp:include>
</head>
<body style="margin: 0px">
<div class="easyui-layout" fit="true">
    <div region="north" border="false" style="height: 39px">
        <div class="toolbar">
            <table cellpadding="0" cellspacing="0" style="width: 95%">
                <tr>
                    <td>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-redo'" onclick="addDraw()">
                            领取
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
        <table id="dhMatchList" class="easyui-datagrid" border="false" fit="true"
               rownumbers="true" pagination="true" sortName="serviceNo" sortOrder="asc"
               data-options="singleSelect:true,fitColumns:true,url:'${pageContext.request.contextPath}/dhmatch/list',method:'get',pageSize:20,striped:true">
            <thead data-options="frozen:true">
            <tr>
                <th data-options="field:'dId',hidden:true">id</th>
                <th data-options="field:'hId',hidden:true">id</th>
                <th data-options="field:'utCertType',hidden:true">id</th>
                <th data-options="field:'utCertNo',hidden:true">id</th>
                <th data-options="field:'phone',hidden:true">id</th>
                <th data-options="field:'serviceNo',width:100,halign:'center',align:'center'">
                    服务编号
                </th>
                <th data-options="field:'dpName',width:100,halign:'center',align:'center'">
                    逝者姓名
                </th>
                <th data-options="field:'dpSex',width:80,halign:'center',align:'center',formatter:sexFormatter">
                    性别
                </th>
                <th data-options="field:'dpAge',width:80,halign:'center',align:'center'">
                    年龄
                </th>
                <th data-options="field:'dpCertType',width:100,halign:'center',align:'center', formatter:certTypeFormatter">
                    证件类型
                </th>
                <th data-options="field:'dpCertNo',width:140,halign:'center',align:'center'">
                    证件号码
                </th>
                <th data-options="field:'dPosition',width:150,halign:'center',align:'center'">
                    盒存放位置
                </th>
                <th data-options="field:'hPosition',width:150,halign:'center',align:'center'">
                    骨灰存放位置
                </th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<div id="dlg" class="easyui-dialog" closed="true" modal="true" buttons="#dlg-buttons">
    <div style="padding:20px 0px 0px 60px">
        <div style="width: 1080px;height: 540px;float: center">
            <form id="addform" method="post" style="margin: 0;padding: 0">
                <jsp:include page="form.jsp"/>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="dlg-buttons" style="text-align:center;">
        <a id="saveButton" href="#" class="easyui-linkbutton" iconCls="icon-save"
           onclick="saveItem()">
            <%=SpringUtils.getMessage("page.action.save")%>
        </a>
        <a id="closeButton" href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#dlg').dialog('close')">
            <%=SpringUtils.getMessage("page.action.close")%>
        </a>
    </div>
</div>
</body>
