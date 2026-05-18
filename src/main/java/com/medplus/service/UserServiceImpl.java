package com.medplus.service;

import com.medplus.model.Role;
import com.medplus.model.User;
import com.medplus.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public User registerUser(String username, String password, Role role, String email, String phone) throws Exception {
        if (userRepository.findByUsername(username).isPresent()) {
            throw new Exception("Username already exists");
        }
        User user = new User(username, password, role, email, phone);
        userRepository.save(user);
        return user;
    }

    @Override
    public User loginUser(String username, String password) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent() && userOpt.get().getPassword().equals(password)) {
            return userOpt.get();
        }
        return null;
    }

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
    
    @Override
    public List<User> getUsersByRole(Role role) {
        return userRepository.findAll().stream()
                .filter(u -> u.getRole() == role)
                .collect(Collectors.toList());
    }

    @Override
    public User getUserById(String id) {
        return userRepository.findById(id).orElse(null);
    }
    
    @Override
    public void updateUser(User user) {
        userRepository.save(user);
    }

    @Override
    public void deleteUser(String id) {
        userRepository.delete(id);
    }

    @Override
    public void deleteUserSafe(String id, User currentUser) {
        if (currentUser != null && !currentUser.getId().equals(id)) {
            deleteUser(id);
        }
    }
}
