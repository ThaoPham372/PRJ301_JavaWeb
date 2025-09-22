<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách Users</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        a { margin: 0 5px; }
    </style>
</head>
<body>
    <h2 style="text-align:center">Danh sách Users</h2>
    <div style="text-align:center; margin-bottom:15px;">
        <a href="user?action=new">➕ Thêm User mới</a>
    </div>
    <table>
        <tr>
            <th>ID</th><th>Username</th><th>Email</th><th>Country</th>
            <th>Role</th><th>Status</th><th>Password</th><th>DOB</th><th>Action</th>
        </tr>
        <c:forEach var="u" items="${listUsers}">
            <tr>
                <td>${u.id}</td>
                <td>${u.username}</td>
                <td>${u.email}</td>
                <td>${u.country}</td>
                <td>${u.role}</td>
                <td><c:choose>
                    <c:when test="${u.status}">Active</c:when>
                    <c:otherwise>Inactive</c:otherwise>
                </c:choose></td>
                <td>${u.password}</td>
                <td>${u.dob}</td>
                <td>
                    <a href="user?action=edit&id=${u.id}">✏ Edit</a>
                    <a href="user?action=delete&id=${u.id}" 
                       onclick="return confirm('Xóa user này?')">❌ Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
