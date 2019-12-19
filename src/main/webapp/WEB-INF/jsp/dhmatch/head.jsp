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

    var passed = false; // 是否通过信息核对

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
        /*$('#readUtIdCard').bind('click', function () {
            var readState = rdcard.readcard(); // 调用readcard操作之后就可以从rdcard对象取出身份证信息
            if (readState == 0) {
                $('#utCertType').combobox('setValue', '0');
                $('#utCertNo').textbox('setValue', rdcard.CardNo);
                $('#utName').textbox('setValue', rdcard.NameL);
                return;
            } else {
                if (readState == -7) {
                    $.messager.alert(title, '验证卡失败，没有找到卡或将卡移开后重新放到验证区', error);
                } else {
                    $.messager.alert(title, '读二代证失败: ' + readState, error);
                }
                readState = null;
                return;
            }
        });*/

        $('#clearUtInfo').bind('click', function () {
            $('#utCertType').combobox('clear');
            $('#utCertNo').textbox('clear');
            $('#utName').textbox('clear');
            $('#phone').textbox('clear');
        });

        $("#readRfid").bind("click", function () {
            $("#rfid2").textbox("clear");
            openRfidReader();
        });

        $('#checkServiceNoRfid').bind('click', function () {
            let sno = $('#serviceNo2').textbox('getValue');
            if (sno == '') {
                $.messager.alert(title, '验证编号不能为空', error);
                $("#serviceNo2").textbox().next("span").find("input").focus();
                return;
            }

            let rfid = $('#rfid2').textbox('getValue');
            if (rfid == '') {
                $.messager.alert(title, '验证识别码不能为空', error);
                return;
            }
            $.ajax({
                type: "POST",
                url: base + "/dhmatch/isMatched",
                data: {sno: sno, rfid: rfid},
                dataType: "json",
                async: false,
                success: function (data) {
                    console.log(data);
                    passed = data.result;
                    if (data.result == true) {
                        $.messager.alert(title, '逝者信息核对正确', info);
                    } else {
                        $.messager.alert(title, '逝者信息核对错误', error);
                        $('#serviceNo2').textbox('clear');
                        $('#rfid2').textbox('clear');
                        $("#serviceNo2").textbox().next("span").find("input").focus();
                    }
                },
                error: function (e) {
                    console.log(e);
                }
            })
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

    // 显示新增领取对话框
    function addDraw() {
        var row = $('#dhMatchList').datagrid('getSelected');
        if (row) {
            $('#dlg').window('maximize');
            $('#addform').form('load', row);
            $('#dlg').dialog('setTitle', '领取骨灰记录').dialog('open');
            $('#cUtName').text("  " + row.utName + "  ");
            $('#cDpName1').text("  " + row.dpName + "  ");
            $('#cDpName2').text("  " + row.dpName + "  ");
            // $('#drawDate').datebox('setValue', formatterDate(new Date()));
            $('#serviceNo2').textbox().next('span').find('input').focus();
            /*var openState = rdcard.openport();
            if (openState == 0) {
                // $.messager.alert('提示', '开启端口成功', 'info');
            } else {
                $.messager.alert(title, '开启端口失败: ' + openState, error);
            }*/
            openRfidReader();
        } else {
            $.messager.alert(title, '请选中要领取骨灰的记录', warning);
        }
    }

    // 保存新增的存放信息
    function saveItem() {
        if (!passed) {
            alert('逝者信息核对错误，不能办理骨灰领取！');
            return;
        }
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
                    closeRfidReader();
                    // closeRdReader(); // 关闭二代证读卡器设备
                    closeHandPad();
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
        console.log('关闭领取骨灰窗口');
        if (toSign && !isSigned) {
            $.messager.alert(title, "签名没有完成", warning);
            return;
        }
        closeRfidReader();
        // closeRdReader();
        closeHandPad();
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

    var timer;
    var tout;
    var count = 60000;

    function openRfidReader() {
        $('#readRfid').linkbutton({disabled: true}); // 初始页面禁用linkbutton
        var port = 3; // 端口COM3
        var baud = 5; // 波特率57600bps
        var connStatus = TUHFReader09.Open(port, baud);
        if (connStatus == '00') {
            console.log('RFID读卡设备连接成功');
        } else if (connStatus == '35') {
            console.log('RFID读卡设备已连接');
            let closeState = TUHFReader09.Close(); // 关闭RFID读卡器
            if (closeState == '00') {
                console.log('RFID读卡设备关闭成功');
            } else {
                console.log('RFID读卡设备关闭失败');
            }
        } else {
            $.messager.alert(
                title,
                'RFID读卡设备连接失败',
                error
            );
        }
        if (connStatus == '00' || connStatus == '35') {
            window.clearTimeout(tout); // 清除上一次的读卡超时
            $("#rfid2").textbox("clear");
            timer = setInterval(readRfid, 100); // 尝试循环读取电子标签
            tout = setTimeout(function () {
                console.log('读电子标签超时');
                window.clearInterval(timer);
                $.messager.alert(title, '读电子标签超时', warning, function () {
                    $('#readRfid').linkbutton({disabled: false}); // 读取到TID后启用该按钮
                });
            }, count);
        }
    }

    function readRfid() {
        let mem = 2 // 读TID区
        let beginAddr = 2; // 起始地址
        let wordNum = 5; // 字数
        let codeNum = TUHFReader09.Inventory(); // 读取电子标签
        if (codeNum != "") {
            console.log('询查到电子标签,EPC=' + codeNum);
            var epcLen = parseInt(codeNum.substr(0, 2), 16);
            var EPC = codeNum.substr(2, epcLen * 2);
            var TID = TUHFReader09.Read(EPC, beginAddr, wordNum, mem);

            if (TID != '') {
                console.log('读数据成功,TID=' + TID);
                window.clearTimeout(tout); // 清除上一次的读卡超时
                window.clearInterval(timer);
                $('#rfid2').textbox('setValue', TID); // 设置识别码输入域的值
                $('#readRfid').linkbutton({disabled: false}); // 读取到TID后启用该按钮
                let closeState = TUHFReader09.Close(); // 关闭RFID读卡器
                if (closeState == '00') {
                    console.log('RFID读卡设备关闭成功');
                } else {
                    console.log('RFID读卡设备关闭失败');
                }
            } else {
                console.log('TID读数据失败');
            }
        } else {
            console.log('未询查到电子标签');
        }
    }

    function closeRfidReader() {
        window.clearInterval(timer);
        window.clearTimeout(tout);
        let closeState = TUHFReader09.Close(); // 关闭RFID读卡器
        if (closeState == '00') {
            console.log('RFID读卡设备关闭成功');
        } else {
            console.log('RFID读卡设备关闭失败');
        }
    }

    /*function closeRdReader() {
        var closeState;
        closeState = rdcard.closeport(); // 关闭端口
        if (closeState == 0) {
            console.log('二代证读卡设备关闭成功');
        } else {
            console.log('二代证读卡设备关闭失败');
        }
    }*/

    function closeHandPad() {
        var handPadState;
        handPadState = signPanel.HWCloseC(); // 关闭手写板
        if (handPadState == 0) {
            console.log('关闭手写板设备成功');
            signPanel.HWClearPenSign();
        } else {
            console.log('关闭手写板设备失败');
        }
    }
</script>
<div style="position:absolute;">
    <OBJECT
            classid="clsid:F1317711-6BDE-4658-ABAA-39E31D3704D3"
            codebase="SDRdCard.cab#version=2,0,1,0"
            width="0"
            height="0"
            align="center"
            hspace="0"
            vspace="0"
            id="idcard"
            name="rdcard"
    >
    </OBJECT>
    <OBJECT
            id="TUHFReader09"
            codebase="UHFReader09Proj.ocx"
            classid="clsid:14428901-AF2B-4B45-ACBD-0B4779551E5D"
            width="0"
            height="0"
            align="center"
            hspace="0"
            vspace="0"
    >
    </OBJECT>
</div>