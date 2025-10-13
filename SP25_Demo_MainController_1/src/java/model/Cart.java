package model;

import java.util.HashMap;
import java.util.Map;

public class Cart {
  private Map<Integer, CartItem> items;
  private String discountCode;
  private boolean discountApplied;

  public Cart() {
    this.items = new HashMap<>();
    this.discountApplied = false;
  }

  public Map<Integer, CartItem> getItems() {
    return items;
  }

  public void setItems(Map<Integer, CartItem> items) {
    this.items = items;
  }

  public void addItem(Product product, int quantity) {
    if (items.containsKey(product.getId())) {
      CartItem existingItem = items.get(product.getId());
      existingItem.setQuantity(existingItem.getQuantity() + quantity);
    } else {
      items.put(product.getId(), new CartItem(product, quantity));
    }
  }

  public void updateItem(int productId, int quantity) {
    if (items.containsKey(productId)) {
      if (quantity <= 0) {
        items.remove(productId);
      } else {
        items.get(productId).setQuantity(quantity);
      }
    }
  }

  public void removeItem(int productId) {
    items.remove(productId);
  }

  public double getTotalCost() {
    double total = 0.0;
    for (CartItem item : items.values()) {
      if (item.getProduct() != null && item.getProduct().getPrice() != null) {
        total += item.getProduct().getPrice().doubleValue() * item.getQuantity();
      }
    }
    return total;
  }

  public boolean isEmpty() {
    return items.isEmpty();
  }

  public int getItemCount() {
    return items.size();
  }

  public String getDiscountCode() {
    return discountCode;
  }

  public void setDiscountCode(String discountCode) {
    this.discountCode = discountCode;
  }

  public boolean isDiscountApplied() {
    return discountApplied;
  }

  public void setDiscountApplied(boolean discountApplied) {
    this.discountApplied = discountApplied;
  }

  public double getDiscountAmount() {
    if (discountApplied) {
      return getTotalCost() * 0.10;
    }
    return 0.0;
  }

  public double getFinalTotal() {
    return getTotalCost() - getDiscountAmount();
  }
}