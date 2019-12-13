<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page
        language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<div>
    <fieldset class="fieldset" style="width:1103px">
        <legend class="legend">
            服务信息
        </legend>
        <table class="tab-border">
            <tr>
                <td style="width: 100px" class="title-bg">
                    RFID编号
                </td>
                <td class="domain-bg">
                    <input type="hidden" id="id" name="id" value=""/>
                    <input
                            class="easyui-textbox"
                            id="serviceNo"
                            name="serviceNo"
                            style="width:198px"
                            data-options="required:true,readonly:true,
                    missingMessage:'请读取RFID识别号码'"/>
                    <a
                            id="readRfid"
                            href="#"
                            class="easyui-linkbutton"
                            data-options="iconCls:'icon-man'"
                            style="width:135px;margin-top:2px;"
                    >读取RFID编号</a>
                </td>
            </tr>
            <tr>
                <td align="right" colspan="4">
                    <a
                            id="readRfid"
                            href="#"
                            class="easyui-linkbutton"
                            data-options="iconCls:'icon-man'"
                            style="width:135px;margin-top:2px;"
                    >读取RFID编号</a>
                </td>
            </tr>
        </table>
    </fieldset>
</div>
<div style="padding-top: 20px;">
    <fieldset class="fieldset" style="width:1103px">
        <legend class="legend">
            逝者信息
        </legend>
        <table class="tab-border">
            <tr>
                <td style="width: 100px" class="title-bg">
                    证件类型
                </td>
                <td class="domain-bg">
                    <input
                            class="easyui-combobox"
                            id="dpCertType"
                            name="dpCertType"
                            style="width:198px"
                            data-options="url:'${pageContext.request.contextPath}/dict/findDict/certType',
                                                editable:false,
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto',
                                                required:true,
                                                missingMessage:'请选择逝者证件类型'"
                    />
                </td>
                <td style="width: 100px" class="title-bg">
                    证件号码
                </td>
                <td class="domain-bg">
                    <input
                            class="easyui-textbox"
                            id="dpCertNo"
                            name="dpCertNo"
                            style="width:198px"
                            data-options="required:true,missingMessage:'请填入逝者证件号码'"
                    />
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    姓名
                </td>
                <td class="domain-bg">
                    <input
                            class="easyui-textbox"
                            id="dpName"
                            name="dpName"
                            style="width:198px"
                            data-options="required:true,
                           missingMessage:'请填入逝者姓名',
                           validType:['chinese','length[2,5]']"
                    />
                </td>
                <td style="width: 100px" class="title-bg">
                </td>
                <td class="domain-bg">
                </td>
            </tr>
            <tr>
                <td align="right" colspan="4">
                    <a
                            id="readUtIdCard"
                            href="#"
                            class="easyui-linkbutton"
                            data-options="iconCls:'icon-man'"
                            style="width:135px;margin-top:2px;"
                    >读逝者身份证</a>
                </td>
            </tr>
        </table>
    </fieldset>
</div>
