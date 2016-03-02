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
                    <%=SpringUtils.getMessage("dict.query.name")%>
                </td>
                <td><input class="easyui-textbox" id="name" name="name"></td>
            </tr>

            <tr>
                <td>
                    <%=SpringUtils.getMessage("dict.query.creator")%>
                </td>
                <td><input class="easyui-textbox" id="creator" name="creator"></td>
            </tr>

        </table>
    </div>
</div>

	