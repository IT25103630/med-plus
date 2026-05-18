package com.medplus.model;

public class ContactMessage extends BaseModel {
    private String name;
    private String email;
    private String message;
    private String date;

    public ContactMessage() {
        super();
        this.date = java.time.LocalDateTime.now().toString().substring(0, 16).replace("T", " ");
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
}
