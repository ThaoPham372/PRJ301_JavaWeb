package userDAO;

import model.User;
import java.sql.SQLException;
import java.util.List;

public interface IUserDAO {
    void insertUser(User user) throws SQLException;

    User selectUser(int id) throws SQLException;

    List<User> selectAllUsers() throws SQLException;

    boolean deleteUser(int id) throws SQLException;

    boolean updateUser(User user) throws SQLException;

    List<User> searchUsers(String keyword) throws SQLException;
    
    User login(String username, String password) throws SQLException;
    
    void updateRememberToken(int userId, String token, java.sql.Timestamp expiry) throws java.sql.SQLException;
    model.User findByRememberToken(String token) throws java.sql.SQLException;


}
