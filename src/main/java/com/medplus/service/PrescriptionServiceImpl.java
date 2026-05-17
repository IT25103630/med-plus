package com.medplus.service;

import com.medplus.model.Prescription;
import com.medplus.model.PrescriptionStatus;
import com.medplus.repository.PrescriptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class PrescriptionServiceImpl implements PrescriptionService {

    private final PrescriptionRepository prescriptionRepository;
    private static final String UPLOAD_DIR = "uploads/";

    @Autowired
    public PrescriptionServiceImpl(PrescriptionRepository prescriptionRepository) {
        this.prescriptionRepository = prescriptionRepository;
    }

    @Override
    public void addPrescription(Prescription prescription) {
        prescriptionRepository.save(prescription);
    }

    @Override
    public List<Prescription> getPrescriptionsByUser(String userId) {
        return prescriptionRepository.findAll().stream()
                .filter(p -> p.getUserId().equals(userId))
                .collect(Collectors.toList());
    }

    @Override
    public List<Prescription> getAllPrescriptions() {
        return prescriptionRepository.findAll();
    }

    @Override
    public void updateStatus(String id, PrescriptionStatus status) {
        Prescription p = prescriptionRepository.findById(id).orElse(null);
        if (p != null) {
            p.setStatus(status);
            prescriptionRepository.save(p);
        }
    }

    @Override
    public Prescription getPrescription(String id) {
        return prescriptionRepository.findById(id).orElse(null);
    }

    @Override
    public String savePrescriptionFile(MultipartFile file, String userId) throws IOException {
        if (file == null || file.isEmpty()) {
            throw new IOException("File is empty");
        }
        
        java.nio.file.Path uploadPath = java.nio.file.Paths.get(UPLOAD_DIR);
        if (!java.nio.file.Files.exists(uploadPath)) {
            java.nio.file.Files.createDirectories(uploadPath);
        }
        
        String filename = java.util.UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        java.nio.file.Path filePath = uploadPath.resolve(filename);
        java.nio.file.Files.copy(file.getInputStream(), filePath);
        
        Prescription p = new Prescription(userId, filename);
        addPrescription(p);
        return p.getId();
    }

    @Override
    public List<Prescription> getPendingPrescriptions() {
        return prescriptionRepository.findAll().stream()
                .filter(p -> p.getStatus() == PrescriptionStatus.PENDING)
                .collect(Collectors.toList());
    }
}
