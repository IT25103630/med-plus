package com.medplus.controller;

import com.medplus.model.PrescriptionStatus;
import com.medplus.model.Role;
import com.medplus.model.User;
import com.medplus.service.PrescriptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/prescription")
public class PrescriptionController {

    private final PrescriptionService prescriptionService;

    @Autowired
    public PrescriptionController(PrescriptionService prescriptionService) {
        this.prescriptionService = prescriptionService;
    }

    @GetMapping("/upload")
    public String uploadPage(HttpSession session) {
        if (session.getAttribute("user") == null) return "redirect:/auth";
        return "prescription_upload";
    }

    @PostMapping("/upload")
    public String handleUpload(@RequestParam("file") MultipartFile file, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/auth";

        try {
            prescriptionService.savePrescriptionFile(file, user.getId());
            return "redirect:/prescription/history";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to upload file: " + e.getMessage());
            return "prescription_upload";
        }
    }

    @GetMapping("/history")
    public String historyPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/auth";
        
        model.addAttribute("prescriptions", prescriptionService.getPrescriptionsByUser(user.getId()));
        return "prescription_history";
    }

    @GetMapping("/review")
    public String reviewPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.PHARMACIST) return "redirect:/";

        model.addAttribute("pendingPrescriptions", prescriptionService.getPendingPrescriptions());
        return "prescription_review";
    }

    @PostMapping("/update-status")
    public String updateStatus(@RequestParam String id, @RequestParam String status, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.PHARMACIST) return "redirect:/";

        prescriptionService.updateStatus(id, PrescriptionStatus.valueOf(status));
        return "redirect:/prescription/review";
    }
}
