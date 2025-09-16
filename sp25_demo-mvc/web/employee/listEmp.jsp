<%-- 
    Document   : listEmp
    Created on : Sep 10, 2025, 1:37:19 PM
    Author     : thaopham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employee CRUD</title>
    </head>
    <body>
       <h2>Employee List</h2>
    <a href="employees?action=create">Add New Employee</a>
    <table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th><th>Name</th><th>Email</th><th>Address</th><th>Actions</th>
    </tr>
    <c:forEach var="emp" items="${employees}">
        <tr>
            <td>${emp.id}</td>
            <td>${emp.name}</td>
            <td>${emp.email}</td>
            <td>${emp.address}</td>
            <td>
                <a href="employees?action=edit&id=${emp.id}">Edit</a>
                <a href="employees?action=delete&id=${emp.id}">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
    </body>
</html>
