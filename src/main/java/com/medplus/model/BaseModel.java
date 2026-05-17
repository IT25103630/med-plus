package com.medplus.model;

import java.io.Serializable;

/**
 * Base model class to demonstrate OOP concepts (Inheritance).
 * Contains common fields for all entities.
 */
public abstract class BaseModel implements Serializable {
    private String id;
    private String createdAt;
    private String updatedAt;

    public BaseModel() {
        this.id = java.util.UUID.randomUUID().toString();
        this.createdAt = java.time.LocalDateTime.now().toString();
        this.updatedAt = java.time.LocalDateTime.now().toString();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }
}