<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
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

        $("#bags").datagrid({
            onDblClickRow: function (index, row) {
                $("#view-dialog").window("maximize");
                $("#viewform").form("load", row);
                $("#view-dialog")
                    .dialog("setTitle", "查看存放记录")
                    .dialog("open");
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
    function addBag() {
        var openState = rdcard.openport();
        if (openState == 0) {
            console.log("二代证阅读机开启端口成功");
        } else {
            $.messager.alert(title, "二代证阅读机开启端口失败: " + openState, error);
        }
        $("#dlg")
            .dialog("setTitle", "新增RFID领取记录")
            .dialog("open");
        $("#dlg").window("maximize");
        $("#addform").form("clear");
        // 修改承办人证件类型,动态添加输入验证规则
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
        // 急取设置领取日期为当天,非急取为当天+2
    }

    // 保存新增的存放信息
    function saveItem() {
        var sno = $("#serviceNo").textbox("getValue");
        url = base + "/bag/save";

        if ($("#id").attr("value") != "") {
            url = base + "/bag/update";
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

                    $("#dlg").dialog("close");
                    $("#bags").datagrid("reload");
                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });
    }

    // 编辑存放信息对话框
    function editBag() {
        var row = $("#bags").datagrid("getSelected");
        if (row) {
            if (row.status == 1) {
                $.messager.alert(title, "状态为已领取，不能修改", error);
                return;
            }
            $("#dlg").window("maximize");
            $("#addform").form("load", row);
            $("#dlg")
                .dialog("setTitle", "修改存放记录")
                .dialog("open");
        } else {
            $.messager.alert(title, "请选择您要修改的RFID领取记录", warning);
        }
    }

    // 查看存放信息对话框
    function viewBag() {
        var row = $("#bags").datagrid("getSelected");
        if (row) {
            $("#view-dialog").window("maximize");
            $("#viewform").form("load", row);
            $("#view-dialog")
                .dialog("setTitle", "查看RFID领取记录")
                .dialog("open");
        } else {
            $.messager.alert(title, "请选择您要查看的RFID领取记录", warning);
        }
    }

    function refresh() {
        $("#bags").datagrid("loadData", {total: 0, rows: []});
        $("#bags").datagrid("load", {});
    }

    // 条件查询窗口
    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + "/bag/query",
            callback: function (data) {
                $("#bags").datagrid("loadData", {total: 0, rows: []});
                $("#bags").datagrid("load", data);
            }
        });
    }

    // 为网格结果的日期格式化
    function formatterDate(date) {
        var day = date.getDate();
        var month = date.getMonth() + 1;
        return date.getFullYear() + "-" + month + "-" + day;
    }

    // 关闭新增寄存窗口时关闭读卡器端口
    function closeAddDialog() {
        var closeState;
        closeState = rdcard.closeport(); // 关闭端口
        if (closeState == 0) {
            // $.messager.alert('提示', '关闭端口成功', 'info');
        } else {
            $.messager.alert(title, "关闭端口失败: " + closeState, error);
        }
        $("#dlg").dialog("close");
    }

    // function checkSerivceNo() {
    //     let sno = $('#serviceNo').textbox('getValue');
    //     $.ajax({
    //         type: "POST",
    //         url: base + "/deposit/exist",
    //         data: {sno: sno},
    //         dataType: "json",
    //         async: false,
    //         success: function (data) {
    //             console.log(data);
    //             if (data.result) {
    //                 if (data.result == true) {
    //                     $.messager.alert(title, '服务编号已存在', warning, function () {
    //                         $("#serviceNo").textbox("setValue", "");
    //                         $("#serviceNo").textbox().next("span").find("input").focus();
    //                     });
    //                 }
    //             }
    //         },
    //         error: function (e) {
    //             console.log(e);
    //         }
    //     })
    // }
</script>

