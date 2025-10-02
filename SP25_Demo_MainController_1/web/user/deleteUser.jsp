<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 450px;
            margin: auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            text-align: center;
        }
        h2 {
            color: #dc3545;
            margin-bottom: 20px;
        }
        p {
            margin-bottom: 25px;
            font-size: 16px;
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
        }
        .btn-delete {
            background-color: #dc3545;
            color: #fff;
            border: none;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: #fff;
            border: none;
        }
        .btn-cancel:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Confirm Delete User</h2>

    <p>Are you sure you want to delete this user?</p>

    <form action="${pageContext.request.contextPath}/users?action=deleteConfirm" method="post">
        <input type="hidden" name="id" value="${param.id}"/>
        <input type="submit" value="🗑 Yes, Delete" class="btn btn-delete"/>
        <a href="${pageContext.request.contextPath}/users?action=list" class="btn btn-cancel">❌ Cancel</a>
    </form>
</div>
</body>
</html>
