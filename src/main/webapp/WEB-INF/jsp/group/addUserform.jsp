<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table>

    <tr>
        <td><%=SpringUtils.getMessage("group.form.parent")%>
        </td>
        <td colspan="2">
            <input class="easyui-combotree" id="parent.id" name="parent.id"
                   data-options="url:'${pageContext.request.contextPath}/group/tree',method:'get'">
        </td>
    </tr>
    <tr>
        <td align="center" colspan="3">
            <table style="width: 400px">
                <tr>
                    <td style="width: 40%">
                        <%=SpringUtils.getMessage("group.form.selectableUser")%>
                        <div id="selectable" style="width:99%;height:240px;overflow: auto">
                            <select id="selectableUsers" name="selectableUsers" size="10"
                                    multiple="multiple"
                                    style="width:99%;height:240px"></select>
                        </div>
                    </td>
                    <td style="width: 20%">
                        <a id="moveToRight" class="easyui-linkbutton"
                           href="javascript:void(0)"><%=SpringUtils.getMessage("group.form.add")%>
                        </a><br><br><br><br>
                        <a id="moveToLeft" class="easyui-linkbutton" href="javascript:void(0)">
                            <%=SpringUtils.getMessage("group.form.remove")%>
                        </a>
                    </td>
                    <td style="width: 40%">
                        <%=SpringUtils.getMessage("group.form.selectedUser")%>
                        <div id="selected" style="width:99%;height:240px;overflow: auto">
                            <select id="selectedUsers" name="selectedUsers" size="10"
                                    multiple="multiple"
                                    style="width:99%;height:240px"></select>
                            <input type="hidden" id="users" name="users" value="">
                            <input type="hidden" id="groupid" name="groupid" value="">
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>

</table>