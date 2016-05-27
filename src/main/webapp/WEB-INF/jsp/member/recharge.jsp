<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<table class="tab-form">
    <tr>
        <td style="width: 100px" class="title-bg">
            <%=SpringUtils.getMessage("member.form.chargeAmount")%>
        </td>
        <td style="width: 180px" class="domain-bg">
            <input id="rechargeAmount" name="rechargeAmount" class="easyui-numberbox" value="0"
                   data-options="precision:2,groupSeparator:',',decimalSeparator:'.',prefix:'¥',required:true">
        </td>
    </tr>

    <tr>
        <td colspan="2" class="domain-bg" style="font-weight: bold;color: #B81C22">
            <%=SpringUtils.getMessage("member.form.chargeConfirmMemberInfo")%>
        </td>
    </tr>

    <tr>
        <td style="width: 100px" class="title-bg">
            <%=SpringUtils.getMessage("member.form.cardNo")%>
        </td>
        <td style="width: 180px" class="domain-bg">
            <input id="c_cardNo" name="c_cardNo" class="easyui-textbox">
        </td>
    </tr>

    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("member.form.cnName")%>
        </td>
        <td class="domain-bg">
            <input id="c_cnName" name="c_cnName" class="easyui-textbox">
        </td>
    </tr>

    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("member.form.mobile")%>
        </td>
        <td class="domain-bg">
            <input id="c_mobile" name="c_mobile" class="easyui-textbox">
        </td>
    </tr>

    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("member.datagrid.memberRank")%>
        </td>
        <td class="domain-bg">
            <input id="memberRank" name="memberRank" class="easyui-textbox">
        </td>
    </tr>
</table>
<input type="hidden" id="c_id" name="c_id">