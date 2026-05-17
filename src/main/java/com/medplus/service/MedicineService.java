package com.medplus.service;

import com.medplus.model.Medicine;
import java.util.List;

public interface MedicineService {
    void addMedicine(Medicine medicine);
    void updateMedicine(Medicine medicine);
    void deleteMedicine(String id);
    Medicine getMedicine(String id);
    Medicine getMedicineById(String id);
    List<Medicine> getAllMedicines();
    void updateStock(String id, int quantity);
    void saveOrUpdateMedicine(String id, String name, String description, double price, int stock, String category, String expiryDate, boolean requiresPrescription);
}
