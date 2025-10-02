<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 500px;
            margin: auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #007bff;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin: 10px 0 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="password"], select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .actions {
            margin-top: 20px;
            text-align: center;
        }
        .btn {
            display: inline-block;
            padding: 10px 18px;
            font-size: 14px;
            font-weight: bold;
            border-radius: 5px;
            text-decoration: none;
            margin: 0 8px;
            cursor: pointer;
            border: none;
        }
        .btn-save {
            background-color: #28a745;
            color: white;
        }
        .btn-save:hover {
            background-color: #218838;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
        }
        .btn-cancel:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Add New User</h2>
    <form action="${pageContext.request.contextPath}/users" method="post">
        <input type="hidden" name="action" value="insert"/>

        <label>Username:</label>
        <input type="text" name="username" required/>

        <label>Email:</label>
        <input type="email" name="email" required/>

        <label>Country:</label>
        <input type="text" name="country" required/>

        <label>Role:</label>
        <input type="text" name="role" required/>

        <label>Status:</label>
        <select name="status">
            <option value="true">Active</option>
            <option value="false">Inactive</option>
        </select>

        <label>Password:</label>
        <input type="password" name="password" required/>

        <label>Date of Birth:</label>
        <input type="text" name="dob" placeholder="yyyy-mm-dd"/>

        <div class="actions">
            <input type="submit" value="💾 Save" class="btn btn-save"/>
            <a href="${pageContext.request.contextPath}/users?action=list" class="btn btn-cancel">❌ Cancel</a>
        </div>
    </form>
</div>
</body>
</html>
