<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<div>
    <div class="subtitle" style="border-bottom:1px solid #ccc">请输入查询参数：</div>
    <div style="padding:10px 0 10px 30px">
        <table cellspacing="5">
            <tr>
                <td>角色名称：</td>
                <td><input id="name" name="name" class="easyui-textbox">
                </td>
            </tr>
            <tr>
                <td>角色状态：</td>
                <td>
                    <input class="easyui-combobox" id="status" name="status"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/status',
                       method:'get',
                    valueField:'value',
                    textField:'name',
                    panelHeight:'auto'">
                </td>
            </tr>
            <tr>
                <td>排序：</td>
                <td><input id="sortNo" name="sortNo" class="easyui-textbox"></td>
            </tr>
            <tr>
                <td>备注：</td>
                <td><input id="memo" name="memo" class="easyui-textbox"></td>
            </tr>

        </table>
    </div>
</div>