package com.medplus.controller;

import com.medplus.model.Medicine;
import com.medplus.service.MedicineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class MedicineController {

    private final MedicineService medicineService;

    @Autowired
    public MedicineController(MedicineService medicineService) {
        this.medicineService = medicineService;
    }

    @GetMapping("/medicine/{id}")
    public String medicineDetails(@PathVariable String id, Model model) {
        Medicine medicine = medicineService.getMedicineById(id);
        if (medicine == null) {
            return "redirect:/";
        }
        model.addAttribute("medicine", medicine);
        return "medicine_details";
    }
}
