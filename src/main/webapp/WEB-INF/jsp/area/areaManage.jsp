<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         buffer="none" %>
<html>
<head>
    <%@include file="../common/global.jsp" %>
</head>
<body class="easyui-layout">
<div data-options="region:'north'" style="height:100%">
    <table id="area"></table>
</div>

<div class="toolbar" id="toolbara">
    <a href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'" onclick="newItem()">新增</a>
    <a href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'" onclick="editItem()">修改</a>
    <a href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove'" onclick="delItem()">删除</a>
</div>

<div id="dlg" style="width:350px;height:300px;"
     class="easyui-dialog" closed="true" modal="true" buttons="#dlg-buttons">
    <div style="margin-top: 30px">
        <div align="center">
            <form id="myform" method="post" style="margin:0;padding:0">
                <table cellpadding="5">
                    <tr>
                        <td>区域名称</td>
                        <td><input class="easyui-textbox" id="areaName" name="areaName"
                                   required="true" style="width: 150px"></td>
                    </tr>
                    <tr>
                        <td>上级区域</td>
                        <td>
                            <input class="easyui-combotree" name="parent.id"
                                   style="width: 150px"
                                   data-options=" url:'<%=base%>/area/initTree', method:'get', valueField:'id', textField:'text'"/>
                        </td>
                    </tr>
                    <tr>
                        <td>备注</td>
                        <td><input class="easyui-textbox" id="remark" name="remark"
                                   style="width: 150px"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="display: none;">
                            <input class="easyui-textbox" id="createDate"
                                   name="createDate"
                                   style="width: 150px">
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <input type="hidden" id="id" name="id">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div style="clear:both"></div>
    </div>
    <div id="dlg-buttons" style="text-align:center;">
        <a href="#" class="easyui-linkbutton" iconCls="icon-save"
           onclick="saveItem()">保存</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#dlg').dialog('close')">关闭</a>
    </div>
</div>
</body>
</html>
<jsp:include page="head.jsp"></jsp:include>
