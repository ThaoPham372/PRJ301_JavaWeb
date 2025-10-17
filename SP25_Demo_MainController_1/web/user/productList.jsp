<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .cart-link {
            position: relative;
            text-decoration: none;
            color: #1976d2;
            padding: 10px 20px;
            border-radius: 4px;
            background-color: #e3f2fd;
            transition: background-color 0.3s;
        }
        .cart-link:hover {
            background-color: #bbdefb;
        }
        .cart-count {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #ff4081;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
        }
        .products-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px 0;
        }
        .product-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s;
        }
        .product-card:hover {
            transform: translateY(-5px);
        }
        .product-name {
            font-size: 1.1em;
            margin: 10px 0;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .product-price {
            color: #1976d2;
            font-weight: bold;
            font-size: 1.2em;
            margin: 15px 0;
        }
        .quantity-input {
            width: 60px;
            padding: 8px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-align: center;
        }
        .add-to-cart {
            background-color: #1976d2;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }
        .add-to-cart:hover {
            background-color: #1565c0;
        }
        .btn {
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="user-info">
            <h2>Welcome, ${sessionScope.user.username}!</h2>
            <a href="${pageContext.request.contextPath}/carts" class="cart-link">
                Cart
                <c:if test="${not empty sessionScope.cart.items}">
                    <span class="cart-count">${sessionScope.cart.items.size()}</span>
                </c:if>
            </a>
            <a href="${pageContext.request.contextPath}/orders" class="btn">My Orders</a>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Logout</a>
    </div>

    <div class="products-container">
        <c:forEach var="product" items="${productList}">
            <div class="product-card">
                <h3 class="product-name">${product.name}</h3>
                <p class="product-price">$${product.price}</p>
                <form action="${pageContext.request.contextPath}/carts" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productId" value="${product.id}">
                    <input type="number" name="quantity" value="1" min="1" class="quantity-input">
                    <button type="submit" class="add-to-cart">Add to Cart</button>
                </form>
            </div>
        </c:forEach>
    </div>
</body>
</html>