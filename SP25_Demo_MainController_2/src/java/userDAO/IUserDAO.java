
package userDAO;

import java.sql.SQLException;
import java.util.List;
import model.User;

public interface IUserDAO {
    public void insertUser(User user) throws SQLException;

    public User selectUser(int id) throws SQLException;

    public List<User> selectAllUsers() throws SQLException;

    public boolean deleteUser(int id) throws SQLException;

    public boolean updateUser(User user) throws SQLException;
    
    List<User> searchUsers(String keyword) throws SQLException;
}
    
