<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<div>
    <fieldset class="fieldset" style="width:1103px">
        <legend class="legend">
            逝者信息
        </legend>
        <table class="tab-border">
            <tr>
                <td style="width: 100px" class="title-bg">
                    业务编号
                </td>
                <td class="domain-bg">
                    <input type="hidden" id="id" name="id" value="">
                    <input class="easyui-textbox" id="serviceNo"
                           name="serviceNo" style="width:198px"
                           data-options="required:true,
                           missingMessage:'请填入服务编号',
                           validType:'serviceNo',
                           events:{blur:checkSerivceNo}">
                </td>
                <td style="width: 100px" class="title-bg">
                    姓名
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="name" name="name"
                           style="width:198px"
                           data-options="required:true,
                           missingMessage:'请填入逝者姓名',
                           validType:['chinese','length[2,5]']">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    性别
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="sex" name="sex"
                           style="width:198px"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/sex',
                                                method:'get',
                                                editable:false,
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto',
                                                required:true,
                                                missingMessage:'请选择逝者性别'">
                </td>
                <td style="width: 100px" class="title-bg">
                    年龄
                </td>
                <td class="domain-bg">
                    <input class="easyui-numberspinner" id="age" name="age"
                           style="width:198px"
                           data-options="required:true,panelHeight:'auto',min:0,max:150,missingMessage:'请填入逝者年龄',validType:'age'">
                </td>
            </tr>
        </table>
    </fieldset>
</div>

<div style="padding-top: 20px;">
    <fieldset class="fieldset" style="width:1103px">
        <legend class="legend">
            生平信息
        </legend>
        <table class="tab-border">
            <tr>
                <td style="width: 100px" class="title-bg">
                    开幕选项
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="beginStat" name="beginStat"
                           style="width:198px;" data-options="
                    url: '${pageContext.request.contextPath}/shelf/list',
                    editable: false,
                    method: 'get',
                    valueField: 'code',
                    textField: 'code',
                    panelHeight: 'auto',
                    required:true,
                    missingMessage:'请选择开幕选项'">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    闭幕选项
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="endStat" name="endStat"
                           style="width:198px;" data-options="
                    url: '${pageContext.request.contextPath}/shelf/list',
                    editable: false,
                    method: 'get',
                    valueField: 'code',
                    textField: 'code',
                    panelHeight: 'auto',
                    required:true,
                    missingMessage:'请选择闭幕选项'">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    主题
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="theme" name="theme"
                           style="width:198px;" data-options="
                    url: '${pageContext.request.contextPath}/shelf/list',
                    editable: false,
                    method: 'get',
                    valueField: 'code',
                    textField: 'code',
                    panelHeight: 'auto',
                    required:true,
                    missingMessage:'请选择主题'">
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第一页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act1" name="act1"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act1')">
                        开始拍照
                    </a>
                    <input id="act1_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act1', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act1')" alt="预览">
                        <img id="act1_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第二页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act2" name="act2"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act2')">
                        开始拍照
                    </a>
                    <input id="act2_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act2', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act2')" alt="预览">
                        <img id="act2_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第三页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act3" name="act3"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act3')">
                        开始拍照
                    </a>
                    <input id="act3_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act3', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act3')" alt="预览">
                        <img id="act3_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第四页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act4" name="act4"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act4')">
                        开始拍照
                    </a>
                    <input id="act4_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act4', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act4')" alt="预览">
                        <img id="act4_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第五页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act5" name="act5"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act5')">
                        开始拍照
                    </a>
                    <input id="act5_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act5', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act5')" alt="预览">
                        <img id="act5_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第六页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act6" name="act6"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act6')">
                        开始拍照
                    </a>
                    <input id="act6_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act6', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act6')" alt="预览">
                        <img id="act6_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第七页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act7" name="act7"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act7')">
                        开始拍照
                    </a>
                    <input id="act7_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act7', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act7')" alt="预览">
                        <img id="act7_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第八页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act8" name="act8"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act8')">
                        开始拍照
                    </a>
                    <input id="act8_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act8', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act8')" alt="预览">
                        <img id="act8_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第九页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act9" name="act9"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act9')">
                        开始拍照
                    </a>
                    <input id="act9_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act9', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act9')" alt="预览">
                        <img id="act9_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第十页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act10" name="act10"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act10')">
                        开始拍照
                    </a>
                    <input id="act10_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act10', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act10')" alt="预览">
                        <img id="act10_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第十一页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act11" name="act11"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act11')">
                        开始拍照
                    </a>
                    <input id="act11_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act11', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act11')" alt="预览">
                        <img id="act11_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第十二页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act12" name="act12"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act12')">
                        开始拍照
                    </a>
                    <input id="act12_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act12', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act12')" alt="预览">
                        <img id="act12_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第十三页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act13" name="act13"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act13')">
                        开始拍照
                    </a>
                    <input id="act13_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act13', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act13')" alt="预览">
                        <img id="act13_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第十四页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act14" name="act14"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act14')">
                        开始拍照
                    </a>
                    <input id="act14_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act14', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act14')" alt="预览">
                        <img id="act14_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第十五页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act15" name="act15"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act15')">
                        开始拍照
                    </a>
                    <input id="act15_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act15', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act15')" alt="预览">
                        <img id="act15_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第十六页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act16" name="act16"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act16')">
                        开始拍照
                    </a>
                    <input id="act16_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act16', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act16')" alt="预览">
                        <img id="act16_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第十七页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act17" name="act17"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act17')">
                        开始拍照
                    </a>
                    <input id="act17_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act17', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act17')" alt="预览">
                        <img id="act17_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第十八页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act18" name="act18"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act18')">
                        开始拍照
                    </a>
                    <input id="act18_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act18', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act18')" alt="预览">
                        <img id="act18_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第十九页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act19" name="act19"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act19')">
                        开始拍照
                    </a>
                    <input id="act19_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act19', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act19')" alt="预览">
                        <img id="act19_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第二十页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act20" name="act20"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act20')">
                        开始拍照
                    </a>
                    <input id="act20_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act20', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act20')" alt="预览">
                        <img id="act20_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第二十一页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act21" name="act21"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act21')">
                        开始拍照
                    </a>
                    <input id="act21_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act21', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act21')" alt="预览">
                        <img id="act21_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第二十二页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act22" name="act22"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act22')">
                        开始拍照
                    </a>
                    <input id="act22_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act22', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act22')" alt="预览">
                        <img id="act22_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第二十三页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act23" name="act23"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act23')">
                        开始拍照
                    </a>
                    <input id="act23_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act23', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act23')" alt="预览">
                        <img id="act23_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第二十四页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act24" name="act24"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act24')">
                        开始拍照
                    </a>
                    <input id="act24_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act24', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act24')" alt="预览">
                        <img id="act24_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第二十五页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act25" name="act25"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act25')">
                        开始拍照
                    </a>
                    <input id="act25_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act25', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act25')" alt="预览">
                        <img id="act25_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第二十六页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act26" name="act26"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act26')">
                        开始拍照
                    </a>
                    <input id="act26_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act26', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act26')" alt="预览">
                        <img id="act26_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第二十七页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act27" name="act27"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act27')">
                        开始拍照
                    </a>
                    <input id="act27_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act27', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act27')" alt="预览">
                        <img id="act27_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第二十八页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act28" name="act28"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act28')">
                        开始拍照
                    </a>
                    <input id="act28_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act28', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act28')" alt="预览">
                        <img id="act28_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第二十九页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act29" name="act29"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act29')">
                        开始拍照
                    </a>
                    <input id="act29_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act29', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act29')" alt="预览">
                        <img id="act29_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第三十页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act30" name="act30"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act30')">
                        开始拍照
                    </a>
                    <input id="act30_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act30', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act30')" alt="预览">
                        <img id="act30_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第三十一页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act31" name="act31"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act31')">
                        开始拍照
                    </a>
                    <input id="act31_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act31', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act31')" alt="预览">
                        <img id="act31_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第三十二页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act32" name="act32"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act32')">
                        开始拍照
                    </a>
                    <input id="act32_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act32', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act32')" alt="预览">
                        <img id="act32_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第三十三页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act33" name="act33"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act33')">
                        开始拍照
                    </a>
                    <input id="act33_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act33', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act33')" alt="预览">
                        <img id="act33_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第三十四页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act34" name="act34"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act34')">
                        开始拍照
                    </a>
                    <input id="act34_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act34', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act34')" alt="预览">
                        <img id="act34_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第三十五页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act35" name="act35"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act35')">
                        开始拍照
                    </a>
                    <input id="act35_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act35', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act35')" alt="预览">
                        <img id="act35_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第三十六页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act36" name="act36"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act36')">
                        开始拍照
                    </a>
                    <input id="act36_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act36', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act36')" alt="预览">
                        <img id="act36_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第三十七页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act37" name="act37"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act37')">
                        开始拍照
                    </a>
                    <input id="act37_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act37', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act37')" alt="预览">
                        <img id="act37_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第三十八页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act38" name="act38"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act38')">
                        开始拍照
                    </a>
                    <input id="act38_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act38', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act38')" alt="预览">
                        <img id="act38_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第三十九页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act39" name="act39"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act39')">
                        开始拍照
                    </a>
                    <input id="act39_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act39', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act39')" alt="预览">
                        <img id="act39_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第四十页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act40" name="act40"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act40')">
                        开始拍照
                    </a>
                    <input id="act40_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act40', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act40')" alt="预览">
                        <img id="act40_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第四十一页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act41" name="act41"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act41')">
                        开始拍照
                    </a>
                    <input id="act41_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act41', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act41')" alt="预览">
                        <img id="act41_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第四十二页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act42" name="act42"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act42')">
                        开始拍照
                    </a>
                    <input id="act42_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act42', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act42')" alt="预览">
                        <img id="act42_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第四十三页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act43" name="act43"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act43')">
                        开始拍照
                    </a>
                    <input id="act43_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act43', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act43')" alt="预览">
                        <img id="act43_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第四十四页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act44" name="act44"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act44')">
                        开始拍照
                    </a>
                    <input id="act44_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act44', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act44')" alt="预览">
                        <img id="act44_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第四十五页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act45" name="act45"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act45')">
                        开始拍照
                    </a>
                    <input id="act45_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act45', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act45')" alt="预览">
                        <img id="act45_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第四十六页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act46" name="act46"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act46')">
                        开始拍照
                    </a>
                    <input id="act46_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act46', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act46')" alt="预览">
                        <img id="act46_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第四十七页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act47" name="act47"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act47')">
                        开始拍照
                    </a>
                    <input id="act47_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act47', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act47')" alt="预览">
                        <img id="act47_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第四十八页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act48" name="act48"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act48')">
                        开始拍照
                    </a>
                    <input id="act48_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act48', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act48')" alt="预览">
                        <img id="act48_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第四十九页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act49" name="act49"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act49')">
                        开始拍照
                    </a>
                    <input id="act49_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act49', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act49')" alt="预览">
                        <img id="act49_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 100px" class="title-bg">
                    第五十页
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="act50" name="act50"
                           style="width:198px">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add"
                       onclick="openScanDialog('act50')">
                        开始拍照
                    </a>
                    <input id="act50_f" class="easyui-filebox" data-options="
    buttonText: '选择文件',onChange: function c(){change('act50', this)}" style="width:63px">
                    <a href="#" onclick="openPreviewDialog('act50')" alt="预览">
                        <img id="act50_img" src="" width="28px" height="21px">
                    </a>
                </td>
            </tr>
        </table>
    </fieldset>
</div>

<div id="scandlg" class="easyui-dialog" closed="false" modal="true"
     buttons="#scandlg-buttons" style="width:614px;height:485px">
    <div>
        <object id="view1" type="application/x-eloamplugin" width="600px"
                height="400px"
                name="view"></object>
        <%--<div style="clear:both"></div>--%>
    </div>
    <div id="scandlg-buttons" style="text-align:center;">
        <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="scan()">
            拍照
        </a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="closeScanDialog()">
            取消
        </a>
    </div>
</div>

<div id="previewdlg" class="easyui-dialog" closed="true" modal="true"
     buttons="#viewdlg-buttons" style="width:614px;height:485px">
    <div>
        <img id="reviewimg" src="" width="600px" height="400px"/>
    </div>
    <div id="viewdlg-buttons" style="text-align:center;">
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="closePreviewDialog()">
            关闭
        </a>
    </div>
</div>