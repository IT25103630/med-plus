package com.medplus.repository;

import com.medplus.model.ContactMessage;
import org.springframework.stereotype.Repository;

@Repository
public class ContactMessageRepository extends BaseFileRepository<ContactMessage> {
    public ContactMessageRepository() {
        super("data/messages.json", ContactMessage[].class);
    }
}
