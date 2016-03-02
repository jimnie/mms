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
            if (_status[i].value == value) {
                return _status[i].name;
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
    <%--var url;--%>

    <%--$(function () {--%>
    <%--$('#tree').tree({--%>
    <%--onClick: function (node) {--%>
    <%--var id = node.id.substr(4);--%>
    <%--if ('ual' == id) {--%>
    <%--url = '<c:url value='/user/getItemsUser.tg'/>';--%>
    <%--} else {--%>
    <%--url = '<c:url value='/user/getItemsUser.tg'/>?id=' + id;--%>
    <%--}--%>
    <%--$('#dt-resources').datagrid('options').url = url;--%>
    <%--$('#dt-resources').datagrid("reload");--%>
    <%--}--%>
    <%--});--%>
    <%--});--%>
    var readonly = {readonly: true};
    var notonly = {readonly: false};
    var disable = {disabled: true};
    var enable = {disabled: false};
    var require = {required: true};
    var norequire = {required: false};

    function newItem() {
        $('#addform').form('clear');
        $('#name').textbox(notonly).textbox(require);
        $('#tag').textbox(notonly).textbox(require);
        $('#nodeState').combobox(readonly).combobox('setValue', 'closed');
        $('#parent\\.id').combotree(readonly).combotree('setValue', '0');
        $('#status').combobox(require);
        $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("group.head.add")%>').dialog('open');
    }

    function editItem() {
        $('#addform').form('clear');
        var node = $('#groupTree').tree('getSelected');
        if (node) {
            var id = node.id;
            if (id == parentid) {
                $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.editRootPrompt")%>', warning);
                return;
            }
            $.each($('#addform input'), function (i) {
                $(this).removeAttr("readonly");
            });
            $('#name').textbox(notonly).textbox(require);
            $('#tag').textbox(readonly);
            $('#nodeState').combobox(readonly).combobox('setValue', 'closed');
            $('#parent\\.id').combotree(readonly).combotree('setValue', parentid);
            $('#status').combobox(require);
            $('#addform').form('load', node.attributes);
            $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("group.head.edit")%>').dialog('open');
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.choiseToEdit")%>', warning);
        }
        url = base + '/group/update';
    }

    function saveItem() {
        url = base + '/group/save';

        if ($('#id').attr('value') != '') {
            url = base + '/group/update';
        }
        $('#addform').form('submit', {
            url: url,
            onSubmit: function () {
                return $('#addform').form('validate');
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
                    $('#groupTree').tree('reload');
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    function delItem() {
        var node = $('#groupTree').tree('getSelected');
        if (node) {
            var id = node.id;

            if (id == parentid) {
                $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.removeRootPrompt")%>', warning);
                return;
            } else if (node.children) {
                $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.removeSubNodeFirst")%>', warning);
                return;
            } else {
                url = base + '/group/delete';
                $('#delGroupId').attr('value', id);
            }
            $.messager.confirm(title, '<%=SpringUtils.getMessage("group.head.confirmToRemove")%>', function (r) {
                if (r) {
                    $('#delform').form('submit', {
                        url: url,
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
                                $('#groupTree').tree('reload');
                                $('#parent\\.id').combotree('reload', base + '/group/tree');
                            } else {
                                $.messager.alert(title, data.content, error);
                            }
                        }
                    });
                }
            });
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.choiseToRemove")%>', warning);
        }
    }

    function addUsers() {
        var node = $('#groupTree').tree('getSelected');
        if (node) {
            if (node.id == parentid) {
                $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.unexecutableOperation")%>', warning);
                return;
            }
            $('#addUserform').form('clear');
            $('#selectableUsers').empty();
            $('#selectedUsers').empty();
            $('#addUserdlg').dialog('setTitle', '<%=SpringUtils.getMessage("group.head.addGroupUser")%>').dialog('open');
            var id = node.id;
            $('#parent\\.id').combotree('setValue', id);
            $('#groupid').attr('value', node.id);
            // 加载所有用户
            $.ajax({
                type: 'GET',
                url: base + '/group/loadSelectableUsers/' + node.id,
                dataType: 'json',
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        $('#selectableUsers').append('<option value="' + data[i].id + '">' + data[i].username + '</option>');
                    }
                },
                error: function (msg) {
                    $.messager.alert(title, msg, error);
                }
            });
            /*加载已选用户*/
            $.ajax({
                type: 'GET',
                url: base + '/group/getUsers/' + node.id,
                dataType: 'json',
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        $('#selectedUsers').append('<option value="' + data[i].id + '">' + data[i].username + '</option>');
                    }
                },
                error: function (msg) {
                    $.messager.alert(title, msg, error);
                }
            });
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.choiseToAdd")%>', warning);
        }
    }

    function saveUsers() {
        var users = '';
        $('#selectedUsers option').each(function () {
            if (users != '') {
                users += ',';
            }
            users += $(this).val();
        });
        if (users == '') {
            users = 'clear';
        }
        $('#addUserform').form('submit', {
            url: base + '/group/saveUsers/' + users + '/groupid/' + $('#groupid').attr('value'),
            onSubmit: function () {
                return $('#addUserform').form('validate');
            },
            success: function (data) {
                $('#addUserdlg').dialog('close');
                data = eval('(' + data + ')');
                if (data.type == 'success') {
                    $.messager.show({
                        title: title,
                        msg: data.content,
                        timeout: 2000,
                        showType: 'slide'
                    });
                    $('#users').datagrid('reload', base + '/group/getUsers/' + $('#groupid').attr('value'));
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    function addRoles() {
        var node = $('#groupTree').tree('getSelected');
        if (node) {
            if (node.id == parentid) {
                $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.unexecutableOperation")%>', warning);
                return;
            }
            $('#addRolesform').form('clear');
            $('#selectableRoles').empty();
            $('#selectedRoles').empty();
            $('#addRolesdlg').dialog('setTitle', '<%=SpringUtils.getMessage("group.head.addGroupRole")%>').dialog('open');
            var id = node.id;
            $('#parent\\.id').combotree('setValue', id);
            $('#groupid').attr('value', node.id);
            // 加载所有角色
            $.ajax({
                type: 'GET',
                url: base + '/group/loadSelectableRoles/' + node.id,
                dataType: 'json',
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        $('#selectableRoles').append('<option value="' + data[i].id + '">' + data[i].name + '</option>');
                    }
                },
                error: function (msg) {
                    $.messager.alert(title, msg, error);
                }
            });
            /*加载已选角色*/
            $.ajax({
                type: 'GET',
                url: base + '/group/getRoles/' + node.id,
                dataType: 'json',
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        $('#selectedRoles').append('<option value="' + data[i].id + '">' + data[i].name + '</option>');
                    }
                },
                error: function (msg) {
                    $.messager.alert(title, msg, error);
                }
            });
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.choiseToAdd")%>', warning);
        }
    }

    function saveRoles() {
        var roles = '';
        $("#selectedRoles option").each(function () {
            if (roles != '') {
                roles += ',';
            }
            roles += $(this).val();
        })
        if (roles == '') {
            roles = 'clear';
        }
        $('#addRolesform').form('submit', {
            url: base + '/group/saveRoles/' + roles + '/groupid/' + $('#groupid').attr('value'),
            onSubmit: function () {
                return $('#addRolesform').form('validate');
            },
            success: function (data) {
                $('#addRolesdlg').dialog('close');
                data = eval('(' + data + ')');
                if (data.type == 'success') {
                    $.messager.show({
                        title: title,
                        msg: data.content,
                        timeout: 2000,
                        showType: 'slide'
                    });
                    $('#groupTree').tree('reload');
                    $('#parent\\.id').combotree('reload', base + '/group/tree');
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    function lookGroupHaveRole() {
        $.messager.alert(title, '未实现功能', 'info');
    }

    $(document).ready(function () {
        $('#groupTree').tree({
            onClick: function (node) {
                $('#users').datagrid('reload', base + '/group/getUsers/' + node.id);
            }
        })

        // "移到右边"按钮的处理
        $('#moveToRight').click(function () {
            if ($('#selectableUsers option:selected').length > 0) {
                $('#selectableUsers option:selected').each(function () {
                    $('#selectedUsers').append('<option value="' + $(this).val() + '">' + $(this).text() + '</option>');
                    $(this).remove();
                })
            }
            else {
                $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.choiseToAddUser")%>', warning);
            }
        });
        // "移到左边"按钮的处理
        $('#moveToLeft').click(function () {
            if ($('#selectedUsers option:selected').length > 0) {
                $('#selectedUsers option:selected').each(function () {
                    $('#selectableUsers').append('<option value="' + $(this).val() + '">' + $(this).text() + '</option>');
                    $(this).remove();
                })
            }
            else {
                $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.choiseToRemoveUser")%>', warning);
            }

        });
        // "移到右边"按钮的处理
        $('#addRoles').click(function () {
            if ($('#selectableRoles option:selected').length > 0) {
                $('#selectableRoles option:selected').each(function () {
                    $('#selectedRoles').append('<option value="' + $(this).val() + '">' + $(this).text() + '</option>');
                    $(this).remove();
                })
            }
            else {
                $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.choiseToAddRole")%>', warning);
            }
        });
        // "移到左边"按钮的处理
        $('#moveRoles').click(function () {
            if ($('#selectedRoles option:selected').length > 0) {
                $('#selectedRoles option:selected').each(function () {
                    $('#selectableRoles').append('<option value="' + $(this).val() + '">' + $(this).text() + '</option>');
                    $(this).remove();
                })
            }
            else {
                $.messager.alert(title, '<%=SpringUtils.getMessage("group.head.choiseToRemoveRole")%>', warning);
            }
        });
    })
</script>
