package com.medplus.controller;

import com.medplus.model.Role;
import com.medplus.model.User;
import com.medplus.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    private final UserService userService;

    @Autowired
    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/auth")
    public String authPage() {
        return "auth";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, HttpSession session, Model model) {
        User user = userService.loginUser(username, password);
        if (user != null) {
            session.setAttribute("user", user);
            if (user.getRole() == Role.ADMIN) return "redirect:/admin/dashboard";
            if (user.getRole() == Role.PHARMACIST) return "redirect:/pharmacist/dashboard";
            return "redirect:/"; // Customer home
        }
        model.addAttribute("error", "Invalid credentials");
        return "auth";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username, @RequestParam String password,
                           @RequestParam String email, @RequestParam String phone,
                           Model model) {
        try {
            userService.registerUser(username, password, Role.CUSTOMER, email, phone);
            model.addAttribute("success", "Registration successful. Please login.");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        return "auth";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
