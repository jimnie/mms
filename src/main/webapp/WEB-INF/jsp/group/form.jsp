<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table class="tab-form">
    <tr>
        <td style="width:100px" class="title-bg">
            <%=SpringUtils.getMessage("group.form.name")%>
        </td>
        <td style="width: 180px" class="domain-bg">
            <input class="easyui-textbox" id="name" name="name"></td>
    </tr>

    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("group.form.tag")%>
        </td>
        <td class="domain-bg">
            <input class="easyui-textbox" id="tag" name="tag">
        </td>
    </tr>

    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("group.form.nodeState")%>
        </td>
        <td class="domain-bg">
            <input class="easyui-combobox" id="nodeState" name="nodeState"
                   data-options="url:'${pageContext.request.contextPath}/dict/findDict/nodeState',method:'get',valueField:'value',textField:'name',panelHeight:'auto'">
        </td>
    </tr>

    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("group.form.parent")%>
        </td>
        <td class="domain-bg">
            <input class="easyui-combotree" id="parent.id" name="parent.id"
                   data-options="url:'${pageContext.request.contextPath}/group/tree',method:'get'">
        </td>
    </tr>

    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("group.form.status")%>
        </td>
        <td class="domain-bg">
            <input class="easyui-combobox" id="status" name="status"
                   data-options="url:'${pageContext.request.contextPath}/dict/findDict/status',method:'get',valueField:'value',textField:'name',panelHeight:'auto'">
        </td>
    </tr>

    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("group.form.sortNo")%>
        </td>
        <td class="domain-bg"><input class="easyui-textbox" id="sortNo" name="sortNo"></td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("group.form.memo")%>
        </td>
        <td class="domain-bg"><input class="easyui-textbox" id="memo" name="memo"></td>
    </tr>
</table>
<input type="hidden" id="id" name="id" value="">