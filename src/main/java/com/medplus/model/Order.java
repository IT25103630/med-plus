package com.medplus.model;

import java.util.ArrayList;
import java.util.List;

public class Order extends BaseModel {
    private String userId;
    private List<OrderItem> items;
    private double totalAmount;
    private OrderStatus status;
    private DeliveryMethod deliveryMethod;
    private String trackingId;
    private String prescriptionId;
    private String date;

    public Order() {
        super();
        this.items = new ArrayList<>();
        this.trackingId = "TRK-" + System.currentTimeMillis();
        this.status = OrderStatus.PENDING;
        this.date = java.time.LocalDateTime.now().toString().substring(0, 16).replace("T", " ");
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }

    public DeliveryMethod getDeliveryMethod() {
        return deliveryMethod;
    }

    public void setDeliveryMethod(DeliveryMethod deliveryMethod) {
        this.deliveryMethod = deliveryMethod;
    }

    public String getTrackingId() {
        return trackingId;
    }

    public void setTrackingId(String trackingId) {
        this.trackingId = trackingId;
    }

    public String getPrescriptionId() {
        return prescriptionId;
    }

    public void setPrescriptionId(String prescriptionId) {
        this.prescriptionId = prescriptionId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
