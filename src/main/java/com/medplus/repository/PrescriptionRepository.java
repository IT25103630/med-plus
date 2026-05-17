package com.medplus.repository;

import com.medplus.model.Prescription;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class PrescriptionRepository extends BaseFileRepository<Prescription> {

    public PrescriptionRepository(@Value("${prescriptions.file}") String filePath) {
        super(filePath, Prescription[].class);
    }

    @Override
    public void save(Prescription prescription) {
        List<Prescription> prescriptions = findAll();
        prescriptions.removeIf(p -> p.getId().equals(prescription.getId()));
        prescriptions.add(prescription);
        saveAll(prescriptions);
    }

    @Override
    public Optional<Prescription> findById(String id) {
        return findAll().stream().filter(p -> p.getId().equals(id)).findFirst();
    }
}
