<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Product Management</title>
</head>
<body>
<h2>Product Management</h2>

<a href="products?action=new">➕ Add New Product</a>
<br/><br/>

<table border="1" cellspacing="0" cellpadding="5">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Price</th>
        <th>Description</th>
        <th>Stock</th>
        <th>Import Date</th>
        <th>Actions</th>
    </tr>

    <c:forEach var="product" items="${listProduct}">
        <tr>
            <td>${product.id}</td>
            <td>${product.name}</td>
            <td>${product.price}</td>
            <td>${product.description}</td>
            <td>${product.stock}</td>
            <td>${product.importDate}</td>
            <td>
                <a href="products?action=edit&id=${product.id}">✏️ Edit</a> |
                <a href="products?action=delete&id=${product.id}" 
                   onclick="return confirm('Are you sure to delete this product?');">🗑 Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

<c:if test="${not empty totalPages}">
    <div style="margin-top: 15px;">
        <c:forEach begin="1" end="${totalPages}" var="i">
            <a href="products?action=list&page=${i}">${i}</a>
            &nbsp;
        </c:forEach>
    </div>
</c:if>

</body>
</html>
