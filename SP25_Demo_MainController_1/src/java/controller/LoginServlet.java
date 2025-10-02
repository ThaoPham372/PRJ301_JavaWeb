package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import service.IUserService;
import service.UserServiceImpl;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.UUID;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private IUserService userService;

    @Override
    public void init() {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String rememberedUser = "";
        String rememberedPass = "";
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("REMEMBER_USER".equals(c.getName())) {
                    rememberedUser = c.getValue();
                } else if ("REMEMBER_PASS".equals(c.getName())) {
                    rememberedPass = c.getValue();
                }
            }
        }

        request.setAttribute("rememberedUser", rememberedUser);
        request.setAttribute("rememberedPass", rememberedPass);

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String remember = request.getParameter("remember");

    try {
        User user = userService.login(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("on".equals(remember)) {
                Cookie userCookie = new Cookie("REMEMBER_USER", username);
                Cookie passCookie = new Cookie("REMEMBER_PASS", password);
                userCookie.setMaxAge(7 * 24 * 60 * 60); 
                passCookie.setMaxAge(7 * 24 * 60 * 60);
                userCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                passCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                response.addCookie(userCookie);
                response.addCookie(passCookie);
            } else {
                Cookie userCookie = new Cookie("REMEMBER_USER", "");
                Cookie passCookie = new Cookie("REMEMBER_PASS", "");
                userCookie.setMaxAge(0);
                passCookie.setMaxAge(0);
                userCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                passCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                response.addCookie(userCookie);
                response.addCookie(passCookie);
            }

            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/users?action=list");
            } else {
                response.sendRedirect(request.getContextPath() + "/products?action=list");
            }

        } else {
            request.setAttribute("error", "Invalid username or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    } catch (SQLException e) {
        throw new ServletException(e);
    }
}
}
