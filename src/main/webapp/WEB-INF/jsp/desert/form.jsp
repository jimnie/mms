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
                    <input type="hidden" id="id" name="id" value=""/>
                    <input
                            class="easyui-textbox"
                            id="serviceNo"
                            name="serviceNo"
                            style="width:198px"
                            data-options="required:true,
                           missingMessage:'请扫码或填入服务编号',
                           validType:'serviceNo'"
                    />
                </td>
                <td style="width: 100px" class="title-bg"></td>
                <td class="domain-bg"></td>
            </tr>
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
                    性别
                </td>
                <td class="domain-bg">
                    <input
                            class="easyui-combobox"
                            id="dpSex"
                            name="dpSex"
                            style="width:198px"
                            data-options="url:'${pageContext.request.contextPath}/dict/findDict/sex',
                                                editable:false,
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto',
                                                required:true,
                                                missingMessage:'请选择逝者性别'"
                    />
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    年龄
                </td>
                <td class="domain-bg">
                    <input
                            class="easyui-numberspinner"
                            id="dpAge"
                            name="dpAge"
                            style="width:198px"
                            data-options="required:true,panelHeight:'auto',min:0,max:120,missingMessage:'请填入逝者年龄',validType:'age'"
                    />
                </td>
                <td style="width: 100px" class="title-bg">
                    住址
                </td>
                <td class="domain-bg">
                    <input
                            class="easyui-textbox"
                            id="dpAddr"
                            name="dpAddr"
                            style="width:198px"
                            data-options="required:true,
                           missingMessage:'请填入逝者住址',
                           validType:'length[1,50]'"
                    />
                </td>
            </tr>
            <tr>
                <td align="right" colspan="4">
                    <a
                            id="readDpIdCard"
                            href="#"
                            class="easyui-linkbutton"
                            data-options="iconCls:'icon-man'"
                            style="width:135px;margin-top:2px;"
                    >读逝者身份证</a
                    >
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
                    联系电话
                </td>
                <td class="domain-bg">
                    <input
                            class="easyui-textbox"
                            id="phone"
                            name="phone"
                            style="width:198px"
                            data-options="required:true,
                           missingMessage:'请填入移动电话号码',
                           validType:'mobile'"
                    />
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
                    >读承办人身份证</a
                    >
                </td>
            </tr>
        </table>
    </fieldset>
</div>

<div style="padding-top: 20px;">
    <fieldset class="fieldset" style="width:1103px">
        <legend class="legend">
            确认签名
        </legend>
        <table class="tab-border">
            <tr>
                <td class="domain-bg">
                    <p>
                        <br/>
                        本人为逝者的亲属代表，逝者亲属一致同意自愿放弃，逝者遗体火化后所产生的遗体骨灰。
                        <br/>
                        本人承诺所填（出示）的证明材料真实有效，内容完全符合家属的真实意愿，对此产生的一切后果，本人愿意承担一切责任。
                        <br/>
                        注：
                        1.丧事承办人再确认信息无误后，应在“确认签名”处签名。
                        2.请家属提供：身份证复印件（家属、逝者）各一份，并交于本馆业务员附于此单据背面留存。
                        <br/>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="domain-bg">
                    <a
                            href="javascript:void(0)"
                            class="easyui-linkbutton"
                            data-options="iconCls:'icon-edit'"
                            onclick="startSign()"
                    >
                        签名
                    </a>
                    <a
                            href="javascript:void(0)"
                            class="easyui-linkbutton"
                            id="clearButton"
                            data-options="iconCls:'icon-undo'"
                            onclick="clearSign()"
                    >
                        重签
                    </a>
                    <a
                            href="javascript:void(0)"
                            class="easyui-linkbutton"
                            id="finishButton"
                            data-options="iconCls:'icon-ok'"
                            onclick="finishSign()"
                    >
                        完成
                    </a>
                    <input id="signPic" name="signPic" type="hidden" value=""/>
                </td>
            </tr>
            <tr>
                <td class="domain-bg">
                    <object
                            id="HWPenSign"
                            name="HWPenSign"
                            classid="clsid:56C162AE-04DC-48E2-A5FC-D12D18B74240"
                            width="100%"
                            height="385"
                    >
                    </object>
                </td>
            </tr>
        </table>
    </fieldset>
</div>
