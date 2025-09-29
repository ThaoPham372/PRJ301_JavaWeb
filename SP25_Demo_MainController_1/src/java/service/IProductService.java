package service;

import model.Product;

import java.sql.SQLException;
import java.util.List;

public interface IProductService {
    void insertProduct(Product pro) throws SQLException;

    Product selectProduct(int id) throws SQLException;

    List<Product> selectAllProducts() throws SQLException;

    boolean deleteProduct(int id) throws SQLException;

    boolean updateProduct(Product pro) throws SQLException;
}
