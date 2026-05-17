package com.medplus.service;

import com.medplus.model.Order;
import com.medplus.model.OrderItem;
import com.medplus.model.OrderStatus;
import com.medplus.model.DeliveryMethod;
import com.medplus.model.Medicine;
import com.medplus.model.User;
import com.medplus.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final MedicineService medicineService;

    @Autowired
    public OrderServiceImpl(OrderRepository orderRepository, MedicineService medicineService) {
        this.orderRepository = orderRepository;
        this.medicineService = medicineService;
    }

    @Override
    public Order placeOrder(Order order) {
        orderRepository.save(order);
        return order;
    }

    @Override
    public List<Order> getOrdersByUser(String userId) {
        return orderRepository.findAll().stream()
                .filter(o -> o.getUserId().equals(userId))
                .collect(Collectors.toList());
    }

    @Override
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }
    
    @Override
    public List<Order> getPendingOrders() {
        return orderRepository.findAll().stream()
                .filter(o -> o.getStatus() == OrderStatus.PENDING)
                .collect(Collectors.toList());
    }

    @Override
    public void updateOrderStatus(String orderId, OrderStatus status) {
        Order order = orderRepository.findById(orderId).orElse(null);
        if (order != null) {
            order.setStatus(status);
            orderRepository.save(order);
        }
    }

    @Override
    public Order getOrder(String id) {
        return orderRepository.findById(id).orElse(null);
    }

    @Override
    public Order createOrderFromCart(User user, Map<String, Integer> cart, DeliveryMethod deliveryMethod, String prescriptionId) {
        Order order = new Order();
        order.setUserId(user.getId());
        order.setDeliveryMethod(deliveryMethod);
        order.setPrescriptionId(prescriptionId);
        
        double subtotal = 0;
        for (Map.Entry<String, Integer> entry : cart.entrySet()) {
            Medicine m = medicineService.getMedicine(entry.getKey());
            if (m != null) {
                OrderItem item = new OrderItem(m.getId(), entry.getValue(), m.getPrice());
                order.getItems().add(item);
                subtotal += (m.getPrice() * entry.getValue());
                
                // Stock management moved to service (SRP)
                medicineService.updateStock(m.getId(), m.getStock() - entry.getValue());
            }
        }
        
        // Fee calculation using OCP (DeliveryMethod.getFee())
        order.setTotalAmount(subtotal + deliveryMethod.getFee());
        
        return placeOrder(order);
    }
}