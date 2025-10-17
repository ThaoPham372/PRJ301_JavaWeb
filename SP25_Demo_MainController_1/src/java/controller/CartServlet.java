package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.Product;
import service.CartService;
import service.ICartService;
import service.IProductService;
import service.ProductServiceImpl;

@WebServlet(name = "CartServlet", urlPatterns = { "/carts" })
public class CartServlet extends HttpServlet {

    private IProductService productService;
    private ICartService cartService;

    @Override
    public void init() {
        productService = new ProductServiceImpl();
        cartService = new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        request.setAttribute("cart", cart);

        // If query param view=1, show cart details page; otherwise show product list
        String view = request.getParameter("view");
        if ("1".equals(view)) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("cart/cart2.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            List<Product> products = productService.selectAllProducts();
            request.setAttribute("productList", products);
            RequestDispatcher dispatcher = request.getRequestDispatcher("productListCart.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error loading products", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
        }

        String action = request.getParameter("action");
        String source = request.getParameter("source"); // 'cart' if invoked from cart page
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            switch (action) {
                case "add":
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    try {
                        Product product = productService.getProductById(productId);
                        if (product != null) {
                            cartService.addToCart(cart, product, quantity);
                            session.setAttribute("cart", cart);
                            request.setAttribute("message", "Thêm sản phẩm thành công!");
                        }
                    } catch (Exception ex) {
                        request.setAttribute("error", "Không thể thêm sản phẩm vào giỏ hàng");
                    }
                    break;

                case "update":
                    int updateQuantity = Integer.parseInt(request.getParameter("quantity"));
                    if (updateQuantity > 0) {
                        cartService.updateCartItem(cart, productId, updateQuantity);
                        request.setAttribute("message", "Cập nhật số lượng thành công!");
                    }
                    break;

                case "remove":
                    cartService.removeCartItem(cart, productId);
                    request.setAttribute("message", "Đã xóa sản phẩm khỏi giỏ hàng!");
                    break;

                case "view":
                    // Hiển thị trang giỏ hàng chi tiết
                    request.setAttribute("cart", cart);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("cart/cart2.jsp");
                    dispatcher.forward(request, response);
                    return;
            }

            session.setAttribute("cart", cart);

            // If source is cart, stay on cart page; otherwise go back to product list
            if ("cart".equals(source)) {
                request.setAttribute("cart", cart);
                RequestDispatcher dispatcher = request.getRequestDispatcher("cart/cart2.jsp");
                dispatcher.forward(request, response);
            } else {
                List<Product> products = productService.selectAllProducts();
                request.setAttribute("productList", products);
                RequestDispatcher dispatcher = request.getRequestDispatcher("productListCart.jsp");
                dispatcher.forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input data");
            doGet(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error processing request", e);
        }
    }
}