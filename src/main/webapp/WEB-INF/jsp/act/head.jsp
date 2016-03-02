<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../common/global.jsp" %>
<script type="text/javascript">
    var actionUrl;
    var base = '<%=request.getContextPath()%>';

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


    $.parser.onComplete = function () {
        $('body').css('visibility', 'visible');
        setTimeout(function () {
            $('#loading-mask').remove();
        }, 50);
    };

    function newItem() {
        $('#addform').form('clear');
        $('#name').textbox({required: true});
        $('#enName').textbox({readonly: false, required: true});
        $('#handler').textbox({readonly: false, required: true});
        $('#status').combobox({readonly: false, required: true});
        $.each($('#myform input'), function (i) {
            $(this).removeAttr("readonly");
        });
        $("#dlg-buttons a:first-child").show();
        $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("action.head.add")%>').dialog('open');
    }
    function editItem() {
        $('#addform').form('clear');
        var row = $('#acts').datagrid('getSelected');
        if (row) {
            $.each($('#addform input'), function (i) {
                $(this).removeAttr("readonly");
            });
            $('#addform').form('load', row);
            $('#status').combobox('setValue', row.status);
            $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("action.head.edit")%>').dialog('open');
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("action.head.choiseToEdit")%>', warning);
        }
    }
    function delItem() {
        var row = $('#acts').datagrid('getSelected');
        if (row) {
            $.messager.confirm(title, '<%=SpringUtils.getMessage("action.head.confirmToRemove")%>', function (r) {
                if (r) {
                    $('#actid').val(row.id);
                    actionUrl = base + '/act/delete';
                    $('#delform').form('submit', {
                        url: actionUrl,
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
                                $('#acts').datagrid('reload')
                            } else {
                                $.messager.alert(title, data.content, error);
                            }
                        }
                    });
                }
            });
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("action.head.choiseToRemove")%>', warning);
        }
    }

    function saveItem() {
        url = base + '/act/save';

        if ($('#id').attr('value') != '') {
            url = base + '/act/update';
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
                    $('#acts').datagrid('reload');
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    function refresh() {
        $('#acts').datagrid('loadData', {total: 0, rows: []});
        $('#acts').datagrid('load', {});
    }

    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + '/act/query',
            callback: function (data) {
                $('#acts').datagrid('loadData', {total: 0, rows: []});
                $('#acts').datagrid('load', data);
            }
        });
    }
</script>