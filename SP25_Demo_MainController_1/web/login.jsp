<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h2>Login</h2>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/login">
    <label>Username: </label>
    <input type="text" name="username" value="${rememberedUser}"/><br/><br/>

    <label>Password: </label>
    <input type="password" name="password" value="${rememberedPass}"/><br/><br/>

    <input type="checkbox" name="remember" 
           <c:if test="${not empty rememberedUser}"></c:if> Remember me <br/><br/>

    <input type="submit" value="Login"/>
</form>
</body>
</html>
