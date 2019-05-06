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
    // 单据状况
    var invoiceState = {};
    $.getJSON(base + '/dict/findDict/invoiceState', function (json) {
        invoiceState = json;
    });
    //磁卡状况
    var magcardState = {};
    $.getJSON(base + '/dict/findDict/magcardState', function (json) {
        magcardState = json;
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

    // 证件类型描述格式化
    function certTypeFormatter(value) {
        for (var i = 0; i < certType.length; i++) {
            if (certType[i].value == value) {
                return certType[i].name;
            }
        }
        return value;
    }

    // 对存放状态值的显示格式化
    function invoiceStateFormatter(value) {
        for (var i = 0; i < state.length; i++) {
            if (state[i].value == value) {
                return state[i].name;
            }
        }
        return value;
    }

    // 对骨灰盒状况列值显示的值做格式化
    function magcardStateFormatter(value) {
        for (var i = 0; i < sex.length; i++) {
            if (facade[i].value == value) {
                return facade[i].name;
            }
        }
        return value;
    }

    // 查看存放信息对话框
    function viewDraw() {
        var row = $('#draws').datagrid('getSelected');
        if (row) {
            $('#view-dialog').window('maximize');
            $('#viewform').form('load', row);
            $('#view-dialog').dialog('setTitle', '查看领取记录').dialog('open');
        } else {
            $.messager.alert(title, '请选择需要查看的存放记录', warning);
        }
    }

    function viewCert() {
        var row = $('#draws').datagrid('getSelected');
        if (row) {
            window.open(base + '/draw/viewPdf/' + row.serviceNo + '/type/cert');
        } else {
            $.messager.alert(title, '请选择需要查看的领取记录', warning);
        }
    }

    function viewConf() {
        var row = $('#draws').datagrid('getSelected');
        if (row) {
            window.open(base + '/draw/viewPdf/' + row.serviceNo + '/type/conf');
        } else {
            $.messager.alert(title, '请选择需要查看的领取记录', warning);
        }
    }

    function refresh() {
        $('#draws').datagrid('loadData', {total: 0, rows: []});
        $('#draws').datagrid('load', {});
    }

    // 条件查询窗口
    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + '/draw/query',
            callback: function (data) {
                $('#draws').datagrid('loadData', {total: 0, rows: []});
                $('#draws').datagrid('load', data);
            }
        });
    }

    function formatterDate(date) {
        var day = date.getDate();
        var month = date.getMonth() + 1;
        return date.getFullYear() + '-' + month + '-' + day;
    }

    function checkSerivceNo() {
        let sno = $('#serviceNo').textbox('getValue');
        $.ajax({
            type: "POST",
            url: base + "/draw/exist",
            data: {sno: sno},
            dataType: "json",
            async: false,
            success: function (data) {
                console.log(data);
                if (data.result) {
                    if (data.result == true) {
                        $.messager.alert(title, '服务编号已存在', warning, function () {
                            $("#serviceNo").textbox("setValue", "");
                            $("#serviceNo").textbox().next("span").find("input").focus();
                        });
                    }
                }
            },
            error: function (e) {
                console.log(e);
            }
        })
    }
</script>