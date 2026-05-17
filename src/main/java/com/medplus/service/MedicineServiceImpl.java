package com.medplus.service;

import com.medplus.model.Medicine;
import com.medplus.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MedicineServiceImpl implements MedicineService {

    private final MedicineRepository medicineRepository;

    @Autowired
    public MedicineServiceImpl(MedicineRepository medicineRepository) {
        this.medicineRepository = medicineRepository;
    }

    @Override
    public void addMedicine(Medicine medicine) {
        medicineRepository.save(medicine);
    }

    @Override
    public void updateMedicine(Medicine medicine) {
        medicineRepository.save(medicine);
    }

    @Override
    public void deleteMedicine(String id) {
        medicineRepository.delete(id);
    }

    @Override
    public Medicine getMedicine(String id) {
        return medicineRepository.findById(id).orElse(null);
    }

    @Override
    public Medicine getMedicineById(String id) {
        return getMedicine(id);
    }

    @Override
    public List<Medicine> getAllMedicines() {
        return medicineRepository.findAll();
    }

    @Override
    public void updateStock(String id, int quantity) {
        Medicine m = getMedicine(id);
        if (m != null) {
            m.setStock(quantity);
            medicineRepository.save(m);
        }
    }

    @Override
    public void saveOrUpdateMedicine(String id, String name, String description, double price, int stock, String category, String expiryDate, boolean requiresPrescription) {
        Medicine m;
        if (id != null && !id.isEmpty()) {
            m = getMedicine(id);
            if (m == null) m = new Medicine();
        } else {
            m = new Medicine();
        }
        
        m.setName(name);
        m.setDescription(description);
        m.setPrice(price);
        m.setStock(stock);
        m.setCategory(category);
        m.setExpiryDate(expiryDate);
        m.setRequiresPrescription(requiresPrescription);
        
        medicineRepository.save(m);
    }
}
