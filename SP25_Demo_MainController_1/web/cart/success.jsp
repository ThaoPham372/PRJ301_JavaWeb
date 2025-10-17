<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Đặt hàng thành công</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        text-align: center;
        margin-top: 50px;
        background-color: #f8f9fa;
      }
      .success-container {
        max-width: 600px;
        margin: 0 auto;
        padding: 30px;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
      .success-icon {
        color: #28a745;
        font-size: 48px;
        margin-bottom: 20px;
      }
      .success-message {
        color: #28a745;
        font-size: 24px;
        margin-bottom: 20px;
      }
      .thank-you {
        color: #666;
        margin-bottom: 30px;
      }
      .continue-link {
        display: inline-block;
        background-color: #007bff;
        color: white;
        padding: 12px 24px;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s;
      }
      .continue-link:hover {
        background-color: #0056b3;
      }
    </style>
  </head>
  <body>
    <div class="success-container">
      <div class="success-icon">✓</div>
      <div class="success-message">Đơn hàng của bạn đã được ghi nhận!</div>
      <div class="thank-you">Cảm ơn bạn đã mua sắm.</div>
      <a href="${pageContext.request.contextPath}/carts" class="continue-link">
        Tiếp tục mua hàng
      </a>
    </div>
  </body>
</html>
