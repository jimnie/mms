<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table cellpadding="5">
    <tr>
        <td style="width:80px">
            <%=SpringUtils.getMessage("dict.form.nickname")%>
        </td>
        <td><input class="easyui-textbox" id="nickname" name="nickname"
                   required="true"></td>
    </tr>
    <tr>
        <td>
            <%=SpringUtils.getMessage("dict.form.value")%>
        </td>
        <td>
            <input class="easyui-textbox" id="value" name="value"
                   required="true"/></td>
    </tr>
    <tr>
        <td>
            <%=SpringUtils.getMessage("dict.form.name")%>
        </td>
        <td>
            <input class="easyui-textbox" id="name" name="name"
                   required="true"/></td>
        </td>
    </tr>
    <tr>
        <td>
            <%=SpringUtils.getMessage("dict.form.type")%>
        </td>
        <td><input class="easyui-textbox" id="type" name="type"></td>
    </tr>
    <tr>
        <td>
            <%=SpringUtils.getMessage("dict.form.updatable")%>
        </td>
        <td>
            <input class="easyui-combobox" id="updatable" name="updatable"
                   data-options="url:'${pageContext.request.contextPath}/dict/findDict/updatable',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto'">
    </tr>
    <tr>
        <td>
            <%=SpringUtils.getMessage("dict.form.status")%>
        </td>
        <td>
            <input class="easyui-combobox" id="status" name="status"
                   data-options="url:'${pageContext.request.contextPath}/dict/findDict/status',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto'">

        </td>
    </tr>
    <tr>
        <td>
            <%=SpringUtils.getMessage("dict.form.sortNo")%>
        </td>
        <td>
            <input class="easyui-textbox" id="sortNo" name="sortNo">
        </td>
    </tr>
    <tr>
        <td>
            <%=SpringUtils.getMessage("dict.form.memo")%>
        </td>
        <td><input class="easyui-textbox" id="memo" name="memo"></td>
    </tr>
    <tr>
        <td></td>
        <td style="display: none;">
            <input class="easyui-textbox" id="createDate" name="createDate">
        </td>
    </tr>
</table>
<input type="hidden" id="id" name="id" value=""></td>