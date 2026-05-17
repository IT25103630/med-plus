package com.medplus.service;

import com.medplus.model.Order;
import com.medplus.model.OrderStatus;
import com.medplus.model.User;
import com.medplus.model.DeliveryMethod;
import java.util.List;
import java.util.Map;

public interface OrderService {
    Order placeOrder(Order order);
    List<Order> getOrdersByUser(String userId);
    List<Order> getAllOrders();
    List<Order> getPendingOrders();
    void updateOrderStatus(String orderId, OrderStatus status);
    Order getOrder(String id);
    Order createOrderFromCart(User user, Map<String, Integer> cart, DeliveryMethod deliveryMethod, String prescriptionId);
}
