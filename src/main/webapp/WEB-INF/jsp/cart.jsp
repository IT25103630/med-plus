<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Med+ | Shopping Cart</title>
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
        <h1>Your Shopping Cart</h1>
        
        <c:choose>
            <c:when test="${not empty cartItems}">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Medicine</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="entry" items="${cartItems}">
                                <tr>
                                    <td>
                                        <strong>${entry.key.name}</strong>
                                        <c:if test="${entry.key.requiresPrescription}">
                                            <span class="badge badge-warning" style="margin-left: 10px; font-size: 10px;">Prescription Required</span>
                                        </c:if>
                                    </td>
                                    <td>Rs. ${entry.key.price}</td>
                                    <td>${entry.value}</td>
                                    <td>Rs. ${entry.key.price * entry.value}</td>
                                    <td><a href="/cart/remove/${entry.key.id}" class="btn btn-danger" style="padding: 4px 8px; font-size: 12px;"><i class="fas fa-trash"></i></a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="3" style="text-align: right;">Grand Total:</th>
                                <th>Rs. ${total}</th>
                                <th></th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                
                <div style="margin-top: 20px; display: flex; justify-content: space-between; align-items: center;">
                    <a href="/cart/clear" class="btn" style="background: #e2e8f0; color: #475569;">Clear Cart</a>
                    <a href="/checkout" class="btn btn-success" style="font-size: 18px; padding: 10px 30px;">Proceed to Checkout <i class="fas fa-arrow-right"></i></a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card" style="text-align: center; padding: 50px;">
                    <i class="fas fa-shopping-cart" style="font-size: 48px; color: #ccc; margin-bottom: 20px;"></i>
                    <h3>Your cart is empty</h3>
                    <p style="color: var(--text-muted); margin-bottom: 20px;">Browse our catalog and add medicines to your cart.</p>
                    <a href="/" class="btn btn-primary">Browse Medicines</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
