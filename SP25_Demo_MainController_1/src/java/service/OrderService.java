package service;

import java.sql.SQLException;
import java.util.List;

import model.Order;
import orderDao.IOrderDao;
import orderDao.OrderDao;

public class OrderService implements IOrderService {

  private IOrderDao orderDao;

  public OrderService() {
    this.orderDao = new OrderDao();
  }

  @Override
  public void addOrder(Order order) throws SQLException {
    orderDao.insertOrder(order);
  }

  @Override
  public Order getOrderById(int id) {
    return orderDao.getOrderById(id);
  }

  @Override
  public List<Order> getAllOrders() {
    return orderDao.selectAllOrders();
  }

  @Override
  public boolean deleteOrder(int id) throws SQLException {
    return orderDao.deleteOrder(id);
  }

  @Override
  public boolean updateOrder(Order order) throws SQLException {
    return orderDao.updateOrder(order);
  }

  @Override
  public int createOrder(Order order) {
    return orderDao.createOrder(order);
  }

  @Override
  public void addOrderDetail(int orderId, int productId, int quantity, Double price) {
    orderDao.addOrderDetail(orderId, productId, quantity, price);
  }
}

