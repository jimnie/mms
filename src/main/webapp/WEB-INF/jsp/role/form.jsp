<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table cellpadding="5">

    <tr>
        <td style="width: 100px">角色名称</td>
        <td>
            <input id="name" name="name" class="easyui-textbox" required="true">
        </td>
    </tr>
    <tr>
        <td>标识符</td>
        <td>
            <input id="tag" name="tag" class="easyui-textbox">
        </td>
    </tr>
    <tr>
        <td>角色状态</td>
        <td>
            <input class="easyui-combobox" id="status" name="status"
                   data-options="url:'${pageContext.request.contextPath}/dict/findDict/status',method:'get',valueField:'value',textField:'name',panelHeight:'auto'">
        </td>
    </tr>
    <tr>
        <td>是否可编辑</td>
        <td>
            <input class="easyui-combobox" id="editable" name="editable"
                   data-options="url:'${pageContext.request.contextPath}/dict/findDict/editable',method:'get',valueField:'value',textField:'name',panelHeight:'auto'">
        </td>
    </tr>
    <tr>
        <td>排序</td>
        <td><input class="easyui-textbox" id="sortNo" name="sortNo"></td>
    </tr>
    <tr>
        <td>备注</td>
        <td>
            <input class="easyui-textbox" id="memo" name="memo">
        </td>
    </tr>

</table>
<input type="hidden" id="id" name="id" value=""></td>