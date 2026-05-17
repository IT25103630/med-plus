<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management | Pharmacist Panel</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="background: #f1f5f9;">
    <nav class="navbar">
        <a href="/" class="logo"><i class="fas fa-capsules"></i> Med+ Pharmacist</a>
        <div class="nav-links">
            <a href="/pharmacist/dashboard">Dashboard</a>
            <a href="/pharmacist/orders">Manage Orders</a>
            <a href="/pharmacist/stock" style="font-weight: 600;">Inventory</a>
            <a href="/logout" class="btn btn-danger" style="margin-left: 15px;">Logout</a>
        </div>
    </nav>

    <div class="container" style="margin-top: 4rem; margin-bottom: 4rem;">
        <h1 style="margin-bottom: 2rem;">Inventory & Stock Levels</h1>

        <div class="card" style="padding: 0; overflow: hidden;">
            <table style="width: 100%; border-collapse: collapse; text-align: left;">
                <thead style="background: #f8fafc; border-bottom: 1px solid #e2e8f0;">
                    <tr>
                        <th style="padding: 20px;">Medicine</th>
                        <th style="padding: 20px;">Category</th>
                        <th style="padding: 20px;">Current Stock</th>
                        <th style="padding: 20px;">Status</th>
                        <th style="padding: 20px;">Quick Update</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="m" items="${medicines}">
                        <tr style="border-bottom: 1px solid #f1f5f9;">
                            <td style="padding: 20px;">
                                <div style="font-weight: 600;">${m.name}</div>
                                <div style="font-size: 12px; color: #64748b;">${m.id.substring(0, 8)}</div>
                            </td>
                            <td style="padding: 20px;">${m.category}</td>
                            <td style="padding: 20px; font-weight: 600; font-size: 18px;">${m.stock}</td>
                            <td style="padding: 20px;">
                                <c:choose>
                                    <c:when test="${m.stock == 0}">
                                        <span class="badge badge-danger" style="background: #FEE2E2; color: #DC2626;">Out of Stock</span>
                                    </c:when>
                                    <c:when test="${m.stock < 10}">
                                        <span class="badge badge-warning" style="background: #FEF3C7; color: #D97706;">Low Stock</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-success" style="background: #DCFCE7; color: #16A34A;">Sufficient</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="padding: 20px;">
                                <form action="/pharmacist/medicine/${m.id}/update-stock" method="get" style="display: flex; gap: 10px;">
                                    <input type="number" name="quantity" value="${m.stock}" min="0" style="width: 70px; padding: 5px; border-radius: 5px; border: 1px solid #ddd;">
                                    <button type="submit" class="btn btn-primary" style="padding: 5px 15px; font-size: 12px;">Update</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
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
