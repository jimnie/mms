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
    var actionUrl;

    function newItem() {
        $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("category.form.add")%>').dialog('open');
        $('#addform').form('clear');
        $("#dlg-buttons a:first-child").show();
    }

    function saveItem() {
        url = base + '/category/save';

        if ($('#id').attr('value') != '') {
            url = base + '/category/update';
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
                    $('#category').datagrid('reload');
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    function editItem() {
        var row = $('#category').datagrid('getSelected');
        if (row) {
            $("#dlg-buttons a:first-child").show();
            $('#addform').form('load', row);
            $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("category.form.edit")%>').dialog('open');
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("category.form.toModifyPrompt")%>', warning);
        }
    }

    function delItem() {
        var row = $('#category').datagrid('getSelected');
        if (row) {
            $.messager.confirm(title, '<%=SpringUtils.getMessage("category.form.confirmToRemove")%>', function (r) {
                if (r) {
                    $('#categoryId').val(row.id);
                    $('#delform').form('submit', {
                        url: base + '/category/delete',
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
                                $('#dlg').dialog('close');
                                $('#category').datagrid('reload')
                            } else {
                                $.messager.alert(title, data.content, error);
                            }
                        }
                    });
                }
            });
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("category.form.toRemovePrompt")%>', warning);
        }

    }

    function refresh() {
        $('#category').datagrid('loadData', {total: 0, rows: []});
        $('#category').datagrid('load', {});
    }
</script>