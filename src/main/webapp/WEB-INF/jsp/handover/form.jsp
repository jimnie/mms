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
                           data-options="prompt:'正在读取骨灰袋识别码...',required:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    业务编号
                </td>
                <td class="domain-bg">
                    <input
                            class="easyui-textbox"
                            id="serviceNo"
                            name="serviceNo"
                            style="width:198px"
                            data-options="required:true"
                    />
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    姓名
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="dpName" name="dpName"
                           style="width:198px"
                           data-options="required:true,
                           missingMessage:'请填入逝者姓名',
                           validType:['chinese','length[2,5]']">
                </td>
                <td style="width: 100px" class="title-bg">
                    性别
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="dpSex" name="dpSex"
                           style="width:198px"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/sex',
                                                method:'get',
                                                editable:false,
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto',
                                                required:true,
                                                missingMessage:'请选择逝者性别'">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    年龄
                </td>
                <td class="domain-bg">
                    <input class="easyui-numberspinner" id="dpAge" name="dpAge"
                           style="width:198px"
                           data-options="required:true,panelHeight:'auto',min:0,max:150,missingMessage:'请填入逝者年龄',validType:'age'">
                </td>
                <td style="width: 100px" class="title-bg">
                </td>
                <td class="domain-bg">
                </td>
            </tr>
            <tr>
                <td align="right" colspan="4">
                    <a
                            id="readRfid"
                            href="#"
                            class="easyui-linkbutton"
                            data-options="iconCls:'icon-search'"
                            style="width:100px;margin-top:2px;"
                    >重新识别</a>
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
                    editable: false,
                    method: 'get',
                    valueField: 'code',
                    textField: 'code',
                    panelHeight: 'auto',
                    required:true,
                    missingMessage:'请选择存放位置'">
                </td>
            </tr>
        </table>
    </fieldset>
</div>
<OBJECT
        id="TUHFReader09"
        codebase="UHFReader09Proj.ocx"
        classid="clsid:14428901-AF2B-4B45-ACBD-0B4779551E5D"
        width="0"
        height="0"
        align="center"
        hspace="0"
        vspace="0"
>
</OBJECT>