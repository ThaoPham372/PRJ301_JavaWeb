package service;

import dao.DBConnection;
import model.User;
import java.sql.*;
import java.util.*;

public class UserDao {

    // SELECT ALL
    public List<User> selectAllUsers() {
        String sql = "SELECT * FROM Users";
        List<User> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
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
                    rs.getString("dob")   // dob để String
                );
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // SELECT BY ID
    public User selectUser(int id) {
        String sql = "SELECT * FROM Users WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
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

    // INSERT
    public void insertUser(User user) throws SQLException {
        String sql = "INSERT INTO Users(username,email,country,role,status,password,dob) VALUES(?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
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

    // UPDATE
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE Users SET username=?, email=?, country=?, role=?, status=?, password=?, dob=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
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

    // DELETE
    public boolean deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM Users WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // MAIN để test
    public static void main(String[] args) {
        UserDao dao = new UserDao();

        // In danh sách user
        System.out.println("Danh sách user:");
        dao.selectAllUsers().forEach(System.out::println);

        // Thêm mới
        try {
            User newU = new User(0, "TestUser", "test@example.com",
                    "VN", "user", true, "123456", "2002-09-17");
            dao.insertUser(newU);
            System.out.println("Đã thêm user mới!");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // In lại
        System.out.println("Sau khi thêm:");
        dao.selectAllUsers().forEach(System.out::println);
    }
}
