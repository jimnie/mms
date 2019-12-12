<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
                           data-options="iconCls:'icon-add'" onclick="addBag()">
                            <%=SpringUtils.getMessage("page.action.add")%>
                        </a>
                        <shiro:hasPermission name="deposit:edit">
                            <a href="javascript:void(0)" class="easyui-linkbutton"
                               data-options="iconCls:'icon-edit'" onclick="editBag()">
                                <%=SpringUtils.getMessage("page.action.edit")%>
                            </a>
                        </shiro:hasPermission>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           data-options="iconCls:'icon-more'" onclick="viewBag()">
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
    </div>
</div>

</body>