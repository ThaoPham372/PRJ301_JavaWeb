<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Create User</title></head>
<body>
<h2>Add New User</h2>
<form action="${pageContext.request.contextPath}/users" method="post">
    <input type="hidden" name="action" value="insert"/>

    Username: <input type="text" name="username" required/><br/>
    Email: <input type="email" name="email" required/><br/>
    Country: <input type="text" name="country" required/><br/>
    Role: <input type="text" name="role" required/><br/>
    Status: <select name="status">
        <option value="true">Active</option>
        <option value="false">Inactive</option>
    </select><br/>
    Password: <input type="password" name="password" required/><br/>
    DOB: <input type="text" name="dob" placeholder="yyyy-mm-dd"/><br/>

    <input type="submit" value="Save"/>
    <a href="${pageContext.request.contextPath}/users?action=list">Cancel</a>
</form>
</body>
</html>
