package service;

import model.Cart;
import model.Product;
import service.ICartService;

public class CartService implements ICartService {

  @Override
  public void addToCart(Cart cart, Product product, int quantity) {
    cart.addItem(product, quantity);
  }

  @Override
  public void updateCartItem(Cart cart, int productId, int quantity) {
    cart.updateItem(productId, quantity);
  }

  @Override
  public void removeCartItem(Cart cart, int productId) {
    cart.removeItem(productId);
  }

  @Override
  public double calculateTotal(Cart cart) {
    return cart.getTotalCost();
  }
}