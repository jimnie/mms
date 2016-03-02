<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table>

    <tr>
        <td>所属组</td>
        <td colspan="2">
            <input class="easyui-combotree" id="parent.id" name="parent.id"
                   data-options="url:'${pageContext.request.contextPath}/group/tree',  method:'get'">
        </td>
    </tr>
    <tr>
        <td align="center" colspan="3">
            <table style="width: 400px">
                <tr>
                    <td style="width: 40%">
                        所有角色：
                        <div id="selectable" style="width:99%;height:240px;overflow: auto">
                            <select id="selectableRoles" name="selectableRoles" size="10"
                                    multiple="multiple"
                                    style="width:99%;height:240px"></select>
                        </div>
                    </td>
                    <td style="width: 20%">
                        <a id="addRoles" class="easyui-linkbutton" href="javascript:void(0)">添加 &gt;&gt;</a><br><br><br><br>
                        <a id="moveRoles" class="easyui-linkbutton" href="javascript:void(0)">&lt;&lt;
                            删除</a>
                    </td>
                    <td style="width: 40%">
                        已选角色：
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