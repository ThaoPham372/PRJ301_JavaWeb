package controller;

import java.io.IOException;

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
        RequestDispatcher dispatcher = request.getRequestDispatcher("cart/cart2.jsp");
        dispatcher.forward(request, response);
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

                            response.sendRedirect(request.getContextPath() + "/carts");
                            return;
                        }
                    } catch (Exception ex) {
                        request.setAttribute("error", "Không thể thêm sản phẩm vào giỏ hàng");
                    }
                    break;

                case "update":
                    int updateQuantity = Integer.parseInt(request.getParameter("quantity"));
                    if (updateQuantity > 0) {
                        cartService.updateCartItem(cart, productId, updateQuantity);
                    }
                    break;

                case "remove":
                    cartService.removeCartItem(cart, productId);
                    break;
            }

            session.setAttribute("cart", cart);
            response.sendRedirect(request.getContextPath() + "/carts");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input data");
            RequestDispatcher dispatcher = request.getRequestDispatcher("cart/cart2.jsp");
            dispatcher.forward(request, response);
        }
    }
}