<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@page import="com.educonsulting.mms.util.SpringUtils" %>
<%
    String base = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>
        <%=SpringUtils.getMessage("sys.error.page")%>
    </title>
    <link href="<%=base%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="<%=base%>/resources/ui/jquery.min.js"></script>
    <script type="text/javascript" src="<%=base%>/resources/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container-fluid" style="margin-top: 15px">
    <div class="alert alert-danger" role="alert">
        <%=SpringUtils.getMessage("sys.error.message")%>
        <a href="javascript:void(0);" class="alert-link"
           onclick="window.history.back(); return false;"><%=SpringUtils.getMessage("sys.error.back")%>
        </a>
    </div>
</div>
</body>
</html>