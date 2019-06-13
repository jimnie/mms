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

    var signPanel;
    // 控制签名后必须点击完成按钮画面正常切回pc屏内，才可以点击对话框底部的关闭按钮
    var isSigned = false;
    var toSign = false;

    // 页面加载成后设置签字区域属性
    window.onload = function () {
        signPanel = document.getElementById("HWPenSign");
        signPanel.HWSetBkColor(0xE0F8E0); // 设置签名区背景颜色
        signPanel.HWSetCtlFrame(2, 0x000000); // 设置边框宽度和颜色
        //  signPanel.HWSetSeparatorLine(lineNum , 0x000000); // 设置分行线的行数和颜色
    }

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

        // 读取承办人身份证信息
        $('#readUtIdCard').bind('click', function () {
            var readState = rdcard.readcard(); // 调用readcard操作之后就可以从rdcard对象取出身份证信息
            if (readState == 0) {
                $('#utCertType').combobox('setValue', '0');
                $('#utCertNo').textbox('setValue', rdcard.CardNo);
                $('#utName').textbox('setValue', rdcard.NameL);
                return;
            } else {
                if (readState == -7) {
                    $.messager.alert(title, '验证卡失败，没有找到卡或者需要将卡拿离验证区重新读卡', error);
                } else {
                    $.messager.alert(title, '读二代证失败: ' + readState, error);
                }
                readState = null;
                return;
            }
        });

        $('#clearUtInfo').bind('click', function () {
            $('#utCertType').combobox('clear');
            $('#utCertNo').textbox('clear');
            $('#utName').textbox('clear');
            $('#phone').textbox('clear');
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
            $('#cUtName').text("  " + row.utName + "  ");
            $('#cDpName1').text("  " + row.dpName + "  ");
            $('#cDpName2').text("  " + row.dpName + "  ");
            // $('#drawDate').datebox('setValue', formatterDate(new Date()));
            var openState = rdcard.openport();
            if (openState == 0) {
                // $.messager.alert('提示', '开启端口成功', 'info');
            } else {
                $.messager.alert(title, '开启端口失败: ' + openState, error);
            }
        } else {
            $.messager.alert(title, '请选择需要领取的记录', warning);
        }
    }

    // 保存新增的存放信息
    function saveItem() {
        let sno = $("#serviceNo").textbox("getValue");
        url = base + '/draw/save';

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
                    $('#dhMatchList').datagrid('reload');
                    $.messager.confirm(title, "是否打印骨灰装置服务确认书?", function (r) {
                        if (r) {
                            window.open(base + '/draw/viewPdf/' + sno + '/type/cert');
                            $.messager.confirm(title, "是否打印领取业务证明单?", function (r) {
                                window.open(base + '/draw/viewPdf/' + sno + '/type/conf');
                            });
                        }
                    });

                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    // 关闭新增寄存窗口时关闭读卡器端口
    function closeAddDialog() {
        if (toSign && !isSigned) {
            $.messager.alert(title, "签名没有完成", warning);
            return;
        }

        var closeState;
        closeState = rdcard.closeport(); // 关闭端口
        if (closeState == 0) {
            // $.messager.alert('提示', '关闭端口成功', 'info');
        } else {
            $.messager.alert(title, '关闭端口失败: ' + closeState, error);
        }
        var handPadState;
        handPadState = signPanel.HWCloseC(); // 关闭手写板
        if (handPadState == 0) {
            signPanel.HWClearPenSign();
        } else {
            $.messager.alert(title, '关闭手写板设备失败: ' + closeState, error);
        }
        $('#dlg').dialog('close');
    }

    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + '/dhmatch/query',
            callback: function (data) {
                $('#dhMatchList').datagrid('loadData', {total: 0, rows: []});
                $('#dhMatchList').datagrid('load', data);
                var closed = TUHFReader09.Close();
                if (closed == "00") {
                    console.log("RFID设备关闭成功");
                } else {
                    console.log("RFID设备关闭失败");
                }
            }
        });
    }

    function formatterDate(date) {
        var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
        var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
            + (date.getMonth() + 1);
        return date.getFullYear() + '/' + month + '/' + day;
    }

    /*以下部分为签名功能*/
    function startSign() {
        var res;
        signPanel.HWRegisterJSButtonCall(2, "clearButton;finishButton;", "clearSign;finishSign;");
        signPanel.HWMonitorWndEnable(0, 0, parent.window.screen.availWidth, parent.window.screen.availHeight);
        res = signPanel.HWInitC();
        switch (res) {
            case 0:
                signPanel.HWSwitchMonitor(1, 1);
                break;
            case -1:
                $.messager.alert(title, '未找到对应的汉王手写设备', error);
                break;
            case -2:
                $.messager.alert(title, '手写模块加载失败', error);
                break;
            case -3:
                $.messager.alert(title, '手写模块初始化失败', error);
                break;
            default:
                $.messager.alert(title, '手写模块未知错误', error);
        }
        toSign = true;
        $('#saveButton').linkbutton({disabled: true});
        $('#closeButton').linkbutton({disabled: true});
    }

    function clearSign() {
        signPanel.HWClearPenSign();
    }

    function finishSign() {
        var res;
        res = signPanel.HWIsNeedSave();
        if (res == 1) {
            signPanel.HWMouseEnable(0);
            signPanel.HWSwitchMonitor(0, 1);
            $('#signPic').val(signPanel.HWGetBase64Stream(1));
        }
        isSigned = true;
        $('#saveButton').linkbutton({disabled: false});
        $('#closeButton').linkbutton({disabled: false});
    }
</script>
<OBJECT classid="clsid:F1317711-6BDE-4658-ABAA-39E31D3704D3"
        codebase="SDRdCard.cab#version=2,0,1,0" width="0"
        height="0" align="center" hspace="0" vspace="0" id="idcard" name="rdcard">
</OBJECT>