<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div>
    <div class="subtitle" style="border-bottom:1px solid #ccc">
        <%=SpringUtils.getMessage("page.common.inputParams")%>
    </div>
    <div style="padding:10px 0 10px 30px">
        <table cellpadding="5">
            <tr>
                <td style="width:80px">
                    <%=SpringUtils.getMessage("member.form.cardNo")%>
                </td>
                <td><input class="easyui-textbox" id="cardNo" name="cardNo"></td>
            </tr>

            <tr>
                <td>
                    <%=SpringUtils.getMessage("member.form.kidCnName")%>
                </td>
                <td><input class="easyui-textbox" id="kidName" name="kidName"></td>
            </tr>

            <tr>
                <td>
                    <%=SpringUtils.getMessage("member.form.mobile")%>
                </td>
                <td><input class="easyui-textbox" id="mobile" name="mobile"></td>
            </tr>

            <tr>
                <td>
                    <%=SpringUtils.getMessage("member.datagrid.memberRank")%>
                </td>
                <td><input class="easyui-combobox" id="memberRankId" name="memberRankId"
                           data-options="url:'${pageContext.request.contextPath}/rank/all',
                method:'get',valueField:'id',textField:'name',panelHeight:'auto'"></td>
            </tr>

        </table>
    </div>
</div>

	