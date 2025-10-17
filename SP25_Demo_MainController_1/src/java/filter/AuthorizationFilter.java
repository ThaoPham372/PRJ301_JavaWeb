package filter;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebFilter("/*")
public class AuthorizationFilter implements Filter {

  @Override
  public void init(FilterConfig filterConfig) throws ServletException {
  }

  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
      throws IOException, ServletException {
    HttpServletRequest httpRequest = (HttpServletRequest) request;
    HttpServletResponse httpResponse = (HttpServletResponse) response;
    HttpSession session = httpRequest.getSession(false);
    String url = httpRequest.getRequestURI();

    // Các URL công khai (Guest có thể xem)
    boolean isPublicResource = url.contains("/login") ||
        url.contains("/logout") ||
        url.contains("/css/") ||
        url.contains("/js/") ||
        url.contains("/images/") ||
        url.contains("/products") || // Guest có thể xem sản phẩm
        url.endsWith("/register.jsp");

    if (isPublicResource) {
      chain.doFilter(request, response);
      return;
    }

    // Kiểm tra quyền truy cập cho user đã đăng nhập
    if (session != null && session.getAttribute("user") != null) {
      User user = (User) session.getAttribute("user");
      String role = user.getRole();

      // URL chỉ dành cho Admin
      boolean isAdminResource = url.contains("/admin") ||
          url.contains("/users") || // Quản lý user
          url.contains("/orders/manage"); // Quản lý đơn hàng

      // URL dành cho User đã đăng nhập
      boolean isUserResource = url.contains("/cart") ||
          url.contains("/checkout") ||
          url.contains("/order/create") ||
          url.contains("/order/history") ||
          url.contains("/profile");

      if ("admin".equalsIgnoreCase(role)) {
        // Admin có thể truy cập mọi trang
        chain.doFilter(request, response);
      } else if ("user".equalsIgnoreCase(role) && !isAdminResource) {
        // User chỉ có thể truy cập trang user và trang công khai
        if (isUserResource || isPublicResource) {
          chain.doFilter(request, response);
        } else {
          // User cố truy cập trang admin
          request.setAttribute("message", "You don't have permission to access this resource!");
          request.getRequestDispatcher("/access-denied.jsp").forward(request, response);
        }
      } else {
        // Role không hợp lệ
        request.setAttribute("message", "Invalid role!");
        request.getRequestDispatcher("/access-denied.jsp").forward(request, response);
      }
    } else {
      // Guest chỉ có thể xem sản phẩm và trang công khai
      if (isPublicResource) {
        chain.doFilter(request, response);
      } else {
        httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
      }
    }
  }

  @Override
  public void destroy() {
  }
}