<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table class="tab-form">

    <tr>
        <td style="width:100px" class="title-bg">
            <%=SpringUtils.getMessage("rank.form.name")%>
        </td>
        <td style="width:180px" class="domain-bg">
            <input class="easyui-textbox" id="name" name="name"
                   missingMessage="<%=SpringUtils.getMessage("rank.form.nameRequired")%>"
                   required="true"></td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("rank.form.scale")%>
        </td>
        <td class="domain-bg">
            <input class="easyui-numberbox" id="scale" name="scale"
                   required="true" precision="2" min="0.01" max="1" value="1"
                   data-options="value:'0'"
                   missingMessage="<%=SpringUtils.getMessage("rank.form.scaleMissing")%>"/></td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("rank.form.amount")%>
        </td>
        <td class="domain-bg">
            <input class="easyui-numberbox" id="amount" name="amount" precision="2" min="0"
                   max="99999999"
                   required="true"
                   missingMessage="<%=SpringUtils.getMessage("rank.form.amountRequired")%>"/></td>
        </td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("rank.form.isDefault")%>
        </td>
        <td class="domain-bg"><input type="checkbox" id="isDefault" name="isDefault"></td>
    </tr>
    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("rank.form.isSpecial")%>
        </td>
        <td class="domain-bg"><input type="checkbox" id="isSpecial" name="isSpecial"></td>
    </tr>

</table>
<input type="hidden" id="id" name="id" value="">