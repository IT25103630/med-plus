package com.medplus.controller;

import com.medplus.model.OrderStatus;
import com.medplus.model.PrescriptionStatus;
import com.medplus.model.Role;
import com.medplus.model.User;
import com.medplus.service.MedicineService;
import com.medplus.service.OrderService;
import com.medplus.service.PrescriptionService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequestMapping("/pharmacist")
public class PharmacistController {

    private final MedicineService medicineService;
    private final OrderService orderService;
    private final PrescriptionService prescriptionService;

    @Autowired
    public PharmacistController(MedicineService medicineService, OrderService orderService, PrescriptionService prescriptionService) {
        this.medicineService = medicineService;
        this.orderService = orderService;
        this.prescriptionService = prescriptionService;
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.PHARMACIST) {
            return "redirect:/auth";
        }
        
        model.addAttribute("pendingOrders", orderService.getPendingOrders());
        model.addAttribute("pendingPrescriptions", prescriptionService.getPendingPrescriptions());
        model.addAttribute("medicines", medicineService.getAllMedicines());
        
        return "dashboard_pharmacist";
    }

    @GetMapping("/prescription/{id}/{action}")
    public String handlePrescription(@PathVariable String id, @PathVariable String action, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null && user.getRole() == Role.PHARMACIST) {
            if ("approve".equals(action)) {
                prescriptionService.updateStatus(id, PrescriptionStatus.APPROVED);
            } else if ("reject".equals(action)) {
                prescriptionService.updateStatus(id, PrescriptionStatus.REJECTED);
            }
        }
        return "redirect:/pharmacist/dashboard";
    }

    @GetMapping("/orders")
    public String orders(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.PHARMACIST) {
            return "redirect:/auth";
        }
        model.addAttribute("orders", orderService.getAllOrders());
        return "pharmacist_orders";
    }

    @GetMapping("/stock")
    public String stock(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.PHARMACIST) {
            return "redirect:/auth";
        }
        model.addAttribute("medicines", medicineService.getAllMedicines());
        return "pharmacist_stock";
    }

    @PostMapping("/order/{id}/process")
    public String processOrder(@PathVariable String id, @RequestParam("status") OrderStatus status, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null && user.getRole() == Role.PHARMACIST) {
            orderService.updateOrderStatus(id, status);
        }
        return "redirect:/pharmacist/dashboard?tab=orders";
    }

    @GetMapping("/medicine/{id}/update-stock")
    public String updateStock(@PathVariable String id, @RequestParam int quantity, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null && user.getRole() == Role.PHARMACIST) {
            medicineService.updateStock(id, quantity);
        }
        return "redirect:/pharmacist/stock";
    }
}
