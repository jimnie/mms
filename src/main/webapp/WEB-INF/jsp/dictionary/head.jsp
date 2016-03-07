<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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

    var updatable = {};
    $.getJSON(base + '/dict/findDict/updatable', function (json) {
        updatable = json;
    });
    function updatableFormatter(value) {
        for (var i = 0; i < updatable.length; i++) {
            if (updatable[i].value == value) {
                return updatable[i].name;
            }
        }
        return value;
    }

    var actionUrl;

    function newItem() {
        $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("dict.head.add")%>').dialog('open');
        $('#addform').form('clear');
        $("#dlg-buttons a:first-child").show();
    }

    function saveItem() {
        url = base + '/dict/save';

        if ($('#id').attr('value') != '') {
            url = base + '/dict/update';
        }

        $('#addform').form('submit', {
            url: url,
            onSubmit: function () {
                return $('#myform').form('validate');
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
                    $('#dictionaries').datagrid('reload');
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    function editItem() {
        var row = $('#dictionaries').datagrid('getSelected');
        if (row.updatable == 'updatable_02') {
            $.messager.alert(title, '<%=SpringUtils.getMessage("dict.head.couldNotEdit")%>', error);
            return;
        }
        if (row) {
            $("#dlg-buttons a:first-child").show();
            $('#addform').form('load', row);
            $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("dict.head.edit")%>').dialog('open');
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("dict.head.toModifyPrompt")%>', warning);
        }
    }

    function delItem() {
        var row = $('#dictionaries').datagrid('getSelected');
        if (row) {
            if (row.updatable == 'updatable_02') {
                $.messager.alert(title, '<%=SpringUtils.getMessage("dict.head.couldNotRemove")%>', error);
                return;
            }
            $.messager.confirm(title, '<%=SpringUtils.getMessage("dict.head.removePrompt")%>', function (r) {
                if (r) {
                    $('#dictId').val(row.id);
                    $('#delform').form('submit', {
                        url: base + '/dict/delete',
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
                                $('#dictionaries').datagrid('reload')
                            } else {
                                $.messager.alert(title, data.content, error);
                            }
                        }
                    });
                }
            });
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("dict.head.toRemovePrompt")%>', warning);
        }

    }

    function refresh() {
        $('#dictionaries').datagrid('loadData', {total: 0, rows: []});
        $('#dictionaries').datagrid('load', {});
    }

    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + '/dict/queryPage',
            callback: function (data) {
                $('#dictionaries').datagrid('loadData', {total: 0, rows: []});
                $('#dictionaries').datagrid('load', data);
            }
        });
    }
</script>