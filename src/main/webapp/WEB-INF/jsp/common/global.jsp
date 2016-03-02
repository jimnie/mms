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
</script>