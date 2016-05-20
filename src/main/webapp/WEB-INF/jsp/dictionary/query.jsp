<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div>
    <div class="subtitle" style="border-bottom:1px solid #ccc">
        <%=SpringUtils.getMessage("page.common.inputParams")%>
    </div>
    <div style="padding:10px 0 10px 30px">
        <table cellpadding="5" class="tab-form">
            <tr>
                <td style="width:70px" class="title-bg">
                    <%=SpringUtils.getMessage("dict.query.name")%>
                </td>
                <td style="width:180px" class="domain-bg">
                    <input class="easyui-textbox" id="name" name="name"></td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("dict.query.creator")%>
                </td>
                <td class="domain-bg"><input class="easyui-textbox" id="creator" name="creator">
                </td>
            </tr>

        </table>
    </div>
</div>

	