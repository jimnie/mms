<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table cellpadding="5">
    <tr>
        <td style="width: 100px"><%=SpringUtils.getMessage("resource.form.text")%>
        </td>
        <td><input class="easyui-textbox" id="text" name="text" required="true">
        </td>
    </tr>

    <tr>
        <td><%=SpringUtils.getMessage("resource.form.aliasName")%>
        </td>
        <td><input class="easyui-textbox" id="aliasName" name="aliasName"></td>
    </tr>

    <tr>
        <td><%=SpringUtils.getMessage("resource.form.url")%>
        </td>
        <td><input class="easyui-textbox" id="url" name="url"></td>
    </tr>

    <tr>
        <td><%=SpringUtils.getMessage("resource.form.resourceType")%>
        </td>
        <td><input class="easyui-combobox" id="resourceType" name="resourceType" data-options="
                    url:'${pageContext.request.contextPath}/dict/findDict/resourceType',method:'get',valueField:'value',textField:'name',panelHeight:'auto',readonly: true">
        </td>
    </tr>

    <tr>
        <td><%=SpringUtils.getMessage("resource.form.parent")%>
        </td>
        <td>
            <input class="easyui-combotree" id="parent.id" name="parent.id" data-options="
                    url:'${pageContext.request.contextPath}/resource/tree',method:'get',readonly:true">
        </td>
    </tr>

    <tr>
        <td><%=SpringUtils.getMessage("resource.form.isLeaf")%>
        </td>
        <td><input class="easyui-combobox" id="isLeaf" name="isLeaf" data-options="
                    url:'${pageContext.request.contextPath}/dict/findDict/isLeaf',method:'get',valueField:'value',textField:'name',panelHeight:'auto',readonly: true">
        </td>
    </tr>

    <tr>
        <td><%=SpringUtils.getMessage("resource.form.icon")%>
        </td>
        <td><input class="easyui-combobox" id="icon" name="icon" data-options="
                    url:'${pageContext.request.contextPath}/dict/findDict/icon',method:'get',valueField:'value',textField:'name',panelHeight:150">
        </td>
    </tr>

    <tr>
        <td><%=SpringUtils.getMessage("resource.form.status")%>
        </td>
        <td><input class="easyui-combobox" id="status" name="status" data-options="
                    url:'${pageContext.request.contextPath}/dict/findDict/status',method:'get',valueField:'value',textField:'name',panelHeight:'auto'">
        </td>
    </tr>

    <tr>
        <td><%=SpringUtils.getMessage("resource.form.editable")%>
        </td>
        <td><input class="easyui-combobox" id="editable" name="editable" data-options="
                    url:'${pageContext.request.contextPath}/dict/findDict/editable',method:'get',valueField:'value',textField:'name',panelHeight:'auto'">
        </td>
    </tr>

    <tr>
        <td><%=SpringUtils.getMessage("resource.form.sortNo")%>
        </td>
        <td><input class="easyui-textbox" id="sortNo" name="sortNo"></td>
    </tr>

    <tr>
        <td></td>
        <td style="display: none;">
            <input class="easyui-textbox" id="createDate" name="createDate">
        </td>
    </tr>
</table>
<input type="hidden" id="id" name="id" value="">
<input type="hidden" id="state" name="state" value="">