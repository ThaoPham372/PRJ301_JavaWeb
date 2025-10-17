<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Access Denied</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        background-color: #f5f5f5;
      }
      .error-container {
        text-align: center;
        padding: 40px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        max-width: 500px;
        width: 90%;
      }
      h1 {
        color: #d32f2f;
        margin-bottom: 20px;
      }
      .message {
        color: #666;
        margin-bottom: 30px;
        padding: 15px;
        background-color: #ffebee;
        border-radius: 4px;
      }
      .button {
        display: inline-block;
        padding: 10px 20px;
        background-color: #1976d2;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s;
      }
      .button:hover {
        background-color: #1565c0;
      }
    </style>
  </head>
  <body>
    <div class="error-container">
      <h1>Access Denied</h1>
      <div class="message">
        ${message != null ? message : "Sorry, you don't have permission to
        access this resource!"}
      </div>
      <a href="${pageContext.request.contextPath}/products" class="button"
        >Back to Products</a
      >
    </div>
  </body>
</html>
