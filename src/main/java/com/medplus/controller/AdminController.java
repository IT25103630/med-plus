package com.medplus.controller;

import com.medplus.model.Role;
import com.medplus.model.User;
import com.medplus.service.MedicineService;
import com.medplus.service.OrderService;
import com.medplus.service.UserService;
import jakarta.servlet.http.HttpSession;
import com.medplus.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final UserService userService;
    private final MedicineService medicineService;
    private final OrderService orderService;
    private final CategoryRepository categoryRepository;

    @Autowired
    public AdminController(UserService userService, MedicineService medicineService, OrderService orderService, CategoryRepository categoryRepository) {
        this.userService = userService;
        this.medicineService = medicineService;
        this.orderService = orderService;
        this.categoryRepository = categoryRepository;
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.ADMIN) {
            return "redirect:/auth";
        }
        model.addAttribute("usersCount", userService.getAllUsers().size());
        model.addAttribute("medicinesCount", medicineService.getAllMedicines().size());
        model.addAttribute("ordersCount", orderService.getAllOrders().size());
        model.addAttribute("recentOrders", orderService.getAllOrders());
        return "dashboard_admin";
    }

    @GetMapping("/medicines")
    public String viewMedicines(@RequestParam(required = false) String editId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.ADMIN) return "redirect:/auth";
        
        if (editId != null && !editId.isEmpty()) {
            model.addAttribute("editMedicine", medicineService.getMedicine(editId));
        }
        
        model.addAttribute("medicines", medicineService.getAllMedicines());
        model.addAttribute("categories", categoryRepository.findAll());
        return "admin_medicines";
    }

    @GetMapping("/orders")
    public String viewOrders(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.ADMIN) return "redirect:/auth";
        model.addAttribute("orders", orderService.getAllOrders());
        return "admin_orders";
    }

    @GetMapping("/users")
    public String viewUsers(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.ADMIN) return "redirect:/auth";
        model.addAttribute("users", userService.getAllUsers());
        return "admin_users";
    }

    @PostMapping("/medicine/save")
    public String saveMedicine(
            @RequestParam(required = false) String id,
            @RequestParam String name,
            @RequestParam(defaultValue = "") String description,
            @RequestParam double price, @RequestParam int stock,
            @RequestParam String category, @RequestParam String expiryDate,
            @RequestParam(defaultValue = "false") boolean requiresPrescription,
            HttpSession session) {
            
        User user = (User) session.getAttribute("user");
        if (user != null && user.getRole() == Role.ADMIN) {
            // Logic moved to Service (SRP)
            medicineService.saveOrUpdateMedicine(id, name, description, price, stock, category, expiryDate, requiresPrescription);
        }
        return "redirect:/admin/medicines";
    }
    
    @PostMapping("/pharmacist/add")
    public String addPharmacist(
            @RequestParam String username, @RequestParam String password, 
            @RequestParam String email, @RequestParam String phone,
            HttpSession session, Model model) {
            
        User user = (User) session.getAttribute("user");
        if (user != null && user.getRole() == Role.ADMIN) {
            try {
                userService.registerUser(username, password, Role.PHARMACIST, email, phone);
            } catch (Exception e) {
                // Ignore
            }
        }
        return "redirect:/admin/users";
    }

    @GetMapping("/medicine/delete/{id}")
    public String deleteMedicine(@PathVariable String id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null && user.getRole() == Role.ADMIN) {
            medicineService.deleteMedicine(id);
        }
        return "redirect:/admin/medicines";
    }

    @GetMapping("/user/delete/{id}")
    public String deleteUser(@PathVariable String id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null && user.getRole() == Role.ADMIN) {
            // Logic moved to Service (SRP)
            userService.deleteUserSafe(id, user);
        }
        return "redirect:/admin/users";
    }
}

