<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Prescription | Med+</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <a href="/" class="logo"><i class="fas fa-capsules"></i> Med+</a>
        <div class="nav-links">
            <a href="/">Home</a>
            <a href="/prescription/history">My Prescriptions</a>
            <a href="/logout" class="btn btn-danger" style="margin-left: 15px;">Logout</a>
        </div>
    </nav>

    <div class="container" style="max-width: 600px; margin-top: 4rem; margin-bottom: 4rem;">
        <div class="card" style="padding: 40px;">
            <div style="text-align: center; margin-bottom: 30px;">
                <i class="fas fa-file-prescription" style="font-size: 64px; color: var(--primary-blue); margin-bottom: 20px;"></i>
                <h1>Upload Prescription</h1>
                <p style="color: var(--text-muted);">Please upload a clear photo or scan of your valid prescription. A pharmacist will review it shortly.</p>
            </div>

            <c:if test="${not empty error}">
                <div style="background: #FEE2E2; color: #DC2626; padding: 15px; border-radius: 8px; margin-bottom: 20px; text-align: center;">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <form action="/prescription/upload" method="post" enctype="multipart/form-data">
                <div class="form-group" style="margin-bottom: 30px;">
                    <label style="display: block; margin-bottom: 10px; font-weight: 600;">Select Prescription Image (JPG, PNG, PDF)</label>
                    <input type="file" name="file" id="fileInput" required style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px;">
                </div>
                
                <div style="padding: 15px; background: #f0f9ff; border-radius: 8px; margin-bottom: 30px;">
                    <ul style="font-size: 14px; color: #0369a1; padding-left: 20px; margin: 0;">
                        <li>Ensure patient name is clearly visible.</li>
                        <li>Check if the doctor's signature is present.</li>
                        <li>Ensure the date of prescription is valid.</li>
                    </ul>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; padding: 15px; font-size: 18px;">
                    <i class="fas fa-upload"></i> Upload for Review
                </button>
            </form>
        </div>
    </div>

    <footer class="footer">
        <div class="footer-content" style="display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:20px;padding:0 40px;">
            <div>
                <div style="font-size:20px;font-weight:700;color:white;"><i class="fas fa-capsules"></i> Med+</div>
                <p style="color:#cbd5e1;font-size:13px;margin-top:5px;">SLIIT, Malabe, Sri Lanka</p>
            </div>
            <div style="color:#cbd5e1;font-size:13px;text-align:center;">
                &copy; 2026 Med+ | SLIIT Online Medical Store
            </div>
            <div style="color:#cbd5e1;font-size:13px;">
                <p><i class="fas fa-phone-alt" style="margin-right:8px;"></i> +94 11 2000000</p>
                <p><i class="fas fa-envelope" style="margin-right:8px;"></i> support@medplus.lk</p>
            </div>
        </div>
    </footer>
</body>
</html>
