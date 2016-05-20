<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table class="tab-form">

    <tr>
        <td style="width: 100px" class="title-bg">角色名称</td>
        <td style="width: 180px" class="domain-bg">
            <input id="name" name="name" class="easyui-textbox" required="true">
        </td>
    </tr>
    <tr>
        <td class="title-bg">标识符</td>
        <td class="domain-bg">
            <input id="tag" name="tag" class="easyui-textbox">
        </td>
    </tr>
    <tr>
        <td class="title-bg">角色状态</td>
        <td class="domain-bg">
            <input class="easyui-combobox" id="status" name="status"
                   data-options="url:'${pageContext.request.contextPath}/dict/findDict/status',method:'get',valueField:'value',textField:'name',panelHeight:'auto'">
        </td>
    </tr>
    <tr>
        <td class="title-bg">是否可编辑</td>
        <td class="domain-bg">
            <input class="easyui-combobox" id="editable" name="editable"
                   data-options="url:'${pageContext.request.contextPath}/dict/findDict/editable',method:'get',valueField:'value',textField:'name',panelHeight:'auto'">
        </td>
    </tr>
    <tr>
        <td class="title-bg">排序</td>
        <td class="domain-bg"><input class="easyui-textbox" id="sortNo" name="sortNo"></td>
    </tr>
    <tr>
        <td class="title-bg">备注</td>
        <td class="domain-bg">
            <input class="easyui-textbox" id="memo" name="memo">
        </td>
    </tr>

</table>
<input type="hidden" id="id" name="id" value=""></td>