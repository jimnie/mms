<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../common/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>
    <%=SpringUtils.getMessage("sys.main.projectName")%>
</title>
<link rel="stylesheet" type="text/css"
      href="${pageContext.request.contextPath}/resources/css/index.css">
<script type="text/javascript">
    var actionUrl;
    var base = '<%=request.getContextPath()%>';

    $.parser.onComplete = function () {
        $('body').css('visibility', 'visible');
        setTimeout(function () {
            $('#loading-mask').remove();
        }, 50);
    };

    var isLocked = {};
    $.getJSON(base + '/dict/findDict/isLocked', function (json) {
        isLocked = json;
    });
    function isLockedFormatter(value) {
        for (var i = 0; i < isLocked.length; i++) {
            if (isLocked[i].value == value.toString()) {
                return isLocked[i].name;
            }
        }
        return value;
    }

    var isEnabled = {};
    $.getJSON(base + '/dict/findDict/isEnabled', function (json) {
        isEnabled = json;
    });
    function isEnabledFormatter(value) {
        for (var i = 0; i < isEnabled.length; i++) {
            if (isEnabled[i].value == value.toString()) {
                return isEnabled[i].name;
            }
        }
        return value;
    }

    var isSystem = {};
    $.getJSON(base + '/dict/findDict/isSystem', function (json) {
        isSystem = json;
    });
    function isSystemFormatter(value) {
        for (var i = 0; i < isSystem.length; i++) {
            if (isSystem[i].value == value.toString()) {
                return isSystem[i].name;
            }
        }
        return value;
    }

    function newItem() {
        $('#addform').form('clear');
        $.each($('#addform input'), function (i) {
            $(this).removeAttr("readonly");
        });
        $("#dlg-buttons a:first-child").show();
        $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("user.head.add")%>').dialog('open');
    }

    function saveItem() {
        var id = $('#id').attr('value');

        if (id != '') {
            actionUrl = base + '/user/update';
        } else {
            actionUrl = base + '/user/save';
        }
        $('#addform').form('submit', {
            url: actionUrl,
            onSubmit: function () {
                return true;
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
                    $('#users').datagrid('reload');
                } else {
                    $.messager.alert(title, data.content, 'error');
                }
            }
        });
    }

    function delItem() {
        var row = $('#users').datagrid('getSelected');
        if (row) {
            if (row.isSystem.toString() == 'true') {
                $.messager.alert(title, '<%=SpringUtils.getMessage("user.head.notUseIt")%>', error);
                return;
            }
            $.messager.confirm(title, '<%=SpringUtils.getMessage("user.head.confirmToRemove")%>', function (r) {
                if (r) {
                    $('#userId').val(row.id);
                    $('#delform').form('submit', {
                        url: base + '/user/delete',
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
                                $('#users').datagrid('reload');
                            } else {
                                $.messager.alert(title, data.content, error);
                            }
                        }
                    });
                }
            });
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("user.head.choiseToRemove")%>', warning);
        }
    }

    function editItem() {
        $('#addform').form('clear');
        $('#username').attr('readonly', 'true');
        var row = $('#users').datagrid('getSelected');
        if (row) {
            $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("user.head.edit")%>').dialog('open');
            $('#userId').val(row.id);
            $('#addform').form('load', row);
            $('#password').text('setValue', '');
            if (row.isEnabled.toString() == 'true') {
                $('#isEnabled').prop({checked: true});
            } else {
                $('#isEnabled').prop({checked: false});
            }
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("user.head.choiseToEdit")%>', warning);
        }
    }

    function unlock() {
        var row = $('#users').datagrid('getSelected');
        if (row) {
            if (row.isSystem.toString() == 'true') {
                $.messager.alert(title, '<%=SpringUtils.getMessage("user.head.notUseIt")%>', error);
                return;
            }
            $.messager.confirm(title, '<%=SpringUtils.getMessage("user.head.confirmToUnlock")%>', function (r) {
                if (r) {
                    $('#userId').val(row.id);
                    $('#delform').form('submit', {
                        url: base + '/user/unlock',
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
                                $('#users').datagrid('reload');
                            } else {
                                $.messager.alert(title, data.content, error);
                            }
                        }
                    });
                }
            });
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("user.head.choiseToUnlock")%>', warning);
        }
    }

    function lock() {
        var row = $('#users').datagrid('getSelected');
        if (row) {
            if (row.isSystem.toString() == 'true') {
                $.messager.alert(title, '<%=SpringUtils.getMessage("user.head.notUseIt")%>', error);
                return;
            }
            $.messager.confirm(title, '<%=SpringUtils.getMessage("user.head.confirmToLock")%>', function (r) {
                if (r) {
                    $('#userId').val(row.id);
                    $('#delform').form('submit', {
                        url: base + '/user/lock',
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
                                $('#users').datagrid('reload');
                            } else {
                                $.messager.alert(title, data.content, error);
                            }
                        }
                    });
                }
            });
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("user.head.choiseToLock")%>', warning);
        }
    }

    function resetPassword() {
        var row = $('#users').datagrid('getSelected');
        if (row) {
            $.messager.confirm(title, '<%=SpringUtils.getMessage("user.head.confirmToReset")%>', function (r) {
                if (r) {
                    $('#userId').val(row.id);
                    $('#delform').form('submit', {
                        url: base + '/user/reset',
                        success: function (data) {
                            data = eval('(' + data + ')');
                            if (data.type == 'success') {
                                $.messager.show({
                                    title: title,
                                    msg: data.content,
                                    timeout: 2000,
                                    showType: 'slide'
                                });
                            } else {
                                $.messager.alert(title, data.content, 'error');
                            }
                        }
                    });
                }
            })
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("user.head.choiseToReset")%>', warning);
        }
    }

    function refresh() {
        $('#users').datagrid('loadData', {total: 0, rows: []});
        $('#users').datagrid('load', {});
    }

    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + '/user/query',
            callback: function (data) {
                $('#users').datagrid('loadData', {total: 0, rows: []});
                $('#users').datagrid('load', data);
            }
        });
    }

</script>