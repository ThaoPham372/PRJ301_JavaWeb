<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-box {
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
            color: #007bff;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .remember {
            text-align: left;
            margin-bottom: 15px;
            font-size: 14px;
        }
        .btn {
            background: #007bff;
            color: #fff;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 15px;
        }
        .btn:hover {
            background: #0056b3;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="login-box">
    <h2>Login</h2>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/login">
        <div class="form-group">
            <label>Username:</label>
            <input type="text" name="username" value="${rememberedUser}" required/>
        </div>

        <div class="form-group">
            <label>Password:</label>
            <input type="password" name="password" value="${rememberedPass}" required/>
        </div>

        <div class="remember">
            <input type="checkbox" name="remember"
                   <c:if test="${not empty rememberedUser}">checked</c:if> />
            Remember me
        </div>

        <button type="submit" class="btn">Login</button>
    </form>
</div>
</body>
</html>
