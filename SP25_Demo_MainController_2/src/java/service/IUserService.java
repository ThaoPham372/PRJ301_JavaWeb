
package service;

import java.util.List;
import model.User;
import java.sql.*;

public interface IUserService {
    void insertUser(User user) throws SQLException;
    User selectUser(int id) throws SQLException;
    List<User> selectAllUsers() throws SQLException;
    boolean updateUser(User user) throws SQLException;
    boolean deleteUser(int id) throws SQLException;
    List<User> searchUsers(String keyword) throws SQLException;
    
    
}
