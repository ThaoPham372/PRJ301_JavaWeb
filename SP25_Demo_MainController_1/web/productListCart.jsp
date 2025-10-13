<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="productDao.ProductDao" %>
<%@ page import="java.util.List" %>

<jsp:useBean id="productDAO" class="productDao.ProductDao" scope="page"/>
<jsp:useBean id="products" class="java.util.ArrayList" scope="request"/>

<%
    request.setAttribute("products", productDAO.selectAllProducts());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Sản Phẩm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }
        .cart-link {
            position: absolute;
            right: 20px;
            top: 10px;
            background-color: #007bff;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .cart-link:hover {
            background-color: #0056b3;
        }
        .products-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .product {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            width: 250px;
            text-align: center;
            transition: transform 0.3s;
        }
        .product:hover {
            transform: translateY(-5px);
        }
        .product h3 {
            margin: 10px 0;
            color: #333;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .product p {
            color: #28a745;
            font-weight: bold;
            font-size: 1.1em;
            margin: 15px 0;
        }
        .add-to-cart {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }
        .add-to-cart:hover {
            background-color: #218838;
        }
        .quantity-input {
            width: 60px;
            padding: 5px;
            margin: 10px 0;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h2>Danh Sách Sản Phẩm</h2>
        <a href="${pageContext.request.contextPath}/carts" class="cart-link">
            Xem Giỏ Hàng
        </a>
    </div>
    
    <div class="products-container">
        <c:forEach var="product" items="${products}">
            <div class="product">
                <h3>${product.name}</h3>
                <p>Giá: ${product.price} VND</p>
                <form action="${pageContext.request.contextPath}/carts" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productId" value="${product.id}">
                    <input type="number" name="quantity" value="1" min="1" class="quantity-input">
                    <button type="submit" class="add-to-cart">Thêm vào Giỏ</button>
                </form>
            </div>
        </c:forEach>
    </div>
</body>
</html>