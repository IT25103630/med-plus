package com.medplus;

import com.medplus.model.Medicine;
import com.medplus.model.Role;
import com.medplus.service.MedicineService;
import com.medplus.service.UserService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class MedPlusApplication {

	public static void main(String[] args) {
		SpringApplication.run(MedPlusApplication.class, args);
	}

	@Bean
	public CommandLineRunner dataLoader(UserService userService, MedicineService medicineService) {
		return args -> {
			if (userService.getAllUsers().isEmpty()) {
				userService.registerUser("admin", "admin123", Role.ADMIN, "admin@medplus.com", "0000000000");
				userService.registerUser("pharmacist1", "pharm123", Role.PHARMACIST, "pharm@medplus.com", "1111111111");
			}
			if (medicineService.getAllMedicines().isEmpty()) {
				Medicine m1 = new Medicine();
				m1.setName("Paracetamol 500mg");
				m1.setCategory("Painkillers");
				m1.setPrice(150.0);
				m1.setStock(100);
				m1.setExpiryDate("2026-12-31");
				m1.setRequiresPrescription(false);
				medicineService.addMedicine(m1);

				Medicine m2 = new Medicine();
				m2.setName("Amoxicillin 250mg");
				m2.setCategory("Antibiotics");
				m2.setPrice(450.0);
				m2.setStock(50);
				m2.setExpiryDate("2025-06-30");
				m2.setRequiresPrescription(true);
				medicineService.addMedicine(m2);
			}
		};
	}
}

