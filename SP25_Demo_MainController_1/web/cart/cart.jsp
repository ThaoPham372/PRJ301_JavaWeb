<%@ page contentType="text/html;charset=UTF-8" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
  <head>
    <title>Giỏ hàng</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
      }
      th,
      td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
      }
      th {
        background-color: #f2f2f2;
      }
      .checkout-btn {
        background-color: #007bff;
        color: white;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
        margin-top: 20px;
      }
    </style>
  </head>
  <body>
    <h2>Giỏ hàng của bạn</h2>

    <table border="1">
      <thead>
        <tr>
          <th>Sản phẩm</th>
          <th>Giá</th>
          <th>Số lượng</th>
          <th>Tổng</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${cart}">
          <tr>
            <td>${item.product.name}</td>
            <td>${item.product.price}</td>
            <td>${item.quantity}</td>
            <td>${item.product.price * item.quantity}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <form action="checkout" method="post">
      <input type="submit" value="Tiền hành thanh toán" class="checkout-btn" />
    </form>
  </body>
</html>

