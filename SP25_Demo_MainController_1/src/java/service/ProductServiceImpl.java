package service;

import model.Product;
import productDao.IProductDao;
import productDao.ProductDao;

import java.sql.SQLException;
import java.util.List;

public class ProductServiceImpl implements IProductService {

    private IProductDao productDao;

    public ProductServiceImpl() {
        this.productDao = new ProductDao();
    }

    @Override
    public void insertProduct(Product pro) throws SQLException {
        productDao.insertProduct(pro);
    }

    @Override
    public Product selectProduct(int id) throws SQLException {
        return productDao.selectProduct(id);
    }

    @Override
    public List<Product> selectAllProducts() throws SQLException {
        return productDao.selectAllProducts();
    }

    @Override
    public boolean deleteProduct(int id) throws SQLException {
        return productDao.deleteProduct(id);
    }

    @Override
    public boolean updateProduct(Product pro) throws SQLException {
        return productDao.updateProduct(pro);
    }
}
