package productDao;

import dao.DBConnection;
import model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDao implements IProductDao {

    private static final String INSERT_PRODUCT =
            "INSERT INTO Product (name, price, description, stock, import_date) VALUES (?, ?, ?, ?, ?)";

    private static final String SELECT_PRODUCT_BY_ID =
            "SELECT * FROM Product WHERE id = ?";

    // lấy toàn bộ
    private static final String SELECT_ALL_PRODUCTS =
              "SELECT * FROM Product WHERE status = 1";

    private static final String UPDATE_STATUS =
        "UPDATE Product SET status = 0 WHERE id = ?";

    private static final String UPDATE_PRODUCT =
            "UPDATE Product SET name = ?, price = ?, description = ?, stock = ?, import_date = ? WHERE id = ?";

    @Override
    public void insertProduct(Product pro) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_PRODUCT)) {

            ps.setString(1, pro.getName());
            ps.setBigDecimal(2, pro.getPrice());
            ps.setString(3, pro.getDescription());
            ps.setInt(4, pro.getStock());
            ps.setTimestamp(5, pro.getImportDate());

            ps.executeUpdate();
        }
    }

    @Override
    public Product selectProduct(int id) throws SQLException {
        Product product = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_PRODUCT_BY_ID)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                java.math.BigDecimal price = rs.getBigDecimal("price");
                String description = rs.getString("description");
                int stock = rs.getInt("stock");
                Timestamp importDate = rs.getTimestamp("import_date");

                product = new Product(id, name, price, description, stock, importDate);
            }
        }
        return product;
    }

    @Override
    public List<Product> selectAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_PRODUCTS)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                java.math.BigDecimal price = rs.getBigDecimal("price");
                String description = rs.getString("description");
                int stock = rs.getInt("stock");
                Timestamp importDate = rs.getTimestamp("import_date");

                products.add(new Product(id, name, price, description, stock, importDate));
            }
        }
        return products;
    }

    @Override
    public boolean deleteProduct(int id) throws SQLException {
    boolean rowUpdated;
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(UPDATE_STATUS)) {

        ps.setInt(1, id);
        rowUpdated = ps.executeUpdate() > 0;
    }
    return rowUpdated;
}


    @Override
    public boolean updateProduct(Product pro) throws SQLException {
        boolean rowUpdated;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_PRODUCT)) {

            ps.setString(1, pro.getName());
            ps.setBigDecimal(2, pro.getPrice());
            ps.setString(3, pro.getDescription());
            ps.setInt(4, pro.getStock());
            ps.setTimestamp(5, pro.getImportDate());
            ps.setInt(6, pro.getId());

            rowUpdated = ps.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    // phân trang
    public List<Product> selectProductsByPage(int page, int pageSize) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getBigDecimal("price"),
                        rs.getString("description"),
                        rs.getInt("stock"),
                        rs.getTimestamp("import_date")
                ));
            }
        }
        return products;
    }
}
