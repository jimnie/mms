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
                    服务编号
                </td>
                <td style="width:180px" class="domain-bg">
                    <input class="easyui-textbox" id="serviceNo" name="serviceNo"></td>
            </tr>

            <tr>
                <td class="title-bg">
                    逝者姓名
                </td>
                <td class="domain-bg"><input class="easyui-textbox" id="dpName"
                                             name="dpName">
                </td>
            </tr>

            <tr>
                <td class="title-bg">
                    存放状态
                </td>
                <td class="domain-bg"><input class="easyui-combobox" id="status"
                                             name="status"
                                             data-options="url:'${pageContext.request.contextPath}/dict/findDict/state',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto'">
                </td>
            </tr>

        </table>
    </div>
</div>

	