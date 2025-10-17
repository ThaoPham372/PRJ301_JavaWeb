<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>User Management</title>
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
        color: orange;
        font-size: 28px;
        font-weight: bold;
        border: 2px solid orange;
        border-radius: 8px;
        background-color: #fff3e0;
        width: fit-content;
        box-shadow: 0 0 6px rgba(0, 0, 0, 0.1);
      }

      form {
        margin-bottom: 15px;
      }
      input[type='text'] {
        padding: 6px;
        border-radius: 4px;
        border: 1px solid #ccc;
      }
      input[type='submit'] {
        padding: 6px 12px;
        border: none;
        border-radius: 4px;
        background: #007bff;
        color: white;
        cursor: pointer;
      }
      input[type='submit']:hover {
        background: #0056b3;
      }
      .add-btn {
        display: inline-block;
        padding: 8px 14px;
        background: #28a745;
        color: #fff;
        text-decoration: none;
        border-radius: 4px;
        font-weight: bold;
      }
      .add-btn:hover {
        background: #218838;
      }
      table {
        border-collapse: collapse;
        width: 100%;
        background: #fff;
      }
      th,
      td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
      }
      th {
        background: #f2f2f2;
      }
      .actions a {
        text-decoration: none;
        padding: 6px 10px;
        border-radius: 4px;
        margin: 0 2px;
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
    </style>
  </head>
  <body>
    <div class="topbar">
      <h2>User Management</h2>
      <div>
        Hello, <b>${sessionScope.user.username}</b> (<span style="color: green"
          >${sessionScope.user.role}</span
        >) |
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
      </div>
    </div>

    <!-- Search form -->
    <form action="${pageContext.request.contextPath}/users" method="get">
      <input type="hidden" name="action" value="search" />
      <input type="text" name="keyword" placeholder="Search user..." />
      <input type="submit" value="Search" />
    </form>

    <!-- Add New User -->
    <a
      href="${pageContext.request.contextPath}/users?action=new"
      class="add-btn"
      >➕ Add New User</a
    >
    <a
      href="${pageContext.request.contextPath}/admin/dashboard.jsp"
      class="add-btn"
      style="background: #6c757d; margin-left: 8px"
      >⬅ Back to Dashboard</a
    >
    <br /><br />

    <!-- User Table -->
    <table>
      <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Country</th>
        <th>Role</th>
        <th>Status</th>
        <th>DOB</th>
        <th>Actions</th>
      </tr>
      <c:forEach var="user" items="${listUser}">
        <tr>
          <td>${user.id}</td>
          <td>${user.username}</td>
          <td>${user.email}</td>
          <td>${user.country}</td>
          <td>${user.role}</td>
          <td><c:out value="${user.status ? 'Active' : 'Inactive'}" /></td>
          <td>${user.dob}</td>
          <td class="actions">
            <a
              href="${pageContext.request.contextPath}/users?action=edit&id=${user.id}"
              class="edit"
              >✏️ Edit</a
            >
            <a
              href="${pageContext.request.contextPath}/users?action=delete&id=${user.id}"
              class="delete"
              onclick="return confirm('Deactivate this user?');"
              >🗑 Delete</a
            >
          </td>
        </tr>
      </c:forEach>
    </table>
  </body>
</html>
