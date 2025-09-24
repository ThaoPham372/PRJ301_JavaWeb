<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>User List</title></head>
<body>
<h2>User Management</h2>

<!-- Search form -->
<form action="${pageContext.request.contextPath}/users" method="get">
    <input type="hidden" name="action" value="search"/>
    <input type="text" name="keyword" placeholder="Search..."/>
    <input type="submit" value="Search"/>
</form>
<br/>

<a href="${pageContext.request.contextPath}/users?action=new">➕ Add New User</a>
<br/><br/>

<table border="1" cellpadding="6" cellspacing="0">
    <tr>
        <th>ID</th><th>Username</th><th>Email</th><th>Country</th>
        <th>Role</th><th>Status</th><th>DOB</th><th>Actions</th>
    </tr>
    <c:forEach var="user" items="${listUser}">
        <tr>
            <td>${user.id}</td>
            <td>${user.username}</td>
            <td>${user.email}</td>
            <td>${user.country}</td>
            <td>${user.role}</td>
            <td><c:out value="${user.status ? 'Active' : 'Inactive'}"/></td>
            <td>${user.dob}</td>
            <td>
                <a href="${pageContext.request.contextPath}/users?action=edit&id=${user.id}">✏️ Edit</a> |
                <a href="${pageContext.request.contextPath}/users?action=delete&id=${user.id}"
                   onclick="return confirm('Deactivate this user?');">🗑 Deactivate</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
