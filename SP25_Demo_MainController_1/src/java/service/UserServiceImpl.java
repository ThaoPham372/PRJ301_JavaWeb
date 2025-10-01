package service;

import model.User;
import userDAO.UserDao;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class UserServiceImpl implements IUserService {
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
    @Override
    public User login(String username, String password) throws SQLException {
    return userDao.login(username, password);
}

    @Override
    public void updateRememberToken(int userId, String token, Timestamp expiry) throws SQLException {
    userDao.updateRememberToken(userId, token, expiry);
}

    @Override
    public User findByRememberToken(String token) throws SQLException {
    return userDao.findByRememberToken(token);
}
}
