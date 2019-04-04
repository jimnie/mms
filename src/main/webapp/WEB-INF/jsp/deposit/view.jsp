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
            骨灰盒信息
        </legend>
        <table class="tab-border">
            <tr>
                <td style="width: 100px" class="title-bg">
                    是否急取
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="urgent" name="urgent"
                           style="width:198px"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/isUrgent',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                disabled:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    存放位置
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="position" name="position"
                           style="width:198px;"
                           data-options="disabled:true">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    存入日期
                </td>
                <td class="domain-bg">
                    <input class="easyui-datebox" id="depositDate" name="depositDate"
                           style="width:198px;" data-options="disabled:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    取出日期
                </td>
                <td class="domain-bg">
                    <input class="easyui-datebox" id="preDrawDate" name="preDrawDate"
                           style="width:198px;"
                           data-options="disabled:true">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    外观
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="facade" name="facade"
                           style="width:198px"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/facade',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                disabled:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    备注
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="memo" name="memo"
                           style="width:198px;" data-options="disabled:true"/>
                </td>
            </tr>
        </table>
    </fieldset>
</div>