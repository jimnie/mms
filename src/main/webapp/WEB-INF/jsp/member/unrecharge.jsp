<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<table class="tab-form">
    <tr>
        <td style="width: 100px" class="title-bg">
            <%=SpringUtils.getMessage("member.form.unrechargeAmount")%>
        </td>
        <td style="width: 180px" class="domain-bg">
            <input id="unrechargeAmount" name="unrechargeAmount" class="easyui-numberbox" value="0"
                   data-options="precision:2,groupSeparator:',',decimalSeparator:'.',prefix:'¥',required:true">
        </td>
    </tr>

    <tr>
        <td style="width: 100px" class="title-bg">
            <%=SpringUtils.getMessage("member.form.unrechargeCause")%>
        </td>
        <td style="width: 180px;height: 78px" class="domain-bg">
            <input id="cause" name="cause" class="easyui-textbox" value="0"
                   data-options="multiline:true,required:true" style="height: 70px">
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
            <input id="b_cardNo" name="b_cardNo" class="easyui-textbox">
        </td>
    </tr>

    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("member.form.cnName")%>
        </td>
        <td class="domain-bg">
            <input id="b_cnName" name="b_cnName" class="easyui-textbox">
        </td>
    </tr>

    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("member.form.mobile")%>
        </td>
        <td class="domain-bg">
            <input id="b_mobile" name="b_mobile" class="easyui-textbox">
        </td>
    </tr>

    <tr>
        <td class="title-bg">
            <%=SpringUtils.getMessage("member.datagrid.memberRank")%>
        </td>
        <td class="domain-bg">
            <input id="b_memberRank" name="b_memberRank" class="easyui-textbox">
        </td>
    </tr>
</table>
<input type="hidden" id="b_id" name="b_id">
<input type="hidden" id="b_balance" name="b_balance">