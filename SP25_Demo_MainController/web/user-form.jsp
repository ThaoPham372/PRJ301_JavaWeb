<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User Form</title>
</head>
<body>
    <h2 style="text-align:center">
        <c:if test="${user != null}">Cập nhật User</c:if>
        <c:if test="${user == null}">Thêm User mới</c:if>
    </h2>

    <form action="user" method="get" style="width:50%; margin:0 auto;">
        <c:if test="${user != null}">
            <input type="hidden" name="id" value="${user.id}" />
            <input type="hidden" name="action" value="update" />
        </c:if>
        <c:if test="${user == null}">
            <input type="hidden" name="action" value="insert" />
        </c:if>

        Username: <input type="text" name="username" value="${user.username}" required /><br/><br/>
        Email: <input type="email" name="email" value="${user.email}" required /><br/><br/>
        Country: <input type="text" name="country" value="${user.country}" /><br/><br/>
        Role: <input type="text" name="role" value="${user.role}" /><br/><br/>
        Status: <input type="checkbox" name="status" <c:if test="${user.status}">checked</c:if> /><br/><br/>
        Password: <input type="password" name="password" value="${user.password}" required /><br/><br/>
        DOB: <input type="date" name="dob" value="${user.dob}" /><br/><br/>

        <input type="submit" value="Save" />
        <a href="user?action=list">Cancel</a>
    </form>
</body>
</html>
