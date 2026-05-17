package com.medplus.controller;

import com.medplus.model.Medicine;
import com.medplus.service.MedicineService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final MedicineService medicineService;

    @Autowired
    public CartController(MedicineService medicineService) {
        this.medicineService = medicineService;
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam String medicineId, @RequestParam(defaultValue = "1") int quantity,
            HttpSession session) {
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        Medicine m = medicineService.getMedicine(medicineId);
        if (m != null && m.getStock() >= quantity && !m.isExpired()) {
            cart.put(medicineId, cart.getOrDefault(medicineId, 0) + quantity);
            session.setAttribute("cart", cart);
        }
        return "redirect:/";
    }

    @PostMapping("/add-ajax")
    @ResponseBody
    public Map<String, Object> addToCartAjax(@RequestParam String medicineId,
            @RequestParam(defaultValue = "1") int quantity, HttpSession session) {
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        Medicine m = medicineService.getMedicine(medicineId);
        Map<String, Object> response = new HashMap<>();
        if (m != null && m.getStock() >= quantity && !m.isExpired()) {
            cart.put(medicineId, cart.getOrDefault(medicineId, 0) + quantity);
            session.setAttribute("cart", cart);
            response.put("success", true);
            response.put("message", m.getName() + " added to cart!");
            int totalItems = cart.values().stream().mapToInt(Integer::intValue).sum();
            response.put("totalItems", totalItems);
        } else {
            response.put("success", false);
            response.put("message", "Could not add item to cart.");
        }
        return response;
    }

    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
        Map<Medicine, Integer> cartItems = new HashMap<>();
        double total = 0;
        boolean requiresPrescription = false;

        if (cart != null) {
            for (Map.Entry<String, Integer> entry : cart.entrySet()) {
                Medicine m = medicineService.getMedicine(entry.getKey());
                if (m != null) {
                    cartItems.put(m, entry.getValue());
                    total += (m.getPrice() * entry.getValue());
                    if (m.isRequiresPrescription()) {
                        requiresPrescription = true;
                    }
                }
            }
        }

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("total", total);
        model.addAttribute("requiresPrescription", requiresPrescription);

        return "cart";
    }

    @GetMapping("/remove/{medicineId}")
    public String removeFromCart(@PathVariable String medicineId, HttpSession session) {
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
        if (cart != null) {
            cart.remove(medicineId);
            session.setAttribute("cart", cart);
        }
        return "redirect:/cart";
    }

    @GetMapping("/clear")
    public String clearCart(HttpSession session) {
        session.removeAttribute("cart");
        return "redirect:/cart";
    }
}