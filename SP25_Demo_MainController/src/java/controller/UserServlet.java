package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import model.User;
import userDao.UserDao;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;

    @Override
    public void init() {
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "insert":
                    insertUser(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateUser(request, response);
                    break;
                default:
                    listUsers(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // ==== LIST ====
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<User> listUsers = userDao.selectAllUsers();
        request.setAttribute("listUsers", listUsers);
        RequestDispatcher dispatcher = request.getRequestDispatcher("user-list.jsp");
        dispatcher.forward(request, response);
    }

    // ==== SHOW NEW FORM ====
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        RequestDispatcher dispatcher = request.getRequestDispatcher("user-form.jsp");
        dispatcher.forward(request, response);
    }

    // ==== INSERT ====
    private void insertUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String country = request.getParameter("country");
        String role = request.getParameter("role");
        boolean status = "on".equals(request.getParameter("status"));
        String password = request.getParameter("password");
        String dob = request.getParameter("dob");

        User newUser = new User(0, username, email, country, role, status, password, dob);
        userDao.insertUser(newUser);
        response.sendRedirect("user?action=list");
    }

    // ==== DELETE ====
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        userDao.deleteUser(id);
        response.sendRedirect("user?action=list");
    }

    // ==== SHOW EDIT FORM ====
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        User existingUser = userDao.selectUser(id);
        request.setAttribute("user", existingUser);
        RequestDispatcher dispatcher = request.getRequestDispatcher("user-form.jsp");
        dispatcher.forward(request, response);
    }

    // ==== UPDATE ====
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String country = request.getParameter("country");
        String role = request.getParameter("role");
        boolean status = "on".equals(request.getParameter("status"));
        String password = request.getParameter("password");
        String dob = request.getParameter("dob");

        User user = new User(id, username, email, country, role, status, password, dob);
        userDao.updateUser(user);
        response.sendRedirect("user?action=list");
    }
}
