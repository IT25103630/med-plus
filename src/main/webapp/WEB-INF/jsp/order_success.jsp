<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Med+ | Order Success</title>
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

    <div class="container" style="text-align: center; margin-top: 50px;">
        <i class="fas fa-check-circle" style="font-size: 80px; color: var(--success-green); margin-bottom: 20px;"></i>
        <h1>Order Placed Successfully!</h1>
        <p style="font-size: 18px; color: var(--text-muted); margin-bottom: 30px;">Thank you for your purchase. Your order has been placed and is pending review.</p>
        
        <div class="card" style="display: inline-block; text-align: left; min-width: 400px; margin-bottom: 30px;">
            <h3>Order Details</h3>
            <hr style="margin: 10px 0;">
            <p><strong>Tracking ID:</strong> ${order.trackingId}</p>
            <p><strong>Status:</strong> <span class="badge badge-warning">${order.status}</span></p>
            <p><strong>Total Amount:</strong> Rs. ${order.totalAmount}</p>
            <p><strong>Delivery Method:</strong> ${order.deliveryMethod}</p>
        </div>
        
        <div>
            <c:if test="${order.deliveryMethod == 'URGENT'}">
                <a href="https://wa.me/94770000000?text=Hi,%20my%20urgent%20order%20ID%20is%20${order.trackingId}" target="_blank" class="btn btn-success" style="background: #25D366; font-size: 18px; padding: 12px 25px;">
                    <i class="fab fa-whatsapp"></i> Contact on WhatsApp
                </a>
            </c:if>
            <a href="/" class="btn btn-primary" style="font-size: 18px; padding: 12px 25px; margin-left: 10px;">Return to Home</a>
        </div>
    </div>
</body>
</html>
