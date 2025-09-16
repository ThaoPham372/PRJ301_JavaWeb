<%-- 
    Document   : createEmp
    Created on : Sep 10, 2025, 1:36:45 PM
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
        <h2>Create New Employee</h2>
    <form action="employees?action=create" method="post">
    ID: <input type="text" name="id"/><br/>
    Name: <input type="text" name="name"/><br/>
    Email: <input type="text" name="email"/><br/>
    Address: <input type="text" name="address"/><br/>
    <input type="submit" value="Save"/>
    </form>
    </body>
</html>
