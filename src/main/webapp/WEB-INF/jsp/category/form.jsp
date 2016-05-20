<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table class="tab-form">

    <tr>
        <td style="width:100px" class="title-bg">
            <%=SpringUtils.getMessage("category.form.name")%>
        </td>
        <td style="width:180px" class="domain-bg">
            <input class="easyui-textbox" id="name" name="name"
                   data-options="required:true,missingMessage:'<%=SpringUtils.getMessage("category.form.nameRequired")%>'">
        </td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("category.form.memo")%>
        </td>
        <td class="domain-bg">
            <textarea id="memo" rowspan="10" name="memo" class="textarea easyui-validatebox"
                      style="resize: none;width: 180px;height: 100px;max-width: 180px;
                      max-height: 100px; overflow-y:auto;"></textarea>
        </td>
    </tr>
    <tr style="display: none;">
        <td></td>
        <td>
            <input class="easyui-textbox" id="createDate" name="createDate">
        </td>
    </tr>

</table>
<input type="hidden" id="id" name="id" value="">