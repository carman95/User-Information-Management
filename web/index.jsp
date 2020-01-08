<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>首页</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</head>
<body>
<div>${sessionScope.loginUser.username},欢迎您</div>
<div align="center">
    <a href="${pageContext.request.contextPath}/findUserByPageServlet" style="text-decoration: none;font-size: 33px">
        查询所有用户信息
    </a>
</div>
</body>
</html>
