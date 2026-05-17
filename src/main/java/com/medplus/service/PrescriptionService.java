package com.medplus.service;

import com.medplus.model.Prescription;
import com.medplus.model.PrescriptionStatus;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.List;

public interface PrescriptionService {
    void addPrescription(Prescription prescription);
    List<Prescription> getPrescriptionsByUser(String userId);
    List<Prescription> getAllPrescriptions();
    void updateStatus(String id, PrescriptionStatus status);
    Prescription getPrescription(String id);
    String savePrescriptionFile(MultipartFile file, String userId) throws IOException;
    List<Prescription> getPendingPrescriptions();
}
