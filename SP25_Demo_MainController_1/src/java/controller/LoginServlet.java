package controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.SQLException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Cart;
import model.User;
import service.IProductService;
import service.IUserService;
import service.ProductServiceImpl;
import service.UserServiceImpl;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private IUserService userService;
    private IProductService productService;

    @Override
    public void init() {
        userService = new UserServiceImpl();
        productService = new ProductServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra nếu người dùng đã đăng nhập
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            redirectBasedOnRole(user, request, response);
            return;
        }

        // Kiểm tra cookie remember me
        String rememberedUser = "";
        String rememberedPass = "";
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("REMEMBER_USER".equals(c.getName())) {
                    try {
                        rememberedUser = URLDecoder.decode(c.getValue(), "UTF-8");
                    } catch (Exception ignore) {
                        rememberedUser = c.getValue();
                    }
                } else if ("REMEMBER_PASS".equals(c.getName())) {
                    try {
                        rememberedPass = URLDecoder.decode(c.getValue(), "UTF-8");
                    } catch (Exception ignore) {
                        rememberedPass = c.getValue();
                    }
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
                // Kiểm tra trạng thái tài khoản
                if (!user.isStatus()) {
                    request.setAttribute("error", "Your account has been disabled. Please contact administrator.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }

                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Khởi tạo giỏ hàng cho user
                Cart cart = new Cart();
                session.setAttribute("cart", cart);

                // Xử lý remember me
                if ("on".equals(remember)) {
                    String encUser = URLEncoder.encode(username, "UTF-8");
                    String encPass = URLEncoder.encode(password, "UTF-8");
                    Cookie userCookie = new Cookie("REMEMBER_USER", encUser);
                    Cookie passCookie = new Cookie("REMEMBER_PASS", encPass);
                    userCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
                    passCookie.setMaxAge(7 * 24 * 60 * 60);
                    userCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                    passCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                    userCookie.setHttpOnly(true);
                    passCookie.setHttpOnly(true);
                    response.addCookie(userCookie);
                    response.addCookie(passCookie);
                } else {
                    // Xóa cookie nếu không chọn remember
                    Cookie userCookie = new Cookie("REMEMBER_USER", "");
                    Cookie passCookie = new Cookie("REMEMBER_PASS", "");
                    userCookie.setMaxAge(0);
                    passCookie.setMaxAge(0);
                    userCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                    passCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                    response.addCookie(userCookie);
                    response.addCookie(passCookie);
                }

                // Điều hướng dựa trên vai trò
                redirectBasedOnRole(user, request, response);

            } else {
                request.setAttribute("error", "Invalid username or password!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void redirectBasedOnRole(User user, HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            if ("admin".equalsIgnoreCase(user.getRole())) {
                // Admin dashboard
                request.setAttribute("userList", userService.selectAllUsers());
                request.setAttribute("productList", productService.selectAllProducts());
                request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
            } else {
                // User - chuyển thẳng đến trang giỏ hàng
                response.sendRedirect(request.getContextPath() + "/carts");
            }
        } catch (SQLException e) {
            throw new ServletException("Error loading data", e);
        }
    }
}