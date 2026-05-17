package com.medplus.model;

public enum DeliveryMethod {
    NORMAL(200), URGENT(500);

    private final double fee;

    DeliveryMethod(double fee) {
        this.fee = fee;
    }

    public double getFee() {
        return fee;
    }
}
