package com.medplus.repository;

import com.medplus.model.User;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class UserRepository extends BaseFileRepository<User> {

    public UserRepository(@Value("${users.file}") String filePath) {
        super(filePath, User[].class);
    }

    @Override
    public void save(User user) {
        List<User> users = findAll();
        users.removeIf(u -> u.getId().equals(user.getId()));
        users.add(user);
        saveAll(users);
    }

    @Override
    public Optional<User> findById(String id) {
        return findAll().stream().filter(u -> u.getId().equals(id)).findFirst();
    }

    public Optional<User> findByUsername(String username) {
        return findAll().stream().filter(u -> u.getUsername().equals(username)).findFirst();
    }
}
