<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<div>
    <div class="subtitle" style="border-bottom:1px solid #ccc">
        <%=SpringUtils.getMessage("page.common.inputParams")%>
    </div>
    <div style="padding:10px 0 10px 30px">
        <table cellspacing="5" class="tab-form">
            <tr>
                <td style="width: 70px" class="title-bg">
                    <%=SpringUtils.getMessage("action.query.name")%>
                </td>
                <td style="width:180px" class="domain-bg">
                    <input name="name" class="easyui-textbox">
                </td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("action.query.enName")%>
                </td>
                <td class="domain-bg">
                    <input name="enName" class="easyui-textbox"></td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("action.query.status")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="status" name="status"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/status',
                       method:'get',
                    valueField:'value',
                    textField:'name',
                    panelHeight:'auto'">
                </td>
            </tr>
        </table>
    </div>
</div>