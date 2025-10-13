package service;

import java.sql.SQLException;
import java.util.List;

import model.Order;

public interface IOrderService {
  public void addOrder(Order order) throws SQLException;

  public Order getOrderById(int id);

  public List<Order> getAllOrders();

  public boolean deleteOrder(int id) throws SQLException;

  public boolean updateOrder(Order order) throws SQLException;

  public int createOrder(Order order);

  public void addOrderDetail(int orderId, int productId, int quantity, Double price);
}

