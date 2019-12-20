<%@ page
        language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="../common/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>
    <%=SpringUtils.getMessage("sys.main.projectName")%>
</title>
<link
        rel="stylesheet"
        type="text/css"
        href="${pageContext.request.contextPath}/css/index.css"
/>
<script type="text/javascript">
    var contextPath = "<%=request.getContextPath()%>";

    var signPanel;
    // 控制签名后必须点击完成按钮画面正常切回pc屏内，才可以点击对话框底部的关闭按钮
    var isSigned = false;
    var toSign = false;

    var passed = false;

    // 页面加载成后设置签字区域属性
    window.onload = function () {
        signPanel = document.getElementById("HWPenSign");
        signPanel.HWSetBkColor(0xe0f8e0); // 设置签名区背景颜色
        signPanel.HWSetCtlFrame(2, 0x000000); // 设置边框宽度和颜色
        //  signPanel.HWSetSeparatorLine(lineNum , 0x000000); // 设置分行线的行数和颜色
    };

    $.parser.onComplete = function () {
        $("body").css("visibility", "visible");
        setTimeout(function () {
            $("#loading-mask").remove();
        }, 50);
    };

    $(function () {

        $(window).resize(function () {
            $("#mainlayout").layout("resize");
        });

        $("#deserts").datagrid({
            onDblClickRow: function (index, row) {
                $("#view-dialog").window("maximize");
                $("#viewform").form("load", row);
                $("#view-dialog")
                    .dialog("setTitle", "查看存放记录")
                    .dialog("open");
            }
        });

        // 读取逝者身份证信息
        $("#readDpIdCard").bind("click", function () {
            // 调用readcard操作之后就可以从rdcard对象取出身份证信息
            var readState = rdcard.readcard();
            if (readState == 0) {
                $("#dpCertType").combobox("setValue", "0");
                $("#dpCertNo").textbox("setValue", rdcard.CardNo);
                $("#dpName").textbox("setValue", rdcard.NameL);
                $("#dpSex").combobox("setValue", rdcard.Sex);
                $("#dpAge").numberspinner("setValue", getDpAge(rdcard.Born));
                $("#dpAddr").textbox("setValue", rdcard.Address);
                return;
            } else {
                if (readState == -7) {
                    $.messager.alert(
                        title,
                        "验证卡失败，没有找到卡或者需要将卡拿离验证区重新读卡",
                        error
                    );
                } else {
                    $.messager.alert(
                        title,
                        "读二代证失败: " + readState,
                        error
                    );
                }
                readState = null;
                return;
            }
        });
        // 读取承办人身份证信息
        $("#readUtIdCard").bind("click", function () {
            var readState = rdcard.readcard(); // 调用readcard操作之后就可以从rdcard对象取出身份证信息
            if (readState == 0) {
                $("#utCertType").combobox("setValue", "0");
                $("#utCertNo").textbox("setValue", rdcard.CardNo);
                $("#utName").textbox("setValue", rdcard.NameL);
                return;
            } else {
                if (readState == -7) {
                    $.messager.alert(
                        title,
                        "验证卡失败，没有找到卡或者需要将卡拿离验证区重新读卡",
                        error
                    );
                } else {
                    $.messager.alert(
                        title,
                        "读二代证失败: " + readState,
                        error
                    );
                }
                readState = null;
                return;
            }
        });

        $("#readRfid").bind("click", function () {
            $("#rfid2").textbox("clear");
            openRfidReader();
        });

        $('#checkServiceNoRfid').bind('click', function () {
            let sno = $('#serviceNo').textbox('getValue');
            if (sno == '') {
                $.messager.alert(title, '验证编号不能为空', error);
                $("#serviceNo").textbox().next("span").find("input").focus();
                return;
            }

            let rfid = $('#rfid2').textbox('getValue');
            if (rfid == '') {
                $.messager.alert(title, '验证识别码不能为空', error);
                return;
            }
            $.ajax({
                type: "POST",
                url: base + "/draw/isMatched",
                data: {sno: sno, rfid: rfid},
                dataType: "json",
                async: false,
                success: function (data) {
                    passed = data.result;
                    console.log('逝者信息核对是否正确:' + passed);
                    if (data.result == true) {
                        $.messager.alert(title, '逝者信息核对正确', info);
                    } else {
                        $.messager.alert(title, '逝者信息核对错误', error);
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
    $.getJSON(base + "/dict/findDict/sex", function (json) {
        sex = json;
    });
    // 逝者证件类型
    var certType = {};
    $.getJSON(base + "/dict/findDict/certType", function (json) {
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

    // 证件类型描述格式化
    function certTypeFormatter(value) {
        for (var i = 0; i < certType.length; i++) {
            if (certType[i].value == value) {
                return certType[i].name;
            }
        }
        return value;
    }

    // 显示新增存放对话框
    function addDesert() {
        var openState = rdcard.openport();
        if (openState == 0) {
            // $.messager.alert('提示', '开启端口成功', 'info');
        } else {
            $.messager.alert(title, "开启端口失败: " + openState, error);
        }
        $("#dlg")
            .dialog("setTitle", "新增记录")
            .dialog("open");
        $("#dlg").window("maximize");
        $("#addform").form("clear");

        // 修改逝者证件类型,动态添加输入验证规则
        $("#dpCertType").combobox({
            onChange: function (newValue, oldValue) {
                // 清空证件号码域
                $("#dpCertNo").textbox("setValue", "");
                if (newValue == 0) {
                    $("#dpCertNo").textbox({
                        validType: ["certNo", "certNoLen[18]"]
                    });
                } else {
                    $("#dpCertNo").textbox({
                        validType: "certNoLen[20]"
                    });
                }
            }
        });
        // 修改承办人证件类型,动态添加输入验证规则
        $("#utCertType").combobox({
            onChange: function (newValue, oldValue) {
                // 清空证件号码域
                $("#utCertNo").textbox("setValue", "");
                if (newValue == 0) {
                    $("#utCertNo").textbox({
                        validType: ["certNo", "certNoLen[18]"]
                    });
                } else {
                    $("#utCertNo").textbox({
                        validType: "certNoLen[20]"
                    });
                }
            }
        });

        // 为方便扫码使用,新增对话框显示后将焦点放到业务编号域
        $("#serviceNo").textbox({
            icons: [{
                iconCls: 'icon-clear',
                handler: function (e) {
                    $(e.data.target).textbox('clear');
                    $('#serviceNo').textbox().next('span').find('input').focus();
                }
            }]
        });

        // 给业务编号扫码添加回车事件
        $('#serviceNo').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keypress: function test() {
                    console.log(event.keyCode);
                    if (event.keyCode == 13) {
                        let sno = $('#serviceNo').textbox('getValue');
                        console.log("查询业务编号:" + sno);
                        $.ajax({ // 查询业务编号是否已经做过放弃骨灰业务
                            type: "POST",
                            url: base + "/desert/exist",
                            data: {sno: sno},
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                console.log('是否已经做过放弃骨灰业务:' + data.result);
                                if (data.result) {
                                    $.messager.alert(title, '放弃骨灰业务信息已存在', warning);
                                    $('#serviceNo').textbox('clear');
                                    $('#serviceNo').textbox().next('span').find('input').focus
                                } else {
                                    $.ajax({ // 查询业务编号是否完成领取业务
                                        type: "POST",
                                        url: base + "/draw/find",
                                        data: {sno: sno},
                                        dataType: "json",
                                        async: false,
                                        success: function (rdata) {
                                            console.log(rdata);
                                            if (rdata.result == true) {
                                                console.log(rdata.rfid);
                                                console.log(rdata.dpName);
                                                $("#rfid").textbox("setValue", rdata.rfid);
                                                $("#dpName").textbox("setValue", rdata.dpName);
                                                $("#dpAge").numberspinner('setValue', rdata.dpAge);
                                                $('#dpSex').combobox('setValue', '' + rdata.dpSex);
                                                $('#dpCertType').combobox('setValue', rdata.dpCertNo.length == 18 ? '0' : '');
                                                $("#dpCertNo").textbox('setValue', rdata.dpCertNo);
                                                $('#dpAddr').textbox('setValue', rdata.dpAddr);

                                                $('#utName').textbox('setValue', rdata.utName);
                                                $('#utCertType').combobox('setValue', rdata.utCertNo.length == 18 ? '0' : '');
                                                $('#utCertNo').textbox('setValue', rdata.utCertNo);
                                                $('#phone').textbox('setValue', rdata.phone);
                                            } else {
                                                console.log('骨灰领取业务信息不存在:' + sno);
                                                $.messager.alert(title, '骨灰领取业务信息不存在', warning, function () {
                                                    $("#serviceNo").textbox("setValue", "");
                                                    $("#serviceNo").textbox().next("span").find("input").focus();
                                                });
                                            }
                                        },
                                        error: function (e) {
                                            console.log(e);
                                        }
                                    })
                                }
                            },
                            error: function (e) {
                                console.log(e);
                            }
                        })
                    }
                }
            })
        });
        $('#serviceNo').textbox().next('span').find('input').focus();
        openRfidReader();
    }

    // 保存新增的存放信息
    function saveItem() {
        console.log('提交存放信息，逝者信息核对是否正确:' + passed);
        if (!passed) {
            alert('逝者信息核对错误，不能办理放弃骨灰业务！');
            return;
        }

        if (toSign && !isSigned) {
            alert('没有签名，不能办理放弃骨灰业务！');
            return;
        }

        let sno = $("#serviceNo").textbox("getValue");
        url = base + "/desert/save";

        if ($("#id").attr("value") != "") {
            url = base + "/desert/update";
        }

        $("#addform").form("submit", {
            url: url,
            onSubmit: function () {
                return $("#addform").form("validate");
            },
            success: function (data) {
                data = eval("(" + data + ")");
                if (data.type == "success") {
                    $.messager.show({
                        title: title,
                        msg: data.content,
                        timeout: 2000,
                        showType: "slide"
                    });
                    closeRfidReader();
                    closeRdReader(); // 关闭二代证读卡器设备
                    closeHandPad();
                    $("#dlg").dialog("close");
                    $("#deserts").datagrid("reload");
                    $.messager.confirm(title, "是否打印放弃骨灰确认书?", function (r) {
                        if (r) {
                            window.open(base + "/desert/viewPDF/" + sno);
                        }
                    });

                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    // 编辑存放信息对话框
    function editDesert() {
        var row = $("#deserts").datagrid("getSelected");
        if (row) {
            $("#dlg").window("maximize");
            $("#addform").form("load", row);
            $("#dlg")
                .dialog("setTitle", "修改记录")
                .dialog("open");
        } else {
            $.messager.alert(title, "请选中需要修改的记录", warning);
        }
    }

    // 查看存放信息对话框
    function viewDesert() {
        var row = $("#deserts").datagrid("getSelected");
        if (row) {
            $("#view-dialog").window("maximize");
            $("#viewform").form("load", row);
            $("#view-dialog")
                .dialog("setTitle", "查看记录")
                .dialog("open");
        } else {
            $.messager.alert(title, "请选择需要查看的记录", warning);
        }
    }

    function previewDesert() {
        var row = $("#deserts").datagrid("getSelected");
        // url = base + '/desert/update';
        if (row) {
            window.open(base + "/desert/viewPDF/" + row.serviceNo);
        } else {
            $.messager.alert(title, "请选中需要查看的记录", warning);
        }
    }

    function refresh() {
        $("#deserts").datagrid("loadData", {total: 0, rows: []});
        $("#deserts").datagrid("load", {});
    }

    // 条件查询窗口
    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + "/desert/query",
            callback: function (data) {
                $("#deposits").datagrid("loadData", {total: 0, rows: []});
                $("#deposits").datagrid("load", data);
            }
        });
    }

    function formatterDate(date) {
        var day = date.getDate();
        var month = date.getMonth() + 1;
        return date.getFullYear() + "-" + month + "-" + day;
    }

    // 通过出生日期计算年龄
    function getDpAge(born) {
        var date = new Date();
        var currYear = date.getFullYear();
        return parseInt(currYear) - parseInt(born.substring(0, 4));
    }

    // 关闭新增寄存窗口时关闭读卡器端口
    function closeAddDialog() {
        if (toSign && !isSigned) {
            alert('没有完成签字确认');
            return;
        }
        closeRfidReader();
        closeRdReader();
        closeHandPad();
        $("#dlg").dialog("close");
    }

    /*以下部分为签名功能*/
    function startSign() {
        var res;
        signPanel.HWRegisterJSButtonCall(
            2,
            "clearButton;finishButton;",
            "clearSign;finishSign;"
        );
        signPanel.HWMonitorWndEnable(0, 0, parent.window.screen.availWidth, parent.window.screen.availHeight);
        res = signPanel.HWInitC();
        switch (res) {
            case 0:
                signPanel.HWSwitchMonitor(1, 1);
                break;
            case -1:
                $.messager.alert(title, "未找到对应的汉王手写设备", error);
                break;
            case -2:
                $.messager.alert(title, "手写模块加载失败", error);
                break;
            case -3:
                $.messager.alert(title, "手写模块初始化失败", error);
                break;
            default:
                $.messager.alert(title, "手写模块未知错误", error);
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
            $("#signPic").val(signPanel.HWGetBase64Stream(1));
        }
        isSigned = true;
        $('#saveButton').linkbutton({disabled: false});
        $('#closeButton').linkbutton({disabled: false});
    }

    function checkSerivceNo() {
        let sno = $('#serviceNo').textbox('getValue');
        $.ajax({
            type: "POST",
            url: base + "/desert/exist",
            data: {sno: sno},
            dataType: "json",
            async: false,
            success: function (data) {
                console.log(data);
                if (data.result) {
                    if (data.result == true) {
                        $.messager.alert(title, '服务编号已存在', warning, function () {
                            $("#serviceNo").textbox("setValue", "");
                        });
                    }
                }
            },
            error: function (e) {
                console.log(e);
            }
        })
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

    function closeRdReader() {
        var closeState;
        closeState = rdcard.closeport(); // 关闭端口
        if (closeState == 0) {
            console.log('二代证读卡设备关闭成功');
        } else {
            console.log('二代证读卡设备关闭失败');
        }
    }

    function closeHandPad() {
        var handPadState;
        signPanel.HWClearPenSign();
        handPadState = signPanel.HWCloseC(); // 关闭手写板
        if (handPadState == 0) {
            console.log('关闭手写板设备成功');
        } else {
            console.log('关闭手写板设备失败');
        }
    }
</script>
<div style="position: absolute">
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