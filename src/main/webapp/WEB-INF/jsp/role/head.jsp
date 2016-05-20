<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../common/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=SpringUtils.getMessage("sys.main.projectName")%>
</title>
<link rel="stylesheet" type="text/css"
      href="${pageContext.request.contextPath}/resources/css/index.css">
<script type="text/javascript">
    var contextPath = '<%=request.getContextPath()%>';
    $.parser.onComplete = function () {
        $('body').css('visibility', 'visible');
        setTimeout(function () {
            $('#loading-mask').remove();
        }, 50);
    };
    $(function () {
        $(window).resize(function () {
            $('#mainlayout').layout('resize');
        });
    });
</script>
<script type="text/javascript">
    var _status = {};
    $.getJSON(base + '/dict/findDict/status', function (json) {
        _status = json;
    });
    function statusFormatter(value) {
        for (var i = 0; i < _status.length; i++) {
            if (_status[i].value == value) return _status[i].name;
        }
        return value;
    }

    var acts = {};
    $.getJSON(base + '/act/loadActs', function (json) {
        acts = json;
    });

    var editable = {};
    $.getJSON(base + '/dict/findDict/editable', function (json) {
        editable = json
    });

    function editableFormatter(value) {
        for (var i = 0; i < editable.length; i++) {
            if (editable[i].value == value) return editable[i].name;
        }
        return value;
    }

    var readonly = {readonly: true};
    var notonly = {readonly: false};
    var disable = {disabled: true};
    var enable = {disabled: false};
    var require = {required: true};
    var norequire = {required: false};

    function newItem() {
        $('#addform').form('clear');
        $('#tag').textbox(notonly).textbox(require);
        $('#status').combobox(notonly).combobox(require);
        $('#editable').combobox(notonly).combobox(require);
        $("#dlg-buttons a:first-child").show();
        $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("role.form.addRoleTitle")%>').dialog('open');
    }

    function editItem() {
        var row = $('#roles').datagrid('getSelected');
        if (row) {
            if (row.editable == 'editable_02') {
                $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.roleCannotEdit")%>', warning);
                return;
            }
            $.each($('#addform input'), function (i) {
                $(this).removeAttr("readonly");
            });
            $('#addform').form('load', row);
            $('#tag').textbox(readonly);
            $('#editable').combobox(readonly).combobox('setValue', row.editable);
            $("#dlg-buttons a:first-child").show();
            $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("role.form.editRoleTitle")%>').dialog('open');
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.selectToRole")%>', warning);
        }
    }

    function delItem() {
        var row = $('#roles').datagrid('getSelected');
        if (row) {
            if (row.editable == 'editable_02') {
                $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.roleCannotDelete")%>', warning);
                return;
            }
            $.messager.confirm(title, '<%=SpringUtils.getMessage("role.form.confirmToDeleteRole")%>', function (r) {
                if (r) {
                    $('#roleId').val(row.id);
                    $('#delform').form('submit', {
                        url: base + '/role/delete',
                        success: function (data) {
                            $('#dlg').dialog('close');
                            data = eval('(' + data + ')');
                            if (data.type == 'success') {
                                $.messager.show({
                                    title: title,
                                    msg: data.content,
                                    timeout: 2000,
                                    showType: 'slide'
                                });
                                $('#roles').datagrid('reload');
                            } else {
                                $.messager.alert(title, data.content, error);
                            }
                        }
                    });
                }
            });
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.selectRoleToDelete")%>', warning);
        }
    }

    function saveItem() {
        url = base + '/role/save';

        if ($('#id').attr('value') != '') {
            url = base + '/role/update';
        }

        $('#addform').form('submit', {
            url: url,
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (data) {
                data = eval('(' + data + ')');
                if (data.type == 'success') {
                    $.messager.show({
                        title: title,
                        msg: data.content,
                        timeout: 2000,
                        showType: 'slide'
                    });
                    $('#dlg').dialog('close');
                    $('#roles').datagrid('reload');
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });

    }

    function refresh() {
        $('#roles').datagrid('loadData', {total: 0, rows: []});
        $('#roles').datagrid('load', {});
    }

    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + '/role/query',
            callback: function (data) {
                $('#roles').datagrid('loadData', {total: 0, rows: []});
                $('#roles').datagrid('load', data);
            }
        });
    }

    function assignResource() {
        var row = $('#roles').datagrid('getSelected');
        if (row) {
            $('#r_roleid').attr('value', row.id);
            showResourcesTree(row);
            row = JSON.stringify(row).replace(/\./g, "\\\\.");
            $('#auth').dialog('setTitle', '<%=SpringUtils.getMessage("role.form.assignResource")%>').dialog('open');
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.selectRoleToAssign")%>', warning);
        }
    }

    function showResourcesTree(row) {
        $('#tt').tree({
            url: base + '/role/getResourceTree/' + row.id,
            method: 'get',
            checkbox: true
        });
    }

    function saveAssignedResources() {
        var nodes = $('#tt').tree('getChecked');
        var s = '';
        for (var i = 0; i < nodes.length; i++) {
            if (s != '') s += ',';
            s += nodes[i].id;
        }
        $('#r_resources').attr('value', s);
        $('#authorization').form('submit', {
            url: base + '/role/saveRoleResources',
            onSubmit: function () {
                return true;
            },
            success: function (data) {
                $('#auth').dialog('close');
                data = eval('(' + data + ')');
                if (data.type == 'success') {
                    $.messager.show({
                        title: title,
                        msg: data.content,
                        timeout: 2000,
                        showType: 'slide'
                    });
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    function assignAuthority() {
        $('#authform').form('clear');
        $('#authorities').datagrid('loadData', {total: 0, rows: []});
//        $('#authorities').datagrid('load', {});
        var row = $('#roles').datagrid('getSelected');
        if (row) {
            $('#role').attr('value', row.id);
            $('#moduleId').combobox({
                url: base + '/role/findResources/' + row.id + '/type/resource_02',
                method: 'get',
                valueField: 'id',
                textField: 'text',
                panelHeight: 'auto',
                onSelect: function (record) {
                    $('#resource').combobox({
                        url: base + '/role/findResources/' + row.id + '/type/resource_03/parent/' + record.id,
                        method: 'get',
                        valueField: 'id',
                        textField: 'text',
                        panelHeight: 'auto',
                        onSelect: function (record) {
                            $('#authorities').datagrid('loadData', {total: 0, rows: []});
                            $('#authorities').datagrid({
                                url: base + '/role/findResourceAuth/' + record.id + '/roleId/' + row.id,
                                method: 'get'
                            });
                        }
                    });
                }
            });
//            row = JSON.stringify(row).replace(/\./g, "\\\\.");

            $('#ac').dialog('setTitle', '<%=SpringUtils.getMessage("role.form.toAssignAuthRoleTitle")%>' + row.name).dialog('open');
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.selectRoleToAssignAuth")%>', warning);
        }
    }

    function addAuth() {
        var perms;
        var roleId = $('#role').attr('value');
        var moduleId = $('#moduleId').combobox('getValue');
        var resourceId = $('#resource').combobox('getValue');
        var resourceArrays = $('#resource').combobox('getData');
        var authsRows = $('#authorities').datagrid('getRows');
        var resourceName = $('#resource').combobox('getText');
        var actAlias = $('#act').combobox('getValue');
        var actName = $('#act').combobox('getText');
        if (moduleId == '') {
            $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.selectModule")%>', warning);
            return;
        }
        if (resourceId == '') {
            $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.selectResource")%>', warning);
            return;
        }
        if (actAlias == '') {
            $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.selectOperation")%>', warning);
            return;
        }

        for (var i = 0; i < resourceArrays.length; i++) {
            if (resourceArrays[i].id == resourceId) {
                perms = resourceArrays[i].aliasName + ':' + $('#act').combobox('getValue');
            }
        }

        for (var i = 0; i < authsRows.length; i++) {
            if (authsRows[i].resourceId == resourceId
                    && authsRows[i].roleId == roleId
                    && authsRows[i].perms == perms) {
                $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.resourceHasAssigned")%>', error);
                return;
            }
        }

        $('#authorities').datagrid('appendRow', {
            roleId: roleId,
            resourceId: resourceId,
            resourceName: resourceName,
            actAlias: actAlias,
            actName: actName,
            perms: perms
        });
    }

    function saveResourcesAuths() {
        var $dg = $("#authorities");
        var authsRows = $dg.datagrid('getRows');

        if ($dg.datagrid('getChanges').length) {
            var inserted = $dg.datagrid('getChanges', "inserted");
            var deleted = $dg.datagrid('getChanges', "deleted");
            var updated = $dg.datagrid('getChanges', "updated");


            $('#inserted').attr('value', JSON.stringify(inserted));
            $('#deleted').attr('value', JSON.stringify(deleted));

            $('#authform').form('submit', {
                url: base + '/role/saveResourceAuth',
                method: 'post',
                onSubmit: function () {
                    return true;
                },
                success: function (data) {
                    $('#ac').dialog('close');
                    data = eval('(' + data + ')');
                    if (data.type == 'success') {
                        $.messager.show({
                            title: title,
                            msg: data.content,
                            timeout: 2000,
                            showType: 'slide'
                        });
                        if (deleted != '') {
                            $.post(base + '/role/saveResourceAuth', {
                                'deleted': $('#deleted').attr('value')
                            }, function () {
                                $('#deleted').attr('value', '');
                            });
                        }
                    } else {
                        $.messager.alert(title, data.content, error);
                    }
                }
            });
        }
    }

    function delAuth() {
        var moduleId = $('#moduleId').combobox('getValue');
        var resourceId = $('#resource').combobox('getValue');

        if (moduleId == '') {
            $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.selectModule")%>', warning);
            return;
        }
        if (resourceId == '') {
            $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.selectResource")%>', warning);
            return;
        }

        var row = $('#authorities').datagrid('getSelected');
        if (row) {
            $('#authorities').datagrid('deleteRow', $('#authorities').datagrid('getRowIndex', row));
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("role.form.selectResourceToDelete")%>', warning);
        }
    }
</script>