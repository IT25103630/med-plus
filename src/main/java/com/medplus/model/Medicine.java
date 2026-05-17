package com.medplus.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class Medicine extends BaseModel {
    private String name;
    private String description;
    private double price;
    private int stock;
    private String category;
    private boolean requiresPrescription;
    private String expiryDate;

    public Medicine() {
        super();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public boolean isRequiresPrescription() {
        return requiresPrescription;
    }

    public void setRequiresPrescription(boolean requiresPrescription) {
        this.requiresPrescription = requiresPrescription;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    @JsonIgnore
    public boolean isExpired() {
        if (expiryDate == null || expiryDate.isEmpty())
            return false;
        try {
            return java.time.LocalDate.parse(expiryDate).isBefore(java.time.LocalDate.now());
        } catch (Exception e) {
            return false;
        }
    }
}
