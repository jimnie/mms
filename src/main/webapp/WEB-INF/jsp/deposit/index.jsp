<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
    <jsp:include page="head.jsp"></jsp:include>
</head>
<body style="margin: 0px" onbeforeunload="unload()">
<div class="easyui-layout" fit="true">
    <div region="north" border="false" style="height: 39px">
        <div class="toolbar">
            <table cellpadding="0" cellspacing="0" style="width: 95%">
                <tr>
                    <td>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-add'" onclick="addDeposit()">
                            <%=SpringUtils.getMessage("page.action.add")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-edit'" onclick="editDeposit()">
                            <%=SpringUtils.getMessage("page.action.edit")%>
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
        <table id="deposits" class="easyui-datagrid" border="false" fit="true"
               rownumbers="true" pagination="true" sortName="serviceNo" sortOrder="asc"
               data-options="singleSelect:true,fitColumns:true,url:'${pageContext.request.contextPath}/deposit/list',method:'get',pageSize:20,striped:true">
            <thead data-options="frozen:true">
            <tr>
                <th data-options="field:'id',hidden:true">id</th>
                <th data-options="field:'serviceNo',width:150,halign:'center',align:'center',sortable:true">
                    服务编号
                </th>
                <th data-options="field:'dpName',width:120,halign:'center',align:'center'">
                    逝者姓名
                </th>
                <th data-options="field:'dpSex',width:100,halign:'center',align:'center',formatter:sexFormatter">
                    逝者性别
                </th>
                <th data-options="field:'dpAge',width:100,halign:'center',align:'center'">
                    逝者年龄
                </th>
                <th data-options="field:'position',width:150,halign:'center',align:'center'">
                    存放位置
                </th>
                <th data-options="field:'depositDate',width:120,halign:'center',align:'center',sortable:true">
                    存入日期
                </th>
                <th data-options="field:'drawDate',width:120,halign:'center',align:'center',sortable:true">
                    领取日期
                </th>
                <th data-options="field:'status',width:120,halign:'center',align:'center',sortable:true,formatter:stateFormatter">
                    状态
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
        <a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="saveItem()">
            <%=SpringUtils.getMessage("page.action.save")%>
        </a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#dlg').dialog('close')">
            <%=SpringUtils.getMessage("page.action.close")%>
        </a>
    </div>
</div>

<%--<div style="display: none">--%>
<%--<form id="delform" method="post">--%>
<%--<input type="hidden" id="memberId" name="memberId">--%>
<%--</form>--%>
<%--</div>--%>
</body>
<OBJECT classid="clsid:F1317711-6BDE-4658-ABAA-39E31D3704D3"
        codebase="SDRdCard.cab#version=2,0,1,0" width="0"
        height="0" align="center" hspace="0" vspace="0" id="idcard" name="rdcard">
</OBJECT>