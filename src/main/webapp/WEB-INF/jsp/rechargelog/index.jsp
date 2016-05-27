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
        <table id="rechargelogs" class="easyui-datagrid" border="false" fit="true"
               rownumbers="true" pagination="true" sortName="createDate" sortOrder="asc"
               data-options="singleSelect:true,fitColumns:true,url:'${pageContext.request.contextPath}/rechargelog/list',method:'get',pageSize:20,striped:true">
            <thead>
            <tr>
                <th data-options="field:'id',hidden:true">ID</th>
                <th data-options="field:'cardNo',width:100,halign:'center',sortable:true">
                    <%=SpringUtils.getMessage("rechargelog.index.cardno")%>
                </th>
                <th data-options="field:'name',width:60,halign:'center',sortable:true">
                    <%=SpringUtils.getMessage("rechargelog.index.name")%>
                </th>
                <th data-options="field:'mobile',width:80,halign:'center',align:'left'">
                    <%=SpringUtils.getMessage("rechargelog.index.mobile")%>
                </th>
                <th data-options="field:'amount',width:60,halign:'center',align:'right',styler:cellStyler">
                    <%=SpringUtils.getMessage("rechargelog.index.amount")%>
                </th>
                <th data-options="field:'type',width:80,halign:'center',align:'center',sortable:true,formatter:typeFormatter,styler:typeCellStyler">
                    <%=SpringUtils.getMessage("rechargelog.index.type")%>
                </th>
                <th data-options="field:'memo',width:150,halign:'center'">
                    <%=SpringUtils.getMessage("rechargelog.index.memo")%>
                </th>
                <th data-options="field:'createDate',width:150,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("rechargelog.index.createDate")%>
                </th>
            </tr>
            </thead>
        </table>
    </div>
</div>

</body>