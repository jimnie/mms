<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../common/global.jsp" %>
<script type="text/javascript">
    var actionUrl;
    var base = '<%=request.getContextPath()%>';

    $(function () {
        $('#icon').combobox({
            formatter: function (row) {
                var imgCls = row.name;
                return '<a class="icon ' + imgCls + ' item-img" /><span class="item-text">' + row.name + '</span>';
            }
        });
    });

    var _status = {};
    $.getJSON(base + '/dict/findDict/status', function (json) {
        _status = json;
    });
    function statusFormatter(value) {
        for (var i = 0; i < _status.length; i++) {
            if (_status[i].value == value) {
                return _status[i].name;
            }
        }
        return value;
    }

    var resourceType = {};
    $.getJSON(base + '/dict/findDict/resourceType', function (json) {
        resourceType = json;
    });
    function resourceTypeFormatter(value) {
        for (var i = 0; i < resourceType.length; i++) {
            if (resourceType[i].value == value) {
                return resourceType[i].name;
            }
        }
        return value;
    }

    var icon = {};
    $.getJSON(base + '/dict/findDict/icon', function (json) {
        icon = json;
    });
    function iconFormatter(value) {
        for (var i = 0; i < icon.length; i++) {
            if (icon[i].value == value) {
                return icon[i].name;
            }
        }
        return value;
    }

    var isLeaf = {};
    $.getJSON(base + '/dict/findDict/isLeaf', function (json) {
        isLeaf = json;
    })
    function isLeafFormatter(value) {
        for (var i = 0; i < isLeaf.length; i++) {
            if (isLeaf[i].value == value) {
                return isLeaf[i].name;
            }
        }
        return value;
    }

    var editable = {};
    $.getJSON(base + '/dict/findDict/editable', function (json) {
        editable = json;
    })
    function editableFormatter(value) {
        for (var i = 0; i < editable.length; i++) {
            if (editable[i].value == value) {
                return editable[i].name;
            }
        }
        return value;
    }

    $.parser.onComplete = function () {
        $('body').css('visibility', 'visible');
        setTimeout(function () {
            $('#loading-mask').remove();
        }, 50);
    };

    var readonly = {readonly: true};
    var notonly = {readonly: false};
    var disable = {disabled: true};
    var enable = {disabled: false};
    var require = {required: true};
    var norequire = {required: false};

    function newItem() {
        var row = $('#resources').treegrid('getSelected');
        if (row && row.resourceType == 'resource_03') {
            $.messager.alert(title, '<%=SpringUtils.getMessage("resource.head.cannotadd")%>', error);
            return false;
        }
        if (row) {
            parentid = row.id;
        }
        $('#addform').form('clear');
        $("#dlg-buttons a:first-child").show();

        $('#parent\\.id').combotree({
            url: base + '/resource/tree',
            valueField: 'id',
            textField: 'text'
        });

        var icon = 'icon-nav';
        $('#parent\\.id').combotree('setValue', parentid);
        $('#aliasName').textbox(notonly);

        if (parentid == '00000000000000000000000000000000') {
            $('#resourceType').combobox('setValue', 'resource_01');
            $('#isLeaf').combobox('setValue', 'isleaf_02');
            $('#url').textbox(readonly).textbox(disable).textbox(norequire);
            icon = '';
            $('#icon').combobox('setValue', icon).combobox(disable);
            $('#aliasName').textbox(require).textbox(enable);
            $('#state').attr('value', 'closed');
        } else if (row.resourceType == 'resource_01') {
            $('#resourceType').combobox('setValue', 'resource_02');
            $('#isLeaf').combobox('setValue', 'isleaf_02');
            $('#url').textbox(readonly).textbox(disable).textbox(norequire);
            $('#icon').combobox(enable).combobox('setValue', icon);
            $('#aliasName').textbox(norequire).textbox(disable);
            $('#state').attr('value', 'closed');
        } else if (row.resourceType == 'resource_02') {
            $('#resourceType').combobox('setValue', 'resource_03');
            $('#isLeaf').combobox('setValue', 'isleaf_01');
            $('#url').textbox(notonly).textbox(enable).textbox(require);
            $('#icon').combobox(enable).combobox('setValue', icon);
            $('#aliasName').textbox(enable).textbox(require);
            $('#state').attr('value', 'closed');
        }
        $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("resource.head.add")%>').dialog('open');
    }

    function editItem() {
        $('#addform').form('clear');
        var row = $('#resources').datagrid('getSelected');
        if (row) {
            if (row.editable == 'editable_02') {
                $.messager.alert(title, '<%=SpringUtils.getMessage("resource.head.cannotmodifty")%>', warning);
                return;
            }
            $.each($('#addform input'), function (i) {
                $(this).removeAttr('readonly');
            });
            $('#resourceType').combobox({editable: false, readonly: true});
            $('#isLeaf').combobox({editable: false, readonly: true});
            $('#icon').combobox({editable: false, readonly: true});
            $('#parent\\.id').combotree({editable: false, readonly: true});
            $('#editable').combobox({editable: false});
            $('#status').combobox({editable: false});
            $('#addform').form('load', row);
            var resourceType = $('#resourceType').combobox('getValue');
            $('#parent\\.id').combotree('setValue', row.parentid);

            if (resourceType == 'resource_01') {
                $('#url').textbox(disable);
                $('#icon').combobox(disable);
                $('#aliasName').textbox(readonly);
            } else if (resourceType == 'resource_02') {
                $('#url').textbox(disable);
                $('#icon').combobox({readonly: false}).combobox('setValue', row.icon);
                $('#aliasName').textbox(readonly);
            } else if (resourceType == 'resource_03') {
                $('#url').textbox(enable).textbox(require);
                $('#icon').combobox({readonly: false}).combobox('setValue', row.icon);
                $('#aliasName').textbox(readonly);
            }
            $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("resource.head.edit")%>').dialog('open');
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("resource.head.modiftyprompt")%>', warning);
        }
    }

    function saveItem() {
        var id = $('#id').attr('value');

        if (id != '') {
            actionUrl = base + '/resource/update';
        } else {
            actionUrl = base + '/resource/save';
        }
        $('#addform').form('submit', {
            url: actionUrl,
            onSubmit: function () {
                return true;
            },
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
                    refresh($('#parent\\.id').combotree('getValue'));
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    function delItem() {
        var row = $('#resources').datagrid('getSelected');
        if (row) {
            $.messager.confirm(title, '<%=SpringUtils.getMessage("resource.head.deleteconfirm")%>', function (r) {
                if (r) {
                    $('#resid').val(row.id);
                    $('#delform').form('submit', {
                        url: base + '/resource/delete',
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
                                var id = row.parentid;
                                if (id == parentid) {
                                    id = row.id;
                                }
                                refresh(id);
                            } else {
                                $.messager.alert(title, data.content, error);
                            }
                        }
                    });
                }
            });
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("resource.head.deleteprompt")%>', warning);
        }
    }

    function refresh(id) {
        var tg = $('#resources');
        if (id) {
            tg.treegrid('reload', id);
        } else {
            var row = tg.treegrid('getSelected');
            if (row == null) {
                tg.treegrid('reload');
            } else {
                tg.treegrid('reload', row.id);
            }
        }
    }

</script>