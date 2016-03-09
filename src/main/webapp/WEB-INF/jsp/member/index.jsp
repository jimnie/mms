<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
    <jsp:include page="head.jsp"></jsp:include>
</head>
<body style="margin:0px;">
<form id="delform" method="post">
    <input type="hidden" id="memberId" name="memberId">
</form>
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
                            <%=SpringUtils.getMessage("page.action.query")%>
                        </a>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div region="center" border="false">
        <table id="members" class="easyui-datagrid" border="false" fit="true"
               rownumbers="true" pagination="true" sortName="nickname" sortOrder="asc"
               data-options="singleSelect:true,fitColumns:true,url:'${pageContext.request.contextPath}/member/list',method:'get',pageSize:20,striped:true">
            <thead>
            <tr>
                <th data-options="field:'id',hidden:true">ID</th>
                <th data-options="field:'firstKidCnName',width:100,halign:'center',sortable:true">
                    <%=SpringUtils.getMessage("member.form.kidCnName")%>
                </th>
                <th data-options="field:'firstKidSex',width:40,halign:'center',align:'center',formatter:sexFormatter">
                    <%=SpringUtils.getMessage("member.form.kidSex")%>
                </th>
                <th data-options="field:'firstKidbirth',width:100,halign:'center',align:'center'">
                    <%=SpringUtils.getMessage("member.form.kidBirth")%>
                </th>
                <th data-options="field:'registerDate',width:100,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("member.form.registerDate")%>
                </th>
                <th data-options="field:'cardNo',width:100,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("member.form.cardNo")%>
                </th>
                <th data-options="field:'memberRank',width:100,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("member.datagrid.memberRank")%>
                </th>
                <th data-options="field:'name',width:100,halign:'center'">
                    <%=SpringUtils.getMessage("member.datagrid.name")%>
                </th>
                <th data-options="field:'relation',width:100,halign:'center',align:'left',sortable:true,formatter:relationFormatter">
                    <%=SpringUtils.getMessage("member.form.relation")%>
                </th>
                <th data-options="field:'mobile',width:100,halign:'center',align:'center'">
                    <%=SpringUtils.getMessage("member.form.mobile")%>
                </th>
                <th data-options="field:'address',width:200,halign:'center'">
                    <%=SpringUtils.getMessage("member.form.address")%>
                </th>
                <th data-options="field:'createDate',width:150,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("page.common.createDate")%>
                </th>
                <th data-options="field:'modifyDate',width:150,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("page.common.modifyDate")%>
                </th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<div id="dlg" class="easyui-dialog" closed="true" modal="true" buttons="#dlg-buttons">
    <div style="padding:20px 0px 0px 60px;">
        <div style="width:1080px;height:630px;float:center">
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

</body>