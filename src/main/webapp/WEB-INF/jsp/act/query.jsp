<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<div>
    <div class="subtitle" style="border-bottom:1px solid #ccc">
        <%=SpringUtils.getMessage("page.common.inputParams")%>
    </div>
    <div style="padding:10px 0 10px 30px">
        <table cellspacing="5">
            <tr>
                <td>
                    <%=SpringUtils.getMessage("action.query.name")%>
                </td>
                <td><input name="name" class="easyui-textbox">
                </td>
            </tr>
            <tr>
                <td>
                    <%=SpringUtils.getMessage("action.query.enName")%>
                </td>
                <td><input name="enName" class="easyui-textbox"></td>
            </tr>
            <tr>
                <td>
                    <%=SpringUtils.getMessage("action.query.status")%>
                </td>
                <td><input class="easyui-combobox" id="status" name="status"
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