<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f8f9fa;
        }
        h2 {
            margin: 20px auto;
            padding: 12px 20px;
            text-align: center;
            color: #007bff;
            font-size: 28px;
            font-weight: bold;
            border: 2px solid #007bff;
            border-radius: 8px;
            background-color: #e9f2ff;
            width: fit-content;
            box-shadow: 0 0 6px rgba(0,0,0,0.1);
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background: #fff;
            margin-top: 15px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        a {
            text-decoration: none;
            margin: 0 5px;
        }
        .actions a {
            padding: 6px 10px;
            border-radius: 4px;
            font-size: 13px;
        }
        .edit {
            background: #ffc107;
            color: #000;
        }
        .edit:hover {
            background: #e0a800;
        }
        .delete {
            background: #dc3545;
            color: #fff;
        }
        .delete:hover {
            background: #c82333;
        }
        .add {
            display: inline-block;
            background: #28a745;
            color: #fff;
            padding: 8px 14px;
            border-radius: 4px;
            font-weight: bold;
        }
        .add:hover {
            background: #218838;
        }
        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        .muted {
            color: #666;
        }
        .pagination {
            margin-top: 15px;
            text-align: center;
        }
        .pagination a {
            margin: 0 4px;
            padding: 6px 10px;
            border: 1px solid #ddd;
            border-radius: 3px;
            text-decoration: none;
            color: #007bff;
        }
        .pagination a.active {
            background: #007bff;
            color: #fff;
        }
    </style>
</head>
<body>

<div class="topbar">
    <h2>Product Management</h2>
    <div>
        Hello, <b>${sessionScope.user.username}</b> 
        (<span style="color:blue">${sessionScope.user.role}</span>) |
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>
</div>


<a href="${pageContext.request.contextPath}/products?action=new" class="add">➕ Add New Product</a>

<c:choose>
    <c:when test="${empty listProduct}">
        <p class="muted">No products to display.</p>
    </c:when>
    <c:otherwise>
        <table>
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
                    <td><fmt:formatNumber value="${product.price}" pattern="#,##0.00" /></td>
                    <td>${product.description}</td>
                    <td>${product.stock}</td>
                    <td><fmt:formatDate value="${product.importDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td class="actions">
                        <a href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}" class="edit">✏️ Edit</a>
                        <a href="${pageContext.request.contextPath}/products?action=delete&id=${product.id}"
                           class="delete"
                           onclick="return confirm('Are you sure you want to delete this product?');">🗑 Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise>
</c:choose>

<c:if test="${not empty totalPages}">
    <div class="pagination">
        <c:forEach begin="1" end="${totalPages}" var="i">
            <a href="${pageContext.request.contextPath}/products?action=list&page=${i}"
               class="${i == currentPage ? 'active' : ''}">${i}</a>
        </c:forEach>
    </div>
</c:if>

</body>
</html>
