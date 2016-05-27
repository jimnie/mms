<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../common/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=SpringUtils.getMessage("sys.main.projectName")%>
</title>
<link rel="stylesheet" type="text/css"
      href="${pageContext.request.contextPath}/resources/css/index.css">
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
    });
</script>
<script type="text/javascript">
    var _types = {};
    $.getJSON(base + '/dict/findDict/rechargeType', function (json) {
        _types = json;
    });

    function typeFormatter(value) {
        for (var i = 0; i < _types.length; i++) {
            if (_types[i].value == value) {
                return _types[i].name;
            }
        }
        return value;
    }

    function cellStyler(value, row, index) {
        if (value < 0) {
            return 'background-color:#ffee00;color:red;font-weight:bold;';
        }
    }

    function typeCellStyler(value, row, index) {
        if (value == 'hedging') {
            return 'background-color:#ffee00;color:red;font-weight:bold;';
        }
    }

    function advanceQuery() {
        showQueryDialog({
            width: 350,
            height: 300,
            form: base + '/rechargelog/query',
            callback: function (data) {
                $('#rechargelogs').datagrid('loadData', {total: 0, rows: []});
                $('#rechargelogs').datagrid('load', data);
            }
        });
    }
</script>