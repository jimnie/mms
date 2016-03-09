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
    var sex = {};
    $.getJSON(base + '/dict/findDict/sex', function (json) {
        sex = json;
    });

    function sexFormatter(value) {
        for (var i = 0; i < sex.length; i++) {
            if (sex[i].value == value) {
                return sex[i].name;
            }
        }
        return value;
    }

    var relation = {};
    $.getJSON(base + '/dict/findDict/relation', function (json) {
        relation = json;
    });
    function relationFormatter(value) {
        for (var i = 0; i < relation.length; i++) {
            if (relation[i].value == value) {
                return relation[i].name;
            }
        }
        return value;
    }

    var actionUrl;

    function newItem() {
        $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("member.form.add")%>').dialog('open');
        $('#dlg').window('maximize')
        $('#addform').form('clear');
        $("#dlg-buttons a:first-child").show();
    }

    function saveItem() {
        url = base + '/member/save';

        if ($('#id').attr('value') != '') {
            url = base + '/member/update';
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
                    $('#members').datagrid('reload');
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    function editItem() {
        var row = $('#members').datagrid('getSelected');
        if (row) {
            $("#dlg-buttons a:first-child").show();
            $('#addform').form('load', row);
            $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("member.form.edit")%>').dialog('open');
            $('#dlg').window('maximize')
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("dict.head.toModifyPrompt")%>', warning);
        }
    }

    function delItem() {
        var row = $('#members').datagrid('getSelected');
        if (row) {
            if (row.updatable == 'updatable_02') {
                $.messager.alert(title, '<%=SpringUtils.getMessage("member.head.couldNotRemove")%>', error);
                return;
            }
            $.messager.confirm(title, '<%=SpringUtils.getMessage("member.head.removePrompt")%>', function (r) {
                if (r) {
                    $('#dictId').val(row.id);
                    $('#delform').form('submit', {
                        url: base + '/member/delete',
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
            $.messager.alert(title, '<%=SpringUtils.getMessage("member.form.toRemovePrompt")%>', warning);
        }

    }

    function refresh() {
        $('#members').datagrid('loadData', {total: 0, rows: []});
        $('#members').datagrid('load', {});
    }

    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + '/member/queryPage',
            callback: function (data) {
                $('#members').datagrid('loadData', {total: 0, rows: []});
                $('#members').datagrid('load', data);
            }
        });
    }

    $(function () {
        $('#state').combobox({
            url: '${pageContext.request.contextPath}/area/findRoots',
            method: 'get',
            valueField: 'id',
            textField: 'name',
            onSelect: function (r) {
                $('#city').combobox({
                    url: base + '/area/findArea/' + r.id
                });
                $('#district').combobox('clear').combobox({
                    url: base + '/area/findArea/0'
                });
            }
        });

        $('#city').combobox({
            onSelect: function (r) {
                $('#district').combobox({
                    url: base + '/area/findArea/' + r.id
                });
            }
        });
    });
</script>