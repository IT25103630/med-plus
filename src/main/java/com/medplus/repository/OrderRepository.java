package com.medplus.repository;

import com.medplus.model.Order;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class OrderRepository extends BaseFileRepository<Order> {

    public OrderRepository(@Value("${orders.file}") String filePath) {
        super(filePath, Order[].class);
    }

    @Override
    public void save(Order order) {
        List<Order> orders = findAll();
        orders.removeIf(o -> o.getId().equals(order.getId()));
        orders.add(order);
        saveAll(orders);
    }

    @Override
    public Optional<Order> findById(String id) {
        return findAll().stream().filter(o -> o.getId().equals(id)).findFirst();
    }
}
