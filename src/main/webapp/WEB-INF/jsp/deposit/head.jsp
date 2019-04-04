<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@include file="../common/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>
    <%=SpringUtils.getMessage("sys.main.projectName")%>
</title>
<link rel="stylesheet" type="text/css"
      href="${pageContext.request.contextPath}/css/index.css">
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

        $('#deposits').datagrid({
            onDblClickRow: function (index, row) {
                $('#view-dialog').window('maximize');
                $('#viewform').form('load', row);
                $('#view-dialog').dialog('setTitle', '查看存放记录').dialog('open');
            }
        });
    });
</script>
<script type="text/javascript">
    // 性别
    var sex = {};
    $.getJSON(base + '/dict/findDict/sex', function (json) {
        sex = json;
    });
    // 逝者证件类型
    var certType = {};
    $.getJSON(base + '/dict/findDict/certType', function (json) {
        certType = json;
    });
    // 存放状态
    var state = {};
    $.getJSON(base + '/dict/findDict/state', function (json) {
        state = json;
    });
    // 骨灰盒状况
    var facade = {};
    $.getJSON(base + '/dict/findDict/facade', function (json) {
        facade = json;
    });

    var urgent = {};
    $.getJSON(base + '/dict/findDict/isUrgent', function (json) {
        urgent = json;
    });

    // 对性别列值显示的值做格式化
    function sexFormatter(value) {
        for (var i = 0; i < sex.length; i++) {
            if (sex[i].value == value) {
                return sex[i].name;
            }
        }
        return value;
    }

    //
    function certTypeFormatter(value) {
        for (var i = 0; i < certType.length; i++) {
            if (certType[i].value == value) {
                return certType[i].name;
            }
        }
        return value;
    }

    // 对存放状态值的显示格式化
    function stateFormatter(value) {
        for (var i = 0; i < state.length; i++) {
            if (state[i].value == value) {
                return state[i].name;
            }
        }
        return value;
    }

    // 对骨灰盒状况列值显示的值做格式化
    function facadeFormatter(value) {
        for (var i = 0; i < sex.length; i++) {
            if (facade[i].value == value) {
                return facade[i].name;
            }
        }
        return value;
    }

    function urgentFormatter(value) {
        for (var i = 0; i < sex.length; i++) {
            if (urgent[i].value == value) {
                return urgent[i].name;
            }
        }
        return value;
    }

    // 显示新增存放对话框
    function addDeposit() {
        $('#dlg').dialog('setTitle', '新增存放记录').dialog('open');
        $('#dlg').window('maximize')
        $('#addform').form('clear');
        // TODO: 为方便扫码使用,新增对话框显示后将焦点放到服务编号域
        $('#serviceNo').textbox().next('span').find('input').focus();
        $('#depositDate').datebox('setValue', formatterDate(new Date()));
        // 修改逝者证件类型,动态添加输入验证规则
        $('#dpCertType').combobox({
            onChange: function (newValue, oldValue) {
                // 清空证件号码域
                $('#dpCertNo').textbox('setValue', '');
                if (newValue == 0) {
                    $('#dpCertNo').textbox({
                        validType: ['certNo', 'certNoLen[18]']
                    });
                } else {
                    $('#dpCertNo').textbox({
                        validType: 'certNoLen[20]'
                    });
                }
            }
        });
        // 修改承办人证件类型,动态添加输入验证规则
        $('#utCertType').combobox({
            onChange: function (newValue, oldValue) {
                // 清空证件号码域
                $('#utCertNo').textbox('setValue', '');
                if (newValue == 0) {
                    $('#utCertNo').textbox({
                        validType: ['certNo', 'certNoLen[18]']
                    });
                } else {
                    $('#utCertNo').textbox({
                        validType: 'certNoLen[20]'
                    });
                }
            }
        });
        // 急取设置领取日期为当天,非急取为当天+2
        $('#urgent').combobox({
            onChange: function (newValue, oldValue) {
                var date = new Date();
                if (newValue == 0) {
                    $('#preDrawDate').datebox('setValue', formatterDate(addDate(date, 2)));
                } else if (newValue == 1) {
                    $('#preDrawDate').datebox('setValue', formatterDate(date));
                }
            }
        }).combobox('setValue', '0');
        // 设置默认为有残
        $('#facade').combobox('setValue', '0');
        // 读取逝者身份证信息
        $('#readDpIdCard').bind('click', function () {
            var openState;
            var readState;
            var closeState;

            openState = rdcard.openport();
            if (openState == 0) {
                // $.messager.alert('提示', '开启端口成功', 'info');
            } else {
                $.messager.alert(title, '开启端口失败: ' + openState, error);
                return;
            }
            // 调用readcard操作之后就可以从rdcard对象取出身份证信息
            readState = rdcard.readcard();
            if (readState == 0) {
                $('#dpCertType').combobox('setValue', '0');
                $('#dpCertNo').textbox('setValue', rdcard.CardNo);
                $('#dpName').textbox('setValue', rdcard.NameL);
                $('#dpSex').combobox('setValue', rdcard.Sex);
                $('#dpAge').numberspinner('setValue', getDpAge(rdcard.Born));
                $('#dpAddr').textbox('setValue', rdcard.Address);
            } else {
                $.messager.alert(title, '读二代证失败: ' + readState, error);
            }

            closeState = rdcard.closeport();
            if (closeState == 0) {
                // $.messager.alert('提示', '关闭端口成功', 'info');
            } else {
                $.messager.alert(title, '关闭端口失败: ' + closeState, error);
                return;
            }
        });
        // 读取承办人身份证信息
        $('#readUtIdCard').bind('click', function () {
            var openState;
            var readState;
            var closeState;

            openState = rdcard.openport(); // 打开端口
            if (openState == 0) {
                // $.messager.alert('提示', '开启端口成功', 'info');
            } else {
                $.messager.alert(title, '开启端口失败: ' + openState, error);
                return;
            }

            readState = rdcard.readcard(); // 调用readcard操作之后就可以从rdcard对象取出身份证信息
            if (readState == 0) {
                $('#utCertType').combobox('setValue', '0');
                $('#utCertNo').textbox('setValue', rdcard.CardNo);
                $('#utName').textbox('setValue', rdcard.NameL);
            } else {
                $.messager.alert(title, '读二代证失败: ' + readState, error);
            }

            closeState = rdcard.closeport(); // 关闭端口
            if (closeState == 0) {
                // $.messager.alert('提示', '关闭端口成功', 'info');
            } else {
                $.messager.alert(title, '关闭端口失败: ' + closeState, error);
                return;
            }
        });
    }

    // 保存新增的存放信息
    function saveItem() {
        url = base + '/deposit/save';

        if ($('#id').attr('value') != '') {
            url = base + '/deposit/update';
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
                    $('#deposits').datagrid('reload');
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });

    }

    // 编辑存放信息对话框
    function editDeposit() {
        var row = $('#deposits').datagrid('getSelected');
        if (row) {
            $('#dlg').window('maximize');
            $('#addform').form('load', row);
            $('#dlg').dialog('setTitle', '修改存放记录').dialog('open');
        } else {
            $.messager.alert(title, '请选择需要修改的存放记录', warning);
        }
    }

    // 查看存放信息对话框
    function viewDeposit() {
        var row = $('#deposits').datagrid('getSelected');
        if (row) {
            $('#view-dialog').window('maximize');
            $('#viewform').form('load', row);
            $('#view-dialog').dialog('setTitle', '查看存放记录').dialog('open');
        } else {
            $.messager.alert(title, '请选择需要查看的存放记录', warning);
        }
    }

    function refresh() {
        $('#deposits').datagrid('loadData', {total: 0, rows: []});
        $('#deposits').datagrid('load', {});
    }

    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + '/deposit/query',
            callback: function (data) {
                $('#deposits').datagrid('loadData', {total: 0, rows: []});
                $('#deposits').datagrid('load', data);
            }
        });
    }

    function formatterDate(date) {
        var day = date.getDate();
        var month = date.getMonth() + 1;
        return date.getFullYear() + '-' + month + '-' + day;
    }

    function addDate(date, days) {
        var d = new Date(date);
        d.setDate(d.getDate() + days);
        return d;
    }

    function getDpAge(born) {
        var date = new Date;
        var currYear = date.getFullYear();
        return parseInt(currYear) - parseInt(born.substring(0, 4));
    }

    function viewPdf() {
    }
</script>
