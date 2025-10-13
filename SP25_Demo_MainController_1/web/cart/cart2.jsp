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
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
      }
      th,
      td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: center;
      }
      th {
        background-color: #f5f5f5;
        font-weight: bold;
      }
      .quantity-input {
        width: 60px;
        padding: 5px;
        text-align: center;
      }
      .btn {
        padding: 6px 12px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin: 0 5px;
      }
      .update-btn {
        background-color: #28a745;
        color: white;
      }
      .remove-btn {
        background-color: #dc3545;
        color: white;
      }
      .button-container {
        text-align: center;
        margin-top: 20px;
      }
      .action-button {
        display: inline-block;
        padding: 8px 20px;
        margin: 0 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        text-decoration: none;
      }
      .continue-btn {
        background-color: #6c757d;
        color: white;
      }
      .checkout-btn {
        background-color: #28a745;
        color: white;
      }
    </style>
  </head>
  <body>
    <h2>Shopping Cart</h2>

    <c:choose>
      <c:when test="${empty cart.items}">
        <p>Your cart is empty</p>
        <div class="button-container">
          <a
            href="${pageContext.request.contextPath}/productListCart.jsp"
            class="action-button continue-btn"
          >
            Continue Shopping
          </a>
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
            href="${pageContext.request.contextPath}/productListCart.jsp"
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
