<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<table cellpadding="5">
    <tr>
        <td style="width: 100px">
            <%=SpringUtils.getMessage("user.form.username")%>
        </td>
        <td><input class="easyui-validatebox textbox" id="username" name="username"
                   required="true">
        </td>
    </tr>

    <tr>
        <td>
            <%=SpringUtils.getMessage("user.form.password")%>
        </td>
        <td>
            <input class="easyui-validatebox textbox" id="password" name="password" type="password"
                   validType="length[4,20]"
                   required="true">
        </td>
    </tr>

    <tr>
        <td>
            <%=SpringUtils.getMessage("user.form.isEnabled")%>
        </td>
        <td><input type="checkbox" id="isEnabled" name="isEnabled" checked></td>
    </tr>

</table>
<input type="hidden" id="id" name="id" value="">
