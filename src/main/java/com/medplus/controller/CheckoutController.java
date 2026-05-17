package com.medplus.controller;

import com.medplus.model.*;
import com.medplus.service.MedicineService;
import com.medplus.service.OrderService;
import com.medplus.service.PrescriptionService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Controller
@RequestMapping("/checkout")
public class CheckoutController {

    private final MedicineService medicineService;
    private final OrderService orderService;
    private final PrescriptionService prescriptionService;

    @Autowired
    public CheckoutController(MedicineService medicineService, OrderService orderService, PrescriptionService prescriptionService) {
        this.medicineService = medicineService;
        this.orderService = orderService;
        this.prescriptionService = prescriptionService;
    }

    @GetMapping
    public String checkoutPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth";
        }
        
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            return "redirect:/cart";
        }
        
        double subtotal = 0;
        boolean requiresPrescription = false;
        
        for (Map.Entry<String, Integer> entry : cart.entrySet()) {
            Medicine m = medicineService.getMedicine(entry.getKey());
            if (m != null) {
                subtotal += (m.getPrice() * entry.getValue());
                if (m.isRequiresPrescription()) {
                    requiresPrescription = true;
                }
            }
        }
        
        model.addAttribute("total", subtotal);
        model.addAttribute("requiresPrescription", requiresPrescription);
        
        return "checkout";
    }

    @PostMapping
    public String placeOrder(
            @RequestParam DeliveryMethod deliveryMethod,
            @RequestParam(required = false) MultipartFile prescriptionFile,
            HttpSession session, Model model) {
            
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/auth";
        
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) return "redirect:/cart";

        String prescriptionId = null;
        
        // Handle Prescription Upload via Service (SRP)
        boolean requiresPrescription = cart.keySet().stream()
                .map(id -> medicineService.getMedicine(id))
                .anyMatch(m -> m != null && m.isRequiresPrescription());

        if (requiresPrescription) {
            if (prescriptionFile == null || prescriptionFile.isEmpty()) {
                model.addAttribute("error", "Prescription is required for some items in your cart.");
                return checkoutPage(session, model);
            }
            try {
                prescriptionId = prescriptionService.savePrescriptionFile(prescriptionFile, user.getId());
            } catch (IOException e) {
                model.addAttribute("error", "Failed to upload prescription.");
                return checkoutPage(session, model);
            }
        }
        
        // Process order via Service (SRP)
        Order order = orderService.createOrderFromCart(user, cart, deliveryMethod, prescriptionId);
        
        session.removeAttribute("cart");
        model.addAttribute("order", order);
        return "order_success";
    }
}
