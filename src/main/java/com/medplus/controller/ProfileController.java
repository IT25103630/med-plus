package com.medplus.controller;

import com.medplus.model.User;
import com.medplus.service.OrderService;
import com.medplus.service.PrescriptionService;
import com.medplus.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    private final OrderService orderService;
    private final PrescriptionService prescriptionService;
    private final UserService userService;

    @Autowired
    public ProfileController(OrderService orderService, PrescriptionService prescriptionService, UserService userService) {
        this.orderService = orderService;
        this.prescriptionService = prescriptionService;
        this.userService = userService;
    }

    @GetMapping
    public String profile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth";
        }
        
        model.addAttribute("myOrders", orderService.getOrdersByUser(user.getId()));
        model.addAttribute("myPrescriptions", prescriptionService.getPrescriptionsByUser(user.getId()));
        
        return "profile";
    }

    @PostMapping("/update")
    public String updateProfile(
            @RequestParam String email, 
            @RequestParam String phone,
            HttpSession session) {
            
        User user = (User) session.getAttribute("user");
        if (user != null) {
            user.setEmail(email);
            user.setPhone(phone);
            // Save to text file
            userService.updateUser(user);
        }
        return "redirect:/profile";
    }
}
