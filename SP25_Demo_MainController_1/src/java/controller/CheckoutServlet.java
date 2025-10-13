package controller;

import java.io.IOException;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.CartItem;
import model.Order;
import model.Product;
import service.IOrderService;
import service.IProductService;
import service.OrderService;
import service.ProductServiceImpl;

@WebServlet(name = "CheckoutServlet", urlPatterns = { "/checkout" })
public class CheckoutServlet extends HttpServlet {

    private IOrderService orderService;
    private IProductService productService;

    @Override
    public void init() {
        orderService = new OrderService();
        productService = new ProductServiceImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carts");
            return;
        }
        
        int userId = 1; 
        double totalPrice = cart.getFinalTotal(); 

        
        Order order = new Order(0, userId, totalPrice, "Pending");

        try {
            
            int orderId = orderService.createOrder(order);

            if (orderId > 0) {
                for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                    Product product = entry.getValue().getProduct();
                    CartItem item = entry.getValue();

                    orderService.addOrderDetail(
                            orderId,
                            product.getId(),
                            item.getQuantity(),
                            product.getPrice().doubleValue());
                }

                
                session.removeAttribute("cart");

                response.sendRedirect(request.getContextPath() + "/cart/success.jsp");
            } else {
                throw new ServletException("Không thể tạo đơn hàng");
            }
        } catch (Exception ex) {
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect(request.getContextPath() + "/cart/error.jsp");
        }
    }
}