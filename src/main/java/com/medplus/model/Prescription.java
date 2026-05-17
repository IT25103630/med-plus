package com.medplus.model;

import java.util.UUID;

public class Prescription extends BaseModel {
    private String userId;
    private String filename;
    private PrescriptionStatus status;

    public Prescription() {
        super();
        this.status = PrescriptionStatus.PENDING;
    }

    public Prescription(String userId, String filename) {
        this();
        this.userId = userId;
        this.filename = filename;
    }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getFilename() { return filename; }
    public void setFilename(String filename) { this.filename = filename; }
    public PrescriptionStatus getStatus() { return status; }
    public void setStatus(PrescriptionStatus status) { this.status = status; }
}
