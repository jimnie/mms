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
                    安放袋编号
                </td>
                <td class="domain-bg">
                    <input type="hidden" id="id" name="id" value=""/>
                    <input
                            class="easyui-textbox"
                            id="serviceNo"
                            name="serviceNo"
                            style="width:198px"
                            data-options="required:true,
                           missingMessage:'请放置安放袋读取识别号码',
                           validType:'serviceNo'"
                    />
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
                    >读取安放袋编号</a>
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
                    <input
                            class="easyui-combobox"
                            id="utCertType"
                            name="utCertType"
                            style="width:198px"
                            data-options="url:'${pageContext.request.contextPath}/dict/findDict/certType',
                                                editable:false,
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto',
                                                required:true,
                                                missingMessage:'请选择承办人证件类型'"
                    />
                </td>
                <td style="width: 100px" class="title-bg">
                    证件号码
                </td>
                <td class="domain-bg">
                    <input
                            class="easyui-textbox"
                            id="utCertNo"
                            name="utCertNo"
                            style="width:198px"
                            data-options="required:true,missingMessage:'请填入承办人证件号码'"
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
                            id="utName"
                            name="utName"
                            style="width:198px"
                            data-options="required:true,
                           missingMessage:'请填入承办人姓名',
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
                    >读承办人身份证</a>
                </td>
            </tr>
        </table>
    </fieldset>
</div>
