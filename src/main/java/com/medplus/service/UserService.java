package com.medplus.service;

import com.medplus.model.Role;
import com.medplus.model.User;
import java.util.List;

public interface UserService {
    User registerUser(String username, String password, Role role, String email, String phone) throws Exception;
    User loginUser(String username, String password);
    List<User> getAllUsers();
    List<User> getUsersByRole(Role role);
    User getUserById(String id);
    void updateUser(User user);
    void deleteUser(String id);
    void deleteUserSafe(String id, User currentUser);
}
