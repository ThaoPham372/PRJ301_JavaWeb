
package service;

import java.util.List;
import model.User;
import userDAO.UserDao;
import java.sql.*;

public class UserServiceImpl implements IUserService{
    private UserDao userDao;

    public UserServiceImpl() {
        this.userDao = new UserDao();
    }

    @Override
    public void insertUser(User user) throws SQLException {
        userDao.insertUser(user);
    }

    @Override
    public User selectUser(int id) throws SQLException {
        return userDao.selectUser(id);
    }

    @Override
    public List<User> selectAllUsers() throws SQLException {
        return userDao.selectAllUsers();
    }

    @Override
    public boolean updateUser(User user) throws SQLException {
        return userDao.updateUser(user);
    }

    @Override
    public boolean deleteUser(int id) throws SQLException {
        return userDao.deleteUser(id);
    }

    @Override
    public List<User> searchUsers(String keyword) throws SQLException {
        return userDao.searchUsers(keyword);
    }
    
    
}
