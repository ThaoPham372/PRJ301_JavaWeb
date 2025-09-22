package userDao;

import dao.DBConnection;
import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao implements IUserDAO {

    // ==== SQL QUERIES ====
    private static final String LOGIN_SQL =
            "SELECT id, username, role FROM Users WHERE username=? AND password=?";
    private static final String INSERT_USER =
            "INSERT INTO Users(username,email,country,role,status,password,dob) VALUES (?,?,?,?,?,?,?)";
    private static final String SELECT_USER_BY_ID =
            "SELECT * FROM Users WHERE id = ?";
    private static final String UPDATE_USER =
            "UPDATE Users SET username=?, email=?, country=?, role=?, status=?, password=?, dob=? WHERE id=?";
    private static final String DELETE_USER =
            "DELETE FROM Users WHERE id=?";
    private static final String SELECT_ALL_USERS =
            "SELECT * FROM Users";

    // ==== CHECK LOGIN ====
    public static User checkLogin(String username, String password) {
        User us = null;
        String sql = LOGIN_SQL;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ptm = con.prepareStatement(sql)) {

            ptm.setString(1, username);
            ptm.setString(2, password);

            try (ResultSet rs = ptm.executeQuery()) {
                if (rs.next()) {
                    int id = rs.getInt("id");
                    String uname = rs.getString("username");
                    String role = rs.getString("role");

                    us = new User(id, uname, "", "", role, true, "", "");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return us;
    }

    // ==== SELECT ALL ====
    public List<User> selectAllUsers() {
        List<User> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_ALL_USERS);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("country"),
                        rs.getString("role"),
                        rs.getBoolean("status"),
                        rs.getString("password"),
                        rs.getString("dob")
                );
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ==== SELECT BY ID ====
    public User selectUser(int id) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_USER_BY_ID)) {

            ps.setInt(1, id);
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ==== INSERT ====
    public void insertUser(User user) throws SQLException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_USER)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getCountry());
            ps.setString(4, user.getRole());
            ps.setBoolean(5, user.isStatus());
            ps.setString(6, user.getPassword());
            ps.setString(7, user.getDob());

            ps.executeUpdate();
        }
    }

    // ==== UPDATE ====
    public boolean updateUser(User user) throws SQLException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_USER)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getCountry());
            ps.setString(4, user.getRole());
            ps.setBoolean(5, user.isStatus());
            ps.setString(6, user.getPassword());
            ps.setString(7, user.getDob());
            ps.setInt(8, user.getId());

            return ps.executeUpdate() > 0;
        }
    }

    // ==== DELETE ====
    public boolean deleteUser(int id) throws SQLException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_USER)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // ==== MAIN TEST ====
    public static void main(String[] args) {
        UserDao dao = new UserDao();

        // Test select all
        System.out.println("Danh sách user:");
        dao.selectAllUsers().forEach(System.out::println);

        // Test insert
        try {
            User newU = new User(0, "TestUser", "test@example.com",
                    "VN", "user", true, "123456", "2002-09-17");
            dao.insertUser(newU);
            System.out.println("Đã thêm user mới!");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Test login
        User u = dao.checkLogin("TestUser", "123456");
        if (u != null) {
            System.out.println("Login ok: " + u.getUsername() + " - " + u.getRole());
        } else {
            System.out.println("Login failed!");
        }
    }
}
