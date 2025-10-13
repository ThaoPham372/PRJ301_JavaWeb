package service;

import model.Cart;
import model.Product;

public interface ICartService {
  public void addToCart(Cart cart, Product product, int quantity);

  public void updateCartItem(Cart cart, int productId, int quantity);

  public void removeCartItem(Cart cart, int productId);

  public double calculateTotal(Cart cart);
}