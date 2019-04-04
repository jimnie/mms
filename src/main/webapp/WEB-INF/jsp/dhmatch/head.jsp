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

    });
</script>
<script type="text/javascript">
    // 性别
    var sex = {};
    $.getJSON(base + '/dict/findDict/sex', function (json) {
        sex = json;
    });
    // 存放状态
    var state = {};
    $.getJSON(base + '/dict/findDict/state', function (json) {
        state = json;
    });

    // 磁卡状况
    var magcardState = {};
    $.getJSON(base + '/dict/findDict/magcardState', function (json) {
        magcardState = json;
    });

    // 单据状况
    var invoiceState = {};
    $.getJSON(base + '/dict/findDict/invoiceState', function (json) {
        invoiceState = json;
    });

    // 证件类型
    var certType = {};
    $.getJSON(base + '/dict/findDict/certType', function (json) {
        certType = json;
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

    // 对存放状态值的显示格式化
    function stateFormatter(value) {
        for (var i = 0; i < state.length; i++) {
            if (state[i].value == value) {
                return state[i].name;
            }
        }
        return value;
    }

    function certTypeFormatter(value) {
        for (var i = 0; i < certType.length; i++) {
            if (certType[i].value == value) {
                return certType[i].name;
            }
        }
        return value;
    }

    // 显示新增存放对话框
    function addDraw() {
        var row = $('#dhMatchList').datagrid('getSelected');
        if (row) {
            $('#dlg').window('maximize');
            $('#addform').form('load', row);
            $('#dlg').dialog('setTitle', '领取记录').dialog('open');
            $('#serviceNo').textbox('setValue', row.serviceNo);
            $('#drawDate').datebox('setValue', formatterDate(new Date()));
        } else {
            $.messager.alert(title, '请选择需要领取的记录', warning);
        }
        // $('#dlg').window('maximize')
        // $('#addform').form('clear');
        // $('#depositDate').datebox('setValue', formatterDate(new Date()));
        // $.getJSON(base + '/shelf/idel/', function (json) {
        //     console.log('shelf:' + json);
        //     // if (json == undefined || json == null) {
        //     //     $.messager.alert(title, '当前没有空闲货架', warning);
        //     // } else {
        //     $('#position').combobox('setValue', json.code);
        //     // }
        // });

    }

    // 保存新增的存放信息
    function saveItem() {
        url = base + '/draw/save';

        if ($('#id').attr('value') != '') {
            url = base + '/draw/update';
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
                    $('#handOverList').datagrid('reload');
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });

    }

    function refresh() {
        $('#dhMatchList').datagrid('loadData', {total: 0, rows: []});
        $('#dhMatchList').datagrid('load', {});
    }

    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + '/dhmatch/query',
            callback: function (data) {
                $('#dhMatchList').datagrid('loadData', {total: 0, rows: []});
                $('#dhMatchList').datagrid('load', data);
            }
        });
    }

    function formatterDate(date) {
        var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
        var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
            + (date.getMonth() + 1);
        return date.getFullYear() + '/' + month + '/' + day;
    }
</script>