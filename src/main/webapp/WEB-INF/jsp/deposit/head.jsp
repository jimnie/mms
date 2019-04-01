<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../common/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

    // 显示新增存放对话框
    function addDeposit() {
        $('#dlg').dialog('setTitle', '新增存放记录').dialog('open');
        $('#dlg').window('maximize')
        $('#addform').form('clear');
        $('#depositDate').datebox('setValue', formatterDate(new Date()));
        // 修改逝者证件类型
        $('#dpCertType').combobox({
            onChange: function (newValue, oldValue) {
                $('#dpCertNo').textbox('setValue', '');
            }
        });
        // 修改承办人证件类型
        $('#utCertType').combobox({
            onChange: function (newValue, oldValue) {
                $('#utCertNo').textbox('setValue', '');
            }
        });
        // 读取逝者身份证信息
        $('#readDpIdCard').bind('click', function () {
            var openState;
            var readState;
            var closeState;
            openState = rdcard.openport();
            if (openState == 0) {
                // $.messager.alert('提示', '开启端口成功', 'info');
            } else {
                $.messager.alert('操作提示', '开启端口失败: ' + openState, 'error');
                return;
            }

            readState = rdcard.readcard();
            if (readState == 0) {
                // $.messager.alert('提示', '读二代证成功', 'info');
                // $.messager.alert('操作提示', '读二代证成功: \r' + rdcard.CardNo + '\r' + rdcard.NameL + '\r' + rdcard.Sex + '\r' + rdcard.Born, 'info');
                $('#dpCertType').combobox('setValue', '0');
                $('#dpCertNo').textbox('setValue', rdcard.CardNo);
                $('#dpName').textbox('setValue', rdcard.NameL);
                $('#dpSex').combobox('setValue', rdcard.Sex);
                $('#dpAge').numberspinner('setValue', getDpAge(rdcard.Born));
            } else {
                $.messager.alert('操作提示', '读二代证失败: ' + readState, 'error');
            }

            closeState = rdcard.closeport();
            if (closeState == 0) {
                // $.messager.alert('提示', '关闭端口成功', 'info');
            } else {
                $.messager.alert('操作提示', '关闭端口失败: ' + closeState, 'error');
                return;
            }
        });
        // 读取承办人身份证信息
        $('#readUtIdCard').bind('click', function () {
            var openState;
            var readState;
            var closeState;
            openState = rdcard.openport();
            //alert(pp);
            if (openState == 0) {
                // $.messager.alert('提示', '开启端口成功', 'info');
            } else {
                $.messager.alert('操作提示', '开启端口失败: ' + openState, 'error');
                return;
            }

            readState = rdcard.readcard();
            if (readState == 0) {
                // $.messager.alert('提示', '读二代证成功', 'info');
                // $.messager.alert('操作提示', '读二代证成功: \r' + rdcard.CardNo + '\r' + rdcard.NameL + '\r' + rdcard.Sex + '\r' + rdcard.Born, 'info');
                $('#utCertType').combobox('setValue', '0');
                $('#utCertNo').textbox('setValue', rdcard.CardNo);
                $('#utName').textbox('setValue', rdcard.NameL);
            } else {
                $.messager.alert('操作提示', '读二代证失败: ' + readState, 'error');
            }

            closeState = rdcard.closeport();
            if (closeState == 0) {
                // $.messager.alert('提示', '关闭端口成功', 'info');
            } else {
                $.messager.alert('操作提示', '关闭端口失败: ' + closeState, 'error');
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
            // var district = row.district;
            // $("#dlg-buttons a:first-child").show();
            $('#dlg').window('maximize');
            // showCategory(row.categories);
            // $('#cardNo').textbox({readonly: true}).textbox('disable');
            // $('#registerDate').datebox({readonly: true}).datebox('disable');
            $('#addform').form('load', row);
            $('#dlg').dialog('setTitle', '修改存放记录').dialog('open');
            // $('#state').combobox('select', row.state);
        } else {
            $.messager.alert(title, '请选择需要修改的存放记录', warning);
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
        var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
        var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
            + (date.getMonth() + 1);
        return date.getFullYear() + '/' + month + '/' + day;
    }

    function unload() {
        myclose_onclick();
        //alert("Page is Close");
    }

    function myclose_onclick() {
        var pp
        pp = rdcard.closeport();
        if (pp == 0) {
            $.messager.alert('提示', 'closeport成功', 'info');
            // document.getElementsByName("tResult")[0].value = "readcard成功";
            //showjpg_onclick();
        } else {
            $.messager.alert('提示', 'closeport失败:' + pp, 'error');
            // document.getElementsByName("tResult")[0].value = "readcard失败: " + pp;
        }
    }

    function getDpAge(born) {
        var date = new Date;
        var currYear = date.getFullYear();
        return parseInt(currYear) - parseInt(born.substring(0, 4));
    }
</script>
<script for=idcard event="Readed()">
    //alert('Readed');
    getinfo_onclick();
</script>

<script for=idcard event="Closed()">
    //window.close();
</script>

<script for=idcard event="Opened()">
    //window.close();
</script>