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

        $('#handOverList').datagrid({
            onDblClickRow: function (index, row) {
                $('#view-dialog').window('maximize');
                $('#viewform').form('load', row);
                $('#view-dialog').dialog('setTitle', '查看交接记录').dialog('open');
            }
        });

        $("#readRfid").bind("click", function () {
            $("#rfid").textbox("clear");
            var port = 3; // 端口COM3
            var baud = 5; // 波特率57600bps
            var mem = 2 // 读TID区
            var beginAddr = 2; // 起始地址
            var wordNum = 5; // 字数
            var connStatus = TUHFReader09.Open(port, baud);

            if (connStatus == '00') {
                console.log('设备连接成功');
            } else if (connStatus == '35') {
                console.log('设备已连接');
            } else {
                $.messager.alert(
                    title,
                    '设备连接失败',
                    error
                );
            }

            if (connStatus == '00' || connStatus == '35') {
                var codeNum = TUHFReader09.Inventory();
                if (codeNum == "") {
                    $.messager.alert(
                        title,
                        '未询查到电子标签',
                        error
                    );
                } else {
                    console.log('询查到电子标签');
                    console.log('EPC=' + codeNum)
                    var epcLen = parseInt(codeNum.substr(0, 2), 16);
                    var EPC = codeNum.substr(2, epcLen * 2);
                    var TID = TUHFReader09.Read(EPC, beginAddr, wordNum, mem);
                    if (TID == '') {
                        $.messager.alert(
                            title,
                            '读数据失败',
                            error
                        );
                    } else {
                        console.log('读数据成功');
                        console.log('TID=' + TID);
                        $('#rfid').textbox('setValue', TID);
                        $.ajax({
                            type: "POST",
                            url: base + "/tmp/queryRfid",
                            data: {rfid: TID},
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                console.log(data);
                                if (data.result == true) {
                                    $('#rfid').textbox('setValue', data.rfid);
                                    $('#serviceNo').textbox('setValue', data.serviceNo);
                                    $('#dpName').textbox('setValue', data.dsName);
                                    $('#dpAge').numberspinner('setValue', data.dsAge);
                                    $('#dpSex').combobox('setValue', '' + data.dsSex);
                                } else {
                                    $.messager.alert(title, '骨灰袋识别码不存在', warning, function () {
                                        $('#rfid').textbox('setValue', '');
                                        $('#rfid').textbox().next('span').find('input').focus();
                                    });
                                }
                            },
                            error: function (e) {
                                console.log(e);
                            }
                        })
                    }
                }

                connStatus = TUHFReader09.Close();
                if (connStatus == '00') {
                    console.log('设备关闭成功');
                } else {
                    console.log('设备关闭失败');
                }
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
    function addHandover() {
        $('#dlg').dialog('setTitle', '新增交接记录').dialog('open');
        $('#dlg').window('maximize')
        $('#addform').form('clear');
        $('#depositDate').datebox('setValue', formatterDate(new Date()));
        $('#position').combobox('reload', '${pageContext.request.contextPath}/shelf/list');
        $.getJSON(base + '/shelf/idel/', function (json) {
            if (json.length == 0) {
                $.messager.alert(title, '当前没有可用的存放位置', warning);
            } else {
                $('#position').combobox('setValue', json[0].code);
            }
        });

        // 为方便扫码使用,新增对话框显示后将焦点放到业务编号域
        $("#rfid").textbox({
            icons: [{
                iconCls: 'icon-clear',
                handler: function (e) {
                    $(e.data.target).textbox('clear');
                    $('#rfid').textbox().next('span').find('input').focus();
                }
            }]
        });

        // 使RFID编号获得焦点
        $('#rfid').textbox().next('span').find('input').focus();
        // TODO: 为方便扫码使用,新增对话框显示后将焦点放到服务编号域
        $('#serviceNo').textbox({
            onChange: function (newValue, oldValue) {
                $.getJSON(base + '/deposit/findDepositByServiceNo/' + newValue, function (json) {
                    if (json.length == 0) {
                        $.messager.alert(title, '没有匹配的骨灰盒存放记录', warning, function () {
                            $("#serviceNo").textbox("clear");
                        });
                    } else {
                        $.ajax({
                            type: "POST",
                            url: base + "/handover/exist",
                            data: {sno: newValue},
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                console.log(data);
                                if (data.result) {
                                    if (data.result == true) {
                                        $.messager.alert(title, '已办理交接业务', warning, function () {
                                            $("#serviceNo").textbox("clear");
                                        });
                                    } else {
                                        $('#dpName').textbox('setValue', json[0].dpName);
                                        $('#dpSex').combobox('setValue', json[0].dpSex);
                                        $('#dpAge').numberspinner('setValue', json[0].dpAge);
                                    }
                                }
                            },
                            error: function (e) {
                                console.log(e);
                            }
                        })
                    }
                });
            }
        });
    }

    // 关闭新增寄存窗口时关闭读卡器端口
    function closeHandover() {
        $("#dlg").dialog("close");
    }

    // 保存新增的存放信息
    function saveItem() {
        url = base + '/handover/save';

        if ($('#id').attr('value') != '') {
            url = base + '/handover/update';
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

    // 编辑存放信息对话框
    function editHandover() {
        var row = $('#handOverList').datagrid('getSelected');
        if (row) {
            if (row.status == 1) {
                $.messager.alert(title, "状态为已领取，不能修改", error);
                return;
            }
            $('#dlg').window('maximize');
            $('#addform').form('load', row);
            $('#dlg').dialog('setTitle', '修改交接记录').dialog('open');
        } else {
            $.messager.alert(title, '请选择需要修改的交接记录', warning);
        }
    }

    // 查看存放信息对话框
    function viewHandover() {
        var row = $('#handOverList').datagrid('getSelected');
        if (row) {
            $('#view-dialog').window('maximize');
            $('#viewform').form('load', row);
            $('#view-dialog').dialog('setTitle', '查看交接记录').dialog('open');
        } else {
            $.messager.alert(title, '请选择需要查看的交接记录', warning);
        }
    }

    function refresh() {
        $('#handOverList').datagrid('loadData', {total: 0, rows: []});
        $('#handOverList').datagrid('load', {});
    }

    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + '/handover/query',
            callback: function (data) {
                $('#handOverList').datagrid('loadData', {total: 0, rows: []});
                $('#handOverList').datagrid('load', data);
            }
        });
    }

    function formatterDate(date) {
        var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
        var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
            + (date.getMonth() + 1);
        return date.getFullYear() + '/' + month + '/' + day;
    }

    function checkSerivceNo() {
        let sno = $('#serviceNo').textbox('getValue');
        $.ajax({
            type: "POST",
            url: base + "/handover/exist",
            data: {sno: sno},
            dataType: "json",
            async: false,
            success: function (data) {
                console.log(data);
                if (data.result) {
                    if (data.result == true) {
                        $.messager.alert(title, 'RFID编号已存在', warning, function () {
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
</script>
<div style="position: absolute">
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