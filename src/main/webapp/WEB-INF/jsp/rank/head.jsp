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
    var isDefault = {};
    $.getJSON(base + '/dict/findDict/isDefault', function (json) {
        isDefault = json;
    });

    function defaultFormatter(value) {
        for (var i = 0; i < isDefault.length; i++) {
            if (isDefault[i].value == value.toString()) {
                return isDefault[i].name;
            }
        }
        return value;
    }

    var isSpecial = {};
    $.getJSON(base + '/dict/findDict/isSpecial', function (json) {
        isSpecial = json;
    });
    function specialFormatter(value) {
        for (var i = 0; i < isSpecial.length; i++) {
            if (isSpecial[i].value == value.toString()) {
                return isSpecial[i].name;
            }
        }
        return value;
    }

    var actionUrl;

    function newItem() {
        $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("rank.form.add")%>').dialog('open');
        $('#addform').form('clear');
        $("#dlg-buttons a:first-child").show();
    }

    function saveItem() {
        url = base + '/rank/save';

        if ($('#id').attr('value') != '') {
            url = base + '/rank/update';
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
                    $('#dlg').dialog('close');
                    $('#rank').datagrid('reload');
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    function editItem() {
        var row = $('#rank').datagrid('getSelected');
        if (row) {
            $("#dlg-buttons a:first-child").show();
            $('#addform').form('load', row);
            $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("rank.form.edit")%>').dialog('open');
            if (row.isDefault.toString() == 'true') {
                $('#isDefault').prop({checked: true});
            } else {
                $('#isDefault').prop({checked: false});
            }
            if (row.isSpecial.toString() == 'true') {
                $('#isSpecial').prop({checked: true});
            } else {
                $('#isSpecial').prop({checked: false});
            }
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("rank.form.toModifyPrompt")%>', warning);
        }
    }

    function delItem() {
        var row = $('#rank').datagrid('getSelected');
        if (row) {
            $.messager.confirm(title, '<%=SpringUtils.getMessage("rank.form.confirmToRemove")%>', function (r) {
                if (r) {
                    $('#rankId').val(row.id);
                    $('#delform').form('submit', {
                        url: base + '/rank/delete',
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
                                $('#rank').datagrid('reload')
                            } else {
                                $.messager.alert(title, data.content, error);
                            }
                        }
                    });
                }
            });
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("rank.form.toRemovePrompt")%>', warning);
        }

    }

    function refresh() {
        $('#rank').datagrid('loadData', {total: 0, rows: []});
        $('#rank').datagrid('load', {});
    }
</script>