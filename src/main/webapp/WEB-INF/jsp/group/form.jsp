<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<table cellpadding="5">
    <tr>
        <td style="width:80px">组名称</td>
        <td><input class="easyui-textbox" id="name" name="name"></td>
    </tr>

    <tr>
        <td>标识符</td>
        <td>
            <input class="easyui-textbox" id="tag" name="tag">
        </td>
    </tr>

    <tr>
        <td>默认状态</td>
        <td>
            <input class="easyui-combobox" id="nodeState" name="nodeState"
                   data-options="url:'${pageContext.request.contextPath}/dict/findDict/nodeState',method:'get',valueField:'value',textField:'name',panelHeight:'auto'">
        </td>
    </tr>

    <tr>
        <td>所属组</td>
        <td>
            <input class="easyui-combotree" id="parent.id" name="parent.id"
                   data-options="url:'${pageContext.request.contextPath}/group/tree',method:'get'">
        </td>
    </tr>

    <tr>
        <td>状态</td>
        <td>
            <input class="easyui-combobox" id="status" name="status"
                   data-options="url:'${pageContext.request.contextPath}/dict/findDict/status',method:'get',valueField:'value',textField:'name',panelHeight:'auto'">
        </td>
    </tr>

    <tr>
        <td>排序</td>
        <td><input class="easyui-textbox" id="sortNo" name="sortNo"></td>
    </tr>
    <tr>
        <td>备注</td>
        <td><input class="easyui-textbox" id="memo" name="memo"></td>
    </tr>
</table>
<input type="hidden" id="id" name="id" value=""></td>