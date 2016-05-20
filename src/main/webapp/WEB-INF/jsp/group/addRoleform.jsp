<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table class="tab-form">

    <tr>
        <td style="width: 100px;" class="title-bg"><%=SpringUtils.getMessage("group.form.parent")%>
        </td>
        <td style="width: 180px" colspan="2" class="domain-bg">
            <input class="easyui-combotree" id="parent.id" name="parent.id"
                   data-options="url:'${pageContext.request.contextPath}/group/tree',method:'get'">
        </td>
    </tr>
    <tr>
        <td align="center" colspan="3" class="domain-bg">
            <table style="width: 400px">
                <tr>
                    <td style="font-size: 12px;width: 40%">
                        <%=SpringUtils.getMessage("group.form.selectableRole")%>
                        <div id="selectable" style="width:99%;height:240px;overflow: auto">
                            <select id="selectableRoles" name="selectableRoles" size="10"
                                    multiple="multiple"
                                    style="width:99%;height:240px"></select>
                        </div>
                    </td>
                    <td style="width: 20%">
                        <a id="addRoles" class="easyui-linkbutton" href="javascript:void(0)">
                            <%=SpringUtils.getMessage("group.form.add")%>
                        </a><br><br><br><br>
                        <a id="moveRoles" class="easyui-linkbutton" href="javascript:void(0)">
                            <%=SpringUtils.getMessage("group.form.remove")%>
                        </a>
                    </td>
                    <td style="font-size: 12px;width: 40%">
                        <%=SpringUtils.getMessage("group.form.selectedRole")%>
                        <div id="selected" style="width:99%;height:240px;overflow: auto">
                            <select id="selectedRoles" name="selectedRoles" size="10"
                                    style="width:99%;height:240px"></select>
                            <input type="hidden" id="roles" name="roles" value="">
                            <input type="hidden" id="groupid" name="groupid" value="">
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>

</table>