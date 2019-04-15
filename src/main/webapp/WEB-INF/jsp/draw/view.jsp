<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<div>
    <fieldset class="fieldset" style="width:1103px">
        <legend class="legend">
            逝者信息
        </legend>
        <table class="tab-border">
            <tr>
                <td style="width: 100px" class="title-bg">
                    服务编号
                </td>
                <td class="domain-bg">
                    <input type="hidden" id="id" name="id" value="">
                    <input class="easyui-textbox" id="serviceNo"
                           name="serviceNo" style="width:198px"
                           data-options="disabled:true">
                </td>
                <td style="width: 100px" class="title-bg">
                </td>
                <td class="domain-bg">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    证件类型
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="dpCertType" name="dpCertType"
                           style="width:198px"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/certType',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                disabled:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    证件号码
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="dpCertNo" name="dpCertNo"
                           style="width:198px"
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
                    住址
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="dpAddr" name="dpAddr"
                           style="width:198px"
                           data-options="disabled:true">
                </td>
            </tr>
        </table>
    </fieldset>
</div>

<div style="padding-top: 20px;">
    <fieldset class="fieldset" style="width:1103px">
        <legend class="legend">
            承办人信息
        </legend>
        <table class="tab-border">
            <tr>
                <td style="width: 100px" class="title-bg">
                    证件类型
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="utCertType" name="utCertType"
                           style="width:198px"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/certType',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                disabled:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    证件号码
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="utCertNo" name="utCertNo"
                           style="width:198px"
                           data-options="disabled:true">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    姓名
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="utName" name="utName"
                           style="width:198px"
                           data-options="disabled:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    联系电话
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="phone" name="phone"
                           style="width:198px"
                           data-options="disabled:true">
                </td>
            </tr>
        </table>
    </fieldset>
</div>

<div style="padding-top: 20px;">
    <fieldset class="fieldset" style="width:1103px">
        <legend class="legend">
            其他信息
        </legend>
        <table class="tab-border">
            <tr>
                <td style="width: 100px" class="title-bg">
                    磁卡情况
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="magcardState" name="magcardState"
                           style="width:198px"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/magcardState',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                disabled:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    单据情况
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="invoiceState" name="invoiceState"
                           style="width:198px"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/invoiceState',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                disabled:true">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    领取类型
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="drawType" name="drawType"
                           style="width:198px"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/drawType',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                disabled:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    领取时间
                </td>
                <td class="domain-bg">
                    <input class="easyui-datebox" id="drawDate" name="drawDate"
                           style="width:198px;" data-options="disabled:true">
                </td>
            </tr>
        </table>
    </fieldset>
</div>