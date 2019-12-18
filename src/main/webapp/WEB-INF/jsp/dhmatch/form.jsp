<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<div>
    <fieldset class="fieldset" style="width:1103px">
        <legend class="legend">
            业务信息核验
        </legend>
        <table class="tab-border">
            <tr>
                <td style="width: 100px" class="title-bg">
                    业务编号
                </td>
                <td class="domain-bg">
                    <input type="hidden" id="dId" name="dId" value="">
                    <input type="hidden" id="hId" name="hId" value="">
                    <input class="easyui-textbox" id="serviceNo"
                           name="serviceNo" style="width:198px"
                           data-options="readonly:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    骨灰袋识别码
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="rfid"
                           name="rfid" style="width:198px"
                           data-options="readonly:true">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    验证编号
                </td>
                <td class="domain-bg">
                    <input type="hidden" id="id" name="id" value=""/>
                    <input
                            class="easyui-textbox"
                            id="serviceNo2"
                            name="serviceNo2"
                            style="width:198px"
                            data-options="prompt:'请输入业务编号或扫码',required:true"
                    />
                </td>
                <td style="width: 100px" class="title-bg">
                    验证识别码
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="rfid2"
                           name="rfid2" style="width:198px"
                           data-options="prompt:'请读取骨灰袋识别码',required:true">
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
                    <a
                            id="checkServiceNoRfid"
                            href="#"
                            class="easyui-linkbutton"
                            data-options="iconCls:'icon-ok'"
                            style="width:120px;margin-top:2px;"
                    >核对逝者信息</a
                    >
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
                    逝者姓名
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="dpName" name="dpName"
                           style="width:198px"
                           data-options="readonly:true">
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
                                                readonly:true">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    年龄
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="dpAge" name="dpAge"
                           style="width:198px"
                           data-options="readonly:true">
                </td>
                <td style="width: 100px" class="title-bg">
                </td>
                <td class="domain-bg">
                </td>
            </tr>
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
                                                readonly:true">
            </td>
            <td style="width: 100px" class="title-bg">
                证件号码
            </td>
            <td class="domain-bg">
                <input class="easyui-textbox" id="dpCertNo" name="dpCertNo"
                       style="width:198px"
                       data-options="readonly:true">
            </td>
            <tr>
                <td style="width: 100px" class="title-bg">
                    骨灰盒位置
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="dPosition" name="dPosition"
                           style="width:198px"
                           data-options="readonly:true">
                </td>
                <td style="width: 100px" class="title-bg">
                    骨灰位置
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="hPosition" name="hPosition"
                           style="width:198px"
                           data-options="readonly:true">
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
                                                panelHeight:'auto',
                                                required:true,
                                                missingMessage:'请选择承办人证件类型'">
                </td>
                <td style="width: 100px" class="title-bg">
                    证件号码
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="utCertNo" name="utCertNo"
                           style="width:198px"
                           data-options="required:true,missingMessage:'请填入承办人证件号码'">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    姓名
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="utName" name="utName"
                           style="width:198px"
                           data-options="required:true,
                           missingMessage:'请填入承办人姓名',
                           validType:['chinese','length[2,5]']">
                </td>
                <td style="width: 100px" class="title-bg">
                    联系电话
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="phone" name="phone"
                           style="width:198px"
                           data-options="required:true,
                           missingMessage:'请填入承办人联系电话',
                           validType:'mobile'">
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
                                                panelHeight:'auto',
                                                required:true,
                                                editable:false,
                                                missingMessage:'请选择磁卡状况'">
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
                                                panelHeight:'auto',
                                                required:true,
                                                editable:false,
                                                missingMessage:'请选择单据状况'">
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
                                                panelHeight:'auto',
                                                required:true,
                                                editable:false,
                                                missingMessage:'请选择领取类型'">
                </td>
                <td style="width: 100px" class="title-bg">
                    领取时间
                </td>
                <td class="domain-bg">
                    <input class="easyui-datebox" id="drawDate" name="drawDate"
                           style="width:198px;" data-options="value:'currentText'">
                </td>
            </tr>
        </table>
    </fieldset>
</div>

<div style="padding-top: 20px;">
    <fieldset class="fieldset" style="width:1103px">
        <legend class="legend">
            骨灰装置服务确认
        </legend>
        <table class="tab-border">
            <tr>
                <td class="domain-bg">
                    <p>
                        <br/>
                        丧事承办人在确认信息、时间无误后，应在“确认签名”处签名。
                        <br/>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="domain-bg">
                    <a href="javascript:void(0)" class="easyui-linkbutton"
                       data-options="iconCls:'icon-edit'" onclick="startSign()">
                        签名
                    </a>
                    <a href="javascript:void(0)" class="easyui-linkbutton"
                       id="clearButton"
                       data-options="iconCls:'icon-undo'" onclick="clearSign()">
                        重签
                    </a>
                    <a href="javascript:void(0)" class="easyui-linkbutton"
                       id="finishButton"
                       data-options="iconCls:'icon-ok'" onclick="finishSign()">
                        完成
                    </a>
                    <input id="signPic" name="signPic" type="hidden" value=""/>
                </td>
            </tr>
            <tr>
                <td class="domain-bg">
                    <object id="HWPenSign"
                            name="HWPenSign"
                            classid="clsid:56C162AE-04DC-48E2-A5FC-D12D18B74240"
                            width="100%"
                            height="385">
                    </object>
                </td>
            </tr>
        </table>
    </fieldset>
</div>
