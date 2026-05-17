<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Med+ | Contact Us</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <a href="/" class="logo"><i class="fas fa-capsules"></i> Med+</a>
        <div class="nav-links">
            <a href="/">Home</a>
            <a href="/about">About Us</a>
            <a href="/contact">Contact</a>
            
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
        <h1 style="text-align: center; margin-bottom: 2rem;">Contact Us & Doctor Channeling</h1>
        
        <c:if test="${not empty success}">
            <div style="background: #dcfce7; color: #15803d; padding: 15px; border-radius: 12px; margin-bottom: 2rem; text-align: center; font-weight: 600; border: 1px solid #bbf7d0;">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>

        <div style="display: flex; gap: 40px; flex-wrap: wrap;">
            <div class="card" style="flex: 1; min-width: 300px;">
                <h2>Send us a Message</h2>
                <form action="/contact/send" method="post">
                    <div class="form-group">
                        <label>Your Name</label>
                        <input type="text" name="name" required placeholder="Enter your full name">
                    </div>
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" required placeholder="Enter your email">
                    </div>
                    <div class="form-group">
                        <label>Message</label>
                        <textarea name="message" rows="5" required style="width: 100%; padding: 0.75rem; border: 1px solid #E5E7EB; border-radius: 8px; outline: none;" placeholder="How can we help you?"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Send Message</button>
                </form>
            </div>
            
            <div class="card" style="flex: 1; min-width: 300px; background: linear-gradient(135deg, #f0f9ff, #e0f2fe); display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; padding: 3rem;">
                <div style="width: 80px; height: 80px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-bottom: 1.5rem; box-shadow: var(--shadow-md);">
                    <i class="fas fa-user-md" style="font-size: 32px; color: var(--primary-blue);"></i>
                </div>
                <h2 style="margin-bottom: 1rem;">Doctor Channeling</h2>
                <p style="color: var(--text-muted); margin-bottom: 2rem;">We are working on bringing professional medical consultations directly to your home.</p>
                <div style="background: white; padding: 20px; border-radius: 16px; border: 2px dashed #bae6fd; color: var(--primary-blue); font-weight: 700; font-size: 18px; width: 100%;">
                    <i class="fas fa-clock"></i> Feature Coming Soon
                </div>
                <p style="margin-top: 1.5rem; font-size: 14px; color: var(--text-muted);">Follow our updates for the launch of our digital channeling portal.</p>
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
                <a href="/cart">Cart</a>
                <a href="/auth">Login / Register</a>
            </div>
            <div class="footer-col">
                <h3>Support</h3>
                <a href="/about">About Us</a>
                <a href="/contact">Contact Us</a>
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
            </div>
            <div class="footer-col">
                <h3>Contact</h3>
                <p style="margin-bottom: 10px;"><i class="fas fa-map-marker-alt" style="margin-right: 10px;"></i> SLIIT, Malabe, Sri Lanka</p>
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
