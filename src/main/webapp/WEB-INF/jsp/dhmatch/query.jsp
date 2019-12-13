<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<div>
    <div class="subtitle" style="border-bottom:1px solid #ccc">
        <%=SpringUtils.getMessage("page.common.inputParams")%>
    </div>
    <div style="padding:10px 0 10px 30px">
        <table cellpadding="5" class="tab-form">
            <tr>
                <td style="width:90px" class="title-bg">
                    RFID编号
                </td>
                <td style="width:180px" class="domain-bg">
                    <input class="easyui-textbox" id="serviceNo2" name="serviceNo2"></td>
            </tr>
            <tr>
                <td class="title-bg">
                    逝者姓名
                </td>
                <td class="domain-bg"><input class="easyui-textbox" id="dpName"
                                             name="dpName">
                </td>
            </tr>
            <tr>
                <td align="right" colspan="4">
                    <a
                            id="readRfid"
                            href="#"
                            class="easyui-linkbutton"
                            data-options="iconCls:'icon-man'"
                            style="width:135px;margin-top:2px;"
                    >读取RFID编号</a>
                </td>
            </tr>
        </table>
    </div>
</div>
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
<script>

    $(function () {
        var txtbox = $("#serviceNo2");

        $("#readRfid").bind("click", function () {
            var port = "4"; // 串口
            var baud = "5"; // 波特率
            var opened = TUHFReader09.Open(port, baud);
            if (opened == "00") {
                console.log("RFID设备连接成功");
                var SnEPC = TUHFReader09.Inventory();
                // 查询电子标签
                if (SnEPC == "") {
                    $.messager.alert(
                        title,
                        "未询查到电子标签",
                        error
                    );
                } else {
                    console.log("询查到电子标签");
                    $("#serviceNo").textbox("setValue", "");
                    var EPC_Len = parseInt(SnEPC.substr(0, 2), 16);
                    var EPC = SnEPC.substr(2, EPC_Len * 2); // EPC号码
                    var TID = TUHFReader09.Read(EPC, 2, 4, 2); // 读取TID
                    console.log("EPC:" + EPC);
                    console.log("TID:" + TID);
                    txtbox.textbox("setValue", TID);
                    // $("#serviceNo").textbox("setValue", TID);
                }
            } else if (opened == "35") {
                console.log("RFID设备已连接");
            } else {
                $.messager.alert(title, "RFID设备连接失败", error);
            }

            var closed = TUHFReader09.Close();
            if (closed == "00") {
                console.log("RFID设备关闭成功");
            } else {
                console.log("RFID设备关闭失败");
            }
        });
    });
</script>

	