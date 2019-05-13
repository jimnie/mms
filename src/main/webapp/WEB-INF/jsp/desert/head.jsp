<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
        // TODO: 为方便扫码使用,新增对话框显示后将焦点放到服务编号域
        $("#serviceNo")
            .textbox()
            .next("span")
            .find("input")
            .focus();
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
    }

    // 保存新增的存放信息
    function saveItem() {
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

                    $.messager.confirm(title, "是否打印放弃骨灰确认书?", function (r) {
                        if (r) {
                            window.open(base + "/desert/viewPDF/" + sno);
                        }

                        $("#dlg").dialog("close");
                        $("#deserts").datagrid("reload");
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
            $.messager.alert(title, "请选择需要修改的记录", warning);
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
            $.messager.alert(title, "请选择需要查看的记录", warning);
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
            $.messager.alert(title, "签名没有完成", warning);
            return;
        }

        var closeState;
        closeState = rdcard.closeport(); // 关闭端口
        if (closeState == 0) {
            // $.messager.alert('提示', '关闭端口成功', 'info');
        } else {
            $.messager.alert(title, "关闭端口失败: " + closeState, error);
        }
        var handPadState;
        handPadState = signPanel.HWCloseC(); // 关闭手写板
        if (handPadState == 0) {
            signPanel.HWClearPenSign();
        } else {
            $.messager.alert(title, "关闭手写板设备失败: " + closeState, error);
        }
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
