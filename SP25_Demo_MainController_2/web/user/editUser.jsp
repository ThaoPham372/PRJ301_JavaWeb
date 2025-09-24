<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Edit User</title></head>
<body>
<h2>Edit User</h2>
<form action="${pageContext.request.contextPath}/users" method="post">
    <input type="hidden" name="action" value="update"/>
    <input type="hidden" name="id" value="${user.id}"/>

    Username: <input type="text" name="username" value="${user.username}" required/><br/>
    Email: <input type="email" name="email" value="${user.email}" required/><br/>
    Country: <input type="text" name="country" value="${user.country}" required/><br/>
    Role: <input type="text" name="role" value="${user.role}" required/><br/>
    Status: <select name="status">
        <option value="true" ${user.status ? "selected" : ""}>Active</option>
        <option value="false" ${!user.status ? "selected" : ""}>Inactive</option>
    </select><br/>
    Password: <input type="password" name="password" value="${user.password}" required/><br/>
    DOB: <input type="text" name="dob" value="${user.dob}" placeholder="yyyy-mm-dd"/><br/>

    <input type="submit" value="Update"/>
    <a href="${pageContext.request.contextPath}/users?action=list">Cancel</a>
</form>
</body>
</html>
