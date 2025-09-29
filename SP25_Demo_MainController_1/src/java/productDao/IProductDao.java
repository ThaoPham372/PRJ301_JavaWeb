
package productDao;

import model.Product;
import java.sql.*;
import java.util.List;

public interface IProductDao {
    public void insertProduct (Product pro) throws SQLException;
    public Product selectProduct (int id) throws SQLException ;
    public List<Product> selectAllProducts() throws SQLException;
    public boolean deleteProduct (int id) throws SQLException;
    public boolean updateProduct (Product pro) throws SQLException;
    
}
