package com.medplus.repository;

import com.medplus.model.Medicine;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class MedicineRepository extends BaseFileRepository<Medicine> {

    public MedicineRepository(@Value("${medicines.file}") String filePath) {
        super(filePath, Medicine[].class);
    }

    @Override
    public void save(Medicine medicine) {
        List<Medicine> medicines = findAll();
        medicines.removeIf(m -> m.getId().equals(medicine.getId()));
        medicines.add(medicine);
        saveAll(medicines);
    }

    @Override
    public Optional<Medicine> findById(String id) {
        return findAll().stream().filter(m -> m.getId().equals(id)).findFirst();
    }

    @Override
    public void delete(String id) {
        List<Medicine> medicines = findAll();
        medicines.removeIf(m -> m.getId().equals(id));
        saveAll(medicines);
    }
}
