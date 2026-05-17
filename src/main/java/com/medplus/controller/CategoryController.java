package com.medplus.controller;

import com.medplus.model.Category;
import com.medplus.model.Role;
import com.medplus.model.User;
import com.medplus.repository.CategoryRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

    private final CategoryRepository categoryRepository;

    @Autowired
    public CategoryController(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @GetMapping
    public String list(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.ADMIN) return "redirect:/auth";

        model.addAttribute("categories", categoryRepository.findAll());
        return "category_management";
    }

    @PostMapping("/add")
    public String add(@RequestParam String name, @RequestParam String description, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.ADMIN) return "redirect:/auth";

        Category category = new Category(name, description);
        categoryRepository.save(category);
        return "redirect:/admin/categories";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable String id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != Role.ADMIN) return "redirect:/auth";

        categoryRepository.delete(id);
        return "redirect:/admin/categories";
    }
}
