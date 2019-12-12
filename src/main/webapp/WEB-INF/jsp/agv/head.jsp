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

    });
</script>

