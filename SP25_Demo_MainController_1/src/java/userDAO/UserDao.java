package userDAO;

import dao.DBConnection;
import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao implements IUserDAO {

    private static final String LOGIN =
            "SELECT id, username, role, password FROM Users WHERE username = ? AND password = ?";

    private static final String LOGIN_SQL =
    "SELECT * FROM Users WHERE username = ? AND password = ? AND status = 1";

    private static final String SELECT_USER_BY_ID =
            "SELECT * FROM Users WHERE id = ?";
    
    private static final String SELECT_ALL_USERS =
            "SELECT * FROM Users";
    
    private static final String UPDATE_USER =
            "UPDATE Users SET username = ?, email = ?, country = ?, role = ?, status = ?, password = ?, dob = ? WHERE id = ?";

    private static final String UPDATE_STATUS =
            "UPDATE Users SET status = 0 WHERE id = ?";

    private static final String INSERT_USER =
            "INSERT INTO Users (username, email, country, role, status, password, dob) VALUES (?, ?, ?, ?, ?, ?, ?)";

    private static final String SEARCH_USERS =
    "SELECT *, CASE WHEN status=1 THEN 'Active' ELSE 'Inactive' END AS statusText " +
    "FROM Users " +
    "WHERE username LIKE ? OR email LIKE ? OR country LIKE ? OR role LIKE ? OR " +
    " (CASE WHEN status=1 THEN 'Active' ELSE 'Inactive' END) LIKE ?";
    
    private static final String UPDATE_REMEMBER_TOKEN =
    "UPDATE Users SET remember_token = ?, remember_expiry = ? WHERE id = ?";

    private static final String SELECT_BY_REMEMBER_TOKEN =
    "SELECT * FROM Users WHERE remember_token = ? AND status = 1";

    @Override
    public void insertUser(User user) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(INSERT_USER);
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getCountry());
                ps.setString(4, user.getRole());
                ps.setBoolean(5, user.isStatus());
                ps.setString(6, user.getPassword());
                ps.setString(7, user.getDob());

                int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("A new user was inserted successfully!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public User selectUser(int id) throws SQLException {
        User user = null;
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(SELECT_USER_BY_ID);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String username = rs.getString("username");
                String email = rs.getString("email");
                String country = rs.getString("country");
                String role = rs.getString("role");
                boolean status = rs.getBoolean("status");
                String password = rs.getString("password");
                String dob = rs.getString("dob");

                user = new User(id, username, email, country, role, status, password, dob);
            }
        }
        return user;
    }

    @Override
    public List<User> selectAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(SELECT_ALL_USERS);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String email = rs.getString("email");
                String country = rs.getString("country");
                String role = rs.getString("role");
                boolean status = rs.getBoolean("status");
                String password = rs.getString("password");
                String dob = rs.getString("dob");

                users.add(new User(id, username, email, country, role, status, password, dob));
            }
        }
        return users;
    }

    @Override
    public boolean deleteUser(int id) throws SQLException {
        boolean rowUpdated;
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(UPDATE_STATUS);
            ps.setInt(1, id);
            rowUpdated = ps.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    @Override
    public boolean updateUser(User user) throws SQLException {
        boolean rowUpdated;
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(UPDATE_USER);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getCountry());
            ps.setString(4, user.getRole());
            ps.setBoolean(5, user.isStatus());
            ps.setString(6, user.getPassword());
            ps.setString(7, user.getDob());
            ps.setInt(8, user.getId());

            rowUpdated = ps.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    @Override
public List<User> searchUsers(String keyword) throws SQLException {
    List<User> users = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection()) {

        PreparedStatement ps;
        // Nếu search theo trạng thái
        if ("active".equalsIgnoreCase(keyword) || "inactive".equalsIgnoreCase(keyword)) {
            boolean status = "active".equalsIgnoreCase(keyword); // active = true, inactive = false
            String sql = "SELECT * FROM Users WHERE status = ?";
            ps = conn.prepareStatement(sql);
            ps.setBoolean(1, status);

        } else {
            // Search theo username, email, country, role
            String sql = "SELECT * FROM Users " +
                         "WHERE username LIKE ? OR email LIKE ? OR country LIKE ? OR role LIKE ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            ps.setString(4, "%" + keyword + "%");
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            int id = rs.getInt("id");
            String username = rs.getString("username");
            String email = rs.getString("email");
            String country = rs.getString("country");
            String role = rs.getString("role");
            boolean status = rs.getBoolean("status");
            String password = rs.getString("password");
            String dob = rs.getString("dob");

            users.add(new User(id, username, email, country, role, status, password, dob));
        }
    }
    return users;
}

    @Override
    public User login(String username, String password) throws SQLException {
    User user = null;
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(LOGIN_SQL)) {
        ps.setString(1, username);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            user = new User(
                rs.getInt("id"),
                rs.getString("username"),
                rs.getString("email"),
                rs.getString("country"),
                rs.getString("role"),
                rs.getBoolean("status"),
                rs.getString("password"),
                rs.getString("dob")
            );
        }
    }
    return user;
}

    @Override
    public void updateRememberToken(int userId, String token, Timestamp expiry) throws SQLException {
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(UPDATE_REMEMBER_TOKEN)) {
        ps.setString(1, token);
        ps.setTimestamp(2, expiry);
        ps.setInt(3, userId);
        ps.executeUpdate();
    }
}

    @Override
    public User findByRememberToken(String token) throws SQLException {
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(SELECT_BY_REMEMBER_TOKEN)) {
        ps.setString(1, token);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("country"),
                    rs.getString("role"),
                    rs.getBoolean("status"),
                    rs.getString("password"),
                    rs.getString("dob")
                );
            }
        }
    }
    return null;
}
}
