<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@include file="../common/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title>
    <%=SpringUtils.getMessage("sys.main.projectName")%>
</title>
<link rel="stylesheet" type="text/css"
      href="${pageContext.request.contextPath}/css/index.css">
<script type="text/javascript">
    var contextPath = '<%=request.getContextPath()%>';
    var DeviceMain; //主头
    var Video; //视频
    var actId;
    var type = 'data:image/jpg;base64,';

    function plugin() {
        return document.getElementById("view1");
    }

    function view() {
        return document.getElementById("view1");
    }

    function addEvent(obj, name, func) {
        if (obj.attachEvent) {
            obj.attachEvent("on" + name, func);
        } else {
            obj.addEventListener(name, func, false);
        }
    }

    function OpenVideo() {
        var dev;

        if (DeviceMain) {
            CloseVideo();
            dev = DeviceMain;
            var SelectType = 1;
            var nResolution = 9;
            Video = plugin().Device_CreateVideo(
                dev,
                nResolution,
                SelectType
            );
            if (Video) {
                view().View_SelectVideo(Video);
                view().View_SetText("打开视频中，请等待...", 0);
            }
        }
    }

    function CloseVideo() {
        if (Video) {
            view().View_SetText("", 0);
            plugin().Video_Release(Video);
            Video = null;
        }
    }

    function Load() {
        //设备接入和丢失
        //type设备类型， 1 表示视频设备， 2 表示音频设备
        //idx设备索引
        //dbt 1 表示设备到达， 2 表示设备丢失
        addEvent(plugin(), "DevChange", function (type, idx, dbt) {
            if (1 == type) {
                //视频设备
                if (1 == dbt) {
                    //设备到达
                    var deviceType = plugin().Global_GetEloamType(
                        1,
                        idx
                    );
                    if (1 == deviceType) {
                        //主摄像头
                        if (null == DeviceMain) {
                            DeviceMain = plugin().Global_CreateDevice(
                                1,
                                idx
                            );
                            OpenVideo();
                        }
                    }
                }
            }
        });
        view().Global_SetWindowName("view");
        plugin().Global_InitDevs();
    }

    function Unload() {
        if (Video) {
            view().View_SetText("", 0);
            plugin().Video_Release(Video);
            Video = null;
        }
        if (DeviceMain) {
            plugin().Device_Release(DeviceMain);
            DeviceMain = null;
        }
        plugin().Global_DeinitDevs();
    }

    // function Scan() {
    //     var date = new Date();
    //     var yy = date.getFullYear().toString();
    //     var mm = (date.getMonth() + 1).toString();
    //     var dd = date.getDate().toString();
    //     var hh = date.getHours().toString();
    //     var nn = date.getMinutes().toString();
    //     var ss = date.getSeconds().toString();
    //     var mi = date.getMilliseconds().toString();
    //     var Name = "D:\\" + yy + mm + dd + hh + nn + ss + mi + ".jpg";
    //
    //     var img = plugin().Video_CreateImage(
    //         Video,
    //         0,
    //         view().View_GetObject()
    //     );
    //     var bSave = plugin().Image_Save(img, Name, 0);
    //     if (bSave) {
    //         view().View_PlayCaptureEffect();
    //     }
    //
    //     plugin().Image_Release(img);
    // }

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
        $('#lifetimeList').datagrid({
            onDblClickRow: function (index, row) {
                $('#view-dialog').window('maximize');
                $('#viewform').form('load', row);
                $('#view-dialog').dialog('setTitle', '查看交接记录').dialog('open');
            }
        });

        $('#scandlg').dialog({
            closed: true,
            closable: false
        });
    });
</script>
<script type="text/javascript">
    // 性别
    var sex = {};
    $.getJSON(base + '/dict/findDict/sex', function (json) {
        sex = json;
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

    // 显示新增生平制作对话框
    function addLifetime() {
        $('#dlg').dialog('setTitle', '新增逝者生平记录').dialog('open');
        $('#dlg').window('maximize')
        $('#addform').form('clear');
        // TODO: 为方便扫码使用,新增对话框显示后将焦点放到服务编号域
        $('#serviceNo').textbox().next('span').find('input').focus();
    }

    function closeAddDialog() {
        let imgs = $("#addform img");
        for (let i = 0; i < imgs.length; i++) {
            imgs[i].src = "";
        }
        $('#dlg').dialog('close');
    }

    function checkSerivceNo() {
        let sno = $('#serviceNo').textbox('getValue');
        if (sno === '') {
            $.messager.alert(title, '请先填入服务编号', warning, function () {
                $("#serviceNo").textbox().next("span").find("input").focus();
            });
        } else {
            var reg = /^((([0-9]{2})(0[48]|[2468][048]|[13579][26]))|((0[48]|[2468][048]|[13579][26])00)0229)|([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))\d{3}$/;
            if (!reg.test(sno)) {
                $.messager.alert(title, '服务编号需填写完整', warning, function () {
                    $("#serviceNo").textbox("setValue", "");
                    $("#serviceNo").textbox().next("span").find("input").focus();
                });
            } else {
                $.ajax({
                    type: "POST",
                    url: base + "/lifetime/exist",
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
        }
    }

    // 删除生平制作
    function removeLifetime() {

    }

    // 保存新增的存放信息
    function saveItem() {
        let sno = $("#serviceNo").textbox("getValue");
        url = base + '/lifetime/save';

        if ($('#id').attr('value') != '') {
            url = base + '/lifetime/update';
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

                    $.messager.confirm(title, '是否下载生平制作清单？', function (r) {
                        if (r) {
                            window.open(base + "/lifetime/export/" + sno);
                        }

                        let imgs = $("#addform img");
                        for (let i = 0; i < imgs.length; i++) {
                            imgs[i].src = "";
                        }
                        $('#dlg').dialog('close');
                        $('#lifetimeList').datagrid('reload');
                    });

                } else {
                    $.messager.alert(title, data.content, error);
                }
            }
        });

    }

    // 编辑存放信息对话框
    function editLifetime() {
        var row = $('#lifetimeList').datagrid('getSelected');
        if (row) {
            $('#dlg').window('maximize');
            $('#addform').form('load', row);
            $('#dlg').dialog('setTitle', '修改逝者生平记录').dialog('open');
        } else {
            $.messager.alert(title, '请选择需要修改的生平记录', warning);
        }
    }

    // 查看存放信息对话框
    function viewLifetime() {
        var row = $('#lifetimeList').datagrid('getSelected');
        if (row) {
            $('#view-dialog').window('maximize');
            $('#viewform').form('load', row);
            $('#view-dialog').dialog('setTitle', '查看逝者生平记录').dialog('open');
        } else {
            $.messager.alert(title, '请选择需要查看的生平记录', warning);
        }
    }

    function refresh() {
        $('#lifetimeList').datagrid('loadData', {total: 0, rows: []});
        $('#lifetimeList').datagrid('load', {});
    }

    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + '/lifetime/query',
            callback: function (data) {
                $('#lifetimeList').datagrid('loadData', {total: 0, rows: []});
                $('#lifetimeList').datagrid('load', data);
            }
        });
    }

    function formatterDate(date) {
        var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
        var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
            + (date.getMonth() + 1);
        return date.getFullYear() + '/' + month + '/' + day;
    }

    // 拍照
    function scan() {
        let sno = $("#serviceNo").textbox("getValue");
        var txtBox = $('#' + actId);
        var origFile = txtBox.textbox('getValue');
        var fso = new ActiveXObject("Scripting.FileSystemObject");
        if (!fso.FolderExists("D:\\lifetime\\" + sno)) {
            fso.CreateFolder("D:\\lifetime\\" + sno);
        }
        if (fso.FileExists("D:\\lifetime\\" + sno + "\\" + origFile)) {
            fso.DeleteFile("D:\\lifetime\\" + sno + "\\" + origFile, false);
        }
        var date = new Date();
        var yy = date.getFullYear().toString();
        var mm = (date.getMonth() + 1).toString();
        var dd = date.getDate().toString();
        var hh = date.getHours().toString();
        var nn = date.getMinutes().toString();
        var ss = date.getSeconds().toString();
        var mi = date.getMilliseconds().toString();
        var fileName = yy + mm + dd + hh + nn + ss + mi + ".jpg";
        var path = "D:\\lifetime\\" + sno + "\\" + fileName;

        var img = plugin().Video_CreateImage(
            Video,
            0,
            view().View_GetObject()
        );
        var base64Str = plugin().Image_GetBase64(img, 2, 0);
        var bSave = plugin().Image_Save(img, path, 0);
        if (bSave) {
            view().View_PlayCaptureEffect();
        }

        plugin().Image_Release(img);
        txtBox.textbox('setValue', fileName);
        txtBox.textbox('setText', fileName);
        closeScanDialog();
        $('#' + actId + '_img').attr('src', type + base64Str);
        $("#" + actId + "_f").textbox("setValue", "");
        actId = null;
    }

    // 清除拍照
    function clearScan(name) {
        var obj = $('#' + name);
        obj.textbox('setValue', '');
    }

    // 开启高拍仪
    function openScanDialog(name) {
        let sno = $("#serviceNo").textbox("getValue");
        if (sno === "") {
            $.messager.alert(title, '请先填入服务编号', warning, function () {
                $("#serviceNo").textbox().next("span").find("input").focus();
            });
        } else {
            actId = name;
            $('#scandlg').dialog('setTitle', '拍照').dialog('open');
            // OpenVideo();
        }
    }

    // 关闭高拍仪
    function closeScanDialog() {
        // CloseVideo();
        $('#scandlg').dialog('close');
    }

    function openPreviewDialog(id) {
        $('#previewdlg').dialog('setTitle', '拍照预览').dialog('open');
        $('#reviewimg').attr('src', $('#' + id + '_img').attr('src'));
    }

    function closePreviewDialog() {
        $('#previewdlg').dialog('close');
    }

    function change(name, _obj) {
        let sno = $("#serviceNo").textbox("getValue");
        if (sno === "") {
            $.messager.alert(title, '请先填入服务编号', warning, function () {
                $("#" + name + "_f").textbox("setValue", "");
                $("#serviceNo").textbox().next("span").find("input").focus();
            });
            return;
        }

        var origFile = $('#' + name).textbox("getValue"); // 拍照文本框文件名
        var selFile = $("#" + name + "_f");
        var value = selFile.filebox('getValue');
        var pos = value.lastIndexOf("\\");
        var fileName = value.substr(pos + 1)
        console.log(value);
        console.log(fileName);

        var date = new Date();
        var yy = date.getFullYear().toString();
        var mm = (date.getMonth() + 1).toString();
        var dd = date.getDate().toString();
        var hh = date.getHours().toString();
        var nn = date.getMinutes().toString();
        var ss = date.getSeconds().toString();
        var mi = date.getMilliseconds().toString();
        var ext = value.substring(value.lastIndexOf(".")).toLowerCase();
        var newfileName = yy + mm + dd + hh + nn + ss + mi;

        var fso = new ActiveXObject("Scripting.FileSystemObject");
        if (!fso.FolderExists("D:\\lifetime\\" + sno)) {
            fso.CreateFolder("D:\\lifetime\\" + sno);
        }
        if (fso.FileExists("D:\\lifetime\\" + sno + "\\" + origFile)) {
            fso.DeleteFile("D:\\lifetime\\" + sno + "\\" + origFile, false);
        }
        fso.CopyFile(value, "D:\\lifetime\\" + sno + "\\" + newfileName + ext, true);
        $("#" + name).textbox("setValue", newfileName + ext);
        // 取后缀名
        // var ext = value.substring(value.lastIndexOf(".") + 1).toLowerCase();
        // if (ext != 'xls') {
        //     if (ext != 'xlsx') {
        //         $.messager.alert("消息提示", "文件格式不对！请重新上传", "error");
        //         return;
        //     }
        // }

//取file

        var file = $(_obj).context.ownerDocument.activeElement.files[0]
        var reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function (e) {
            $('#' + name + '_img').attr('src', this.result);
        }
    }
</script>