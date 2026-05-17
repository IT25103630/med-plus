<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Prescriptions | Med+</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <a href="/" class="logo"><i class="fas fa-capsules"></i> Med+</a>
        <div class="nav-links">
            <a href="/">Home</a>
            <a href="/prescription/upload" class="btn btn-primary" style="color: white;"><i class="fas fa-plus"></i> Upload New</a>
            <a href="/logout" class="btn btn-danger" style="margin-left: 15px;">Logout</a>
        </div>
    </nav>

    <div class="container" style="margin-top: 4rem; margin-bottom: 4rem;">
        <h1 style="margin-bottom: 2rem;">My Prescription History</h1>

        <c:if test="${empty prescriptions}">
            <div class="card" style="text-align: center; padding: 60px;">
                <i class="fas fa-history" style="font-size: 64px; color: #cbd5e1; margin-bottom: 20px;"></i>
                <h3 style="color: #64748b;">No prescriptions found.</h3>
                <p style="margin-bottom: 30px;">You haven't uploaded any prescriptions yet.</p>
                <a href="/prescription/upload" class="btn btn-primary">Upload Your First Prescription</a>
            </div>
        </c:if>

        <c:if test="${not empty prescriptions}">
            <div class="card" style="padding: 0; overflow: hidden;">
                <table style="width: 100%; border-collapse: collapse; text-align: left;">
                    <thead style="background: #f8fafc; border-bottom: 1px solid #e2e8f0;">
                        <tr>
                            <th style="padding: 20px;">Date</th>
                            <th style="padding: 20px;">Prescription ID</th>
                            <th style="padding: 20px;">File Name</th>
                            <th style="padding: 20px;">Status</th>
                            <th style="padding: 20px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${prescriptions}">
                            <tr style="border-bottom: 1px solid #f1f5f9;">
                                <td style="padding: 20px;">${p.createdAt}</td>
                                <td style="padding: 20px;"><code style="background: #f1f5f9; padding: 4px 8px; border-radius: 4px; font-size: 12px;">${p.id.substring(0, 8)}...</code></td>
                                <td style="padding: 20px;">${p.filename}</td>
                                <td style="padding: 20px;">
                                    <c:choose>
                                        <c:when test="${p.status == 'PENDING'}">
                                            <span class="badge badge-warning" style="background: #FEF3C7; color: #D97706;">Pending Review</span>
                                        </c:when>
                                        <c:when test="${p.status == 'APPROVED'}">
                                            <span class="badge badge-success" style="background: #DCFCE7; color: #16A34A;">Approved</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-danger" style="background: #FEE2E2; color: #DC2626;">Rejected</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="padding: 20px;">
                                    <a href="/uploads/prescriptions/${p.filename}" target="_blank" class="btn btn-primary" style="padding: 5px 15px; font-size: 14px;">View File</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
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
