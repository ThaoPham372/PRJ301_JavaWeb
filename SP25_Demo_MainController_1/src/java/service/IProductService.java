package service;

import java.sql.SQLException;
import java.util.List;

import model.Product;

public interface IProductService {
    void insertProduct(Product pro) throws SQLException;

    Product selectProduct(int id) throws SQLException;

    // Convenience alias used by some controllers
    Product getProductById(int id) throws SQLException;

    List<Product> selectAllProducts() throws SQLException;

    boolean deleteProduct(int id) throws SQLException;

    boolean updateProduct(Product pro) throws SQLException;
}
