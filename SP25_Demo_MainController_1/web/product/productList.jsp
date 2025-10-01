<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Product Management</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h2 { margin-bottom: 20px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        a { text-decoration: none; margin: 0 5px; }
        .actions a { padding: 4px 8px; border-radius: 4px; }
        .edit { background: #ffc107; color: #000; }
        .delete { background: #dc3545; color: #fff; }
        .add { background: #28a745; color: #fff; padding: 6px 12px; border-radius: 4px; }
        .topbar { display:flex; justify-content:space-between; align-items:center; margin-bottom: 12px; }
        .pagination { margin-top: 15px; text-align: center; }
        .pagination a { margin: 0 4px; padding: 4px 8px; border: 1px solid #ddd; border-radius: 3px; }
        .pagination a.active { background: #007bff; color: #fff; }
        .muted { color:#666; }
    </style>
</head>
<body>

<div class="topbar">
    <h2>Product Management</h2>

    <div>
        <span class="muted">Xin chào, <b>${sessionScope.user != null ? sessionScope.user.username : 'Guest'}</b></span>
        |
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>
</div>

<!-- Nút thêm mới -->
<a href="${pageContext.request.contextPath}/products?action=new" class="add">➕ Add New Product</a>
<br/><br/>

<!-- Bảng sản phẩm -->
<c:choose>
    <c:when test="${empty listProduct}">
        <p class="muted">Không có sản phẩm nào để hiển thị.</p>
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
                    <td>
                        <fmt:formatNumber value="${product.price}" pattern="#,##0.00" />
                    </td>
                    <td>${product.description}</td>
                    <td>${product.stock}</td>
                    <td>
                        <fmt:formatDate value="${product.importDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td class="actions">
                        <a href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}" class="edit">✏️ Edit</a>
                        <a href="${pageContext.request.contextPath}/products?action=delete&id=${product.id}"
                           class="delete"
                           onclick="return confirm('Are you sure to delete this product?');">🗑 Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise>
</c:choose>

<!-- Phân trang -->
<c:if test="${not empty totalPages}">
    <div class="pagination">
        <c:forEach begin="1" end="${totalPages}" var="i">
            <a href="${pageContext.request.contextPath}/products?action=list&page=${i}"
               class="${i == currentPage ? 'active' : ''}">
                ${i}
            </a>
        </c:forEach>
    </div>
</c:if>

</body>
</html>
