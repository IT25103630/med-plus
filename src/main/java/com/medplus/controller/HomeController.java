package com.medplus.controller;

import com.medplus.service.MedicineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

    private final MedicineService medicineService;

    @Autowired
    public HomeController(MedicineService medicineService) {
        this.medicineService = medicineService;
    }

    @GetMapping("/")
    public String index(@RequestParam(required = false) String search, 
                        @RequestParam(required = false) String category, 
                        Model model) {
        java.util.List<com.medplus.model.Medicine> medicines = medicineService.getAllMedicines();
        
        if (search != null && !search.trim().isEmpty()) {
            String finalSearch = search.toLowerCase().trim();
            medicines = medicines.stream()
                .filter(m -> (m.getName() != null && m.getName().toLowerCase().contains(finalSearch)) || 
                            (m.getCategory() != null && m.getCategory().toLowerCase().contains(finalSearch)) ||
                            (m.getDescription() != null && m.getDescription().toLowerCase().contains(finalSearch)))
                .collect(java.util.stream.Collectors.toList());
        }
        
        if (category != null && !category.trim().isEmpty()) {
            medicines = medicines.stream()
                .filter(m -> m.getCategory() != null && m.getCategory().equalsIgnoreCase(category.trim()))
                .collect(java.util.stream.Collectors.toList());
        }
        
        model.addAttribute("medicines", medicines);
        return "index";
    }
}
