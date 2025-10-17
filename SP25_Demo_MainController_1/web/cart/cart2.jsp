<%@ page contentType="text/html;charset=UTF-8" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
  <head>
    <title>Shopping Cart</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
        padding: 0;
        background-color: #f5f5f5;
      }
      .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding: 15px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
      .user-info {
        display: flex;
        align-items: center;
        gap: 20px;
      }
      .welcome-message {
        font-size: 1.2em;
        color: #333;
      }
      .logout-btn {
        background-color: #dc3545;
        color: white;
        padding: 8px 15px;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s;
      }
      .logout-btn:hover {
        background-color: #c82333;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
      th,
      td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: center;
      }
      th {
        background-color: #f8f9fa;
        font-weight: bold;
      }
      .quantity-input {
        width: 60px;
        padding: 5px;
        text-align: center;
        border: 1px solid #ddd;
        border-radius: 4px;
      }
      .btn {
        padding: 6px 12px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin: 0 5px;
        transition: background-color 0.3s;
      }
      .update-btn {
        background-color: #28a745;
        color: white;
      }
      .update-btn:hover {
        background-color: #218838;
      }
      .remove-btn {
        background-color: #dc3545;
        color: white;
      }
      .remove-btn:hover {
        background-color: #c82333;
      }
      .button-container {
        text-align: center;
        margin-top: 20px;
      }
      .action-button {
        display: inline-block;
        padding: 10px 20px;
        margin: 0 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        text-decoration: none;
        transition: background-color 0.3s;
      }
      .continue-btn {
        background-color: #6c757d;
        color: white;
      }
      .continue-btn:hover {
        background-color: #5a6268;
      }
      .checkout-btn {
        background-color: #28a745;
        color: white;
      }
      .checkout-btn:hover {
        background-color: #218838;
      }
      .empty-cart {
        text-align: center;
        padding: 40px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
    </style>
  </head>
  <body>
    <div class="header">
      <div class="user-info">
        <span class="welcome-message"
          >Welcome, ${sessionScope.user.username}!</span
        >
      </div>
      <a href="${pageContext.request.contextPath}/logout" class="logout-btn"
        >Logout</a
      >
    </div>

    <h2>Shopping Cart</h2>

    <c:choose>
      <c:when test="${empty cart.items}">
        <div class="empty-cart">
          <p>Your cart is empty</p>
          <div class="button-container">
            <a
              href="${pageContext.request.contextPath}/carts"
              class="action-button continue-btn"
            >
              Continue Shopping
            </a>
          </div>
        </div>
      </c:when>
      <c:otherwise>
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Price</th>
              <th>Quantity</th>
              <th>Total</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="entry" items="${cart.items}">
              <tr>
                <td>${entry.key}</td>
                <td>${entry.value.product.name}</td>
                <td>$${entry.value.product.price}</td>
                <td>
                  <form
                    action="${pageContext.request.contextPath}/carts"
                    method="post"
                    style="display: inline"
                  >
                    <input type="hidden" name="action" value="update" />
                    <input type="hidden" name="source" value="cart" />
                    <input
                      type="hidden"
                      name="productId"
                      value="${entry.key}"
                    />
                    <input
                      type="number"
                      name="quantity"
                      value="${entry.value.quantity}"
                      min="1"
                      class="quantity-input"
                    />
                    <button type="submit" class="btn update-btn">Update</button>
                  </form>
                </td>
                <td>$${entry.value.product.price * entry.value.quantity}</td>
                <td>
                  <form
                    action="${pageContext.request.contextPath}/carts"
                    method="post"
                    style="display: inline"
                  >
                    <input type="hidden" name="action" value="remove" />
                    <input type="hidden" name="source" value="cart" />
                    <input
                      type="hidden"
                      name="productId"
                      value="${entry.key}"
                    />
                    <button type="submit" class="btn remove-btn">Remove</button>
                  </form>
                </td>
              </tr>
            </c:forEach>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="4" style="text-align: right">
                <strong>Total Cost:</strong>
              </td>
              <td colspan="2"><strong>$${cart.totalCost}</strong></td>
            </tr>
          </tfoot>
        </table>

        <div class="button-container">
          <a
            href="${pageContext.request.contextPath}/carts"
            class="action-button continue-btn"
          >
            Continue Shopping
          </a>
          <form
            action="${pageContext.request.contextPath}/checkout"
            method="post"
            style="display: inline"
          >
            <button type="submit" class="action-button checkout-btn">
              Checkout
            </button>
          </form>
        </div>
      </c:otherwise>
    </c:choose>
  </body>
</html>
