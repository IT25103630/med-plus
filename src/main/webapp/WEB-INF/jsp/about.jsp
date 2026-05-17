<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Med+ | About Us</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <a href="/" class="logo"><i class="fas fa-capsules"></i> Med+</a>
        <div class="nav-links">
            <a href="/">Home</a>
            <a href="/about">About Us</a>
            
            <a href="/cart" style="margin-left: 20px;"><i class="fas fa-shopping-cart"></i> Cart <span class="badge badge-warning" style="border-radius: 50%; padding: 2px 6px; font-size: 10px;">${not empty sessionScope.cart ? sessionScope.cart.size() : 0}</span></a>
            
            <c:if test="${empty sessionScope.user}">
                <a href="/auth" class="btn btn-primary" style="margin-left: 20px;">Login / Register</a>
            </c:if>
            <c:if test="${not empty sessionScope.user}">
                <c:choose>
                    <c:when test="${sessionScope.user.role == 'ADMIN'}">
                        <a href="/admin/dashboard" style="margin-left: 20px;"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                    </c:when>
                    <c:when test="${sessionScope.user.role == 'PHARMACIST'}">
                        <a href="/pharmacist/dashboard" style="margin-left: 20px;"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/profile" style="margin-left: 20px;"><i class="fas fa-user"></i> My Profile</a>
                    </c:otherwise>
                </c:choose>
                <a href="/logout" class="btn btn-danger" style="margin-left: 15px;">Logout</a>
            </c:if>
        </div>
    </nav>

    <div class="container">
        <div class="hero" style="background: linear-gradient(135deg, #1e293b, #334155);">
            <h1>About Med+ Store</h1>
            <p style="margin-bottom: 0;">Our mission is to provide accessible, high-quality healthcare and medicines to everyone in Sri Lanka with utmost safety and convenience.</p>
        </div>
        
        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; margin-top: 40px;">
            <div class="card" style="text-align: center;">
                <i class="fas fa-shield-alt" style="font-size: 40px; color: var(--success-green); margin-bottom: 15px;"></i>
                <h3>100% Genuine</h3>
                <p style="color: var(--text-muted); font-size: 14px; margin-top: 10px;">All our medicines are directly sourced from authorized distributors to ensure authenticity and quality.</p>
            </div>
            <div class="card" style="text-align: center;">
                <i class="fas fa-truck" style="font-size: 40px; color: var(--primary-blue); margin-bottom: 15px;"></i>
                <h3>Fast Delivery</h3>
                <p style="color: var(--text-muted); font-size: 14px; margin-top: 10px;">We offer standard delivery across the country and urgent Whatsapp-integrated delivery for immediate needs.</p>
            </div>
            <div class="card" style="text-align: center;">
                <i class="fas fa-user-md" style="font-size: 40px; color: var(--warning); margin-bottom: 15px;"></i>
                <h3>Expert Pharmacists</h3>
                <p style="color: var(--text-muted); font-size: 14px; margin-top: 10px;">Every prescription is carefully reviewed and approved by our registered in-house pharmacists.</p>
            </div>
        </div>
    </div>
    
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-col">
                <div style="font-size: 24px; font-weight: 700; color: white; margin-bottom: 15px;"><i class="fas fa-capsules"></i> Med+</div>
                <p style="color: #cbd5e1; margin-bottom: 20px; font-size: 14px; line-height: 1.8;">Your trusted online medical store. We ensure the delivery of high-quality medicines directly to your home with safety and reliability.</p>
                <div style="display: flex; gap: 15px;">
                    <a href="#" style="font-size: 20px;"><i class="fab fa-facebook"></i></a>
                    <a href="#" style="font-size: 20px;"><i class="fab fa-twitter"></i></a>
                    <a href="#" style="font-size: 20px;"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div class="footer-col">
                <h3>Quick Links</h3>
                <a href="/">Home</a>
                <a href="/about">About Us</a>
            </div>
            <div class="footer-col">
                <h3>Contact</h3>
                <p style="margin-bottom: 10px;"><i class="fas fa-map-marker-alt" style="margin-right: 10px;"></i> 123 Health Ave, Colombo, Sri Lanka</p>
                <p style="margin-bottom: 10px;"><i class="fas fa-phone-alt" style="margin-right: 10px;"></i> +94 11 2000000</p>
                <p><i class="fas fa-envelope" style="margin-right: 10px;"></i> support@medplus.lk</p>
            </div>
        </div>
        <div class="footer-bottom">
            &copy; 2026 Med+ Online Medical Store. All rights reserved.
        </div>
    </footer>
</body>
</html>
