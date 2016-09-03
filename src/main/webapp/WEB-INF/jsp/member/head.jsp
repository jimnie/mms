<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../common/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>
    <%=SpringUtils.getMessage("sys.main.projectName")%>
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

        $('#state').combobox({
            url: base + '/area/findRoots',
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

    function categoryFormatter(row, value) {
        var ids = '';
        for (var i = 0; i < row.length; i++) {
            if (i != 0 && i < row.length) {
                ids += ',';
            }
            ids += row[i].id
        }
        return ids;
    }

    var actionUrl;

    function showCategory(array) {
        $.ajax({
            url: base + '/category/findAll',
            type: 'post',
            cache: false,
            dataType: 'json',
            success: function (data) {
                var text = '<table width="100%" height="100%"><tr>';
                if (array && array.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        var b = (i + 1) % 6 == 0;
                        var t = false;
                        for (var j = 0; j < array.length; j++) {
                            if (data[i].id == array[j].id) {
                                t = true;
                            }
                        }
                        if (t) {
                            text += '<td style="width: 100px;height: 40px;font-size: 12px"><input type="checkbox" id="' + data[i].id + '" name="' + data[i].id + '" checked>' + data[i].name + '</td>';
                        } else {
                            text += '<td style="width: 100px;height: 40px;font-size: 12px"><input type="checkbox" id="' + data[i].id + '" name="' + data[i].id + '">' + data[i].name + '</td>';
                        }
                        if (b) {
                            text += '</tr><tr>'
                        }
                    }
                } else {
                    for (var i = 0; i < data.length; i++) {
                        var b = (i + 1) % 6 == 0;
                        text += '<td style="width: 100px;height: 40px;font-size: 12px"><input type="checkbox" id="' + data[i].id + '" name="' + data[i].id + '">' + data[i].name + '</td>';
                        if (b) {
                            text += '</tr><tr>'
                        }
                    }
                }
                text += '</tr></table>';
                $('#ctgroup').html(text);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.messager.alert(title, errorThrown, error);
            }
        });
    }

    function defaultMemberRank() {
        $.ajax({
            url: base + '/rank/default',
            type: 'post',
            cache: false,
            dataType: 'json',
            success: function (data) {
                $('#memberRank\\.id').combobox('setValue', data.id);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.messager.alert(title, errorThrown, error);
            }
        });
    }

    function newItem() {
        $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("member.form.add")%>').dialog('open');
        $('#dlg').window('maximize')
        $('#addform').form('clear');
        $('#cardNo').textbox({readonly: false}).textbox('enable');
        $('#state').combobox('reload');
        $('#district').combobox('clear').combobox({
            url: base + '/area/findArea/0'
        });
        $('#city').combobox('clear').combobox({
            url: base + '/area/findArea/0'
        }).combobox({
            onSelect: function (r) {
                if (r) {
                    $('#district').combobox({
                        url: base + '/area/findArea/' + r.id
                    });
                }
            }
        });
        $('#registerDate').datebox({readonly: false}).datebox('enable');
        $("#dlg-buttons a:first-child").show();
        showCategory();
        defaultMemberRank();
    }

    function saveItem() {
        var str = '';
        var intr = $("input[type='checkbox']:checked");
        var addr = $('#state').combobox('getText') + $('#city').combobox('getText') + $('#district').combobox('getText') + $('#street').val();
        $('#address').attr('value', addr);
        intr.each(function (index, element) {
            if ($(element).prop('checked')) {
                if (index < intr.length && index != 0) {
                    str += ',';
                }
                str += $(element).prop('id')
            }
        });
        $('#activities').val(str);

        url = base + '/member/save';

        if ($('#id').attr('value') != '') {
            url = base + '/member/update';
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
            var district = row.district;
            $("#dlg-buttons a:first-child").show();
            $('#dlg').window('maximize');
            showCategory(row.categories);
            $('#cardNo').textbox({readonly: true}).textbox('disable');
            $('#registerDate').datebox({readonly: true}).datebox('disable');
            $('#addform').form('load', row);
            $('#memberRank\\.id').combobox('setValue', row.memberRank.id);
            $('#dlg').dialog('setTitle', '<%=SpringUtils.getMessage("member.form.edit")%>').dialog('open');
            $('#state').combobox('select', row.state);
            $('#city').combobox({
                url: base + '/area/findArea/' + row.state,
                onSelect: function (r) {
                    if (r) {
                        $('#district').combobox({
                            url: base + '/area/findArea/' + r.id
                        }).combobox('select', district);
                    }
                }
            }).combobox('select', row.city);
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("member.form.toModifyPrompt")%>', warning);
        }
    }

    function delItem() {
        var row = $('#members').datagrid('getSelected');
        if (row) {
            $.messager.confirm(title, '<%=SpringUtils.getMessage("member.form.removePrompt")%>', function (r) {
                if (r) {
                    $('#memberId').val(row.id);
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
                                $('#members').datagrid('reload')
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
            form: base + '/member/query',
            callback: function (data) {
                $('#members').datagrid('loadData', {total: 0, rows: []});
                $('#members').datagrid('load', data);
            }
        });
    }

    function recharge() {
        $('#rechargeform').form('clear');
        var row = $('#members').datagrid('getSelected');
        if (row) {
            $.each($('#rechargeform input'), function (i) {
                $(this).removeAttr("readonly");
            });
            $('#c_cardNo').textbox({readonly: true}).textbox('disable');
            $('#c_cnName').textbox({readonly: true}).textbox('disable');
            $('#c_mobile').textbox({readonly: true}).textbox('disable');
            $('#memberRank').textbox({readonly: true}).textbox('disable');
            $('#c_id').attr('value', row.id);
            $('#c_cardNo').textbox('setValue', row.cardNo);
            $('#c_cnName').textbox('setValue', row.cnName);
            $('#c_mobile').textbox('setValue', row.mobile);
            $('#memberRank').textbox('setValue', row.memberRank.name);
            $('#rechargeDlg').dialog('setTitle', '<%=SpringUtils.getMessage("member.form.chargeTitle")%>').dialog('open');
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("member.form.selectMemberToCharge")%>', warning);
        }
    }

    function unrecharge() {
        $('#unrechargeform').form('clear');
        var row = $('#members').datagrid('getSelected');
        if (row) {
            $.each($('#unrechargeform input'), function (i) {
                $(this).removeAttr("readonly");
            });
            $('#b_cardNo').textbox({readonly: true}).textbox('disable');
            $('#b_cnName').textbox({readonly: true}).textbox('disable');
            $('#b_mobile').textbox({readonly: true}).textbox('disable');
            $('#b_memberRank').textbox({readonly: true}).textbox('disable');
            $('#b_id').attr('value', row.id);
            $('#b_balance').attr('value', row.balance);
            $('#b_cardNo').textbox('setValue', row.cardNo);
            $('#b_cnName').textbox('setValue', row.cnName);
            $('#b_mobile').textbox('setValue', row.mobile);
            $('#b_memberRank').textbox('setValue', row.memberRank.name);
            $('#unrechargeDlg').dialog('setTitle', '<%=SpringUtils.getMessage("member.form.chargeTitle")%>').dialog('open');
        } else {
            $.messager.alert(title, '<%=SpringUtils.getMessage("member.form.selectMemberToCharge")%>', warning);
        }
    }

    function saveRecharge() {
        $.messager.confirm(title, '<%=SpringUtils.getMessage("member.form.rechargeSaveConfirm")%>' + $('#rechargeAmount').numberbox('getValue'), function (r) {
            if (r) {
                $('#rechargeform').form('submit', {
                    url: base + '/member/recharge',
                    onSubmit: function () {
                        return $('#rechargeform').form('validate');
                    },
                    success: function (data) {
                        data = eval('(' + data + ')');
                        if (data.type == 'success') {
                            $.messager.show({
                                title: title,
                                msg: '<%=SpringUtils.getMessage("member.form.rechargeComplete")%>',
                                timeout: 2000,
                                showType: 'slide'
                            });
                            $('#rechargeDlg').dialog('close');
                            $('#members').datagrid('reload');
                        } else {
                            $.messager.alert(title, data.content, error);
                        }
                    }
                });
            }
        });
    }

    function saveUnrecharge() {
        $.messager.confirm(title, '<%=SpringUtils.getMessage("member.form.unrechargeSaveConfirm")%>' + $('#unrechargeAmount').numberbox('getValue'), function (r) {
            if (r) {
                if (validateUnrechargeAmount()) {
                    $.messager.alert(title, '<%=SpringUtils.getMessage("member.form.unrechargeWarning")%>', warning);
                    return;
                } else {
                    $('#unrechargeform').form('submit', {
                        url: base + '/member/unrecharge',
                        onSubmit: function () {
                            return $('#unrechargeform').form('validate');
                        },
                        success: function (data) {
                            data = eval('(' + data + ')');
                            if (data.type == 'success') {
                                $.messager.show({
                                    title: title,
                                    msg: '<%=SpringUtils.getMessage("member.form.unrechargeComplete")%>',
                                    timeout: 2000,
                                    showType: 'slide'
                                });
                                $('#unrechargeDlg').dialog('close');
                                $('#members').datagrid('reload');
                            } else {
                                $.messager.alert(title, data.content, error);
                            }
                        }
                    });
                }
            }
        });
    }

    function validateUnrechargeAmount() {
        var amount = $('#unrechargeAmount').numberbox('getValue');
        var balance = $('#b_balance').attr('value');
        return parseFloat(amount) > parseFloat(balance);
    }

    function formatCurrency(num, row) {
        num = num.toString().replace(/\$|\,/g, '');
        if (isNaN(num))
            num = "0";
        sign = (num == (num = Math.abs(num)));
        num = Math.floor(num * 100 + 0.50000000001);
        cents = num % 100;
        num = Math.floor(num / 100).toString();
        if (cents < 10)
            cents = "0" + cents;
        for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
            num = num.substring(0, num.length - (4 * i + 3)) + ',' +
                    num.substring(num.length - (4 * i + 3));
        return (((sign) ? '' : '-') + num + '.' + cents);
    }
</script>