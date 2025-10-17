<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Admin Dashboard</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f5f5f5;
      }
      .dashboard {
        max-width: 1200px;
        margin: 0 auto;
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
      .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 0;
      }
      a {
        text-decoration: none;
      }
      .nav-menu {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 24px;
        margin: 20px 0 10px;
      }
      .nav-card {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 120px;
        background: linear-gradient(135deg, #e3f2fd 0%, #ffffff 100%);
        border: 1px solid #dbe7fb;
        border-radius: 10px;
        text-decoration: none;
        color: #0d47a1;
        font-weight: 600;
        font-size: 18px;
        box-shadow: 0 6px 12px rgba(13, 71, 161, 0.08);
        transition: transform 0.15s ease, box-shadow 0.15s ease,
          background 0.3s ease;
      }
      .nav-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 18px rgba(13, 71, 161, 0.16);
        background: linear-gradient(135deg, #d6eaff 0%, #ffffff 100%);
      }
      .section {
        margin-bottom: 40px;
      }
      .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
      }
      .btn {
        display: inline-block;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s;
      }
      .btn-primary {
        background-color: #1976d2;
        color: white;
      }
      .btn-danger {
        background-color: #d32f2f;
        color: white;
      }
      .table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
      }
      .table th,
      .table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
      }
      .table th {
        background-color: #f5f5f5;
      }
      .action-links a {
        margin-right: 10px;
        text-decoration: none;
        color: #1976d2;
      }
    </style>
  </head>
  <body>
    <div class="dashboard">
      <div class="header">
        <h1>Admin Dashboard</h1>
        <div>
          <span>Welcome, ${sessionScope.user.username}!</span>
          <a
            href="${pageContext.request.contextPath}/logout"
            class="btn btn-danger"
            >Logout</a
          >
        </div>
      </div>

      <div class="nav-menu">
        <a href="${pageContext.request.contextPath}/users?action=list"
          >Manage Users</a
        >
        <a href="${pageContext.request.contextPath}/products?action=list"
          >Manage Products</a
        >
      </div>

      <!-- Simplified dashboard per request: show only navigation links -->
      <div class="nav-menu">
        <a
          class="nav-card"
          href="${pageContext.request.contextPath}/users?action=list"
          >Manage Users</a
        >
        <a
          class="nav-card"
          href="${pageContext.request.contextPath}/products?action=list"
          >Manage Products</a
        >
      </div>
    </div>
  </body>
</html>
