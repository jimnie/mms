<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<div>
    <fieldset class="fieldset" style="width:1103px">
        <legend class="legend">
            骨灰信息
        </legend>
        <table class="tab-border">
            <tr>
                <td style="width: 100px" class="title-bg">
                    骨灰袋识别码
                </td>
                <td class="domain-bg">
                    <input type="hidden" id="id" name="id" value="">
                    <input class="easyui-textbox" id="rfid"
                           name="rfid" style="width:198px"
                           data-options="disabled:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    业务编号
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="serviceNo"
                           name="serviceNo" style="width:198px"
                           data-options="disabled:true">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    姓名
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="dpName" name="dpName"
                           style="width:198px"
                           data-options="disabled:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    性别
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="dpSex" name="dpSex"
                           style="width:198px"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/sex',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                disabled:true">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    年龄
                </td>
                <td class="domain-bg">
                    <input class="easyui-numberspinner" id="dpAge" name="dpAge"
                           style="width:198px"
                           data-options="disabled:true">
                </td>
                <td style="width: 100px" class="title-bg">
                </td>
                <td class="domain-bg">
                </td>
            </tr>
        </table>
    </fieldset>
</div>
<div style="padding-top: 20px;">
    <fieldset class="fieldset" style="width:1103px">
        <legend class="legend">
            存放信息
        </legend>
        <table class="tab-border">
            <tr>
                <td style="width: 100px" class="title-bg">
                    存放位置
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="position" name="position"
                           style="width:198px;" data-options="
                    url: '${pageContext.request.contextPath}/shelf/list',
                    method: 'get',
                    valueField: 'code',
                    textField: 'code',
                    disabled:true">
                </td>
            </tr>
        </table>
    </fieldset>
</div>