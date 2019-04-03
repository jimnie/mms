<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    String base = request.getContextPath();
%>
<link rel="stylesheet" type="text/css"
      href="<%=base%>/ui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
      href="<%=base%>/ui/themes/icon.css">
<link rel="stylesheet" type="text/css"
      href="<%=base%>/css/icon-extension.css">
<style type="text/css">
    .title {
        border: solid #C0C0C0 1px;
        background-color: #F1F6FF;
        padding-left: 10px;
    }

    .domain {
        border: solid #C0C0C0 1px;
        background-color: #FAFCFF;
        padding-left: 10px;
    }

    .tab-form {
        border-collapse: collapse;
        border: none;
        padding-top: 10px;
        vertical-align: middle;
    }

    .title-bg {
        height: 40px;
        font-size: 14px;
        border: solid #C0C0C0 1px;
        background-color: #F1F6FF;
        padding-right: 10px;
        text-align: right;
    }

    .domain-bg {
        height: 40px;
        font-size: 14px;
        border: solid #C0C0C0 1px;
        background-color: #FAFCFF;
        padding-left: 10px;
    }

    .tab-border {
        width: 1080px;
        border-collapse: collapse;
        border: none;
        padding-top: 10px;
        vertical-align: middle;
    }

    .fieldset {
        width: 300px;
        border: 1px solid grey;
    }

    .legend {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 14px;
        font-weight: bold;
    }
</style>

<script type="text/javascript"
        src="<%=base%>/ui/jquery.min.js"></script>
<script type="text/javascript"
        src="<%=base%>/ui/jquery.easyui.min.js"></script>
<script type="text/javascript"
        src="<%=base%>/ui/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript" src="<%=base%>/js/json2.js"></script>
<script type="text/javascript" src="<%=base%>/js/query.string.js"></script>
<script type="text/javascript" src="<%=base%>/js/common.js"></script>
<script type="text/javascript">
    var base = '<%=base%>';
    var title = '<%=SpringUtils.getMessage("page.messager.title")%>';
    var info = '<%=SpringUtils.getMessage("page.messager.info")%>';
    var error = '<%=SpringUtils.getMessage("page.messager.error")%>';
    var warning = '<%=SpringUtils.getMessage("page.messager.warning")%>';
    var question = '<%=SpringUtils.getMessage("page.messager.question")%>';
    var advencedQuery = '<%=SpringUtils.getMessage("page.common.advencedQuery")%>'
    var query = '<%=SpringUtils.getMessage("page.common.query")%>'
    var cancel = '<%=SpringUtils.getMessage("page.common.cancel")%>'
    var reset = '<%=SpringUtils.getMessage("page.common.reset")%>'
    var parentid = '00000000000000000000000000000000';
    $(function () {

        $.extend($.fn.validatebox.defaults.rules, {
            // 移动手机号码验证
            mobile: {//value值为文本框中的值
                validator: function (value) {
                    var reg = /^1[3|4|5|7|8|9]\d{9}$/;
                    var reg2 = /^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
                    if (reg.test(value) || reg2.test(value)) {
                        return true;
                    } else {
                        return false;
                    }
                },
                message: '联系电话格式不正确'
            },
            // 中文输入验证
            chinese: {
                validator: function (value) {
                    var reg = /^[\u4e00-\u9fa5]+$/i;
                    return reg.test(value);
                },
                message: "请填入中文"
            },
            // 验证年龄
            age: {
                validator: function (value) {
                    return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value);
                },
                message: '年龄必须是0到120之间的整数'
            },
            // 验证服务编号
            serviceNo: {
                validator: function (value) {
                    var reg = /^((([0-9]{2})(0[48]|[2468][048]|[13579][26]))|((0[48]|[2468][048]|[13579][26])00)0229)|([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))\d{3}$/;
                    return reg.test(value);
                },
                message: '服务编号正确格式：年月日+3位数字，如：YYYYMMDDNNN'
            },
            // 验证字符长度
            length: {
                validator: function (value, param) {
                    var len = $.trim(value).length;
                    return len >= param[0] && len <= param[1];
                },
                message: '字符长度必须介于{0}和{1}之间'
            },
            // 验证存放位置
            position: {
                validator: function (value) {
                    var reg = /^\d{1,3}$/;
                    return reg.test(value);
                },
                message: '请输入1至3位的数字'
            },
            // 身份证号验证
            certNo: {
                validator: function (value) {
                    var reg = /^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
                    return reg.test(value);
                },
                message: '身份证号码格式不正确'
            },
            certNoLen: {
                validator: function (value, param) {
                    var len = $.trim(value).length;
                    return len <= param[0];
                },
                message: '证件号码字符长度必须小于{0}'
            }
        });

    });
</script>