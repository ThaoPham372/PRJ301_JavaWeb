<%-- 
    Document   : editEmp
    Created on : Sep 10, 2025, 1:37:05 PM
    Author     : thaopham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Edit Employee</h2>
    <form action="employees?action=edit" method="post">
    <input type="hidden" name="id" value="${emp.id}"/>
    Name: <input type="text" name="name" value="${emp.name}"/><br/>
    Email: <input type="text" name="email" value="${emp.email}"/><br/>
    Address: <input type="text" name="address" value="${emp.address}"/><br/>
    <input type="submit" value="Update"/>
    </form>
    </body>
</html>
