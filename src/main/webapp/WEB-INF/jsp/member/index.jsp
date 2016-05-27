<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
    <jsp:include page="head.jsp"></jsp:include>
</head>
<body style="margin: 0px">
<div class="easyui-layout" fit="true">
    <div region="north" border="false" style="height: 35px">
        <div class="toolbar">
            <table cellpadding="0" cellspacing="0" style="width: 95%">
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
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-redo'" onclick="recharge()">
                            <%=SpringUtils.getMessage("member.form.charge")%>
                        </a>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-undo'" onclick="unrecharge()">
                            <%=SpringUtils.getMessage("member.form.unrecharge")%>
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
        <table id="members" class="easyui-datagrid" border="false" fit="true"
               rownumbers="true" pagination="true" sortName="registerDate" sortOrder="desc"
               data-options="singleSelect:true,fitColumns:false,url:'${pageContext.request.contextPath}/member/list',method:'get',pageSize:20,striped:true">
            <thead data-options="frozen:true">
            <tr>
                <th data-options="field:'id',hidden:true"></th>
                <th data-options="field:'state',hidden:true">state</th>
                <th data-options="field:'city',hidden:true">city</th>
                <th data-options="field:'district',hidden:true">district</th>
                <th data-options="field:'street',hidden:true">street</th>
                <th data-options="field:'categories',hidden:true">categories</th>
                <th data-options="field:'cardNo',width:100,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("member.form.cardNo")%>
                </th>
                <th data-options="field:'firstKidCnName',width:80,halign:'center'">
                    <%=SpringUtils.getMessage("member.form.kidCnName")%>
                </th>
                <th data-options="field:'firstKidSex',width:40,halign:'center',align:'center',formatter:sexFormatter">
                    <%=SpringUtils.getMessage("member.form.kidSex")%>
                </th>
                <th data-options="field:'firstKidBirth',width:80,halign:'center',align:'center'">
                    <%=SpringUtils.getMessage("member.form.kidBirth")%>
                </th>
                <th data-options="field:'memberRank',width:100,halign:'center',align:'center',sortable:true,
                formatter:function(value,row){return row.memberRank.name;}">
                    <%=SpringUtils.getMessage("member.datagrid.memberRank")%>
                </th>
                <th data-options="field:'balance',width:120,halign:'center',align:'right',formatter:formatCurrency">
                    <%=SpringUtils.getMessage("member.form.balance")%>
                </th>
                <th data-options="field:'amount',width:120,halign:'center',align:'right',sortable:true,formatter:formatCurrency">
                    <%=SpringUtils.getMessage("member.form.amount")%>
                </th>
                <th data-options="field:'registerDate',width:100,halign:'center',align:'center',sortable:true">
                    <%=SpringUtils.getMessage("member.form.registerDate")%>
                </th>
            </tr>
            </thead>
            <thead>
            <tr>
                <th data-options="field:'cnName',width:120,halign:'center'">
                    <%=SpringUtils.getMessage("member.datagrid.name")%>
                </th>
                <th data-options="field:'relation',width:120,halign:'center',align:'left',formatter:relationFormatter">
                    <%=SpringUtils.getMessage("member.form.relation")%>
                </th>
                <th data-options="field:'mobile',width:100,halign:'center',align:'center'">
                    <%=SpringUtils.getMessage("member.form.mobile")%>
                </th>
                <th data-options="field:'address',width:300,halign:'center'">
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
    <div style="padding:20px 0px 0px 60px">
        <div style="width: 1080px;height: 630px;float: center">
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

<div id="rechargeDlg" class="easyui-dialog" style="width: 400px;height: 300px"
     closed="true" modal="true" buttons="#recharge-dlg-buttons">
    <div style="padding:20px 0px 0px 40px">
        <div style="float: center">
            <form id="rechargeform" method="post">
                <jsp:include page="recharge.jsp"></jsp:include>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="recharge-dlg-buttons" style="text-align: center">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
           onclick="saveRecharge()">
            <%=SpringUtils.getMessage("page.action.ok")%>
        </a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
           onclick="javascript:$('#rechargeDlg').dialog('close')">
            <%=SpringUtils.getMessage("page.action.close")%>
        </a>
    </div>
</div>

<div id="unrechargeDlg" class="easyui-dialog" style="width: 400px;height: 380px"
     closed="true" modal="true" buttons="#unrecharge-dlg-buttons">
    <div style="padding:20px 0px 0px 40px">
        <div style="float: center">
            <form id="unrechargeform" method="post">
                <jsp:include page="unrecharge.jsp"></jsp:include>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="unrecharge-dlg-buttons" style="text-align: center">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
           onclick="saveUnrecharge()">
            <%=SpringUtils.getMessage("page.action.ok")%>
        </a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
           onclick="javascript:$('#unrechargeDlg').dialog('close')">
            <%=SpringUtils.getMessage("page.action.close")%>
        </a>
    </div>
</div>

<div style="display: none">
    <form id="delform" method="post">
        <input type="hidden" id="memberId" name="memberId">
    </form>
</div>
</body>