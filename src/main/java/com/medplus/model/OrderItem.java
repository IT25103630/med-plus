package com.medplus.model;

public class OrderItem {
    private String medicineId;
    private int quantity;
    private double priceAtPurchase;

    public OrderItem() {}

    public OrderItem(String medicineId, int quantity, double priceAtPurchase) {
        this.medicineId = medicineId;
        this.quantity = quantity;
        this.priceAtPurchase = priceAtPurchase;
    }

    public String getMedicineId() { return medicineId; }
    public void setMedicineId(String medicineId) { this.medicineId = medicineId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getPriceAtPurchase() { return priceAtPurchase; }
    public void setPriceAtPurchase(double priceAtPurchase) { this.priceAtPurchase = priceAtPurchase; }
}
