<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户信息管理系统</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        function deleteUser (id) {
            if(confirm("您确定要删除吗？")){
                location.href="${pageContext.request.contextPath}/delUserServlet?id="+id;
            }
        }
        window.onload=function () {
            document.getElementById("delSelected").onclick=function () {
                if(confirm("您确定要删除选中项吗？")) {
                    var cbs=document.getElementsByName("uid");
                    var flag=false;
                    for(var i=0; i<cbs.length; i++){
                        if(cbs[i].checked){
                            flag=true;
                            break;
                        }
                    }
                    if(flag){
                        document.getElementById("form").submit();
                    }
                }
            }
            document.getElementById("firstCb").onclick=function () {
                var cbs=document.getElementsByName("uid");
                for(var i=0; i<cbs.length; i++){
                    cbs[i].checked=this.checked;
                }
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h3 style="text-align: center">用户信息列表</h3>
    <div style="float: left;">
        <form class="form-inline" action="${pageContext.request.contextPath}/findUserByPageServlet" method="post">
            <div class="form-group">
                <label for="exampleInputName2">姓名</label>
                <input type="text" name="name" value="${condition.name[0]}" class="form-control" id="exampleInputName2" >
            </div>
            <div class="form-group">
                <label for="exampleInputName3">籍贯</label>
                <input type="text" name="address" value="${condition.address[0]}" class="form-control" id="exampleInputName3" >
            </div>

            <div class="form-group">
                <label for="exampleInputEmail2">邮箱</label>
                <input type="text" name="email" value="${condition.email[0]}" class="form-control" id="exampleInputEmail2"  >
            </div>
            <button type="submit" class="btn btn-default">查询</button>
        </form>
    </div>

    <div style="float: right;margin: 5px;">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/add.jsp">添加联系人</a>
        <a class="btn btn-primary" href="javascript:void(0);" id="delSelected">删除选中</a>
    </div>

    <form id="form" action="${pageContext.request.contextPath}/delSelectedServlet" method="post">
<%--        用这个表单包裹表格，主要是因为获取那些checkbox勾选的状态比较方便，当提交这个表单时会把name=value提交--%>
        <table border="1" class="table table-bordered table-hover">
            <tr class="success">
                <th><input type="checkbox" id="firstCb"></th>
                <th>编号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>年龄</th>
                <th>籍贯</th>
                <th>QQ</th>
                <th>邮箱</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${requestScope.pb.list}" var="user" varStatus="s">
                <tr>
                    <td><input type="checkbox" name="uid" value="${user.id}"></td>
                    <td>${s.count}</td>
                    <td>${user.name}</td>
                    <td>${user.gender}</td>
                    <td>${user.age}</td>
                    <td>${user.address}</td>
                    <td>${user.qq}</td>
                    <td>${user.email}</td>
                    <td><a class="btn btn-default btn-sm" href="${pageContext.request.contextPath}/findUserServlet?id=${user.id}">修改</a>&nbsp;
                        <a class="btn btn-default btn-sm" href="javascript:deleteUser(${user.id});">删除</a></td>
                </tr>
            </c:forEach>
        </table>
    </form>

    <div>
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <c:if test="${pb.currentPage == 1}">
                    <li class="disabled">
                </c:if>
                <c:if test="${pb.currentPage != 1}">
                    <li>
                </c:if>
                    <a href="${pageContext.request.contextPath}/findUserByPageServlet?currentPage=${pb.currentPage - 1}&rows=5&name=${condition.name[0]}&address=${condition.address[0]}&email=${condition.email[0]}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>

                <c:forEach begin="1" end="${pb.totalPage}" var="i" >
                    <c:if test="${pb.currentPage == i}">
                        <li class="active"><a href="${pageContext.request.contextPath}/findUserByPageServlet?currentPage=${i}&rows=5&name=${condition.name[0]}&address=${condition.address[0]}&email=${condition.email[0]}">${i}</a></li>
                    </c:if>
                    <c:if test="${pb.currentPage != i}">
                        <li><a href="${pageContext.request.contextPath}/findUserByPageServlet?currentPage=${i}&rows=5&name=${condition.name[0]}&address=${condition.address[0]}&email=${condition.email[0]}">${i}</a></li>
                    </c:if>
                </c:forEach>

                <c:if test="${pb.currentPage==pb.totalPage}">
                    <li class="disabled">
                </c:if>
                <c:if test="${pb.currentPage!=pb.totalPage}">
                    <li>
                </c:if>
                    <a href="${pageContext.request.contextPath}/findUserByPageServlet?currentPage=${pb.currentPage + 1}&rows=5&name=${condition.name[0]}&address=${condition.address[0]}&email=${condition.email[0]}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                <span style="font-size: 25px;margin-left: 5px;">
                    共${pb.totalCount}条记录，共${pb.totalPage}页
                </span>
            </ul>
        </nav>
    </div>

</div>
</body>
</html>
