<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%
    String base = request.getContextPath();
%>
<link rel="stylesheet" type="text/css"
      href="<%=base%>/resources/ui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
      href="<%=base%>/resources/ui/themes/icon.css">
<link rel="stylesheet" type="text/css"
      href="<%=base%>/resources/css/icon-extension.css">
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
        height: 30px;
        font-size: 12px;
        border: solid #C0C0C0 1px;
        background-color: #F1F6FF;
        padding-right: 10px;
        text-align: right;
    }

    .domain-bg {
        height: 30px;
        font-size: 12px;
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
        src="<%=base%>/resources/ui/jquery.min.js"></script>
<script type="text/javascript"
        src="<%=base%>/resources/ui/jquery.easyui.min.js"></script>
<script type="text/javascript"
        src="<%=base%>/resources/ui/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript" src="<%=base%>/resources/js/json2.js"></script>
<script type="text/javascript" src="<%=base%>/resources/js/query.string.js"></script>
<script type="text/javascript" src="<%=base%>/resources/js/common.js"></script>
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
</script>