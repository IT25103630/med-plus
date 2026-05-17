<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Prescriptions | Pharmacist Panel</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="background: #f1f5f9;">
    <nav class="navbar">
        <a href="/" class="logo"><i class="fas fa-capsules"></i> Med+ Pharmacist</a>
        <div class="nav-links">
            <a href="/pharmacist/dashboard">Dashboard</a>
            <a href="/prescription/review" style="font-weight: 600;">Prescription Queue</a>
            <a href="/logout" class="btn btn-danger" style="margin-left: 15px;">Logout</a>
        </div>
    </nav>

    <div class="container" style="margin-top: 4rem; margin-bottom: 4rem;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
            <h1>Pending Prescriptions</h1>
            <span class="badge badge-warning" style="padding: 8px 15px; font-size: 16px;">${pendingPrescriptions.size()} Pending</span>
        </div>

        <c:if test="${empty pendingPrescriptions}">
            <div class="card" style="text-align: center; padding: 60px;">
                <i class="fas fa-check-double" style="font-size: 64px; color: var(--success-green); margin-bottom: 20px;"></i>
                <h3 style="color: #64748b;">Queue is empty!</h3>
                <p>All prescriptions have been reviewed.</p>
            </div>
        </c:if>

        <c:if test="${not empty pendingPrescriptions}">
            <div class="card-grid">
                <c:forEach var="p" items="${pendingPrescriptions}">
                    <div class="card" style="padding: 25px;">
                        <div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
                            <div>
                                <div style="font-size: 12px; color: #64748b; text-transform: uppercase; font-weight: 600;">Prescription ID</div>
                                <div style="font-weight: 600;">#${p.id.substring(0, 8)}</div>
                            </div>
                            <div style="text-align: right;">
                                <div style="font-size: 12px; color: #64748b; text-transform: uppercase; font-weight: 600;">Date</div>
                                <div>${p.createdAt}</div>
                            </div>
                        </div>

                        <div style="background: #f8fafc; border-radius: 10px; height: 200px; display: flex; align-items: center; justify-content: center; margin-bottom: 20px; border: 1px solid #e2e8f0; position: relative; overflow: hidden;">
                             <img src="/uploads/prescriptions/${p.filename}" style="width: 100%; height: 100%; object-fit: cover; opacity: 0.3;">
                             <a href="/uploads/prescriptions/${p.filename}" target="_blank" class="btn btn-primary" style="position: absolute; padding: 8px 20px; font-size: 14px;">
                                <i class="fas fa-search-plus"></i> View Full Image
                             </a>
                        </div>

                        <div style="display: flex; gap: 10px;">
                            <form action="/prescription/update-status" method="post" style="flex: 1;">
                                <input type="hidden" name="id" value="${p.id}">
                                <input type="hidden" name="status" value="APPROVED">
                                <button type="submit" class="btn btn-success" style="width: 100%; background: var(--success-green);">
                                    <i class="fas fa-check"></i> Approve
                                </button>
                            </form>
                            <form action="/prescription/update-status" method="post" style="flex: 1;">
                                <input type="hidden" name="id" value="${p.id}">
                                <input type="hidden" name="status" value="REJECTED">
                                <button type="submit" class="btn btn-danger" style="width: 100%;">
                                    <i class="fas fa-times"></i> Reject
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
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
