<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<head>
    <jsp:include page="head.jsp"></jsp:include>
</head>
<body style="margin: 0px">
<div class="easyui-layout" fit="true" style="z-index: auto">
    <div region="north" border="false" style="height: 39px">
        <div class="toolbar">
            <table cellpadding="0" cellspacing="0" style="width: 95%">
                <tr>
                    <td>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-add'" onclick="addHandover()">
                            <%=SpringUtils.getMessage("page.action.add")%>
                        </a>
                        <shiro:hasPermission name="handover:edit">
                            <a href="javascript:void(0)" class="easyui-linkbutton"
                               data-options="iconCls:'icon-edit'"
                               onclick="editHandover()">
                                <%=SpringUtils.getMessage("page.action.edit")%>
                            </a>
                        </shiro:hasPermission>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-more'" onclick="viewHandover()">
                            <%=SpringUtils.getMessage("page.action.view")%>
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
        <table id="handOverList" class="easyui-datagrid" border="false" fit="true"
               rownumbers="true" pagination="true" sortName="serviceNo" sortOrder="asc"
               data-options="singleSelect:true,fitColumns:true,url:'${pageContext.request.contextPath}/handover/list',method:'get',pageSize:20,striped:true">
            <thead data-options="frozen:true">
            <tr>
                <th data-options="field:'id',hidden:true">id</th>
                <th data-options="field:'serviceNo',width:150,halign:'center',align:'center',sortable:true">
                    业务编号
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
                <th data-options="field:'rcpDate',width:120,halign:'center',align:'center',sortable:true">
                    交接时间
                </th>
                <th data-options="field:'position',width:110,halign:'center',align:'center'">
                    骨灰存放位置
                </th>
                <th data-options="field:'drawDate',width:130,halign:'center',align:'center'">
                    领取时间
                </th>
                <th data-options="field:'status',width:80,halign:'center',align:'center',sortable:true,formatter:stateFormatter">
                    状态
                </th>
                <th data-options="field:'rfid',width:180,halign:'center',align:'center',sortable:true">
                    骨灰袋识别码
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
           onclick="closeHandover()">
            <%=SpringUtils.getMessage("page.action.close")%>
        </a>
    </div>
</div>

<%--查看存放详情--%>
<div id="view-dialog" class="easyui-dialog" closed="true" modal="true"
     buttons="#view-buttons">
    <div style="padding:20px 0px 0px 60px">
        <div style="width: 1080px;height: 550px;float: center">
            <form id="viewform" method="post" style="margin: 0;padding: 0">
                <jsp:include page="view.jsp"/>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="view-buttons" style="text-align:center;">
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#view-dialog').dialog('close')">
            关闭
        </a>
    </div>
</div>
</body>
