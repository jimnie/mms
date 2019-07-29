<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/jsp/common/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>
        <%=SpringUtils.getMessage("sys.main.projectName")%>
    </title>
    <link rel="shortcut icon" href="<%=base%>/images/favorite.ico" type="image/x-icon"/>
    <link rel="stylesheet" type="text/css"
          href="<%=base%>/css/agv.css">
    <script type="text/javascript">
        /*********************** 无人智能运输车控制台功能 ***********************/
        $(function () {
            var beginPosition = 0; // 出发站点
            var currPosition = 0; // 车辆站点
            var currSpeed = 0; // 车辆速度
            var movingStat = false; // 车辆移动中
            var agvInfInit = false; // 车辆信息初始化
            var batteryLow = false; // 电量低

            $('#agvGo').bind("click", function () {
                if (batteryLow) {
                    $.messager.alert(title, '车辆电量低,请及时充电', error);
                    return;
                }
                if (agvInfInit) {
                    if (currSpeed != 0 && movingStat) {
                        $.messager.alert(title, '车辆行驶中,操作无效', warning);
                    } else {
                        if (currPosition == 2) {
                            $.messager.alert(title, '车辆已到达十号厅', warning);
                        } else {
                            $('#tabs').tabs('loading', '正在启动车辆...')
                            $.ajax({
                                url: base + "/agv/toStation2",
                                dataType: "json",
                                async: false,
                                success: function (data) {
                                    if (data.statusInf != undefined) {
                                        console.log(data.statusInf);
                                        if (data.statusInf.currSpeed != 0 && data.statusInf.movingOrNot) {
                                            closableMessager('车辆已出发', info)
                                            beginPosition = data.statusInf.currPosition;
                                            currSpeed = data.statusInf.currSpeed;
                                            movingStat = data.statusInf.movingOrNot;
                                        }
                                    }
                                    $("#tabs").tabs("loaded")
                                },
                                error: function (e) {
                                    console.log(e);
                                    $("#tabs").tabs("loaded")
                                }
                            });
                        }
                    }
                } else {
                    $.messager.alert(title, '正在查询车辆信息,请稍后再试', warning);
                }
            });

            $('#agvRet').bind("click", function () {
                if (batteryLow) {
                    $.messager.alert(title, '车辆电量低,请及时充电', error);
                    return;
                }
                if (agvInfInit) {
                    if (currSpeed != 0 && movingStat) {
                        $.messager.alert(title, '车辆行驶中,操作无效', warning);
                    } else {
                        if (currPosition == 1) {
                            $.messager.alert(title, '车辆已到达后炉', warning);
                        } else {
                            $('#tabs').tabs('loading', '正在启动车辆...')
                            $.ajax({
                                url: base + "/agv/toStation1",
                                dataType: "json",
                                async: false,
                                success: function (data) {
                                    // console.log(data.statusInf != undefined);
                                    if (data.statusInf != undefined) {
                                        console.log(data.statusInf);
                                        if (data.statusInf.currSpeed != 0 && data.statusInf.movingOrNot) {
                                            closableMessager('车辆已出发', info)
                                            beginPosition = data.statusInf.currPosition;
                                            currSpeed = data.statusInf.currSpeed;
                                            movingStat = data.statusInf.movingOrNot;
                                        }
                                    }
                                    $("#tabs").tabs("loaded")
                                },
                                error: function (e) {
                                    console.log(e);
                                    $("#tabs").tabs("loaded")
                                }
                            });
                        }
                    }
                } else {
                    $.messager.alert(title, '正在查询车辆信息,请稍后再试', warning);
                }
            });

            setInterval(function () {
                $.ajax({
                    url: base + "/agv/queryStatus",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        // console.log(data.statusInf);
                        if (data.statusInf != undefined) {
                            console.log(data.statusInf);
                            if (beginPosition != 0 && data.statusInf.currPosition != beginPosition) {
                                if (data.statusInf.currPosition == 1) {
                                    $.messager.alert(title, '车辆已到达后炉', warning);
                                }
                                if (data.statusInf.currPosition == 2) {
                                    $.messager.alert(title, '车辆已到达十号厅', warning);
                                }
                                beginPosition = data.statusInf.currPosition;
                            }
                            if (data.statusInf.currPosition == 1) {
                                $('#currPosition').html('后炉');
                            } else if (data.statusInf.currPosition == 2) {
                                $('#currPosition').html('十号厅');
                            } else {
                                $('#currPosition').html('行驶中');
                            }
                            $('#currSpeed').html('' + data.statusInf.currSpeed);
                            $('#batteryBalance').html(data.statusInf.batteryBalance + '%');
                            $('#faultCode').html('' + data.statusInf.faultCode);

                            $('#faultInf').html(getValueByBoolean(data.statusInf.faultInf));
                            $('#missingStat').html(getValueByBoolean(data.statusInf.missingStat));
                            $('#ctrlRelease').html(getValueByBoolean(data.statusInf.ctrlRelease));
                            $('#trafficCtrl').html(getValueByBoolean(data.statusInf.trafficCtrl));
                            $('#taskLocking').html(getValueByBoolean(data.statusInf.taskLocking));
                            $('#taskNull').html(getValueByBoolean(data.statusInf.taskNull));
                            $('#movingOrNot').html(getValueByBoolean(data.statusInf.movingOrNot));
                            $('#startUpOrAwait').html(getValueByBoolean(data.statusInf.startUpOrAwait));
                            $('#charging').html(getValueByBoolean(data.statusInf.charging));
                            $('#taskExecuting').html(getValueByBoolean(data.statusInf.taskExecuting));
                            $('#stopByObstacle').html(getValueByBoolean(data.statusInf.stopByObstacle));
                            $('#pauseByMainCtrl').html(getValueByBoolean(data.statusInf.pauseByMainCtrl));

                            if (parseInt(data.statusInf.batteryBalance) < 30) {
                                $.messager.alert(title, '车辆电量低,请及时充电', error);
                                batteryLow = true;
                            } else {
                                batteryLow = false;
                            }

                            agvInfInit = true;
                            currPosition = data.statusInf.currPosition;
                            currSpeed = data.statusInf.currSpeed;
                            movingStat = data.statusInf.movingOrNot;
                            $('#agvStatus').html('<font color="blue">车辆在线</font>');
                        } else {
                            agvInfInit = false;
                            $('#currPosition').html('');
                            $('#currSpeed').html('');
                            $('#batteryBalance').html('');
                            $('#faultCode').html('');

                            $('#faultInf').html('');
                            $('#missingStat').html('');
                            $('#ctrlRelease').html('');
                            $('#trafficCtrl').html('');
                            $('#taskLocking').html('');
                            $('#taskNull').html('');
                            $('#movingOrNot').html('');
                            $('#startUpOrAwait').html('');
                            $('#charging').html('');
                            $('#taskExecuting').html('');
                            $('#stopByObstacle').html('');
                            $('#pauseByMainCtrl').html('');
                            $('#agvStatus').html('<font color="red">车辆离线</font>');
                        }
                    },
                    error: function (e) {
                        console.log(e);
                    }
                })
            }, 3000);

        });

        function closableMessager(content, type) {
            var interval;
            var time = 1000;
            var x = 3;
            $.messager.alert(' ', content, type, function () {
            });
            $(".messager-window .window-header .panel-title").append("系统提示（" + x + "秒后自动关闭）");
            interval = setInterval(fun, time);

            function fun() {
                --x;
                if (x == 0) {
                    clearInterval(interval);
                    $(".messager-body").window('close');
                }
                $(".messager-window .window-header .panel-title").text("");
                $(".messager-window .window-header .panel-title").append("系统提示（" + x + "秒后自动关闭）");
            }
        }

        function getValueByBoolean(val) {
            return val ? '是' : '否';
        }

        function onloading() {
            $("<div class=\"datagrid-mask\"></div>").css({
                display: "block",
                width: "100%",
                height: $(window).height()
            }).appendTo("body");
            $("<div class=\"datagrid-mask-msg2\"></div>").html("正在启动车辆...").appendTo("body").css({
                display: "block",
                left: ($(document.body).outerWidth(true) - 190) / 2,
                top: ($(window).height() - 45) / 2
            });
        }

        function removeload() {
            $(".datagrid-mask").remove();
            $(".datagrid-mask-msg2").remove();
        }
    </script>
</head>

<body class="easyui-layout" scroll="no">

<noscript>
    <div style="position: absolute; z-index: 100000; height: 2046px; top: 0px; left: 0px;
            width: 100%; background: white; text-align: center;">
        <img src="images/noscript.gif"
             alt='<%=SpringUtils.getMessage("page.main.noscript")%>'/>
    </div>
</noscript>

<!-- 内容 -->
<div id="mainPanle" data-options="region:'center'"
     style="background: #eee; overflow-y: hidden">
    <div id="tabs" class="easyui-tabs" data-options="fit:true,border:false">
        <div id="home" title="无人智能运输车控制台"
             style="padding: 20px; overflow: hidden; text-align: center;">
            <div style="display: inline-block;">
                <div id="opPanel" class="easyui-panel" title="车辆操作"
                     style="width: 700px; height: 100px; padding: 10px; text-align: center;"
                     collapsible="false">
                    <a id="agvGo" href="#" class="easyui-linkbutton"
                       data-options="iconCls:'icon-redo',size:'large'">车辆出发</a>
                    <a id="agvRet" href="#" class="easyui-linkbutton"
                       data-options="iconCls:'icon-undo',size:'large'">车辆返回</a>
                </div>
                <div style="margin-bottom: 10px;"></div>
                <div id="stPanel" class="easyui-panel" title="车辆状态"
                     style="width: 700px; padding: 10px;" collapsible="false">
                    <table width="100%">
                        <tr>
                            <td colspan="4" align="center"><label id="agvStatus">车辆状态初始化中...</label>
                            </td>
                        </tr>
                        <tr>
                            <td width="20%">当前位置：</td>
                            <td align="left"><label id="currPosition"></label></td>
                            <td width="20%">当前速度：</td>
                            <td align="left"><label id="currSpeed"></label></td>
                        </tr>
                        <tr>
                            <td width="20%">剩余电量：</td>
                            <td align="left"><label id="batteryBalance"></label></td>
                            <td width="20%">故障代码：</td>
                            <td align="left"><label id="faultCode"></label></td>
                        </tr>
                    </table>
                </div>
                <div style="margin-bottom: 10px;"></div>
                <div id="runPanel" class="easyui-panel" title="行驶状态"
                     style="width: 700px; padding: 10px;" collapsible="false">
                    <table width="100%">
                        <tr>
                            <td width="20%">故障信息：</td>
                            <td align="left"><label id="faultInf"></label></td>
                            <td width="20%">失联状态：</td>
                            <td align="left"><label id="missingStat"></label></td>
                        </tr>
                        <tr>
                            <td width="20%">管制放行：</td>
                            <td align="left"><label id="ctrlRelease"></label></td>
                            <td width="20%">交通管制：</td>
                            <td align="left"><label id="trafficCtrl"></label></td>
                        </tr>
                        <tr>
                            <td width="20%">任务锁定：</td>
                            <td align="left"><label id="taskLocking"></label></td>
                            <td width="20%">任务空：</td>
                            <td align="left"><label id="taskNull"></label></td>
                        </tr>
                        <tr>
                            <td width="20%">运动/静止：</td>
                            <td align="left"><label id="movingOrNot"></label></td>
                            <td width="20%">启动/待机：</td>
                            <td align="left"><label id="startUpOrAwait"></label></td>
                        </tr>
                        <tr>
                            <td width="20%">正在充电：</td>
                            <td align="left"><label id="charging"></label></td>
                            <td width="20%">任务执行中：</td>
                            <td align="left"><label id="taskExecuting"></label></td>
                        </tr>
                        <tr>
                            <td width="20%">障碍停止：</td>
                            <td align="left"><label id="stopByObstacle"></label></td>
                            <td width="20%">主控暂停：</td>
                            <td align="left"><label id="pauseByMainCtrl"></label></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 页脚 -->
<div data-options="region:'south',split:true" style="height: 30px; background: #D2E0F2;">
    <div class="footer"
         style="text-align:center"><%=SpringUtils.getMessage("sya.main.footerInfo")%>
    </div>
</div>

</body>
</html>