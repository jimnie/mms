<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table class="tab-form">

    <tr>
        <td style="width: 100px" class="title-bg">
            <%=SpringUtils.getMessage("role.datagrid.name")%>
        </td>
        <td style="width: 180px" class="domain-bg">
            <input id="name" name="name" class="easyui-textbox" required="true">
        </td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("role.form.tag")%>
        </td>
        <td class="domain-bg">
            <input id="tag" name="tag" class="easyui-textbox">
        </td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("role.datagrid.status")%>
        </td>
        <td class="domain-bg">
            <input class="easyui-combobox" id="status" name="status"
                   data-options="url:'${pageContext.request.contextPath}/dict/findDict/status',method:'get',valueField:'value',textField:'name',panelHeight:'auto'">
        </td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("role.form.isEditable")%>
        </td>
        <td class="domain-bg">
            <input class="easyui-combobox" id="editable" name="editable"
                   data-options="url:'${pageContext.request.contextPath}/dict/findDict/editable',method:'get',valueField:'value',textField:'name',panelHeight:'auto'">
        </td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("role.datagrid.sortNo")%>
        </td>
        <td class="domain-bg"><input class="easyui-textbox" id="sortNo" name="sortNo"></td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("role.datagrid.memo")%>
        </td>
        <td class="domain-bg">
            <input class="easyui-textbox" id="memo" name="memo">
        </td>
    </tr>

</table>
<input type="hidden" id="id" name="id" value="">