<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete Product</title>
</head>
<body>
<h2>Confirm Delete Product</h2>

<p>Are you sure you want to delete this product?</p>

<form action="products?action=deleteConfirm" method="post">
    <input type="hidden" name="id" value="${param.id}"/>
    <input type="submit" value="Yes, Delete"/>
    <a href="products?action=list">Cancel</a>
</form>


</body>
</html>
