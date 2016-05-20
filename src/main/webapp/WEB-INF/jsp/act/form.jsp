<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table class="tab-form">
    <tr>
        <td style="width: 100px" class="title-bg">
            <%=SpringUtils.getMessage("action.form.name")%>
        </td>
        <td style="width: 180px" class="domain-bg"><input id="name" name="name"
                                                          class="easyui-textbox">
        </td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("action.form.enName")%>
        </td>
        <td class="domain-bg"><input id="enName" name="enName" class="easyui-textbox"></td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("action.form.handler")%>
        </td>
        <td class="domain-bg"><input id="handler" name="handler" class="easyui-textbox"></td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("action.form.status")%>
        </td>
        <td class="domain-bg"><input id="status" class="easyui-combobox" name="status"
                                     data-options="
                    url:'${pageContext.request.contextPath}/dict/findDict/status',
                    method:'get',
                    valueField:'value',
                    textField:'name',
                    panelHeight:'auto'
            ">
        </td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("action.form.sortNo")%>
        </td>
        <td class="domain-bg"><input id="sortNo" name="sortNo" class="easyui-textbox"></td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("action.form.memo")%>
        </td>
        <td class="domain-bg"><input id="memo" name="memo" class="easyui-textbox"></td>
    </tr>
</table>
<input type="hidden" id="id" name="id" value="">