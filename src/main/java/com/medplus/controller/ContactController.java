package com.medplus.controller;

import com.medplus.model.ContactMessage;
import com.medplus.repository.ContactMessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/contact")
public class ContactController {

    private final ContactMessageRepository messageRepository;

    @Autowired
    public ContactController(ContactMessageRepository messageRepository) {
        this.messageRepository = messageRepository;
    }

    @GetMapping
    public String contact() {
        return "contact";
    }

    @PostMapping("/send")
    public String sendMessage(@RequestParam String name, 
                             @RequestParam String email, 
                             @RequestParam String message, 
                             RedirectAttributes redirectAttributes) {
        ContactMessage msg = new ContactMessage();
        msg.setName(name);
        msg.setEmail(email);
        msg.setMessage(message);
        messageRepository.save(msg);
        
        redirectAttributes.addFlashAttribute("success", "Your message has been sent successfully!");
        return "redirect:/contact";
    }
}
