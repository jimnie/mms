<%--
  Created by IntelliJ IDEA.
  User: Songwc
  Date: 2015/12/4
  Time: 10:12
  To change this template use File | Settings | File Templates.
  个人中心jsp
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<div style="text-align: center">
    <div>
        <form id="perForm">
            <input type="hidden" id="id" name="id">
            <fieldset>
                <legend>个人资料</legend>
                <div style="margin-left: 70px">
                    <table cellpadding="5">
                        <tr>
                            <td style="text-align: right">账号名称：</td>
                            <td><input class="easyui-textbox" id="username" name="username"
                                       readonly="readonly"
                                       style="width: 150px"></td>
                            <td style="text-align: right">用户姓名：</td>
                            <td><input class="easyui-textbox" id="entryName" name="entryName"
                                       readonly="readonly"
                                       style="width: 150px"></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">电话号码：</td>
                            <td><input class="easyui-textbox" id="entryPhone" name="entryPhone"
                                       style="width: 150px"
                                       data-options="required:true,validType:'phoneRex'"></td>
                            <td style="text-align: right">电子邮箱：</td>
                            <td><input class="easyui-textbox" id="entryEmail" name="entryEmail"
                                       style="width: 150px"
                                       data-options="required:true,validType:'email'"></td>
                        </tr>
                    </table>
                </div>
            </fieldset>
            <fieldset>
                <legend>现居住地址</legend>
                <div style="margin-left: 70px">
                    <table cellpadding="5">
                        <tr>
                            <td style="text-align: right">&nbsp;居住省份：</td>
                            <td><input class="easyui-combobox" id="nowProvince" name="nowProvince"
                                       required="required" style="width: 150px">
                            </td>
                            <td style="text-align: right">&nbsp;居住城市：</td>
                            <td><input class="easyui-combobox" id="nowCity" name="nowCity"
                                       required="required"
                                       style="width: 150px">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">&nbsp;居住区县：</td>
                            <td><input class="easyui-combobox" id="nowCounty" name="nowCounty"
                                       style="width: 150px">
                            </td>
                            <td style="text-align: right">&nbsp;详细地址：</td>
                            <td><input class="easyui-textbox" name="nowAddress" id="nowAddress"
                                       required="required"
                                       style="width: 150px"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </fieldset>
            <fieldset>
                <legend>紧急联络人</legend>
                <div style="margin-left: 70px">
                    <table cellpadding="5">
                        <tr>
                            <td style="text-align: right">与本人关系：</td>
                            <td><input class="easyui-textbox" name="emeRelation" id="emeRelation"
                                       required="required"
                                       style="width: 150px"/></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">联络人姓名：</td>
                            <td><input class="easyui-textbox" name="emeName" id="emeName"
                                       required="required"
                                       style="width: 150px"/></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">联络人电话：</td>
                            <td><input class="easyui-textbox" name="emePhone" id="emePhone"
                                       style="width: 150px"
                                       data-options="required:true,validType:'phoneRex'"/></td>
                        </tr>
                    </table>
                </div>
            </fieldset>
        </form>
    </div>
    <div style="margin-top: 20px">
        <a id="editPer" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">修 改</a>
        <a style="margin-left:10px" id="closePer" href="#" class="easyui-linkbutton"
           data-options="iconCls:'icon-cancel'">关 闭</a>
    </div>
</div>


<script>
    //自定义验证:手机号码
    $.extend($.fn.validatebox.defaults.rules, {
        phoneRex: {
            validator: function (value) {
                var rex = /^1[3-8]+\d{9}$/;
                var rex2 = /^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
                if (rex.test(value) || rex2.test(value)) {
                    return true;
                } else {
                    return false;
                }

            },
            message: '请输入正确的电话号码'
        }
    });
    $('#perCenter').click(function () {
        $('#perForm').form('load', '/cwma/employee/getEmp');
        $('#perWin').window('open');
    });
    $('#editPer').click(function () {
        $('#perForm').form('submit', {
            url: '/cwma/employee/employeeUpdate',
            success: function (data) {
                data = eval('(' + data + ')');
                if (data.type == 'success') {
                    $('#perWin').window('close');
                    $.messager.alert(title, '修改成功', 'info');
                } else {
                    $.messager.alert(title, data.content, 'error');
                }
            }
        });
    });
    $('#closePer').click(function () {
        $('#perWin').window('close');
    });
    /*居住地址级联菜单*/
    /*省份*/
    $('#nowProvince').combobox({
        url: "/cwma/area/province",
        editable: false,
        method: 'get',
        valueField: 'areaName',
        textField: 'areaName',
        onSelect: function (record) {
            var areaName = $('#nowProvince').combobox('getValue');
            $('#nowCity').combobox('reload', base + '/area/getChildrenbyName/' + areaName);
        }
    });
    /*城市*/
    $('#nowCity').combobox({
        editable: false,
        method: 'get',
        valueField: 'areaName',
        textField: 'areaName',
        onSelect: function (record) {
            var areaName = $('#nowCity').combobox('getValue');
            $('#nowCounty').combobox('reload', base + '/area/getChildrenbyName/' + areaName);
        }
    });
    /*区县*/
    $('#nowCounty').combobox({
        editable: false,
        method: 'get',
        valueField: 'areaName',
        textField: 'areaName'
    });
</script>